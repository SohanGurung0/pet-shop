<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="pageTitle" value="Login — Paw Furr-Ever Pet Supply" />
  <jsp:param name="description" value="Log in to Paw Furr-Ever" />
  <jsp:param name="cssFile" value="auth.css" />
</jsp:include>
<body class="auth-body">

<div class="auth-wrapper">

  <!-- Left panel — branding -->
  <jsp:include page="/WEB-INF/templates/auth-left.jsp">
    <jsp:param name="tagline" value="Premium supplies for your beloved pets" />
  </jsp:include>

  <!-- Right panel — form -->
  <div class="auth-panel auth-panel--right">
    <div class="auth-form-container">

      <h2 class="auth-title">Welcome back</h2>
      <p class="auth-subtitle">Sign in to your account</p>

      <%-- Success message from registration --%>
      <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert--success">
          <c:out value="${sessionScope.successMsg}"/>
        </div>
        <c:remove var="successMsg" scope="session"/>
      </c:if>

      <%-- Error message --%>
      <c:if test="${not empty error}">
        <div class="alert alert--error">
          <c:out value="${error}"/>
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" novalidate>

        <div class="form-group">
          <label for="email" class="form-label">Email address</label>
          <input type="email" id="email" name="email" class="form-input"
                 placeholder="you@example.com"
                 value="<c:out value='${param.email}' default=''/>"
                 required autocomplete="email"/>
        </div>

        <div class="form-group position-relative">
          <label for="password" class="form-label">Password</label>
          <input type="password" id="password" name="password" class="form-input"
                 placeholder="Your password"
                 required autocomplete="current-password"/>
                <div class="form-row form-row--space-between">
                   <label class="form-check-label">
                      <input type="checkbox" class="password-toggle" id="togglePassword" onclick="password.type = this.checked ? 'text' : 'password'">
                         <span>Show Password</span>
                     </label>
                </div>
        </div>

        <button type="submit" id="loginBtn" class="btn btn--primary btn--full">
          Sign In
        </button>

        <div class="form-row form-row--space-between">
          <label class="form-check-label">
            <input type="checkbox" name="remember" id="remember"/>
            <span>Remember me</span>
          </label>
        </div>

        <p class="auth-link-text">
          Don't have an account?
          <a href="${pageContext.request.contextPath}/register" class="auth-link">Create one</a>
        </p>

      </form>
    </div>
  </div>

</div>
</body>
</html>
