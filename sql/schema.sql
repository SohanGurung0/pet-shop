-- ============================================================
-- Pet Supply Shop — MySQL Schema
-- CS5054NP Coursework Milestone 1
-- Run this in XAMPP phpMyAdmin or MySQL CLI
-- ============================================================

DROP DATABASE IF EXISTS pet_supply_shop;
CREATE DATABASE pet_supply_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pet_supply_shop;

-- ============================================================
-- TABLE: users
-- Stores registered customers and admin accounts.
-- Passwords are stored as BCrypt hashes (never plaintext).
-- New users default to role='user' and status='pending'
-- until an admin approves them.
-- ============================================================
CREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100)  NOT NULL,
    email       VARCHAR(150)  NOT NULL UNIQUE,
    phone       VARCHAR(20)   NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,           -- BCrypt hash
    role        ENUM('user','admin') NOT NULL DEFAULT 'user',
    status      ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Index on email for fast login lookups
CREATE INDEX idx_users_email  ON users(email);
CREATE INDEX idx_users_phone  ON users(phone);
CREATE INDEX idx_users_status ON users(status);

-- ============================================================
-- TABLE: products
-- Stores all pet supply products with category, stock, price.
-- ============================================================
CREATE TABLE products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(200)   NOT NULL UNIQUE,
    description TEXT,
    price       DECIMAL(10,2)  NOT NULL CHECK (price >= 0),
    category    ENUM('food','toy','vitamin','supplement') NOT NULL,
    image_url   VARCHAR(500)   DEFAULT 'images/default-product.png',
    stock       INT            NOT NULL DEFAULT 0 CHECK (stock >= 0),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Index for category-filtered browsing and search
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_name     ON products(name);

-- ============================================================
-- TABLE: orders
-- Represents a placed order by an approved user.
-- ============================================================
CREATE TABLE orders (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT           NOT NULL,
    total_price   DECIMAL(10,2) NOT NULL,
    status        ENUM('pending','confirmed','shipped','delivered','cancelled')
                  NOT NULL DEFAULT 'pending',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status  ON orders(status);

-- ============================================================
-- TABLE: order_items
-- Line items belonging to each order.
-- unit_price stored at time of purchase (price may change later).
-- ============================================================
CREATE TABLE order_items (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    order_id     INT           NOT NULL,
    product_id   INT           NOT NULL,
    quantity     INT           NOT NULL CHECK (quantity > 0),
    unit_price   DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_items_order   FOREIGN KEY (order_id)   REFERENCES orders(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX idx_order_items_order   ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);

-- ============================================================
-- SEED DATA
-- Default admin account (password: Admin@123)
-- Sample products across all four categories
-- ============================================================

-- Admin user — BCrypt of 'Admin@123' (cost=10)
INSERT INTO users (full_name, email, phone, password, role, status) VALUES
('Admin User',
 'admin@petsupply.com',
 '0000000000',
 '$2a$10$Bm00UioOASVRpSaa8M6Dket7tcBHLo27f0OnDfJLFKCnRYGyicPZW',
 'admin',
 'approved');

-- Sample products
INSERT INTO products (name, description, price, category, image_url, stock) VALUES
('Premium Puppy Kibble',    'High-protein puppy formula with real chicken, rice and DHA for brain development.',
 24.99, 'food',       'images/products/puppy-kibble.png',       50),
('Adult Dog Food — Salmon', 'Grain-free salmon & sweet potato recipe for adult dogs with sensitive stomachs.',
 29.99, 'food',       'images/products/adult-salmon.png',       40),
('Squeaky Rope Toy',        'Durable braided cotton rope with squeaky centre — great for tug-of-war.',
  8.99, 'toy',        'images/products/rope-toy.png',           80),
('Interactive Puzzle Ball', 'Treat-dispensing puzzle ball to keep curious dogs mentally stimulated.',
 14.99, 'toy',        'images/products/puzzle-ball.png',        35),
('Daily Multi-Vitamin',     'Complete daily vitamin supplement with Omega-3, Vitamin D & E for all breeds.',
 18.50, 'vitamin',    'images/products/multivitamin.png',       60),
('Joint Care Supplement',   'Glucosamine & chondroitin formula to support healthy joints in older dogs.',
 22.00, 'supplement', 'images/products/joint-care.png',         45),
('Dental Chew Sticks',      'Enzymatic dental chews that reduce tartar and freshen breath — pack of 20.',
 11.99, 'supplement', 'images/products/dental-chews.png',       70),
('Omega-3 Fish Oil',        'Pure wild-caught fish oil in soft gels to support coat shine and joint health.',
 16.75, 'vitamin',    'images/products/fish-oil.png',           55);
