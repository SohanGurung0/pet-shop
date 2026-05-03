package com.petsupply.controller;

import com.petsupply.model.Order;
import com.petsupply.model.OrderItem;
import com.petsupply.model.Product;
import com.petsupply.model.User;
import com.petsupply.service.OrderService;
import com.petsupply.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final OrderService orderService = new OrderService();

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cart") == null || ((Map<?, ?>) session.getAttribute("cart")).isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate total for display on checkout page
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        BigDecimal total = BigDecimal.ZERO;
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product p = productService.getProductById(entry.getKey());
            if (p != null) {
                total = total.add(p.getPrice().multiply(BigDecimal.valueOf(entry.getValue())));
            }
        }

        // Apply delivery fee
        BigDecimal deliveryFee = (total.compareTo(new BigDecimal("5000")) >= 0) ? BigDecimal.ZERO : new BigDecimal("150");
        BigDecimal finalTotal = total.add(deliveryFee);

        request.setAttribute("subtotal", total);
        request.setAttribute("deliveryFee", deliveryFee);
        request.setAttribute("finalTotal", finalTotal);
        
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;
        Map<Integer, Integer> cart = (session != null) ? (Map<Integer, Integer>) session.getAttribute("cart") : null;

        if (user == null || !"user".equals(user.getRole()) || cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String address = request.getParameter("address");
        String paymentMethod = "COD"; // COD only for now

        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("error", "Shipping address is required.");
            doGet(request, response);
            return;
        }

        // Create Order object
        List<OrderItem> items = new ArrayList<>();
        BigDecimal subtotal = BigDecimal.ZERO;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product p = productService.getProductById(entry.getKey());
            if (p != null) {
                OrderItem item = new OrderItem(p.getId(), entry.getValue(), p.getPrice());
                items.add(item);
                subtotal = subtotal.add(p.getPrice().multiply(BigDecimal.valueOf(entry.getValue())));
            }
        }

        BigDecimal deliveryFee = (subtotal.compareTo(new BigDecimal("5000")) >= 0) ? BigDecimal.ZERO : new BigDecimal("150");
        BigDecimal total = subtotal.add(deliveryFee);

        Order order = new Order(user.getId(), total, address, paymentMethod);
        order.setItems(items);

        boolean success = orderService.placeOrder(order);

        if (success) {
            session.removeAttribute("cart");
            session.setAttribute("successMsg", "Order placed successfully! 🐾");
            response.sendRedirect(request.getContextPath() + "/home?checkoutSuccess=true");
        } else {
            request.setAttribute("error", "Failed to place order. Please check stock levels.");
            doGet(request, response);
        }
    }
}
