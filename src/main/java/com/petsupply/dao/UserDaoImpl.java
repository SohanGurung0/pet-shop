package com.petsupply.dao;

import com.petsupply.model.User;
import com.petsupply.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDaoImpl — JDBC implementation of UserDao.
 *
 * Follows the workshop pattern:
 *   1. Get connection
 *   2. Prepare SQL with ? placeholders
 *   3. Set parameters
 *   4. Execute
 *   5. Close connection in finally block
 */
public class UserDaoImpl implements UserDao {

    // ── Helper: map one ResultSet row to a User object ────────
    private User mapRow(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("id"),
            rs.getString("full_name"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getString("password"),
            rs.getString("role"),
            rs.getString("status"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
    }

    // ── insertUser ────────────────────────────────────────────
    @Override
    public boolean insertUser(User user) {
        // Check for duplicate email and phone before inserting
        if (findByEmail(user.getEmail()) != null) {
            System.out.println("Email already exists: " + user.getEmail());
            return false;
        }
        if (findByPhone(user.getPhone()) != null) {
            System.out.println("Phone already exists: " + user.getPhone());
            return false;
        }

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO users (full_name, email, phone, password, role, status) "
                       + "VALUES (?, ?, ?, ?, 'user', 'pending')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPassword());
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error inserting user: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    // ── findByEmail ───────────────────────────────────────────
    @Override
    public User findByEmail(String email) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error finding user by email: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    // ── findByPhone ───────────────────────────────────────────
    @Override
    public User findByPhone(String phone) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE phone = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error finding user by phone: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    // ── findById ──────────────────────────────────────────────
    @Override
    public User findById(int id) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error finding user by id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    // ── findAll ───────────────────────────────────────────────
    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) users.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("Error fetching all users: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return users;
    }

    // ── findByStatus ──────────────────────────────────────────
    @Override
    public List<User> findByStatus(String status) {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE status = ? ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) users.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("Error fetching users by status: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return users;
    }

    // ── updateStatus ──────────────────────────────────────────
    @Override
    public boolean updateStatus(int userId, String status) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating user status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }
}
