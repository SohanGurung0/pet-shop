package com.petsupply.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * LogoutServlet — invalidates the session and clears cookies.
 *
 * GET /logout → destroy session → redirect to /login
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Clear remember-me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/login");
    }
}
