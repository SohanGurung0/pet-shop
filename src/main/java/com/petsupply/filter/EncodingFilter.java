package com.petsupply.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * EncodingFilter — sets UTF-8 encoding on all requests and responses.
 * Must run first in the filter chain.
 */
@WebFilter("/*")
public class EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig config) {}
    @Override public void destroy() {}
}
