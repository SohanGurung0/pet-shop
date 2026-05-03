package com.petsupply.controller.admin;

import com.petsupply.model.Product;
import com.petsupply.service.ProductService;
import com.petsupply.utils.ImageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
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
 * POST /admin/products?action=add  → insert product (with file upload)
 * POST /admin/products?action=edit → update product (with file upload)
 */
@WebServlet("/admin/products")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,   // 2 MB
        maxFileSize       = 1024 * 1024 * 10,   // 10 MB
        maxRequestSize    = 1024 * 1024 * 50    // 50 MB
)
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
        String stock       = request.getParameter("stock");

        if ("add".equals(action)) {
            // Handle image file upload
            Part imagePart = request.getPart("image");
            String imagePath = ImageUtil.uploadImage(imagePart);
            if (imagePath == null) {
                imagePath = "images/default-product.png";  // fallback
            }

            String error = productService.addProduct(name, description, price, category, imagePath, stock);

            if (error != null) {
                // Upload succeeded but validation failed — clean up the uploaded file
                if (!imagePath.equals("images/default-product.png")) {
                    ImageUtil.deleteImage(imagePath);
                }
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

            // Fetch existing product to get current image
            Product existing = productService.getProductById(editId);
            if (existing == null) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            // Handle image file upload for edit
            Part imagePart = request.getPart("image");
            String imagePath = ImageUtil.uploadImage(imagePart);

            if (imagePath != null) {
                // New image uploaded — delete the old one
                ImageUtil.deleteImage(existing.getImageUrl());
            } else {
                // No new image — keep existing
                imagePath = existing.getImageUrl();
            }

            String error = productService.updateProduct(editId, name, description,
                                                        price, category, imagePath, stock);
            if (error != null) {
                // Validation failed — if we uploaded a new image, clean it up
                if (imagePath != null && !imagePath.equals(existing.getImageUrl())) {
                    ImageUtil.deleteImage(imagePath);
                }
                request.setAttribute("error", error);
                Product p = productService.getProductById(editId);
                request.setAttribute("product", p != null ? p : existing);
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
