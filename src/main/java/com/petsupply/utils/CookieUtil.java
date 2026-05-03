package com.petsupply.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtil — Helper for managing HTTP cookies.
 */
public class CookieUtil {

    /**
     * Set a cookie.
     */
    public static void setCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true); // Security best practice
        response.addCookie(cookie);
    }

    /**
     * Get a cookie value by name.
     */
    public static String getCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Delete a cookie by name.
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        setCookie(response, name, "", 0);
    }
}
