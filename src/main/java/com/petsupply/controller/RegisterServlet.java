package com.petsupply.controller;

import com.petsupply.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * RegisterServlet — handles new user registration.
 *
 * GET  /register → display register.jsp
 * POST /register → validate → hash password → insert (pending) → redirect to /login
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName         = request.getParameter("fullName");
        String email            = request.getParameter("email");
        String phone            = request.getParameter("phone");
        String password         = request.getParameter("password");
        String confirmPassword  = request.getParameter("confirmPassword");

        // Delegate all validation + persistence to service layer
        String error = userService.register(fullName, email, phone, password, confirmPassword);

        if (error != null) {
            // Forward back with error — param values retained by ${param.*}
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Success: redirect to login with a success message in session
        HttpSession session = request.getSession(true);
        session.setAttribute("successMsg",
            "Registration successful! Your account is pending admin approval.");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
