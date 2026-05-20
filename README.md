# 🐾 Paw Furr-Ever Pet Supply E-Commerce

[![Java Version](https://img.shields.io/badge/Java-17%2B-orange.svg?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue.svg?style=for-the-badge&logo=jakartaee&logoColor=white)](https://jakarta.ee/)
[![Apache Tomcat](https://img.shields.io/badge/Tomcat-10.1.x-red.svg?style=for-the-badge&logo=apachetomcat&logoColor=white)](https://tomcat.apache.org/)
[![Database](https://img.shields.io/badge/MySQL-8.0-blue.svg?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Build Tool](https://img.shields.io/badge/Maven-3.8%2B-red.svg?style=for-the-badge&logo=apachemaven&logoColor=white)](https://maven.apache.org/)

Paw Furr-Ever is a feature-rich, production-ready Java/J2EE web application built for a pet supply store. It features a complete Model-View-Controller (MVC) architecture, secure password hashing, role-based authorization filters, an administrative control panel, dynamic cart calculations, transactional checkout, and a beautifully polished responsive user interface.

---

## 🌟 Core Features

### 👤 Customer Experience
*   **Secure Authentication**: Self-service user registration with secure, non-reversible **BCrypt** password hashing.
*   **Approval-Gate Security**: Registered users start in a `pending` state and cannot access system functions until activated/approved by an administrator.
*   **Interactive Catalog**: Filterable product inventory across multiple categories: **Food**, **Toys**, **Vitamins**, and **Supplements**.
*   **Dynamic Cart & Checkouts**: Real-time cart quantity additions, removals, and subtotal calculation, leading to a secure checkout form.
*   **Transactional Order Confirmation**: Automated stock deduction and atomic checkout transactions.
*   **Detailed Invoicing**: Order history dashboard with dedicated printable receipt/order detail views.

### 🛡️ Admin Dashboard & Analytics
*   **Sales Performance Analytics**: Live, interactive dashboard visualization containing a 7-day revenue performance line chart powered by **Chart.js**.
*   **User Management**: View pending user registrations and approve/reject accounts.
*   **Product CRUD Management**: Create, view, edit, and delete products, including uploading images.
*   **Order Fulfillment Tracking**: Track orders and progress them through fulfillment states: `Pending ➔ Confirmed ➔ Shipped ➔ Delivered`.
*   **Order Maintenance**: Full capability to clean up and delete historical orders.

---


## 🛠️ Technology Stack

| Component | Technology | Version | Purpose |
| :--- | :--- | :--- | :--- |
| **Language** | Java JDK | 17+ | Core platform language |
| **Backend Framework** | Jakarta EE (Servlets & JSP) | 10.0 (API: Servlet 6.1, JSP 4.0) | Controller and View-rendering logic |
| **Database** | MySQL | 8.0+ | Persistent relational storage |
| **Frontend Libraries** | JSTL (Glassfish Impl) | 3.0.2 / 3.0.1 | Tag libraries for dynamic JSP page rendering |
| **Security** | jBCrypt | 0.4 | Secure salt generation & password hashing |
| **Build & Deploy** | Apache Maven / Cargo Plugin | 3.8+ / Cargo 1.10.15 | Dependency management & Tomcat embedded container |
| **Server** | Apache Tomcat | 10.1.34 | Servlets container running the application |

---

## 📁 Project Structure

The project follows a standard Maven web application structure organized by MVC responsibilities:

```text
pet-shop/
├── sql/
│   └── schema.sql              # Database schema definition, indexing, & seed data
├── src/main/java/
│   └── com/petsupply/
│       ├── controller/         # Servlets handling requests (Login, Cart, Register, Checkout)
│       │   └── admin/          # Admin-specific controllers (Dashboard, User & Product CRUD)
│       ├── dao/                # Data Access Objects (JDBC database interactions)
│       ├── filter/             # Security (AuthFilter) & character encoding (EncodingFilter)
│       ├── model/              # Domain entities (User, Product, Order, OrderItem)
│       ├── service/            # Business validation & coordinator services
│       └── utils/              # Helper utilities (DatabaseConnection, PasswordUtil, ImageUtil, SessionUtil)
├── src/main/webapp/
│   ├── css/                    # Modular stylesheets (home.css, admin.css, details.css)
│   ├── images/                 # Static local branding assets & default images
│   ├── WEB-INF/
│   │   ├── templates/          # Fragment files (header.jsp, nav.jsp, footer.jsp)
│   │   └── views/              # View JSPs (cart, products, checkout, register, error folders)
│   │       └── admin/          # JSPs for the administrative dashboards
│   └── index.jsp               # Root entry page (redirects to /home)
├── pom.xml                     # Maven build config, dependencies & embedded Cargo container
```

---

## 🚀 Setup & Installation Instructions

Follow these steps to run Paw Furr-Ever locally on your machine:

### 1. Database Setup
1. Start your **MySQL** server (via **XAMPP** or your local MySQL installation) on port `3306`.
2. Connect to MySQL using a client or open **phpMyAdmin** (`http://localhost/phpmyadmin`).
3. Create a database named `pet_supply_shop`:
   ```sql
   CREATE DATABASE pet_supply_shop;
   ```
4. Import the schema and seed data by running the script located at [sql/schema.sql](file:///e:/Antiii/Clg/proj/pet-shop/sql/schema.sql) in your database tool.

### 2. External Image Upload Folder
To prevent product images uploaded by admins from being deleted whenever Maven compiles or cleans the project target folder, they are stored externally.
*   The project automatically creates a folder named `pet-supply-uploads` in your home directory:
    *   **Windows**: `C:\Users\<Username>\pet-supply-uploads`
    *   **macOS/Linux**: `~/pet-supply-uploads`
*   Ensure the application has write permissions to create folders in the user home directory.

### 3. Build & Run
The project uses the Maven Cargo plugin to run an embedded Tomcat 10 container without needing a separate Tomcat installation.

1. Open your terminal in the project root directory.
2. Build the package and launch Tomcat using:
   ```bash
   mvn clean package cargo:run
   ```
3. Once the terminal shows Tomcat is running, open your web browser and navigate to:
   ```http
   http://localhost:9090/pet-supply/
   ```

> [!TIP]
> To run Tomcat on a different port, you can override the default servlet port using:
> `mvn clean package cargo:run -Dcargo.servlet.port=YOUR_PORT_NUMBER`

---

## 🔑 Default Accounts

Use the following credentials to access the system:

| Role | Username / Email | Password |
| :--- | :--- | :--- |
| **Administrator** | `admin@petsupply.com` | `Admin@123` |
| **Standard User** | *Register an account and approve it via the admin panel* | *User-defined* |

> [!WARNING]
> Standard registered users will be in `pending` status upon registration. You must log in with the administrator account, navigate to **Manage Users**, and approve their account before they can log in.

---
