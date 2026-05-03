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

        // Create session using SessionUtil
        com.petsupply.utils.SessionUtil.set(request, "loggedUser", user);
        com.petsupply.utils.SessionUtil.set(request, "userId",   user.getId());
        com.petsupply.utils.SessionUtil.set(request, "userRole", user.getRole());
        com.petsupply.utils.SessionUtil.set(request, "userName", user.getFullName());
        
        request.getSession().setMaxInactiveInterval(30 * 60); // 30 minutes

        // Set remember-me cookie using CookieUtil (1 week)
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
