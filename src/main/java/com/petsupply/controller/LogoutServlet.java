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

        // Invalidate session via SessionUtil
        com.petsupply.utils.SessionUtil.invalidate(request);

        // Clear remember-me cookie via CookieUtil
        com.petsupply.utils.CookieUtil.deleteCookie(response, "userEmail");

        response.sendRedirect(request.getContextPath() + "/login");
    }
}
