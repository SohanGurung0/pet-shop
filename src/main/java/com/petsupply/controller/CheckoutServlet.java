package com.petsupply.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * CheckoutServlet — placeholder for order processing.
 * Currently redirects back to cart with a "Coming Soon" message.
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // In a real app, this would show the checkout form.
        // For Milestone 1, we just provide the route protection logic.
        
        HttpSession session = request.getSession(true);
        session.setAttribute("successMsg", "Checkout functionality will be implemented in Milestone 2! 🐾");
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
