# Paw Furr-Ever — Logic Flows & Architecture

This document explains the step-by-step technical flow of the application's core functions.

---

## 1. User Registration & Admin Approval

This flow ensures that new users can register but cannot access the shop until an administrator manually verifies them.

### Registration Flow:
1.  **Submission**: User fills the registration form in `register.jsp`.
2.  **Validation**: `RegisterServlet` validates inputs (email format, password strength, etc.).
3.  **Hashing**: `UserService` uses `jBCrypt.hashpw()` to encrypt the password before it touches the database.
4.  **Persistence**: The user is stored in the `users` table with a `status = 'pending'` and `role = 'user'`.
5.  **Redirect**: The user is sent to a "Pending Approval" page.

### Approval Flow:
1.  **Dashboard**: Admin logs in and visits the **Admin Dashboard > Users**.
2.  **Lookup**: `AdminUserServlet` fetches all users with `status = 'pending'`.
3.  **Action**: Admin clicks "Approve".
4.  **Update**: `AdminUserServlet` updates the user's status to `'approved'` in the MySQL database.

---

## 2. Secure Authentication Flow

Uses session management to track authenticated users across different pages.

1.  **Login Submission**: User submits email/password to `LoginServlet`.
2.  **Credential Check**: System fetches the user record by email.
3.  **Verification**: `BCrypt.checkpw()` compares the plain-text password with the stored hash.
4.  **Session Establishment**:
    *   On success, the user object and role are stored in the `HttpSession`.
    *   Important attributes: `userId`, `userName`, `userRole`.
5.  **Cookie Persistence**: If "Remember Me" is checked, the email is stored in a secure browser cookie via `CookieUtil`.

---

## 3. Shopping Cart Flow

Manages user selections during a single browser session.

1.  **Interaction**: User clicks "Add to Cart" on a product card (`products.jsp` or `home.jsp`).
2.  **Request**: `CartServlet` receives the `productId` and `quantity`.
3.  **Logic**:
    *   If a cart doesn't exist in the session, a new one is created.
    *   The product is added to a `Map<Integer, CartItem>`.
4.  **State**: The cart is stored in the **HTTPSession**, meaning it stays active as long as the user doesn't close their browser.
5.  **View**: `cart.jsp` iterates through the session cart to display totals.

---

## 4. Admin Product CRUD (with File Management)

This flow handles the lifecycle of products and their physical images.

### Create Product:
1.  **Form**: Admin fills `addProduct.jsp` with `enctype="multipart/form-data"`.
2.  **Multipart Handling**: `AdminProductServlet` (using `@MultipartConfig`) extracts the `Part` (the image file).
3.  **File Storage**: `ImageUtil` saves the file to `~/pet-supply-uploads/` with a unique timestamped filename.
4.  **Database**: `ProductService` saves the product name, price, category, and the **image filename** in the DB.

### Update Product:
1.  **Preview**: `editProduct.jsp` displays the current image preview.
2.  **Change**: If a new file is uploaded, `ImageUtil` saves the new file and **deletes the old file** from the disk.
3.  **Database**: The `image_url` column is updated with the new filename.

### Delete Product:
1.  **Command**: Admin clicks "Delete".
2.  **Cleanup**: `ProductService` calls `ImageUtil.deleteImage()` first.
3.  **Removal**: The file is deleted from the server disk, and the database record is removed.

---

## 5. Security Filter (AuthFilter)

Every single request to the server passes through this "Bouncer."

1.  **Public Bypass**: URLs like `/login`, `/register`, and `/uploads/*` (images) are allowed for everyone.
2.  **Auth Check**: Checks if `loggedUser` exists in the session.
3.  **Approval Check**: Checks if `user.isApproved()` is true.
4.  **Role Check**: If the URL starts with `/admin`, it checks if `user.getRole() == 'admin'`.
5.  **Interception**: If any check fails, the user is redirected to `/login` or `/home`.

---

## 6. File System Summary

*   **src/main/java**: All Java logic (MVC).
*   **src/main/webapp**: All JSP views and CSS.
*   **sql/schema.sql**: Database structure.
*   **~/pet-supply-uploads/**: External storage for dynamic images.
