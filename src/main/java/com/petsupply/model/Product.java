package com.petsupply.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Product entity — represents a pet supply product.
 * Maps to the `products` table in the database.
 *
 * Category: 'food' | 'toy' | 'vitamin' | 'supplement'
 */
public class Product {

    private int        id;
    private String     name;
    private String     description;
    private BigDecimal price;
    private String     category;    // food, toy, vitamin, supplement
    private String     imageUrl;
    private int        stock;
    private Timestamp  createdAt;
    private Timestamp  updatedAt;

    // Constructor for creating a new product (before DB insert)
    public Product(String name, String description, BigDecimal price,
                   String category, String imageUrl, int stock) {
        this.name        = name;
        this.description = description;
        this.price       = price;
        this.category    = category;
        this.imageUrl    = imageUrl;
        this.stock       = stock;
    }

    // Constructor for reading from database (full record)
    public Product(int id, String name, String description, BigDecimal price,
                   String category, String imageUrl, int stock,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.id          = id;
        this.name        = name;
        this.description = description;
        this.price       = price;
        this.category    = category;
        this.imageUrl    = imageUrl;
        this.stock       = stock;
        this.createdAt   = createdAt;
        this.updatedAt   = updatedAt;
    }

    // ── Getters ──────────────────────────────────────────────
    public int        getId()          { return id; }
    public String     getName()        { return name; }
    public String     getDescription() { return description; }
    public BigDecimal getPrice()       { return price; }
    public String     getCategory()    { return category; }
    public String     getImageUrl()    { return imageUrl; }
    public int        getStock()       { return stock; }
    public Timestamp  getCreatedAt()   { return createdAt; }
    public Timestamp  getUpdatedAt()   { return updatedAt; }

    // ── Setters ──────────────────────────────────────────────
    public void setId(int id)                    { this.id = id; }
    public void setName(String n)                { this.name = n; }
    public void setDescription(String d)         { this.description = d; }
    public void setPrice(BigDecimal p)           { this.price = p; }
    public void setCategory(String c)            { this.category = c; }
    public void setImageUrl(String u)            { this.imageUrl = u; }
    public void setStock(int s)                  { this.stock = s; }

    // ── Convenience ──────────────────────────────────────────
    public boolean isInStock()     { return stock > 0; }
    public String  getCategoryLabel() {
        if (name == null) return "";
        switch (category) {
            case "food":       return "Dog Food";
            case "toy":        return "Toys";
            case "vitamin":    return "Vitamins";
            case "supplement": return "Supplements";
            default:           return category;
        }
    }

    @Override
    public String toString() {
        return "[" + id + "] " + name + " (" + category + ") £" + price + " stock=" + stock;
    }
}
