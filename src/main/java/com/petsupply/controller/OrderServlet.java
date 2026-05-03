package com.petsupply.controller;

import com.petsupply.model.Order;
import com.petsupply.model.User;
import com.petsupply.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdParam = request.getParameter("id");
        if (orderIdParam != null) {
            // View specific order details
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderService.getOrderDetails(orderId);
            
            // Security check: ensure order belongs to user or user is admin
            if (order != null && (order.getUserId() == user.getId() || user.isAdmin())) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/views/orderDetail.jsp").forward(request, response);
                return;
            }
        }

        // List all orders for the user
        List<Order> userOrders = orderService.getUserOrders(user.getId());
        request.setAttribute("orders", userOrders);
        request.getRequestDispatcher("/WEB-INF/views/orderHistory.jsp").forward(request, response);
    }
}
