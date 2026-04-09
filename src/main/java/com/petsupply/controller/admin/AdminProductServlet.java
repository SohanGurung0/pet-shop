package com.petsupply.controller.admin;

import com.petsupply.model.Product;
import com.petsupply.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminProductServlet — CRUD management for products (admin only).
 *
 * GET  /admin/products             → list all products
 * GET  /admin/products?action=add  → show add form
 * GET  /admin/products?action=edit&id=X → show edit form pre-filled
 * GET  /admin/products?action=delete&id=X → delete + redirect
 * POST /admin/products?action=add  → insert product
 * POST /admin/products?action=edit → update product
 */
@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    // ── GET ───────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "add":
                request.getRequestDispatcher("/WEB-INF/views/admin/addProduct.jsp")
                       .forward(request, response);
                break;

            case "edit":
                int editId = parseId(request.getParameter("id"));
                if (editId <= 0) { response.sendRedirect(request.getContextPath() + "/admin/products"); return; }
                Product toEdit = productService.getProductById(editId);
                if (toEdit == null) { response.sendRedirect(request.getContextPath() + "/admin/products"); return; }
                request.setAttribute("product", toEdit);
                request.getRequestDispatcher("/WEB-INF/views/admin/editProduct.jsp")
                       .forward(request, response);
                break;

            case "delete":
                int delId = parseId(request.getParameter("id"));
                if (delId > 0) {
                    String err = productService.deleteProduct(delId);
                    HttpSession s = request.getSession(true);
                    if (err != null) { s.setAttribute("errorMsg", err); }
                    else             { s.setAttribute("successMsg", "Product deleted successfully."); }
                }
                response.sendRedirect(request.getContextPath() + "/admin/products");
                break;

            default: // "list"
                request.setAttribute("products", productService.getAllProducts());
                request.getRequestDispatcher("/WEB-INF/views/admin/productList.jsp")
                       .forward(request, response);
        }
    }

    // ── POST ──────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String name        = request.getParameter("name");
        String description = request.getParameter("description");
        String price       = request.getParameter("price");
        String category    = request.getParameter("category");
        String imageUrl    = request.getParameter("imageUrl");
        String stock       = request.getParameter("stock");

        if ("add".equals(action)) {
            String error = productService.addProduct(name, description, price, category, imageUrl, stock);

            if (error != null) {
                request.setAttribute("error", error);
                request.getRequestDispatcher("/WEB-INF/views/admin/addProduct.jsp")
                       .forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("successMsg", "Product added successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/products");

        } else if ("edit".equals(action)) {
            int editId = parseId(request.getParameter("id"));
            String error = productService.updateProduct(editId, name, description,
                                                        price, category, imageUrl, stock);
            if (error != null) {
                request.setAttribute("error", error);
                Product p = productService.getProductById(editId);
                request.setAttribute("product", p);
                request.getRequestDispatcher("/WEB-INF/views/admin/editProduct.jsp")
                       .forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("successMsg", "Product updated successfully.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    private int parseId(String idParam) {
        try { return Integer.parseInt(idParam); }
        catch (Exception e) { return -1; }
    }
}
