package com.petsupply.model;

import java.sql.Timestamp;

/**
 * User entity — represents a registered user account.
 * Maps to the `users` table in the database.
 *
 * Passwords are stored as BCrypt hashes — never plaintext.
 * Role:   'user' | 'admin'
 * Status: 'pending' | 'approved' | 'rejected'
 */
public class User {

    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String password;       // BCrypt hash
    private String role;           // "user" or "admin"
    private String status;         // "pending", "approved", "rejected"
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor for new registration (before DB insert)
    public User(String fullName, String email, String phone, String password) {
        this.fullName = fullName;
        this.email    = email;
        this.phone    = phone;
        this.password = password;
        this.role     = "user";
        this.status   = "pending";
    }

    // Constructor for reading from database (full record)
    public User(int id, String fullName, String email, String phone,
                String password, String role, String status,
                Timestamp createdAt, Timestamp updatedAt) {
        this.id        = id;
        this.fullName  = fullName;
        this.email     = email;
        this.phone     = phone;
        this.password  = password;
        this.role      = role;
        this.status    = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ── Getters ──────────────────────────────────────────────
    public int       getId()        { return id; }
    public String    getFullName()  { return fullName; }
    public String    getEmail()     { return email; }
    public String    getPhone()     { return phone; }
    public String    getPassword()  { return password; }
    public String    getRole()      { return role; }
    public String    getStatus()    { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }

    // ── Setters ──────────────────────────────────────────────
    public void setId(int id)               { this.id = id; }
    public void setFullName(String n)       { this.fullName = n; }
    public void setEmail(String e)          { this.email = e; }
    public void setPhone(String p)          { this.phone = p; }
    public void setPassword(String pw)      { this.password = pw; }
    public void setRole(String r)           { this.role = r; }
    public void setStatus(String s)         { this.status = s; }

    // ── Convenience ──────────────────────────────────────────
    public boolean isAdmin()    { return "admin".equals(role); }
    public boolean isApproved() { return "approved".equals(status); }
    public boolean isPending()  { return "pending".equals(status); }

    @Override
    public String toString() {
        return "[" + id + "] " + fullName + " <" + email + "> role=" + role + " status=" + status;
    }
}
