package com.petsupply.controller.admin;

import com.petsupply.service.ProductService;
import com.petsupply.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminDashboardServlet — serves the admin dashboard overview.
 *
 * GET /admin/dashboard → loads stats → display admin/dashboard.jsp
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final UserService    userService    = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Stats for summary cards ───────────────────────────
        request.setAttribute("totalProducts",  productService.getTotalProductCount());
        request.setAttribute("totalUsers",     userService.getAllUsers().size());
        request.setAttribute("pendingUsers",   userService.countPendingUsers());
        
        java.util.Map<String, java.math.BigDecimal> salesData = new com.petsupply.service.OrderService().getSalesData();
        java.math.BigDecimal totalSales = salesData.values().stream().reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);
        
        request.setAttribute("totalSales",     totalSales);
        request.setAttribute("salesData",      salesData);
        request.setAttribute("categoryStats",  productService.getCategoryStats());

        // Recent products table (latest 5)
        request.setAttribute("recentProducts", productService.getAllProducts()
                .stream().limit(5).collect(java.util.stream.Collectors.toList()));

        // Pending users for quick-approval widget
        request.setAttribute("pendingUserList", userService.getUsersByStatus("pending"));

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
               .forward(request, response);
    }
}
