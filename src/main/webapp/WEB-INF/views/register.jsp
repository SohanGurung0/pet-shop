<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta name="description" content="Create your PawShop account to start shopping for premium pet supplies."/>
  <title>Register — PawShop Pet Supply</title>
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
      <p class="auth-brand-tagline">Join thousands of happy pet owners</p>
    </div>
    <div class="auth-illustration">🐕</div>
  </div>

  <!-- Right panel — form -->
  <div class="auth-panel auth-panel--right">
    <div class="auth-form-container">

      <h2 class="auth-title">Create account</h2>
      <p class="auth-subtitle">Fill in your details to register</p>

      <%-- Validation error message --%>
      <c:if test="${not empty error}">
        <div class="alert alert--error">
          <c:out value="${error}"/>
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>

        <div class="form-group">
          <label for="fullName" class="form-label">Full name</label>
          <input type="text" id="fullName" name="fullName" class="form-input"
                 placeholder="e.g. Sarah Johnson"
                 value="<c:out value='${param.fullName}' default=''/>"
                 required autocomplete="name"/>
          <small class="form-hint">Letters and spaces only — no numbers</small>
        </div>

        <div class="form-group">
          <label for="email" class="form-label">Email address</label>
          <input type="email" id="email" name="email" class="form-input"
                 placeholder="you@example.com"
                 value="<c:out value='${param.email}' default=''/>"
                 required autocomplete="email"/>
        </div>

        <div class="form-group">
          <label for="phone" class="form-label">Phone number</label>
          <input type="tel" id="phone" name="phone" class="form-input"
                 placeholder="07700123456"
                 value="<c:out value='${param.phone}' default=''/>"
                 required autocomplete="tel"/>
        </div>

        <div class="form-group position-relative">
          <label for="password" class="form-label">Password</label>
          <input type="password" id="password" name="password" class="form-input"
                 placeholder="Min 8 chars, 1 uppercase, 1 number, 1 symbol"
                 required autocomplete="new-password"/>
          <button type="button" class="password-toggle" id="togglePassword" aria-label="Show password">
            👁️
          </button>
          <small class="form-hint">Must contain uppercase, a number, and a symbol (@$!%*?&amp;)</small>
        </div>

        <div class="form-group position-relative">
          <label for="confirmPassword" class="form-label">Confirm password</label>
          <input type="password" id="confirmPassword" name="confirmPassword" class="form-input"
                 placeholder="Re-enter your password"
                 required autocomplete="new-password"/>
          <button type="button" class="password-toggle" id="toggleConfirmPassword" aria-label="Show password">
            👁️
          </button>
        </div>

        <div class="alert alert--info" style="font-size:0.82rem; margin-bottom:1rem;">
          ⏳ New accounts require admin approval before you can log in.
        </div>

        <button type="submit" id="registerBtn" class="btn btn--primary btn--full">
          Create Account
        </button>

        <p class="auth-link-text">
          Already have an account?
          <a href="${pageContext.request.contextPath}/login" class="auth-link">Sign in</a>
        </p>

      </form>
    </div>
  </div>

</div>
  <script>
    // Toggle password visibility for password field
    document.getElementById('togglePassword').addEventListener('click', function () {
      const passwordInput = document.getElementById('password');
      const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordInput.setAttribute('type', type);
      // Toggle icon
      this.textContent = type === 'password' ? '👁️' : '👁️‍🗨️';
    });

    // Toggle password visibility for confirm password field
    document.getElementById('toggleConfirmPassword').addEventListener('click', function () {
      const confirmInput = document.getElementById('confirmPassword');
      const type = confirmInput.getAttribute('type') === 'password' ? 'text' : 'password';
      confirmInput.setAttribute('type', type);
      // Toggle icon
      this.textContent = type === 'password' ? '👁️' : '👁️‍🗨️';
    });
  </script>
</body>
</html>
