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
│       ├── controller/         # Servlets (Login, Register, Cart, Checkout, Orders)
│       ├── dao/                # Data Access Objects (JDBC)
│       ├── filter/             # AuthFilter & EncodingFilter
│       ├── model/              # Domain Models (Product, User, Order)
│       ├── service/            # Business Logic & Validation
│       └── utils/              # DatabaseConnection, BCrypt, ImageUtil, cookies, session
├── src/main/webapp/
│   ├── css/                    # Stylesheets (home.css, admin.css, etc.)
│   ├── images/                 # Static branding & default assets
│   └── WEB-INF/
│       ├── templates/          # Header, Nav, Footer fragments
│       └── views/              # JSP Pages
│           ├── admin/          # Dashboard, Product CRUD, Order Management
│           ├── error/          # 404 and 500 error pages
│           ├── home.jsp        # Landing page
│           ├── products.jsp    # Product catalogue
│           ├── cart.jsp        # Shopping cart view
│           ├── checkout.jsp    # Secure checkout form
│           ├── orderHistory.jsp # User's past orders
│           └── orderDetail.jsp # Detailed order receipt view
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
4. **Filter Protection**: `AuthFilter` intercepts requests to `/admin/*`, `/cart`, and `/checkout`, ensuring the user is logged in, approved, and has the correct role.

### 3. Product CRUD & File Management
1. **Create/Update**: Admin submits product form with `enctype="multipart/form-data"`.
2. **Image Upload**: `ImageUtil` saves the file to `~/pet-supply-uploads/` with a unique timestamped filename.
3. **Database Entry**: `AdminProductServlet` saves the relative image filename in the MySQL `products` table.
4. **Serving**: `ImageServlet` handles `/uploads/*` requests by streaming file bytes from the external storage folder.

### 4. Checkout & Order Processing
1. **Validation**: `CheckoutServlet` ensures only logged-in, approved users with the `user` role can checkout.
2. **Details**: User provides shipping address; payment is restricted to **Cash on Delivery (COD)** for this version.
3. **Atomic Transaction**: `OrderDao` performs a database transaction that:
   - Inserts the main order record.
   - Inserts each item into `order_items`.
   - **Reduces product stock** levels automatically.
4. **Success**: User is redirected to home with a success popup and can view the order in **My Orders**.

### 5. Admin Order Management & Analytics
1. **Analytics**: Admin dashboard features a **Sales Performance Graph** (Chart.js) showing revenue trends for the last 7 days.
2. **Tracking**: Admin can view all customer orders and their current fulfillment status.
3. **Workflow**: Admin can update order status (Pending → Confirmed → Shipped → Delivered).
4. **Maintenance**: Admin has the authority to delete past order records from the system.

---

##  Default Accounts
- **Admin**: `admin@petsupply.com` / `Admin@123`

---

