package com.petsupply.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * SessionUtil — Helper for managing HttpSession attributes.
 */
public class SessionUtil {

    /**
     * Set attribute in session.
     */
    public static void set(HttpServletRequest request, String key, Object value) {
        request.getSession(true).setAttribute(key, value);
    }

    /**
     * Get attribute from session.
     */
    @SuppressWarnings("unchecked")
    public static <T> T get(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (T) session.getAttribute(key) : null;
    }

    /**
     * Remove attribute from session.
     */
    public static void remove(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidate session (logout).
     */
    public static void invalidate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
