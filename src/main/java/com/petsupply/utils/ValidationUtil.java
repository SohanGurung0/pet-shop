package com.petsupply.utils;

import java.util.regex.Pattern;

/**
 * ValidationUtil — server-side input validation helpers.
 *
 * Client-side validation (HTML required / JS checks) can be bypassed.
 * Every form submission must be validated here on the server.
 */
public class ValidationUtil {

    /** Returns true if the value is null or blank after trimming. */
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Name validation: only letters and spaces, no digits.
     * E.g. "John Smith" → valid | "J0hn" → invalid.
     */
    public static boolean isValidName(String name) {
        return name != null && name.matches("^[a-zA-Z\\s'-]{2,100}$");
    }

    /**
     * Email format validation.
     * Pattern: word-chars/dots/hyphens @ domain . 2-6 char TLD
     */
    public static boolean isValidEmail(String email) {
        String regex = "^[\\w\\-\\.]+@([\\w\\-]+\\.)+[\\w\\-]{2,6}$";
        return email != null && Pattern.matches(regex, email);
    }

    /**
     * Phone validation: 7-15 digits, optionally starting with +.
     */
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^\\+?[0-9]{7,15}$");
    }

    /**
     * Password strength: 8+ chars, 1 uppercase, 1 digit, 1 symbol.
     * Allowed symbols: @$!%*?&
     */
    public static boolean isValidPassword(String password) {
        String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(regex);
    }

    /** Returns true if both passwords are non-null and identical. */
    public static boolean doPasswordsMatch(String password, String confirm) {
        return password != null && password.equals(confirm);
    }

    /**
     * Product price validation: must be a positive decimal.
     */
    public static boolean isValidPrice(String price) {
        try {
            double p = Double.parseDouble(price);
            return p >= 0;
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
    }

    /**
     * Stock validation: must be a non-negative integer.
     */
    public static boolean isValidStock(String stock) {
        try {
            int s = Integer.parseInt(stock);
            return s >= 0;
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
    }

    /**
     * Category validation: must be one of the four allowed values.
     */
    public static boolean isValidCategory(String category) {
        return "food".equals(category) || "toy".equals(category)
            || "vitamin".equals(category) || "supplement".equals(category);
    }
}
