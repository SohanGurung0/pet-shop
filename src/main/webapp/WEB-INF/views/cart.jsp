<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Your Cart — PawShop</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css"/>
</head>
<body>

<nav class="navbar">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand"><span class="nav-logo">🐾</span> PawShop</a>
    <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/home"     class="nav-link">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/products" class="nav-link">Shop</a></li>
    </ul>
    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart nav-link--active">
        🛒 <span class="cart-badge">${fn:length(cartItems)}</span>
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

<div class="page-header">
  <div class="container">
    <h1 class="page-title">🛒 Your Cart</h1>
  </div>
</div>

<div class="container cart-layout">
  <c:choose>
    <c:when test="${not empty cartItems}">

      <%-- Cart Items Table --%>
      <div class="cart-items">
        <table class="cart-table">
          <thead>
            <tr>
              <th>Product</th>
              <th>Price</th>
              <th>Quantity</th>
              <th>Subtotal</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="entry" items="${cartItems}">
              <tr class="cart-row">
                <td>
                  <div class="cart-product-cell">
                    <img src="${pageContext.request.contextPath}/${entry.key.imageUrl}"
                         alt="<c:out value='${entry.key.name}'/>"
                         class="cart-thumb"
                         onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
                    <div>
                      <a href="${pageContext.request.contextPath}/product?id=${entry.key.id}"
                         class="cart-product-name"><c:out value="${entry.key.name}"/></a>
                      <span class="cart-product-cat product-badge product-badge--${entry.key.category}">
                        <c:out value="${entry.key.category}"/>
                      </span>
                    </div>
                  </div>
                </td>
                <td class="cart-price">£<c:out value="${entry.key.price}"/></td>
                <td>
                  <form action="${pageContext.request.contextPath}/cart" method="post" class="cart-qty-form">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id"     value="${entry.key.id}"/>
                    <input type="number" name="qty"    value="${entry.value}"
                           min="1" max="${entry.key.stock}"
                           class="form-input qty-input"
                           onchange="this.form.submit()"/>
                  </form>
                </td>
                <td class="cart-subtotal">£<c:out value="${entry.key.price * entry.value}"/></td>
                <td>
                  <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="remove"/>
                    <input type="hidden" name="id"     value="${entry.key.id}"/>
                    <button type="submit" class="btn-icon btn-icon--danger" title="Remove">✕</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

        <form action="${pageContext.request.contextPath}/cart" method="post" class="cart-clear-form">
          <input type="hidden" name="action" value="clear"/>
          <button type="submit" class="btn btn--ghost">Clear Cart</button>
        </form>
      </div>

      <%-- Order Summary --%>
      <aside class="cart-summary">
        <h2 class="cart-summary__title">Order Summary</h2>
        <div class="cart-summary__row">
          <span>Subtotal</span>
          <span>£<c:out value="${cartTotal}"/></span>
        </div>
        <div class="cart-summary__row">
          <span>Delivery</span>
          <span class="cart-free">
            <c:choose>
              <c:when test="${cartTotal >= 30}">FREE</c:when>
              <c:otherwise>£3.99</c:otherwise>
            </c:choose>
          </span>
        </div>
        <div class="cart-summary__divider"></div>
        <div class="cart-summary__row cart-summary__row--total">
          <span>Total</span>
          <span>
            £<c:choose>
              <c:when test="${cartTotal >= 30}"><c:out value="${cartTotal}"/></c:when>
              <c:otherwise><c:out value="${cartTotal + 3.99}"/></c:otherwise>
            </c:choose>
          </span>
        </div>
        <c:if test="${cartTotal < 30}">
          <p class="cart-delivery-hint">Add £<c:out value="${30 - cartTotal}"/> more for free delivery!</p>
        </c:if>
        <c:choose>
          <c:when test="${not empty sessionScope.loggedUser && sessionScope.loggedUser.approved}">
            <button class="btn btn--primary btn--full btn--lg">Proceed to Checkout</button>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/login" class="btn btn--primary btn--full btn--lg">
              Login to Checkout
            </a>
          </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/products" class="btn btn--ghost btn--full" style="margin-top:.5rem;">
          Continue Shopping
        </a>
      </aside>

    </c:when>
    <c:otherwise>
      <div class="empty-state-box" style="grid-column:1/-1;">
        <div class="empty-state-icon">🛒</div>
        <h3>Your cart is empty</h3>
        <p>Browse our store and add some products!</p>
        <a href="${pageContext.request.contextPath}/products" class="btn btn--primary">Start Shopping</a>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<footer class="footer">
  <div class="container footer-inner">
    <div class="footer-brand"><span class="nav-logo">🐾</span><span class="footer-brand-name">PawShop</span></div>
    <p class="footer-copy">&copy; 2026 PawShop. CS5054NP Coursework.</p>
  </div>
</footer>

</body>
</html>
