package com.petsupply.model;

import java.math.BigDecimal;

/**
 * OrderItem entity — a single line item within an order.
 * Maps to the `order_items` table in the database.
 *
 * unit_price is stored at purchase time so historical orders
 * are not affected by future price changes.
 */
public class OrderItem {

    private int        id;
    private int        orderId;
    private int        productId;
    private int        quantity;
    private BigDecimal unitPrice;

    // Joined from products — loaded for display purposes
    private String productName;
    private String productImageUrl;

    public OrderItem(int productId, int quantity, BigDecimal unitPrice) {
        this.productId = productId;
        this.quantity  = quantity;
        this.unitPrice = unitPrice;
    }

    public OrderItem(int id, int orderId, int productId, int quantity, BigDecimal unitPrice) {
        this.id        = id;
        this.orderId   = orderId;
        this.productId = productId;
        this.quantity  = quantity;
        this.unitPrice = unitPrice;
    }

    // ── Getters ──────────────────────────────────────────────
    public int        getId()              { return id; }
    public int        getOrderId()         { return orderId; }
    public int        getProductId()       { return productId; }
    public int        getQuantity()        { return quantity; }
    public BigDecimal getUnitPrice()       { return unitPrice; }
    public String     getProductName()     { return productName; }
    public String     getProductImageUrl() { return productImageUrl; }

    // Calculated subtotal for this line item
    public BigDecimal getSubtotal() {
        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    // ── Setters ──────────────────────────────────────────────
    public void setId(int id)                        { this.id = id; }
    public void setQuantity(int q)                   { this.quantity = q; }
    public void setProductName(String n)             { this.productName = n; }
    public void setProductImageUrl(String u)         { this.productImageUrl = u; }
}
