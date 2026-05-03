package com.petsupply.controller.admin;

import com.petsupply.model.Order;
import com.petsupply.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            updateStatus(request, response);
            return;
        } else if ("delete".equals(action)) {
            deleteOrder(request, response);
            return;
        }

        List<Order> allOrders = orderService.getAllOrders();
        request.setAttribute("orders", allOrders);
        request.getRequestDispatcher("/WEB-INF/views/admin/orderList.jsp").forward(request, response);
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        boolean success = orderService.updateOrderStatus(orderId, status);

        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("successMsg", "Order status updated to " + status + "!");
        } else {
            session.setAttribute("errorMsg", "Failed to update order status.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));
        boolean success = orderService.deleteOrder(orderId);

        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("successMsg", "Order #" + orderId + " has been deleted.");
        } else {
            session.setAttribute("errorMsg", "Failed to delete order.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
