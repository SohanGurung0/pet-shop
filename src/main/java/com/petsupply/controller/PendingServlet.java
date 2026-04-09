package com.petsupply.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * PendingServlet — displays the account pending activation notice.
 *
 * GET /pending → display pending.jsp
 */
@WebServlet("/pending")
public class PendingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/pending.jsp").forward(request, response);
    }
}
