package com.petsupply.dao;

import com.petsupply.model.Product;
import com.petsupply.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDaoImpl — JDBC implementation of ProductDao.
 * Follows the workshop JDBC pattern: get → prepare → set → execute → close.
 */
public class ProductDaoImpl implements ProductDao {

    // ── Helper: map one ResultSet row to a Product object ─────
    private Product mapRow(ResultSet rs) throws SQLException {
        return new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getBigDecimal("price"),
                rs.getString("category"),
                rs.getString("image_url"),
                rs.getInt("stock"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at"));
    }

    // ── insertProduct ─────────────────────────────────────────
    @Override
    public boolean insertProduct(Product product) {
        // Enforce unique product name
        if (findByName(product.getName()) != null) {
            System.out.println("Product name already exists: " + product.getName());
            return false;
        }
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO products (name, description, price, category, image_url, stock) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            stmt.setString(4, product.getCategory());
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getStock());
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error inserting product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    // ── findById ──────────────────────────────────────────────
    @Override
    public Product findById(int id) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next())
                return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error finding product by id: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    // ── findByName ────────────────────────────────────────────
    @Override
    public Product findByName(String name) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE LOWER(name) = LOWER(?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next())
                return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error finding product by name: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }

    // ── findAll ───────────────────────────────────────────────
    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next())
                products.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("Error fetching all products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    // ── findByCategory ────────────────────────────────────────
    @Override
    public List<Product> findByCategory(String category) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE category = ? ORDER BY name ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next())
                products.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("Error finding products by category: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    // ── search ────────────────────────────────────────────────
    @Override
    public List<Product> search(String keyword) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM products WHERE LOWER(name) LIKE ? OR LOWER(description) LIKE ? "
                    + "ORDER BY name ASC";
            String like = "%" + keyword.toLowerCase() + "%";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, like);
            stmt.setString(2, like);
            ResultSet rs = stmt.executeQuery();
            while (rs.next())
                products.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("Error searching products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return products;
    }

    // ── updateProduct ─────────────────────────────────────────
    @Override
    public boolean updateProduct(Product product) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE products SET name=?, description=?, price=?, category=?, "
                    + "image_url=?, stock=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            stmt.setString(4, product.getCategory());
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getStock());
            stmt.setInt(7, product.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    // ── deleteProduct ─────────────────────────────────────────
    @Override
    public boolean deleteProduct(int id) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    // ── countAll ──────────────────────────────────────────────
    @Override
    public int countAll() {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM products";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return 0;
    }

    // ── countByCategory ───────────────────────────────────────
    @Override
    public List<Object[]> countByCategory() {
        List<Object[]> results = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT category, COUNT(*) AS cnt FROM products GROUP BY category";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                results.add(new Object[] { rs.getString("category"), rs.getInt("cnt") });
            }
        } catch (SQLException e) {
            System.out.println("Error counting by category: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(conn);
        }
        return results;
    }
}
