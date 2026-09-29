package com.petsupply.controller;

import com.petsupply.model.User;
import com.petsupply.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * LoginServlet — handles user authentication.
 *
 * GET  /login → display login.jsp
 * POST /login → verify credentials → create session → redirect by role
 *
 * Security:
 *  - Session fixation: old session invalidated before creating new one
 *  - Brute-force: max 5 failures per IP per 10-minute window, then locked out
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    // Brute-force protection: track failed attempts per IP
    private static final int  MAX_ATTEMPTS = 5;
    private static final long LOCKOUT_MS   = 10 * 60 * 1000L; // 10 minutes
    private final Map<String, AtomicInteger> failCount   = new ConcurrentHashMap<>();
    private final Map<String, Long>          lockoutTime = new ConcurrentHashMap<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, redirect to home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            User u = (User) session.getAttribute("loggedUser");
            response.sendRedirect(request.getContextPath() +
                    (u.isAdmin() ? "/admin/dashboard" : "/home"));
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ip = request.getRemoteAddr();

        // ── Brute-force check ─────────────────────────────────
        Long locked = lockoutTime.get(ip);
        if (locked != null) {
            if (System.currentTimeMillis() - locked < LOCKOUT_MS) {
                request.setAttribute("error", "Too many failed attempts. Try again in 10 minutes.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            } else {
                // Lockout expired — reset
                lockoutTime.remove(ip);
                failCount.remove(ip);
            }
        }

        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        boolean remember = "on".equals(request.getParameter("remember"));

        // Attempt login via service
        User user = userService.login(email, password);

        if (user == null) {
            int fails = failCount.computeIfAbsent(ip, k -> new AtomicInteger(0)).incrementAndGet();
            if (fails >= MAX_ATTEMPTS) {
                lockoutTime.put(ip, System.currentTimeMillis());
                request.setAttribute("error", "Too many failed attempts. Account locked for 10 minutes.");
            } else {
                request.setAttribute("error", "Invalid email or password.");
            }
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        // Reset fail counter on success
        failCount.remove(ip);
        lockoutTime.remove(ip);

        // Check account status
        if (user.isPending()) {
            request.setAttribute("error", "Your account is awaiting admin approval.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        if ("rejected".equals(user.getStatus())) {
            request.setAttribute("error", "Your account has been rejected. Please contact support.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        // ── Session fixation fix: invalidate old session, create fresh one ──
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) oldSession.invalidate();
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("loggedUser", user);
        newSession.setAttribute("userId",     user.getId());
        newSession.setAttribute("userRole",   user.getRole());
        newSession.setAttribute("userName",   user.getFullName());
        newSession.setMaxInactiveInterval(30 * 60); // 30 minutes

        // Set remember-me cookie (1 week)
        if (remember) {
            com.petsupply.utils.CookieUtil.setCookie(response, "userEmail", user.getEmail(), 7 * 24 * 60 * 60);
        }

        // Role-based redirect
        if (user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
