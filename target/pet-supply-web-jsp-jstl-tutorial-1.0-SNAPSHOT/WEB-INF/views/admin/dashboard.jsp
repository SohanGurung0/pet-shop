<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard — PawShop</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
</head>
<body class="admin-body">

<%-- ═══ ADMIN SIDEBAR ═════════════════════════════════════════ --%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="admin-sidebar__brand">
      <span class="nav-logo">🐾</span>
      <span>PawShop Admin</span>
    </div>
    <nav class="admin-nav">
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav__link admin-nav__link--active">
        <span class="admin-nav__icon">📊</span> Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/admin/products" class="admin-nav__link">
        <span class="admin-nav__icon">📦</span> Products
      </a>
      <a href="${pageContext.request.contextPath}/admin/users" class="admin-nav__link">
        <span class="admin-nav__icon">👥</span> Users
        <c:if test="${pendingUsers > 0}">
          <span class="nav-badge">${pendingUsers}</span>
        </c:if>
      </a>
      <div class="admin-nav__divider"></div>
      <a href="${pageContext.request.contextPath}/home" class="admin-nav__link">
        <span class="admin-nav__icon">🏠</span> View Shop
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="admin-nav__link admin-nav__link--logout">
        <span class="admin-nav__icon">🚪</span> Logout
      </a>
    </nav>
  </aside>

  <%-- ═══ ADMIN MAIN CONTENT ══════════════════════════════════ --%>
  <main class="admin-main">

    <%-- Top bar --%>
    <div class="admin-topbar">
      <div>
        <h1 class="admin-page-title">Dashboard</h1>
        <p class="admin-page-subtitle">
          Welcome back, <strong><c:out value="${sessionScope.userName}"/></strong>
        </p>
      </div>
      <a href="${pageContext.request.contextPath}/admin/products?action=add"
         class="btn btn--primary">+ Add Product</a>
    </div>

    <%-- Flash messages --%>
    <c:if test="${not empty sessionScope.successMsg}">
      <div class="alert alert--success"><c:out value="${sessionScope.successMsg}"/></div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMsg}">
      <div class="alert alert--error"><c:out value="${sessionScope.errorMsg}"/></div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <%-- STAT CARDS --%>
    <div class="stat-grid">
      <div class="stat-card stat-card--blue">
        <div class="stat-card__icon">📦</div>
        <div class="stat-card__body">
          <div class="stat-card__value">${totalProducts}</div>
          <div class="stat-card__label">Total Products</div>
        </div>
      </div>
      <div class="stat-card stat-card--mint">
        <div class="stat-card__icon">👥</div>
        <div class="stat-card__body">
          <div class="stat-card__value">${totalUsers}</div>
          <div class="stat-card__label">Registered Users</div>
        </div>
      </div>
      <div class="stat-card stat-card--peach">
        <div class="stat-card__icon">⏳</div>
        <div class="stat-card__body">
          <div class="stat-card__value">${pendingUsers}</div>
          <div class="stat-card__label">Pending Approvals</div>
        </div>
      </div>
      <div class="stat-card stat-card--lavender">
        <div class="stat-card__icon">🗂️</div>
        <div class="stat-card__body">
          <div class="stat-card__value">4</div>
          <div class="stat-card__label">Categories</div>
        </div>
      </div>
    </div>

    <%-- TWO-COLUMN LOWER SECTION --%>
    <div class="dashboard-grid">

      <%-- Recent Products table --%>
      <div class="admin-card">
        <div class="admin-card__header">
          <h2 class="admin-card__title">Recent Products</h2>
          <a href="${pageContext.request.contextPath}/admin/products" class="card-link">View all →</a>
        </div>
        <table class="admin-table">
          <thead>
            <tr><th>Name</th><th>Category</th><th>Price</th><th>Stock</th></tr>
          </thead>
          <tbody>
            <c:forEach var="p" items="${recentProducts}">
              <tr>
                <td><c:out value="${p.name}"/></td>
                <td><span class="product-badge product-badge--${p.category}"><c:out value="${p.category}"/></span></td>
                <td>£<c:out value="${p.price}"/></td>
                <td>
                  <c:choose>
                    <c:when test="${p.stock > 0}"><span class="stock-badge stock-badge--in">${p.stock}</span></c:when>
                    <c:otherwise><span class="stock-badge stock-badge--out">0</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <%-- Pending users approval widget --%>
      <div class="admin-card">
        <div class="admin-card__header">
          <h2 class="admin-card__title">Pending Approvals</h2>
          <a href="${pageContext.request.contextPath}/admin/users" class="card-link">View all →</a>
        </div>
        <c:choose>
          <c:when test="${not empty pendingUserList}">
            <ul class="pending-list">
              <c:forEach var="u" items="${pendingUserList}">
                <li class="pending-item">
                  <div class="pending-item__info">
                    <strong><c:out value="${u.fullName}"/></strong>
                    <span class="pending-item__email"><c:out value="${u.email}"/></span>
                  </div>
                  <div class="pending-item__actions">
                    <a href="${pageContext.request.contextPath}/admin/users?action=approve&id=${u.id}"
                       class="btn btn--success btn--xs">Approve</a>
                    <a href="${pageContext.request.contextPath}/admin/users?action=reject&id=${u.id}"
                       class="btn btn--danger btn--xs">Reject</a>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </c:when>
          <c:otherwise>
            <p class="empty-state" style="padding:1.5rem;">No pending approvals 🎉</p>
          </c:otherwise>
        </c:choose>
      </div>

    </div><%-- end dashboard-grid --%>

  </main>
</div>

</body>
</html>
