package com.petsupply.controller;

import com.petsupply.model.Product;
import com.petsupply.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * ProductDetailServlet — shows a single product's detail page.
 *
 * GET /product?id=3 → load product from DB → display productDetail.jsp
 */
@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product ID is required.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID.");
            return;
        }

        Product product = productService.getProductById(id);
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/WEB-INF/views/productDetail.jsp").forward(request, response);
    }
}
