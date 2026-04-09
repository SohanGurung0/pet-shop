package com.petsupply.service;

import com.petsupply.dao.UserDao;
import com.petsupply.dao.UserDaoImpl;
import com.petsupply.model.User;
import com.petsupply.utils.PasswordUtil;
import com.petsupply.utils.ValidationUtil;

import java.util.List;

/**
 * UserService — business logic layer for user operations.
 * Sits between controllers and the DAO layer.
 *
 * Handles:
 *  - Registration validation + password hashing
 *  - Login credential verification
 *  - Admin approval/rejection of users
 */
public class UserService {

    private final UserDao userDao = new UserDaoImpl();

    /**
     * Register a new user.
     * Returns null on success, or an error message string on failure.
     *
     * Validates:
     *  - All fields non-empty
     *  - Name: letters/spaces only (no digits)
     *  - Email: valid format + not already registered
     *  - Phone: valid format + not already registered
     *  - Password: strength (8+ chars, uppercase, digit, symbol)
     *  - Confirm password: matches password
     */
    public String register(String fullName, String email, String phone,
                           String password, String confirmPassword) {

        StringBuilder errors = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(fullName)) {
            errors.append("Full name is required. ");
        } else if (!ValidationUtil.isValidName(fullName)) {
            errors.append("Name must contain letters only (no numbers or special characters). ");
        }

        if (ValidationUtil.isNullOrEmpty(email)) {
            errors.append("Email is required. ");
        } else if (!ValidationUtil.isValidEmail(email)) {
            errors.append("Invalid email format. ");
        } else if (userDao.findByEmail(email) != null) {
            errors.append("This email address is already registered. ");
        }

        if (ValidationUtil.isNullOrEmpty(phone)) {
            errors.append("Phone number is required. ");
        } else if (!ValidationUtil.isValidPhone(phone)) {
            errors.append("Phone must be 7-15 digits. ");
        } else if (userDao.findByPhone(phone) != null) {
            errors.append("This phone number is already registered. ");
        }

        if (ValidationUtil.isNullOrEmpty(password)) {
            errors.append("Password is required. ");
        } else if (!ValidationUtil.isValidPassword(password)) {
            errors.append("Password must be 8+ characters with at least one uppercase letter, one number, and one symbol (@$!%*?&). ");
        }

        if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            errors.append("Passwords do not match. ");
        }

        if (errors.length() > 0) {
            return errors.toString().trim();
        }

        // Hash password and insert user
        String hashedPassword = PasswordUtil.hashPassword(password);
        User user = new User(fullName.trim(), email.trim(), phone.trim(), hashedPassword);

        boolean inserted = userDao.insertUser(user);
        if (!inserted) {
            return "Registration failed — email or phone may already be in use.";
        }

        return null; // null = success
    }

    /**
     * Verify login credentials.
     * Returns the User object on success, or null on failure.
     *
     * Login is by email. If user is 'pending' or 'rejected', login is refused.
     */
    public User login(String email, String password) {
        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            return null;
        }

        User user = userDao.findByEmail(email);
        if (user == null) return null;

        if (!PasswordUtil.checkPassword(password, user.getPassword())) return null;

        return user; // caller checks user.getStatus() to enforce approval
    }

    /** Returns all registered users. */
    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    /** Returns users with the given status. */
    public List<User> getUsersByStatus(String status) {
        return userDao.findByStatus(status);
    }

    /** Approve a user account. Returns true on success. */
    public boolean approveUser(int userId) {
        return userDao.updateStatus(userId, "approved");
    }

    /** Reject a user account. Returns true on success. */
    public boolean rejectUser(int userId) {
        return userDao.updateStatus(userId, "rejected");
    }

    /** Count pending users awaiting approval. */
    public int countPendingUsers() {
        return userDao.findByStatus("pending").size();
    }
}
