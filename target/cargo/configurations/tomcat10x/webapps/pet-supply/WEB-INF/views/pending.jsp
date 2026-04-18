<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Account Pending — PawShop</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css"/>
</head>
<body class="auth-body">
<div style="display:flex; align-items:center; justify-content:center; min-height:100vh; text-align:center; padding:2rem;">
  <div class="auth-form-container" style="max-width:480px;">
    <div style="font-size:4rem; margin-bottom:1rem;">⏳</div>
    <h1 style="font-size:2rem; font-weight:700; color:var(--color-text); margin-bottom:.5rem;">Account Pending Approval</h1>
    <p style="color:var(--color-muted); margin-bottom:2rem; line-height:1.6;">
      Thank you for registering with PawShop! Your account is currently awaiting review by our admin team.
      You'll be able to log in as soon as your account is approved.
    </p>
    <a href="${pageContext.request.contextPath}/login" class="btn btn--primary btn--full">Back to Login</a>
  </div>
</div>
</body>
</html>
