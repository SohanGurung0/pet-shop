<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta name="description" content="PawShop — Premium dog food, toys, vitamins and supplements for your beloved pets."/>
  <title>PawShop — Pet Supply Store</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
</head>
<body>

<%-- ═══ NAVBAR ════════════════════════════════════════════════ --%>
<nav class="navbar">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand">
      <span class="nav-logo">🐾</span> PawShop
    </a>
    <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/home" class="nav-link nav-link--active">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/products" class="nav-link">Shop All</a></li>
      <li><a href="${pageContext.request.contextPath}/products?category=food" class="nav-link">Dog Food</a></li>
      <li><a href="${pageContext.request.contextPath}/products?category=toy" class="nav-link">Toys</a></li>
      <li><a href="${pageContext.request.contextPath}/products?category=vitamin" class="nav-link">Vitamins</a></li>
    </ul>
    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
        🛒 <span class="cart-badge">
        <c:choose>
          <c:when test="${not empty sessionScope.cart}">${fn:length(sessionScope.cart)}</c:when>
          <c:otherwise>0</c:otherwise>
        </c:choose>
        </span>
      </a>
      <c:choose>
        <c:when test="${not empty sessionScope.loggedUser}">
          <c:if test="${sessionScope.loggedUser.admin}">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn--outline btn--sm">Admin</a>
          </c:if>
          <a href="${pageContext.request.contextPath}/logout" class="btn btn--ghost btn--sm">Logout</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login"    class="btn btn--outline btn--sm">Login</a>
          <a href="${pageContext.request.contextPath}/register" class="btn btn--primary btn--sm">Register</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>

<%-- ═══ HERO ══════════════════════════════════════════════════ --%>
<section class="hero">
  <div class="hero-content">
    <span class="hero-badge">New Arrivals 🌟</span>
    <h1 class="hero-title">Everything Your Dog<br/><em>Needs to Thrive</em></h1>
    <p class="hero-subtitle">
      Premium food, fun toys, and health supplements — curated for happy, healthy pups.
    </p>
    <div class="hero-cta">
      <a href="${pageContext.request.contextPath}/products" class="btn btn--primary btn--lg">Shop Now</a>
      <a href="${pageContext.request.contextPath}/products?category=food" class="btn btn--outline btn--lg">View Food Range</a>
    </div>
    <div class="hero-stats">
      <div class="hero-stat"><strong>100+</strong><span>Products</span></div>
      <div class="hero-stat"><strong>4</strong><span>Categories</span></div>
      <div class="hero-stat"><strong>⭐ 4.9</strong><span>Rating</span></div>
    </div>
  </div>
  <div class="hero-image">
    <div class="hero-blob">🐕</div>
  </div>
</section>

<%-- ═══ CATEGORY CARDS ════════════════════════════════════════ --%>
<section class="section section--categories">
  <div class="container">
    <h2 class="section-title">Shop by Category</h2>
    <div class="category-grid">
      <a href="${pageContext.request.contextPath}/products?category=food" class="category-card category-card--food">
        <div class="category-icon">🦴</div>
        <h3>Dog Food</h3>
        <p>Nutritious meals for every life stage</p>
      </a>
      <a href="${pageContext.request.contextPath}/products?category=toy" class="category-card category-card--toy">
        <div class="category-icon">🎾</div>
        <h3>Toys</h3>
        <p>Keep your pup entertained for hours</p>
      </a>
      <a href="${pageContext.request.contextPath}/products?category=vitamin" class="category-card category-card--vitamin">
        <div class="category-icon">💊</div>
        <h3>Vitamins</h3>
        <p>Daily supplements for overall health</p>
      </a>
      <a href="${pageContext.request.contextPath}/products?category=supplement" class="category-card category-card--supplement">
        <div class="category-icon">🌿</div>
        <h3>Supplements</h3>
        <p>Joint, dental, and coat support</p>
      </a>
    </div>
  </div>
</section>

<%-- ═══ FEATURED PRODUCTS ═════════════════════════════════════ --%>
<section class="section section--featured">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Featured Products</h2>
      <a href="${pageContext.request.contextPath}/products" class="section-link">View all →</a>
    </div>

    <div class="product-grid">
      <c:forEach var="product" items="${featuredProducts}" end="7">
        <div class="product-card">
          <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="product-card__link">
            <div class="product-card__img">
              <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                   alt="<c:out value='${product.name}'/>"
                   onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
              <span class="product-badge product-badge--${product.category}">
                <c:out value="${product.category}"/>
              </span>
            </div>
            <div class="product-card__body">
              <h3 class="product-card__name"><c:out value="${product.name}"/></h3>
              <p class="product-card__desc"><c:out value="${product.description}"/></p>
              <div class="product-card__footer">
                <span class="product-card__price">£<c:out value="${product.price}"/></span>
                <c:choose>
                  <c:when test="${product.inStock}">
                    <span class="stock-badge stock-badge--in">In Stock</span>
                  </c:when>
                  <c:otherwise>
                    <span class="stock-badge stock-badge--out">Out of Stock</span>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </a>
          <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
            <input type="hidden" name="action" value="add"/>
            <input type="hidden" name="id" value="${product.id}"/>
            <input type="hidden" name="qty" value="1"/>
            <button type="submit" class="btn btn--primary btn--full btn--sm"
                    <c:if test="${!product.inStock}">disabled</c:if>>
              Add to Cart
            </button>
          </form>
        </div>
      </c:forEach>
    </div>
    <c:if test="${empty featuredProducts}">
      <p class="empty-state">No products available yet. Check back soon! 🐾</p>
    </c:if>
  </div>
</section>

<%-- ═══ BANNER / VALUE PROPS ══════════════════════════════════ --%>
<section class="section section--banner">
  <div class="container">
    <div class="banner-grid">
      <div class="banner-item">
        <div class="banner-icon">🚚</div>
        <h4>Free Delivery</h4>
        <p>On orders over £30</p>
      </div>
      <div class="banner-item">
        <div class="banner-icon">✅</div>
        <h4>Vet Approved</h4>
        <p>All products vetted by experts</p>
      </div>
      <div class="banner-item">
        <div class="banner-icon">🔄</div>
        <h4>Easy Returns</h4>
        <p>30-day hassle-free returns</p>
      </div>
      <div class="banner-item">
        <div class="banner-icon">💬</div>
        <h4>24/7 Support</h4>
        <p>Always here to help</p>
      </div>
    </div>
  </div>
</section>

<%-- ═══ FOOTER ════════════════════════════════════════════════ --%>
<footer class="footer">
  <div class="container footer-inner">
    <div class="footer-brand">
      <span class="nav-logo">🐾</span>
      <span class="footer-brand-name">PawShop</span>
      <p class="footer-tagline">Made with love for pets.</p>
    </div>
    <div class="footer-links">
      <a href="${pageContext.request.contextPath}/home">Home</a>
      <a href="${pageContext.request.contextPath}/products">Shop</a>
      <a href="${pageContext.request.contextPath}/login">Login</a>
      <a href="${pageContext.request.contextPath}/register">Register</a>
    </div>
    <p class="footer-copy">&copy; 2026 PawShop. CS5054NP Coursework.</p>
  </div>
</footer>

</body>
</html>
