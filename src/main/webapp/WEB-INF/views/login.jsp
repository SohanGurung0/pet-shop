<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta name="description" content="Log in to PawShop — your pet supply destination for dog food, toys, vitamins and supplements."/>
  <title>Login — PawShop Pet Supply</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css"/>
</head>
<body class="auth-body">

<div class="auth-wrapper">

  <!-- Left panel — branding -->
  <div class="auth-panel auth-panel--left">
    <div class="auth-brand">
      <div class="auth-logo">🐾</div>
      <h1 class="auth-brand-name">PawShop</h1>
      <p class="auth-brand-tagline">Premium supplies for your beloved pets</p>
    </div>
    <div class="auth-illustration">🐶</div>
  </div>

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
          <button type="button" class="password-toggle" id="togglePassword" aria-label="Show password">
            👁️
          </button>
        </div>

        <div class="form-row form-row--space-between">
          <label class="form-check-label">
            <input type="checkbox" name="remember" id="remember"/>
            <span>Remember me</span>
          </label>
        </div>

        <button type="submit" id="loginBtn" class="btn btn--primary btn--full">
          Sign In
        </button>

        <p class="auth-link-text">
          Don't have an account?
          <a href="${pageContext.request.contextPath}/register" class="auth-link">Create one</a>
        </p>

      </form>
    </div>
  </div>

</div>
  <script>
    document.getElementById('togglePassword').addEventListener('click', function () {
      const passwordInput = document.getElementById('password');
      const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordInput.setAttribute('type', type);
      // Toggle icon
      this.textContent = type === 'password' ? '👁️' : '👁️‍🗨️';
    });
  </script>
</body>
</html>
