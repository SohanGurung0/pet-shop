package com.petsupply.dao;

import com.petsupply.model.User;
import java.util.List;

/**
 * UserDao — interface for all user database operations.
 * Implementations use JDBC via DatabaseConnection.
 */
public interface UserDao {

    /** Insert a new user. Returns false if email or phone already exists. */
    boolean insertUser(User user);

    /** Find a user by email (case-insensitive). Returns null if not found. */
    User findByEmail(String email);

    /** Find a user by phone. Returns null if not found. */
    User findByPhone(String phone);

    /** Find a user by their primary key. Returns null if not found. */
    User findById(int id);

    /** Return all registered users (all roles, all statuses). */
    List<User> findAll();

    /** Return all users with the given status ('pending', 'approved', 'rejected'). */
    List<User> findByStatus(String status);

    /**
     * Update a user's status field.
     * @param userId the user to update
     * @param status 'pending' | 'approved' | 'rejected'
     * @return true if the row was updated
     */
    boolean updateStatus(int userId, String status);
}
