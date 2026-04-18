<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta name="description" content="${product.name} — ${product.description}"/>
  <title><c:out value="${product.name}"/> — PawShop</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css"/>
</head>
<body>

<%-- NAVBAR --%>
<nav class="navbar">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand"><span class="nav-logo">🐾</span> PawShop</a>
    <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/home" class="nav-link">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/products" class="nav-link">Shop All</a></li>
    </ul>
    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">🛒
        <span class="cart-badge">
          <c:choose>
            <c:when test="${not empty sessionScope.cart}">${fn:length(sessionScope.cart)}</c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </span>
      </a>
      <c:choose>
        <c:when test="${not empty sessionScope.loggedUser}">
          <a href="${pageContext.request.contextPath}/logout" class="btn btn--ghost btn--sm">Logout</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login" class="btn btn--primary btn--sm">Login</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>

<%-- BREADCRUMB --%>
<div class="breadcrumb-bar">
  <div class="container">
    <nav class="breadcrumb">
      <a href="${pageContext.request.contextPath}/home">Home</a>
      <span class="breadcrumb-sep">›</span>
      <a href="${pageContext.request.contextPath}/products">Shop</a>
      <span class="breadcrumb-sep">›</span>
      <a href="${pageContext.request.contextPath}/products?category=${product.category}">
        <c:out value="${product.categoryLabel}"/>
      </a>
      <span class="breadcrumb-sep">›</span>
      <span class="breadcrumb-current"><c:out value="${product.name}"/></span>
    </nav>
  </div>
</div>

<%-- PRODUCT DETAIL --%>
<div class="container detail-layout">

  <%-- Product Image --%>
  <div class="detail-image-wrapper">
    <div class="detail-image">
      <img src="${pageContext.request.contextPath}/${product.imageUrl}"
           alt="<c:out value='${product.name}'/>"
           onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"
           class="detail-img"/>
    </div>
    <span class="product-badge product-badge--${product.category} detail-category-badge">
      <c:out value="${product.categoryLabel}"/>
    </span>
  </div>

  <%-- Product Info --%>
  <div class="detail-info">
    <h1 class="detail-name"><c:out value="${product.name}"/></h1>

    <div class="detail-price-row">
      <span class="detail-price">£<c:out value="${product.price}"/></span>
      <c:choose>
        <c:when test="${product.inStock}">
          <span class="stock-badge stock-badge--in">✓ In Stock (${product.stock} left)</span>
        </c:when>
        <c:otherwise>
          <span class="stock-badge stock-badge--out">✗ Out of Stock</span>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="detail-divider"></div>

    <h2 class="detail-section-title">Description</h2>
    <p class="detail-description"><c:out value="${product.description}"/></p>

    <div class="detail-divider"></div>

    <%-- Add to Cart form --%>
    <c:choose>
      <c:when test="${product.inStock}">
        <form action="${pageContext.request.contextPath}/cart" method="post" class="detail-cart-form" id="addToCartForm">
          <input type="hidden" name="action" value="add"/>
          <input type="hidden" name="id"     value="${product.id}"/>
          <div class="qty-row">
            <label for="qty" class="form-label">Quantity</label>
            <div class="qty-control">
              <input type="number" id="qty" name="qty" value="1"
                     min="1" max="${product.stock}"
                     class="form-input qty-input"/>
            </div>
          </div>
          <button type="submit" class="btn btn--primary btn--lg" id="addCartBtn">
            🛒 Add to Cart
          </button>
        </form>
      </c:when>
      <c:otherwise>
        <p class="detail-out-stock-msg">
          This product is currently out of stock. Check back soon!
        </p>
      </c:otherwise>
    </c:choose>

    <%-- Meta info --%>
    <div class="detail-meta">
      <div class="detail-meta-item">
        <span class="meta-label">Category</span>
        <span class="meta-value"><c:out value="${product.categoryLabel}"/></span>
      </div>
      <div class="detail-meta-item">
        <span class="meta-label">Product ID</span>
        <span class="meta-value">#${product.id}</span>
      </div>
    </div>
  </div>

</div>

<footer class="footer">
  <div class="container footer-inner">
    <div class="footer-brand"><span class="nav-logo">🐾</span><span class="footer-brand-name">PawShop</span></div>
    <p class="footer-copy">&copy; 2026 PawShop. CS5054NP Coursework.</p>
  </div>
</footer>

</body>
</html>
