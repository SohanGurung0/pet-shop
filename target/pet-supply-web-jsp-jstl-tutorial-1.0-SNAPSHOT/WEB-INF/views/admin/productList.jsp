<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Manage Products — PawShop Admin</title>
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
      <a href="${pageContext.request.contextPath}/admin/products" class="admin-nav__link admin-nav__link--active"><span class="admin-nav__icon">📦</span> Products</a>
      <a href="${pageContext.request.contextPath}/admin/users"    class="admin-nav__link"><span class="admin-nav__icon">👥</span> Users</a>
      <div class="admin-nav__divider"></div>
      <a href="${pageContext.request.contextPath}/home"    class="admin-nav__link"><span class="admin-nav__icon">🏠</span> View Shop</a>
      <a href="${pageContext.request.contextPath}/logout"  class="admin-nav__link admin-nav__link--logout"><span class="admin-nav__icon">🚪</span> Logout</a>
    </nav>
  </aside>

  <main class="admin-main">
    <div class="admin-topbar">
      <div>
        <h1 class="admin-page-title">Products</h1>
        <p class="admin-page-subtitle">${products.size()} products in catalogue</p>
      </div>
      <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn--primary">+ Add Product</a>
    </div>

    <c:if test="${not empty sessionScope.successMsg}">
      <div class="alert alert--success"><c:out value="${sessionScope.successMsg}"/></div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMsg}">
      <div class="alert alert--error"><c:out value="${sessionScope.errorMsg}"/></div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <div class="admin-card">
      <table class="admin-table admin-table--striped">
        <thead>
          <tr>
            <th>#</th>
            <th>Image</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="p" items="${products}">
            <tr>
              <td class="text-muted">${p.id}</td>
              <td>
                <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                     alt="<c:out value='${p.name}'/>"
                     class="admin-table-thumb"
                     onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
              </td>
              <td><strong><c:out value="${p.name}"/></strong></td>
              <td><span class="product-badge product-badge--${p.category}"><c:out value="${p.category}"/></span></td>
              <td>£<c:out value="${p.price}"/></td>
              <td>
                <c:choose>
                  <c:when test="${p.stock > 0}"><span class="stock-badge stock-badge--in">${p.stock}</span></c:when>
                  <c:otherwise><span class="stock-badge stock-badge--out">0</span></c:otherwise>
                </c:choose>
              </td>
              <td class="table-actions">
                <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}"
                   class="btn btn--outline btn--xs">✏️ Edit</a>
                <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}"
                   class="btn btn--danger btn--xs"
                   onclick="return confirm('Delete \'${p.name}\'? This cannot be undone.');">🗑️ Delete</a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty products}">
            <tr><td colspan="7" class="text-center text-muted">No products yet. <a href="${pageContext.request.contextPath}/admin/products?action=add">Add one!</a></td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </main>
</div>

</body>
</html>
