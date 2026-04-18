package com.petsupply.controller;

import com.petsupply.model.Product;
import com.petsupply.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * CartServlet — manages the session-based shopping cart.
 *
 * Cart is stored in the session as Map&lt;Integer, Integer&gt;
 * (productId → quantity).
 *
 * GET /cart → display cart contents
 * POST /cart?action=add&id=3&qty=1 → add/increase item
 * POST /cart?action=remove&id=3 → remove item entirely
 * POST /cart?action=update&id=3&qty=2 → set exact quantity
 * POST /cart?action=clear → empty cart
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getCart(HttpSession session) {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // ── GET: display cart ─────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Map<Integer, Integer> cart = getCart(session);

        Map<Product, Integer> cartItems = new LinkedHashMap<>();
        BigDecimal total = BigDecimal.ZERO;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Product p = productService.getProductById(entry.getKey());
            if (p != null) {
                cartItems.put(p, entry.getValue());
                total = total.add(p.getPrice().multiply(BigDecimal.valueOf(entry.getValue())));
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    // ── POST: cart actions ────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Map<Integer, Integer> cart = getCart(session);

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        String qtyParam = request.getParameter("qty");

        if ("add".equals(action) && idParam != null) {
            int id = Integer.parseInt(idParam);
            int qty = (qtyParam != null) ? Integer.parseInt(qtyParam) : 1;
            cart.merge(id, qty, Integer::sum);

        } else if ("remove".equals(action) && idParam != null) {
            cart.remove(Integer.parseInt(idParam));

        } else if ("update".equals(action) && idParam != null && qtyParam != null) {
            int id = Integer.parseInt(idParam);
            int qty = Integer.parseInt(qtyParam);
            if (qty <= 0) {
                cart.remove(id);
            } else {
                cart.put(id, qty);
            }

        } else if ("clear".equals(action)) {
            cart.clear();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
