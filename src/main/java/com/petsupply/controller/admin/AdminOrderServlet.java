package com.petsupply.controller.admin;

import com.petsupply.model.Order;
import com.petsupply.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    // Whitelist of valid order statuses to prevent arbitrary DB writes
    private static final Set<String> VALID_STATUSES =
            Set.of("pending", "confirmed", "shipped", "delivered", "cancelled");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            deleteOrder(request, response);
            return;
        }

        List<Order> allOrders = orderService.getAllOrders();
        request.setAttribute("orders", allOrders);
        request.getRequestDispatcher("/WEB-INF/views/admin/orderList.jsp").forward(request, response);
    }

    // State-changing operations moved to POST (prevents CSRF via link)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            updateStatus(request, response);
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int orderId = parseId(request.getParameter("id"));
        String status = request.getParameter("status");

        HttpSession session = request.getSession();
        if (orderId <= 0 || !VALID_STATUSES.contains(status)) {
            session.setAttribute("errorMsg", "Invalid order ID or status.");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        boolean success = orderService.updateOrderStatus(orderId, status);
        if (success) {
            session.setAttribute("successMsg", "Order status updated to " + status + "!");
        } else {
            session.setAttribute("errorMsg", "Failed to update order status.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int orderId = parseId(request.getParameter("id"));
        HttpSession session = request.getSession();

        if (orderId <= 0) {
            session.setAttribute("errorMsg", "Invalid order ID.");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        boolean success = orderService.deleteOrder(orderId);
        if (success) {
            session.setAttribute("successMsg", "Order #" + orderId + " has been deleted.");
        } else {
            session.setAttribute("errorMsg", "Failed to delete order.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private int parseId(String idParam) {
        try { return Integer.parseInt(idParam); }
        catch (Exception e) { return -1; }
    }
}
