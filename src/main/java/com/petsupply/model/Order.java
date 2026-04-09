package com.petsupply.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 * Order entity — represents a customer order.
 * Maps to the `orders` table in the database.
 *
 * Status: 'pending' | 'confirmed' | 'shipped' | 'delivered' | 'cancelled'
 */
public class Order {

    private int        id;
    private int        userId;
    private BigDecimal totalPrice;
    private String     status;
    private Timestamp  createdAt;
    private Timestamp  updatedAt;

    // Joined data — not in orders table, loaded separately
    private List<OrderItem> items;
    private String          userName;   // joined from users

    public Order(int userId, BigDecimal totalPrice) {
        this.userId     = userId;
        this.totalPrice = totalPrice;
        this.status     = "pending";
    }

    public Order(int id, int userId, BigDecimal totalPrice, String status,
                 Timestamp createdAt, Timestamp updatedAt) {
        this.id         = id;
        this.userId     = userId;
        this.totalPrice = totalPrice;
        this.status     = status;
        this.createdAt  = createdAt;
        this.updatedAt  = updatedAt;
    }

    // ── Getters ──────────────────────────────────────────────
    public int            getId()         { return id; }
    public int            getUserId()     { return userId; }
    public BigDecimal     getTotalPrice() { return totalPrice; }
    public String         getStatus()     { return status; }
    public Timestamp      getCreatedAt()  { return createdAt; }
    public Timestamp      getUpdatedAt()  { return updatedAt; }
    public List<OrderItem> getItems()     { return items; }
    public String         getUserName()   { return userName; }

    // ── Setters ──────────────────────────────────────────────
    public void setId(int id)                       { this.id = id; }
    public void setStatus(String s)                 { this.status = s; }
    public void setItems(List<OrderItem> items)     { this.items = items; }
    public void setUserName(String n)               { this.userName = n; }
    public void setTotalPrice(BigDecimal t)         { this.totalPrice = t; }

    @Override
    public String toString() {
        return "[Order#" + id + "] user=" + userId + " £" + totalPrice + " status=" + status;
    }
}
