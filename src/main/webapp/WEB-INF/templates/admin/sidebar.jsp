<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="admin-sidebar">
  <div class="admin-sidebar__brand"><span class="nav-logo">🐾</span><span>Paw Furr-Ever Admin</span></div>
  <nav class="admin-nav">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav__link ${param.activeLink == 'dashboard' ? 'admin-nav__link--active' : ''}"><span class="admin-nav__icon">📊</span> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/products" class="admin-nav__link ${param.activeLink == 'products' ? 'admin-nav__link--active' : ''}"><span class="admin-nav__icon">📦</span> Products</a>
    <a href="${pageContext.request.contextPath}/admin/users"    class="admin-nav__link ${param.activeLink == 'users' ? 'admin-nav__link--active' : ''}"><span class="admin-nav__icon">👥</span> Users
      <c:if test="${pendingUsers > 0}">
        <span class="nav-badge">${pendingUsers}</span>
      </c:if>
    </a>
    <div class="admin-nav__divider"></div>
    <a href="${pageContext.request.contextPath}/home"    class="admin-nav__link"><span class="admin-nav__icon">🏠</span> View Shop</a>
    <a href="${pageContext.request.contextPath}/logout"  class="admin-nav__link admin-nav__link--logout"><span class="admin-nav__icon">🚪</span> Logout</a>
  </nav>
</aside>
