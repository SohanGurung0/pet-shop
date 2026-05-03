<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
      <!DOCTYPE html>
      <html lang="en">
      <jsp:include page="/WEB-INF/templates/head.jsp">
        <jsp:param name="pageTitle" value="Shop — Paw Furr-Ever Pet Supply" />
        <jsp:param name="description"
          value="Browse all pet supplies at Paw Furr-Ever — dog food, toys, vitamins and supplements." />
        <jsp:param name="cssFile" value="products.css" />
      </jsp:include>

      <body>

        <%-- NAVBAR --%>
          <jsp:include page="/WEB-INF/templates/nav.jsp">
            <jsp:param name="activeLink" value="shop" />
          </jsp:include>

          <%-- PAGE HEADER --%>
            <div class="page-header">
              <div class="container">
                <h1 class="page-title">
                  <c:choose>
                    <c:when test="${not empty searchQuery}">
                      Search results for "
                      <c:out value='${searchQuery}' />"
                    </c:when>
                    <c:when test="${selectedCategory == 'food'}">Dog Food</c:when>
                    <c:when test="${selectedCategory == 'toy'}">Toys</c:when>
                    <c:when test="${selectedCategory == 'vitamin'}">Vitamins</c:when>
                    <c:when test="${selectedCategory == 'supplement'}">Supplements</c:when>
                    <c:otherwise>All Products</c:otherwise>
                  </c:choose>
                </h1>
                <p class="page-subtitle">${fn:length(products)} product<c:if test="${fn:length(products) != 1}">s</c:if>
                  found</p>
              </div>
            </div>

            <div class="container shop-layout">

              <%-- SIDEBAR FILTERS --%>
                <aside class="shop-sidebar">

                  <%-- Search --%>
                    <div class="filter-section">
                      <h3 class="filter-title">Search</h3>
                      <form action="${pageContext.request.contextPath}/products" method="get" id="searchForm">
                        <div class="search-box">
                          <input type="text" name="search" class="form-input search-input"
                            placeholder="Search products…" value="<c:out value='${searchQuery}' default=''/>" />
                          <button type="submit" class="search-btn" aria-label="Search">🔍</button>
                        </div>
                      </form>
                    </div>

                    <%-- Category Filter --%>
                      <div class="filter-section">
                        <h3 class="filter-title">Category</h3>
                        <ul class="filter-list">
                          <li>
                            <a href="${pageContext.request.contextPath}/products"
                              class="filter-link ${empty selectedCategory && empty searchQuery ? 'filter-link--active' : ''}">
                              All Products
                            </a>
                          </li>
                          <li>
                            <a href="${pageContext.request.contextPath}/products?category=food"
                              class="filter-link ${selectedCategory == 'food' ? 'filter-link--active' : ''}">
                              🥩 Dog Food
                            </a>
                          </li>
                          <li>
                            <a href="${pageContext.request.contextPath}/products?category=toy"
                              class="filter-link ${selectedCategory == 'toy' ? 'filter-link--active' : ''}">
                              🎾 Toys
                            </a>
                          </li>
                          <li>
                            <a href="${pageContext.request.contextPath}/products?category=vitamin"
                              class="filter-link ${selectedCategory == 'vitamin' ? 'filter-link--active' : ''}">
                              💊 Vitamins
                            </a>
                          </li>
                          <li>
                            <a href="${pageContext.request.contextPath}/products?category=supplement"
                              class="filter-link ${selectedCategory == 'supplement' ? 'filter-link--active' : ''}">
                              🌿 Supplements
                            </a>
                          </li>
                        </ul>
                      </div>
                </aside>

                <%-- PRODUCT GRID --%>
                  <main class="shop-main">
                    <c:choose>
                      <c:when test="${not empty products}">
                        <div class="product-grid">
                          <c:forEach var="product" items="${products}">
                            <div class="product-card">
                              <a href="${pageContext.request.contextPath}/product?id=${product.id}"
                                class="product-card__link">
                                <div class="product-card__img">
                                  <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                    alt="<c:out value='${product.name}'/>"
                                    onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'" />
                                  <span class="product-badge product-badge--${product.category}">
                                    <c:out value="${product.category}" />
                                  </span>
                                </div>
                                <div class="product-card__body">
                                  <h3 class="product-card__name">
                                    <c:out value="${product.name}" />
                                  </h3>
                                  <p class="product-card__desc">
                                    <c:out value="${product.description}" />
                                  </p>
                                  <div class="product-card__footer">
                                    <span class="product-card__price">£
                                      <c:out value="${product.price}" />
                                    </span>
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
                              <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="id" value="${product.id}" />
                                <input type="hidden" name="qty" value="1" />
                                <button type="submit" class="btn btn--primary btn--full btn--sm" <c:if
                                  test="${!product.inStock}">disabled</c:if>>
                                  Add to Cart
                                </button>
                              </form>
                            </div>
                          </c:forEach>
                        </div>
                      </c:when>
                      <c:otherwise>
                        <div class="empty-state-box">
                          <div class="empty-state-icon"> </div>
                          <h3>No products found</h3>
                          <p>Try a different search term or browse all categories.</p>
                          <a href="${pageContext.request.contextPath}/products" class="btn btn--primary">View All
                            Products</a>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </main>

            </div>

            <jsp:include page="/WEB-INF/templates/footer.jsp" />

      </body>

      </html>