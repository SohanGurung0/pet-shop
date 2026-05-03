<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
      <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

        <!DOCTYPE html>
        <html lang="en">

        <jsp:include page="/WEB-INF/templates/head.jsp">
          <jsp:param name="pageTitle" value="Your Cart — Paw Furr-Ever" />
          <jsp:param name="cssFile" value="products.css" />
        </jsp:include>

        <body>

          <jsp:include page="/WEB-INF/templates/nav.jsp">
            <jsp:param name="activeLink" value="cart" />
          </jsp:include>

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
                                  alt="<c:out value='${entry.key.name}'/>" class="cart-thumb"
                                  onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'" />
                                <div>
                                  <a href="${pageContext.request.contextPath}/product?id=${entry.key.id}"
                                    class="cart-product-name">
                                    <c:out value="${entry.key.name}" />
                                  </a>
                                  <span class="cart-product-cat product-badge product-badge--${entry.key.category}">
                                    <c:out value="${entry.key.category}" />
                                  </span>
                                </div>
                              </div>
                            </td>
                            <td class="cart-price">Rs.
                              <fmt:formatNumber value="${entry.key.price}" minFractionDigits="2"
                                maxFractionDigits="2" />
                            </td>
                            <td>
                              <form action="${pageContext.request.contextPath}/cart" method="post"
                                class="cart-qty-form">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="id" value="${entry.key.id}" />
                                <input type="number" name="qty" value="${entry.value}" min="1" max="${entry.key.stock}"
                                  class="form-input qty-input" onchange="this.form.submit()" />
                              </form>
                            </td>
                            <td class="cart-subtotal">Rs.
                              <fmt:formatNumber value="${entry.key.price * entry.value}" minFractionDigits="2"
                                maxFractionDigits="2" />
                            </td>
                            <td>
                              <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="remove" />
                                <input type="hidden" name="id" value="${entry.key.id}" />
                                <button type="submit" class="btn-icon btn-icon--danger" title="Remove">❌</button>
                              </form>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>

                    <form action="${pageContext.request.contextPath}/cart" method="post" class="cart-clear-form">
                      <input type="hidden" name="action" value="clear" />
                      <button type="submit" class="btn btn--ghost">Clear Cart</button>
                    </form>
                  </div>

                  <%-- Order Summary --%>
                    <aside class="cart-summary">
                      <h2 class="cart-summary__title">Order Summary</h2>
                      <div class="cart-summary__row">
                        <span>Subtotal</span>
                        <span>Rs.
                          <fmt:formatNumber value="${cartTotal}" minFractionDigits="2" maxFractionDigits="2" />
                        </span>
                      </div>
                      <div class="cart-summary__row">
                        <span>Delivery</span>
                        <span class="cart-free">
                          <c:choose>
                            <c:when test="${cartTotal >= 5000}">FREE</c:when>
                            <c:otherwise>Rs. 150</c:otherwise>
                          </c:choose>
                        </span>
                      </div>
                      <div class="cart-summary__divider"></div>
                      <div class="cart-summary__row cart-summary__row--total">
                        <span>Total</span>
                        <span>
                          Rs. <c:choose>
                            <c:when test="${cartTotal >= 5000}">
                              <fmt:formatNumber value="${cartTotal}" minFractionDigits="2" maxFractionDigits="2" />
                            </c:when>
                            <c:otherwise>
                              <fmt:formatNumber value="${cartTotal + 150}" minFractionDigits="2"
                                maxFractionDigits="2" />
                            </c:otherwise>
                          </c:choose>
                        </span>
                      </div>
                      <c:if test="${cartTotal < 5000}">
                        <p class="cart-delivery-hint">Add Rs.
                          <fmt:formatNumber value="${5000 - cartTotal}" minFractionDigits="2" maxFractionDigits="2" />
                          more for free delivery!
                        </p>
                      </c:if>
                      <c:choose>
                        <c:when
                          test="${not empty sessionScope.loggedUser && sessionScope.loggedUser.approved && sessionScope.loggedUser.role == 'user'}">
                          <a href="${pageContext.request.contextPath}/checkout"
                            class="btn btn--primary btn--full btn--lg">Proceed to Checkout</a>
                        </c:when>
                        <c:otherwise>
                          <a href="${pageContext.request.contextPath}/login" class="btn btn--primary btn--full btn--lg">
                            Login to Checkout
                          </a>
                        </c:otherwise>
                      </c:choose>
                      <a href="${pageContext.request.contextPath}/products" class="btn btn--ghost btn--full"
                        style="margin-top:.5rem;">
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

          <jsp:include page="/WEB-INF/templates/footer.jsp" />

        </body>

        </html>