<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

      <nav class="navbar">
        <div class="nav-container">
          <a href="${pageContext.request.contextPath}/home" class="nav-brand">
            <span class="nav-logo">🐾</span> Paw Furr-Ever
          </a>
          <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home"
                class="nav-link ${param.activeLink == 'home' ? 'nav-link--active' : ''}">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/products"
                class="nav-link ${param.activeLink == 'shop' && empty selectedCategory ? 'nav-link--active' : ''}">Shop
                All</a></li>
            <li><a href="${pageContext.request.contextPath}/products?category=food"
                class="nav-link ${selectedCategory == 'food' ? 'nav-link--active' : ''}">Dog Food</a></li>
            <li><a href="${pageContext.request.contextPath}/products?category=toy"
                class="nav-link ${selectedCategory == 'toy' ? 'nav-link--active' : ''}">Toys</a></li>
            <li><a href="${pageContext.request.contextPath}/products?category=vitamin"
                class="nav-link ${selectedCategory == 'vitamin' ? 'nav-link--active' : ''}">Vitamins</a></li>
          </ul>
          <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/cart"
              class="nav-cart ${param.activeLink == 'cart' ? 'nav-link--active' : ''}">
              🛒 <span class="cart-badge">
                <c:choose>
                  <c:when test="${not empty sessionScope.cart}">${fn:length(sessionScope.cart)}</c:when>
                  <c:when test="${not empty cartItems}">${fn:length(cartItems)}</c:when>
                  <c:otherwise>0</c:otherwise>
                </c:choose>
              </span>
            </a>
            <c:choose>
              <c:when test="${not empty sessionScope.loggedUser}">
                <c:if test="${sessionScope.loggedUser.admin}">
                  <a href="${pageContext.request.contextPath}/admin/dashboard"
                    class="btn btn--outline btn--sm">Admin</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn--ghost btn--sm">Logout</a>
              </c:when>
              <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn btn--outline btn--sm">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn--primary btn--sm">Register</a>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </nav>