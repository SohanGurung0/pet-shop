package com.petsupply.dao;

import com.petsupply.model.Product;
import java.util.List;

/**
 * ProductDao — interface for all product database operations.
 */
public interface ProductDao {

    /** Insert a new product. Returns false if a product with the same name exists. */
    boolean insertProduct(Product product);

    /** Find a product by primary key. Returns null if not found. */
    Product findById(int id);

    /** Find a product by exact name (case-insensitive). Returns null if not found. */
    Product findByName(String name);

    /** Return all products, newest first. */
    List<Product> findAll();

    /** Return all products in a given category. */
    List<Product> findByCategory(String category);

    /**
     * Search products whose name or description contains the keyword (case-insensitive).
     * @param keyword the search term
     * @return matching products
     */
    List<Product> search(String keyword);

    /**
     * Update an existing product record.
     * @return true if the row was updated
     */
    boolean updateProduct(Product product);

    /**
     * Delete a product by its primary key.
     * @return true if the row was deleted
     */
    boolean deleteProduct(int id);

    /** Count total number of products in the catalogue. */
    int countAll();

    /** Count products grouped by category — returns list of Object[]{category, count}. */
    List<Object[]> countByCategory();
}
