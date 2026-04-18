<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Page Not Found — PawShop</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
  <style>
    .error-page { display:flex; flex-direction:column; align-items:center; justify-content:center; min-height:80vh; text-align:center; padding:2rem; }
    .error-code  { font-size:8rem; font-weight:800; color:var(--color-primary); line-height:1; }
    .error-emoji { font-size:4rem; margin:1rem 0; }
    .error-title { font-size:2rem; font-weight:700; color:var(--color-text); margin-bottom:.5rem; }
    .error-msg   { color:var(--color-muted); margin-bottom:2rem; font-size:1.1rem; }
  </style>
</head>
<body>
<nav class="navbar" style="position:relative;">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand"><span class="nav-logo">🐾</span> PawShop</a>
  </div>
</nav>
<div class="error-page">
  <div class="error-code">404</div>
  <div class="error-emoji">🐕</div>
  <h1 class="error-title">Page Not Found</h1>
  <p class="error-msg">Looks like this page took a walk and didn't come back!</p>
  <a href="${pageContext.request.contextPath}/home" class="btn btn--primary btn--lg">Go Back Home</a>
</div>
</body>
</html>
