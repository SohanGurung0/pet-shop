package com.petsupply.controller;

import com.petsupply.model.Product;
import com.petsupply.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * HomeServlet — loads the homepage with featured products.
 *
 * GET /home → fetch 8 newest products → display home.jsp
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load featured products (all, JSP will slice first 8)
        List<Product> products = productService.getAllProducts();
        request.setAttribute("featuredProducts", products);

        // Category samples for homepage category cards
        request.setAttribute("foodProducts",       productService.getProductsByCategory("food"));
        request.setAttribute("toyProducts",        productService.getProductsByCategory("toy"));
        request.setAttribute("vitaminProducts",    productService.getProductsByCategory("vitamin"));
        request.setAttribute("supplementProducts", productService.getProductsByCategory("supplement"));

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
