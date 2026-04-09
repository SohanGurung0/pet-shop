package com.petsupply.service;

import com.petsupply.dao.ProductDao;
import com.petsupply.dao.ProductDaoImpl;
import com.petsupply.model.Product;
import com.petsupply.utils.ValidationUtil;

import java.math.BigDecimal;
import java.util.List;

/**
 * ProductService — business logic layer for product CRUD operations.
 * Validates input before delegating to the DAO layer.
 */
public class ProductService {

    private final ProductDao productDao = new ProductDaoImpl();

    /**
     * Add a new product with validation.
     * Returns null on success, or an error message string on failure.
     */
    public String addProduct(String name, String description, String priceStr,
                             String category, String imageUrl, String stockStr) {

        StringBuilder errors = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(name) || name.trim().length() < 2) {
            errors.append("Product name must be at least 2 characters. ");
        } else if (productDao.findByName(name.trim()) != null) {
            errors.append("A product with this name already exists. ");
        }

        if (!ValidationUtil.isValidCategory(category)) {
            errors.append("Category must be food, toy, vitamin, or supplement. ");
        }

        if (!ValidationUtil.isValidPrice(priceStr)) {
            errors.append("Price must be a valid positive number. ");
        }

        if (!ValidationUtil.isValidStock(stockStr)) {
            errors.append("Stock must be a non-negative whole number. ");
        }

        if (errors.length() > 0) return errors.toString().trim();

        String url = (imageUrl == null || imageUrl.trim().isEmpty())
                     ? "images/default-product.png"
                     : imageUrl.trim();

        Product product = new Product(
            name.trim(),
            description == null ? "" : description.trim(),
            new BigDecimal(priceStr),
            category,
            url,
            Integer.parseInt(stockStr)
        );

        boolean ok = productDao.insertProduct(product);
        return ok ? null : "Failed to add product — name may already exist.";
    }

    /**
     * Update an existing product with validation.
     * Returns null on success, or an error message string on failure.
     */
    public String updateProduct(int id, String name, String description,
                                String priceStr, String category,
                                String imageUrl, String stockStr) {

        StringBuilder errors = new StringBuilder();

        Product existing = productDao.findById(id);
        if (existing == null) return "Product not found.";

        if (ValidationUtil.isNullOrEmpty(name) || name.trim().length() < 2) {
            errors.append("Product name must be at least 2 characters. ");
        } else {
            // Name uniqueness check (allow same name if it's the same product)
            Product byName = productDao.findByName(name.trim());
            if (byName != null && byName.getId() != id) {
                errors.append("Another product with this name already exists. ");
            }
        }

        if (!ValidationUtil.isValidCategory(category)) {
            errors.append("Category must be food, toy, vitamin, or supplement. ");
        }

        if (!ValidationUtil.isValidPrice(priceStr)) {
            errors.append("Price must be a valid positive number. ");
        }

        if (!ValidationUtil.isValidStock(stockStr)) {
            errors.append("Stock must be a non-negative whole number. ");
        }

        if (errors.length() > 0) return errors.toString().trim();

        String url = (imageUrl == null || imageUrl.trim().isEmpty())
                     ? existing.getImageUrl()
                     : imageUrl.trim();

        existing.setName(name.trim());
        existing.setDescription(description == null ? "" : description.trim());
        existing.setPrice(new BigDecimal(priceStr));
        existing.setCategory(category);
        existing.setImageUrl(url);
        existing.setStock(Integer.parseInt(stockStr));

        boolean ok = productDao.updateProduct(existing);
        return ok ? null : "Failed to update product.";
    }

    /**
     * Delete a product by ID.
     * Returns null on success, or an error message on failure.
     */
    public String deleteProduct(int id) {
        if (productDao.findById(id) == null) return "Product not found.";
        boolean ok = productDao.deleteProduct(id);
        return ok ? null : "Cannot delete product — it may be referenced in existing orders.";
    }

    /** Get all products. */
    public List<Product> getAllProducts() { return productDao.findAll(); }

    /** Get a product by ID. Returns null if not found. */
    public Product getProductById(int id) { return productDao.findById(id); }

    /** Get products by category. */
    public List<Product> getProductsByCategory(String category) {
        return productDao.findByCategory(category);
    }

    /** Search products by keyword. */
    public List<Product> searchProducts(String keyword) {
        if (ValidationUtil.isNullOrEmpty(keyword)) return productDao.findAll();
        return productDao.search(keyword.trim());
    }

    /** Total product count. */
    public int getTotalProductCount() { return productDao.countAll(); }

    /** Category breakdown. */
    public List<Object[]> getCategoryStats() { return productDao.countByCategory(); }
}
