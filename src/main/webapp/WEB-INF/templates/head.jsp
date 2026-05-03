<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <c:if test="${not empty param.description}">
    <meta name="description" content="${param.description}"/>
  </c:if>
  <title>${empty param.pageTitle ? 'Paw Furr-Ever — Pet Supply Store' : param.pageTitle}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <c:if test="${not empty param.cssFile}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${param.cssFile}"/>
  </c:if>
</head>
