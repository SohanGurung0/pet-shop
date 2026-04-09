package com.petsupply.filter;

import com.petsupply.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthFilter — protects all pages under /user/* and /admin/*.
 *
 * Rules:
 *  - Anyone may access /login, /register, /home, /products, /product
 *  - /admin/* requires role = 'admin'
 *  - All other protected paths require a logged-in, approved user
 *  - If not logged in → redirect to /login
 *  - If logged in but not approved → redirect to /pending
 */
@WebFilter(urlPatterns = {"/cart", "/checkout", "/orders", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();

        // ── No user session → redirect to login ──────────────
        if (user == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        // ── Not approved → redirect to pending page ───────────
        if (!user.isApproved()) {
            response.sendRedirect(contextPath + "/pending");
            return;
        }

        // ── Admin-only paths → check role ─────────────────────
        if (requestURI.startsWith(contextPath + "/admin")) {
            if (!user.isAdmin()) {
                response.sendRedirect(contextPath + "/home");
                return;
            }
        }

        chain.doFilter(req, res);
    }

    @Override public void init(FilterConfig config) {}
    @Override public void destroy() {}
}
