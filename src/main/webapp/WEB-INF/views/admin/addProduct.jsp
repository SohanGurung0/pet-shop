<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Add Product — PawShop Admin</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
</head>
<body class="admin-body">

<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="admin-sidebar__brand"><span class="nav-logo">🐾</span><span>PawShop Admin</span></div>
    <nav class="admin-nav">
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav__link"><span class="admin-nav__icon">📊</span> Dashboard</a>
      <a href="${pageContext.request.contextPath}/admin/products"  class="admin-nav__link admin-nav__link--active"><span class="admin-nav__icon">📦</span> Products</a>
      <a href="${pageContext.request.contextPath}/admin/users"     class="admin-nav__link"><span class="admin-nav__icon">👥</span> Users</a>
      <div class="admin-nav__divider"></div>
      <a href="${pageContext.request.contextPath}/home"   class="admin-nav__link"><span class="admin-nav__icon">🏠</span> View Shop</a>
      <a href="${pageContext.request.contextPath}/logout" class="admin-nav__link admin-nav__link--logout"><span class="admin-nav__icon">🚪</span> Logout</a>
    </nav>
  </aside>

  <main class="admin-main">
    <div class="admin-topbar">
      <div>
        <h1 class="admin-page-title">Add New Product</h1>
        <p class="admin-page-subtitle">
          <a href="${pageContext.request.contextPath}/admin/products">← Back to Products</a>
        </p>
      </div>
    </div>

    <c:if test="${not empty error}">
      <div class="alert alert--error"><c:out value="${error}"/></div>
    </c:if>

    <div class="admin-card admin-form-card">
      <form action="${pageContext.request.contextPath}/admin/products?action=add"
            method="post" id="addProductForm" novalidate>

        <div class="form-grid-2">

          <div class="form-group">
            <label for="name" class="form-label">Product Name <span class="required">*</span></label>
            <input type="text" id="name" name="name" class="form-input"
                   placeholder="e.g. Premium Puppy Kibble"
                   value="<c:out value='${param.name}' default=''/>"
                   required minlength="2" maxlength="200"/>
            <small class="form-hint">Must be unique across all products</small>
          </div>

          <div class="form-group">
            <label for="category" class="form-label">Category <span class="required">*</span></label>
            <select id="category" name="category" class="form-input form-select" required>
              <option value="">— Select category —</option>
              <option value="food"       ${param.category == 'food'       ? 'selected' : ''}>🦴 Dog Food</option>
              <option value="toy"        ${param.category == 'toy'        ? 'selected' : ''}>🎾 Toy</option>
              <option value="vitamin"    ${param.category == 'vitamin'    ? 'selected' : ''}>💊 Vitamin</option>
              <option value="supplement" ${param.category == 'supplement' ? 'selected' : ''}>🌿 Supplement</option>
            </select>
          </div>

          <div class="form-group">
            <label for="price" class="form-label">Price (£) <span class="required">*</span></label>
            <input type="number" id="price" name="price" class="form-input"
                   placeholder="0.00" step="0.01" min="0"
                   value="<c:out value='${param.price}' default=''/>"
                   required/>
          </div>

          <div class="form-group">
            <label for="stock" class="form-label">Stock Quantity <span class="required">*</span></label>
            <input type="number" id="stock" name="stock" class="form-input"
                   placeholder="0" min="0"
                   value="<c:out value='${param.stock}' default='0'/>"
                   required/>
            <small class="form-hint">Must be 0 or greater</small>
          </div>

        </div>

        <div class="form-group">
          <label for="description" class="form-label">Description</label>
          <textarea id="description" name="description" class="form-input form-textarea"
                    placeholder="Describe the product features, ingredients, benefits…"
                    rows="4"><c:out value='${param.description}' default=''/></textarea>
        </div>

        <div class="form-group">
          <label for="imageUrl" class="form-label">Image URL / Path</label>
          <input type="text" id="imageUrl" name="imageUrl" class="form-input"
                 placeholder="images/products/my-product.png"
                 value="<c:out value='${param.imageUrl}' default=''/>"/>
          <small class="form-hint">Relative path from webapp root, e.g. images/products/food.png. Leave blank for default.</small>
        </div>

        <div class="form-actions">
          <button type="submit" id="addProductBtn" class="btn btn--primary">Add Product</button>
          <a href="${pageContext.request.contextPath}/admin/products" class="btn btn--ghost">Cancel</a>
        </div>

      </form>
    </div>
  </main>
</div>

</body>
</html>
