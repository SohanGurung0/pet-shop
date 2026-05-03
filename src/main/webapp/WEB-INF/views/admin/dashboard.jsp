<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="en">
    <jsp:include page="/WEB-INF/templates/head.jsp">
      <jsp:param name="pageTitle" value="Admin Dashboard — Paw Furr-Ever" />
      <jsp:param name="cssFile" value="admin.css" />
    </jsp:include>

    <body class="admin-body">

      <div class="admin-layout">
        <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
          <jsp:param name="activeLink" value="dashboard" />
        </jsp:include>

        <main class="admin-main">

          <%-- Top bar --%>
            <div class="admin-topbar">
              <div>
                <h1 class="admin-page-title">Dashboard</h1>
                <p class="admin-page-subtitle">
                  Welcome back, <strong>
                    <c:out value="${sessionScope.userName}" />
                  </strong>
                </p>
              </div>
              <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn--primary">+ Add
                Product</a>
            </div>

            <%-- Flash messages --%>
              <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert--success">
                  <c:out value="${sessionScope.successMsg}" />
                </div>
                <c:remove var="successMsg" scope="session" />
              </c:if>
              <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert--error">
                  <c:out value="${sessionScope.errorMsg}" />
                </div>
                <c:remove var="errorMsg" scope="session" />
              </c:if>

              <%-- STAT CARDS --%>
                <div class="stat-grid">
                  <div class="stat-card stat-card--blue">
                    <div class="stat-card__icon">💰</div>
                    <div class="stat-card__body">
                      <div class="stat-card__value">Rs. <fmt:formatNumber value="${totalSales}" maxFractionDigits="0" /></div>
                      <div class="stat-card__label">Total Revenue</div>
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
                    <div class="stat-card__icon">📦</div>
                    <div class="stat-card__body">
                      <div class="stat-card__value">${totalProducts}</div>
                      <div class="stat-card__label">Products</div>
                    </div>
                  </div>
                </div>

                <%-- SALES GRAPH --%>
                <div class="admin-card graph-container">
                    <div class="admin-card__header">
                        <h2 class="admin-card__title">Sales Performance</h2>
                        <span class="text-muted small">Last 7 Days</span>
                    </div>
                    <canvas id="salesChart" height="100"></canvas>
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
                            <tr>
                              <th>Name</th>
                              <th>Category</th>
                              <th>Price</th>
                              <th>Stock</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach var="p" items="${recentProducts}">
                              <tr>
                                <td>
                                  <c:out value="${p.name}" />
                                </td>
                                <td><span class="product-badge product-badge--${p.category}">
                                    <c:out value="${p.category}" />
                                  </span></td>
                                <td>Rs. 
                                  <fmt:formatNumber value="${p.price}" minFractionDigits="2" maxFractionDigits="2" />
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${p.stock > 0}"><span
                                        class="stock-badge stock-badge--in">${p.stock}</span></c:when>
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
                                      <strong>
                                        <c:out value="${u.fullName}" />
                                      </strong>
                                      <span class="pending-item__email">
                                        <c:out value="${u.email}" />
                                      </span>
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

      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
      <script>
        const ctx = document.getElementById('salesChart').getContext('2d');
        const labels = [
            <c:forEach var="entry" items="${salesData}" varStatus="loop">
                '${entry.key}'${!loop.last ? ',' : ''}
            </c:forEach>
        ];
        const data = [
            <c:forEach var="entry" items="${salesData}" varStatus="loop">
                ${entry.value}${!loop.last ? ',' : ''}
            </c:forEach>
        ];

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total Sales (Rs.)',
                    data: data,
                    borderColor: '#6366f1',
                    backgroundColor: 'rgba(99, 102, 241, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#6366f1',
                    pointRadius: 4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) { return 'Rs. ' + value; }
                        }
                    }
                }
            }
        });
      </script>

      <style>
          .graph-container { margin-bottom: 2rem; padding: 1.5rem; }
          .text-muted { color: #718096; }
          .small { font-size: 0.8rem; }
      </style>

    </body>
</html>