<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="pageTitle" value="Edit Product — Paw Furr-Ever Admin" />
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
        <h1 class="admin-page-title">Edit Product</h1>
        <p class="admin-page-subtitle"><a href="${pageContext.request.contextPath}/admin/products">← Back to Products</a></p>
      </div>
    </div>

    <c:if test="${not empty error}">
      <div class="alert alert--error"><c:out value="${error}"/></div>
    </c:if>

    <div class="admin-card admin-form-card">
      <form action="${pageContext.request.contextPath}/admin/products?action=edit"
            method="post" id="editProductForm" novalidate enctype="multipart/form-data">

        <input type="hidden" name="id" value="${product.id}"/>

        <div class="form-grid-2">

          <div class="form-group">
            <label for="name" class="form-label">Product Name <span class="required">*</span></label>
            <input type="text" id="name" name="name" class="form-input"
                   value="<c:out value='${product.name}'/>"
                   required minlength="2" maxlength="200"/>
          </div>

          <div class="form-group">
            <label for="category" class="form-label">Category <span class="required">*</span></label>
            <select id="category" name="category" class="form-input form-select" required>
              <option value="food"       ${product.category == 'food'       ? 'selected' : ''}>🥩 Dog Food</option>
              <option value="toy"        ${product.category == 'toy'        ? 'selected' : ''}>🎾 Toy</option>
              <option value="vitamin"    ${product.category == 'vitamin'    ? 'selected' : ''}>💊 Vitamin</option>
              <option value="supplement" ${product.category == 'supplement' ? 'selected' : ''}>🌿 Supplement</option>
            </select>
          </div>

          <div class="form-group">
            <label for="price" class="form-label">Price (Rs. ) <span class="required">*</span></label>
            <input type="number" id="price" name="price" class="form-input"
                   value="<c:out value='${product.price}'/>"
                   step="0.01" min="0" required/>
          </div>

          <div class="form-group">
            <label for="stock" class="form-label">Stock Quantity <span class="required">*</span></label>
            <input type="number" id="stock" name="stock" class="form-input"
                   value="<c:out value='${product.stock}'/>"
                   min="0" required/>
          </div>

        </div>

        <div class="form-group">
          <label for="description" class="form-label">Description</label>
          <textarea id="description" name="description" class="form-input form-textarea" rows="4">
<c:out value="${product.description}"/></textarea>
        </div>

        <%-- Image preview showing current image when editing --%>
        <div class="form-group">
          <label class="form-label">Current Image</label>
          <div class="image-preview-row">
            <c:choose>
              <c:when test="${not empty product.imageUrl and fn:startsWith(product.imageUrl, 'images/')}">
                <%-- Static image from project --%>
                <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                     alt="Current image" class="image-preview"
                     onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
              </c:when>
              <c:when test="${not empty product.imageUrl}">
                <%-- Uploaded image from external folder --%>
                <img src="${pageContext.request.contextPath}/uploads/${product.imageUrl}"
                     alt="Current image" class="image-preview"
                     onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'"/>
              </c:when>
              <c:otherwise>
                <img src="${pageContext.request.contextPath}/images/default-product.png"
                     alt="Default image" class="image-preview"/>
              </c:otherwise>
            </c:choose>
            <div class="image-preview-info">
              <p class="image-preview-text">Upload a new image below to replace the current one,
                or leave empty to keep it.</p>
            </div>
          </div>
        </div>

        <div class="form-group">
          <label for="image" class="form-label">Upload New Image</label>
          <input type="file" id="image" name="image" class="form-input form-file-input"
                 accept=".jpg,.jpeg,.png"/>
          <small class="form-hint">Accepted formats: JPG, JPEG, PNG (max 10 MB). Leave blank to keep current image.</small>
        </div>

        <div class="form-actions">
          <button type="submit" id="editProductBtn" class="btn btn--primary">Save Changes</button>
          <a href="${pageContext.request.contextPath}/admin/products" class="btn btn--ghost">Cancel</a>
        </div>

      </form>
    </div>
  </main>
</div>

</body>
</html>
