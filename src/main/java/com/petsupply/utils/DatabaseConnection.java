package com.petsupply.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DatabaseConnection — manages MySQL JDBC connections.
 *
 * XAMPP default credentials: root / (no password) / port 3306.
 * Change DB_URL, DB_USER, DB_PASSWORD to match your environment.
 *
 * Usage:
 *   Connection conn = null;
 *   try {
 *       conn = DatabaseConnection.getConnection();
 *       // ... JDBC work ...
 *   } catch (SQLException e) {
 *       System.out.println("DB error: " + e.getMessage());
 *   } finally {
 *       DatabaseConnection.closeConnection(conn);
 *   }
 */
public class DatabaseConnection {

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/pet_supply_shop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "";   // XAMPP default: empty password

    // Load MySQL driver once when class is initialised
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    /**
     * Returns a new JDBC connection to the pet_supply_shop database.
     * Caller is responsible for closing it via closeConnection().
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * Safely closes a Connection. Call this in a finally block.
     */
    public static void closeConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}
