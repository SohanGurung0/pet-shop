package com.petsupply.controller;

import com.petsupply.model.Product;
import com.petsupply.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * ProductListServlet — handles the product catalogue/listing page.
 *
 * GET /products                   → show all products
 * GET /products?category=food     → filter by category
 * GET /products?search=keyword    → search by keyword
 */
@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String search   = request.getParameter("search");

        List<Product> products;

        if (search != null && !search.trim().isEmpty()) {
            products = productService.searchProducts(search.trim());
            request.setAttribute("searchQuery", search.trim());
        } else if (category != null && !category.trim().isEmpty()) {
            products = productService.getProductsByCategory(category.trim());
            request.setAttribute("selectedCategory", category.trim());
        } else {
            products = productService.getAllProducts();
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}
