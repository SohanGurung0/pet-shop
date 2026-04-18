<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Manage Users — PawShop Admin</title>
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
      <a href="${pageContext.request.contextPath}/admin/products"  class="admin-nav__link"><span class="admin-nav__icon">📦</span> Products</a>
      <a href="${pageContext.request.contextPath}/admin/users"     class="admin-nav__link admin-nav__link--active"><span class="admin-nav__icon">👥</span> Users</a>
      <div class="admin-nav__divider"></div>
      <a href="${pageContext.request.contextPath}/home"   class="admin-nav__link"><span class="admin-nav__icon">🏠</span> View Shop</a>
      <a href="${pageContext.request.contextPath}/logout" class="admin-nav__link admin-nav__link--logout"><span class="admin-nav__icon">🚪</span> Logout</a>
    </nav>
  </aside>

  <main class="admin-main">
    <div class="admin-topbar">
      <div>
        <h1 class="admin-page-title">Users</h1>
        <p class="admin-page-subtitle">${users.size()} registered users</p>
      </div>
    </div>

    <c:if test="${not empty sessionScope.successMsg}">
      <div class="alert alert--success"><c:out value="${sessionScope.successMsg}"/></div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMsg}">
      <div class="alert alert--error"><c:out value="${sessionScope.errorMsg}"/></div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <%-- Pending users highlighted section --%>
    <c:if test="${not empty pendingUsers}">
      <div class="admin-card" style="border-left: 4px solid var(--color-accent); margin-bottom:1.5rem;">
        <div class="admin-card__header">
          <h2 class="admin-card__title">⏳ Pending Approvals (${pendingUsers.size()})</h2>
        </div>
        <table class="admin-table">
          <thead><tr><th>Name</th><th>Email</th><th>Phone</th><th>Registered</th><th>Actions</th></tr></thead>
          <tbody>
            <c:forEach var="u" items="${pendingUsers}">
              <tr>
                <td><strong><c:out value="${u.fullName}"/></strong></td>
                <td><c:out value="${u.email}"/></td>
                <td><c:out value="${u.phone}"/></td>
                <td class="text-muted">${u.createdAt}</td>
                <td class="table-actions">
                  <a href="${pageContext.request.contextPath}/admin/users?action=approve&id=${u.id}"
                     class="btn btn--success btn--xs">✓ Approve</a>
                  <a href="${pageContext.request.contextPath}/admin/users?action=reject&id=${u.id}"
                     class="btn btn--danger btn--xs">✕ Reject</a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>

    <%-- All users table --%>
    <div class="admin-card">
      <div class="admin-card__header">
        <h2 class="admin-card__title">All Users</h2>
      </div>
      <table class="admin-table admin-table--striped">
        <thead>
          <tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Status</th><th>Actions</th></tr>
        </thead>
        <tbody>
          <c:forEach var="u" items="${users}">
            <tr>
              <td class="text-muted">${u.id}</td>
              <td><strong><c:out value="${u.fullName}"/></strong></td>
              <td><c:out value="${u.email}"/></td>
              <td><c:out value="${u.phone}"/></td>
              <td>
                <c:choose>
                  <c:when test="${u.role == 'admin'}">
                    <span class="role-badge role-badge--admin">Admin</span>
                  </c:when>
                  <c:otherwise>
                    <span class="role-badge role-badge--user">User</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${u.status == 'approved'}"><span class="status-badge status-badge--approved">Approved</span></c:when>
                  <c:when test="${u.status == 'pending'}"> <span class="status-badge status-badge--pending">Pending</span></c:when>
                  <c:otherwise>                            <span class="status-badge status-badge--rejected">Rejected</span></c:otherwise>
                </c:choose>
              </td>
              <td class="table-actions">
                <c:if test="${u.status != 'approved' && u.role != 'admin'}">
                  <a href="${pageContext.request.contextPath}/admin/users?action=approve&id=${u.id}"
                     class="btn btn--success btn--xs">Approve</a>
                </c:if>
                <c:if test="${u.status != 'rejected' && u.role != 'admin'}">
                  <a href="${pageContext.request.contextPath}/admin/users?action=reject&id=${u.id}"
                     class="btn btn--danger btn--xs">Reject</a>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </main>
</div>

</body>
</html>
