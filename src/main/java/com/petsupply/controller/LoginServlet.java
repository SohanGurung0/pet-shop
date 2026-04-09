package com.petsupply.controller;

import com.petsupply.model.User;
import com.petsupply.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * LoginServlet — handles user authentication.
 *
 * GET  /login → display login.jsp
 * POST /login → verify credentials → create session → redirect by role
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

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

        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        boolean remember = "on".equals(request.getParameter("remember"));

        // Attempt login via service
        User user = userService.login(email, password);

        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

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

        // Create session
        HttpSession session = request.getSession(true);
        session.setAttribute("loggedUser", user);
        session.setAttribute("userId",   user.getId());
        session.setAttribute("userRole", user.getRole());
        session.setAttribute("userName", user.getFullName());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        // Optional remember-me cookie (1 week)
        if (remember) {
            Cookie cookie = new Cookie("userEmail", user.getEmail());
            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        }

        // Role-based redirect
        if (user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
