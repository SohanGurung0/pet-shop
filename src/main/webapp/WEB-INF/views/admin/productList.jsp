<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="pageTitle" value="Manage Products — Paw Furr-Ever Admin" />
  <jsp:param name="cssFile" value="admin.css" />
</jsp:include>
<body class="admin-body">

<div class="admin-layout">
  <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
    <jsp:param name="activeLink" value="products" />
  </jsp:include>

  <main class="admin-main">
    <div class="admin-topbar">
      <div>
        <h1 class="admin-page-title">Products</h1>
        <p class="admin-page-subtitle">${products.size()} products in catalogue</p>
      </div>
      <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn--primary">+ Add Product</a>
    </div>

    <c:if test="${not empty sessionScope.successMsg}">
      <div class="alert alert--success"><c:out value="${sessionScope.successMsg}"/></div>
      <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMsg}">
      <div class="alert alert--error"><c:out value="${sessionScope.errorMsg}"/></div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <div class="admin-card">
      <table class="admin-table admin-table--striped">
        <thead>
          <tr>
            <th>#</th>
            <th>Image</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="p" items="${products}">
            <tr>
              <td class="text-muted">${p.id}</td>
              <td>
                <c:choose>
                  <c:when test="${fn:startsWith(p.imageUrl, 'images/')}">
                    <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                         alt="<c:out value='${p.name}'/>"
                         class="admin-table-thumb"
                         onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/uploads/${p.imageUrl}"
                         alt="<c:out value='${p.name}'/>"
                         class="admin-table-thumb"
                         onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
                  </c:otherwise>
                </c:choose>
              </td>
              <td><strong><c:out value="${p.name}"/></strong></td>
              <td><span class="product-badge product-badge--${p.category}"><c:out value="${p.category}"/></span></td>
              <td>Rs. <c:out value="${p.price}"/></td>
              <td>
                <c:choose>
                  <c:when test="${p.stock > 0}"><span class="stock-badge stock-badge--in">${p.stock}</span></c:when>
                  <c:otherwise><span class="stock-badge stock-badge--out">0</span></c:otherwise>
                </c:choose>
              </td>
              <td class="table-actions">
                <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}"
                   class="btn btn--outline btn--xs">✏️ Edit</a>
                <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}"
                   class="btn btn--danger btn--xs"
                   onclick="return confirm('Delete \'${p.name}\'? This cannot be undone.');">🗑️ Delete</a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty products}">
            <tr><td colspan="7" class="text-center text-muted">No products yet. <a href="${pageContext.request.contextPath}/admin/products?action=add">Add one!</a></td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </main>
</div>

</body>
</html>
