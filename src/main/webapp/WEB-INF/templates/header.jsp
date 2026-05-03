<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
  <div class="container">
    <h1 class="page-title"><c:out value="${param.title}"/></h1>
    <c:if test="${not empty param.subtitle}">
      <p class="page-subtitle"><c:out value="${param.subtitle}"/></p>
    </c:if>
  </div>
</div>
