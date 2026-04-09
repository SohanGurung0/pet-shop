package com.petsupply.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil — BCrypt password hashing and verification.
 *
 * Uses jBCrypt library (org.mindrot:jbcrypt:0.4).
 * BCrypt automatically generates and embeds a random salt —
 * no separate salt table needed.
 *
 * Cost factor 10 = 2^10 = 1024 hashing iterations.
 * Higher cost = more brute-force resistant but slower.
 */
public class PasswordUtil {

    private static final int COST = 10;

    /**
     * Hashes a plaintext password with BCrypt.
     * Returns a 60-character hash string like:
     *   $2a$10$N9qo8uLO...
     *
     * @param plainPassword the plaintext password from the form
     * @return the BCrypt hash — store this in the database
     */
    public static String hashPassword(String plainPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(plainPassword, salt);
    }

    /**
     * Verifies a plaintext password against a stored BCrypt hash.
     * BCrypt extracts the salt from the hash, re-hashes the input,
     * and compares — returns true if they match.
     *
     * @param plainPassword  the password typed by the user on login
     * @param hashedPassword the BCrypt hash stored in the database
     * @return true if the password is correct
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) return false;
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
