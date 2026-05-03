#  Paw Furr-Ever Pet Supply E-Commerce Project

##  Overview
Paw Furr-Ever is a production-ready Java/J2EE web application for a pet supply store. It features a complete MVC architecture, secure authentication, admin dashboard for product management, and a responsive, pastel-themed UI.



##  Technology Stack
- **Backend**: Java 11+, Jakarta EE (Servlets & JSP)
- **Database**: MySQL 8.0 (XAMPP)
- **Frontend**: JSP, JSTL, CSS
- **Build Tool**: Maven
- **Server**: Apache Tomcat 10


##  Setup Instructions

### 1. Database Setup
1. Start **XAMPP** and ensure **MySQL** is running on port 3306.
2. Open **MyAdmin** (`http://localhost/phpmyadmin`).
3. Create a new database named `pet_supply_shop`.
4. Import the file `sql/schema.sql` into the database.

### 2. intelij/IDE Setup
1. Open intelij IDE.
2. File -> open pet-shop.

### 3. Deployment
1. goto terminal run `mvn clean package cargo:run`.
2. The app will be available at `http://localhost:9090/pet-supply/`.

##  Project Structure

```text
pet-shop/
├── sql/
│   └── schema.sql              # Database schema & seed data
├── src/main/java/
│   └── com.petsupply/
│       ├── controller/         # Servlets (Login, Register, Cart, Home)
│       ├── dao/                # Data Access Objects (JDBC)
│       ├── filter/             # AuthFilter & EncodingFilter
│       ├── model/              # Domain Models (Product, User, Cart)
│       ├── service/            # Business Logic & Validation
│       └── utils/              # DatabaseConnection, BCrypt, ImageUtil , cookies , session
├── src/main/webapp/
│   ├── css/                    # Stylesheets (home.css, admin.css, etc.)
│   ├── images/                 # Static branding & default assets
│   └── WEB-INF/
│       ├── templates/          # Header, Nav, Footer fragments
│       └── views/              # JSP Pages
│           ├── admin/          # Dashboard, Product CRUD forms
│           ├── error/          # 404 and 500 error pages
│           ├── home.jsp        # Landing page
│           ├── products.jsp    # Product catalogue
│           └── cart.jsp        # Shopping cart view
├── pom.xml                     # Maven project configuration
└── FLOWS.md                    # Detailed logic & architectural flows

External Storage:
└── ~/pet-supply-uploads/       # Permanent storage for uploaded product images
```

---

##  Logic Flows

### 1. Registration & Approval Flow
1. **Submit**: New user submits registration form (`RegisterServlet`).
2. **Security**: Password is hashed using **jBCrypt** before database entry.
3. **Pending Status**: User is created with `status = 'pending'`.
4. **Admin Review**: Admin logs in and visits the **Admin Dashboard > Users**.
5. **Approval**: Admin clicks "Approve". `AdminUserServlet` updates status to 'approved'.
6. **Access**: Only approved users can bypass the `AuthFilter` to access protected pages.

### 2. Secure Authentication Flow
1. **Login**: User submits credentials to `LoginServlet`.
2. **Verification**: System fetches user by email and compares hashes using `BCrypt.checkpw`.
3. **Session Management**: On success, user ID, name, and role are stored in the `HttpSession`.
4. **Cookie Persistence**: Optional "Remember Me" functionality stores email in a secure cookie.
5. **Filter Protection**: `AuthFilter` intercepts requests to `/admin/*`, `/cart`, and `/checkout`, ensuring the user is logged in, approved, and has the correct role.

### 3. Product CRUD & File Management
1. **Create/Update**: Admin submits product form with `enctype="multipart/form-data"`.
2. **Image Upload**: `ImageUtil` saves the file to `~/pet-supply-uploads/` with a unique timestamped filename.
3. **Database Entry**: `AdminProductServlet` saves the relative image filename in the MySQL `products` table.
4. **Serving**: `ImageServlet` handles `/uploads/*` requests by streaming file bytes from the external storage folder.
5. **Cleanup**: When a product is deleted or its image is replaced, `ImageUtil` automatically deletes the old file from the disk to save space.

### 4. Shopping Cart Flow
1. **Add to Cart**: Users click "Add to Cart" on the shop page.
2. **State**: `CartServlet` stores the cart object in the user's **Session**, allowing it to persist across page reloads.
3. **Management**: Users can update quantities or remove items directly in the cart view.
4. **Checkout**: `CheckoutServlet` (Placeholder for M2) ensures the user is logged in before allowing them to proceed.

---

##  Default Accounts
- **Admin**: `admin@petsupply.com` / `Admin@123`
- **Note**: New users register with status 'pending' and must be approved by an admin via the admin dashboard.

---

