#  Paw Furr-Ever Pet Supply E-Commerce Project

##  Overview
Paw Furr-Ever is a production-ready Java/J2EE web application for a pet supply store. It features a complete MVC architecture, secure authentication, admin dashboard for product management, and a responsive, pastel-themed UI.

This project is built as part of the CS5054NP Milestone 1 coursework.

##  Features
- **User Authentication**: Secure Login/Register with jBCrypt password hashing.
- **Admin Dashboard**:
    - **User Management**: Approve or reject new registrations.
    - **Product CRUD**: Full Create, Read, Update, and Delete capabilities for products.
- **Shopping Experience**:
    - Featured products on home page.
    - Product catalogue with category filters and keyword search.
    - Detailed product views with stock management.
    - Session-based Shopping Cart.
- **Responsive Design**: Built with pure CSS Flexbox and media queries (No Bootstrap).
- **Security**: Server-side validation, UTF-8 encoding filter, and session-based auth protection.

##  Technology Stack
- **Backend**: Java 11+, Jakarta EE (Servlets & JSP)
- **Database**: MySQL 8.0 (XAMPP)
- **Frontend**: JSP, JSTL, Vanilla CSS
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9/10


##  Setup Instructions

### 1. Database Setup
1. Start **XAMPP** and ensure **MySQL** is running on port 3306.
2. Open **MyAdmin** (`http://localhost/phpmyadmin`).
3. Create a new database named `pet_supply_shop`.
4. Import the file `sql/schema.sql` into the database.

### 2. intelij/IDE Setup
1. Open intelij IDE.
2. File -> Import -> Existing Maven Projects.
3. Select the `apt_cw` directory.
4. Right-click project -> Maven -> Update Project.

### 3. Deployment
1. Ensure your Tomcat server is configured in Eclipse.
2. Right-click the project -> Run As -> Run on Server.
3. Select your Tomcat server and click Finish.
4. The app will be available at `http://localhost:9090/pet-supply/`.

##  Default Accounts
- **Admin**: `admin@petsupply.com` / `Admin@123`
- **Note**: No default user accounts are pre-approved. New users register with status 'pending' and must be approved by an admin via the admin dashboard.

---

