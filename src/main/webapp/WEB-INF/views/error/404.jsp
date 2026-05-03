<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
  <!DOCTYPE html>
  <html lang="en">
  <jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="pageTitle" value="Page Not Found — Paw Furr-Ever" />
  </jsp:include>
  <style>
    .error-page {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 80vh;
      text-align: center;
      padding: 2rem;
    }

    .error-code {
      font-size: 8rem;
      font-weight: 800;
      color: var(--color-primary);
      line-height: 1;
    }

    .error-emoji img {
      width: 320px;
      height: 340px;
      object-fit: cover;
      border-radius: 20px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .error-title {
      font-size: 2rem;
      font-weight: 700;
      color: var(--color-text);
      margin-bottom: .5rem;
    }

    .error-msg {
      color: var(--color-muted);
      margin-bottom: 2rem;
      font-size: 1.1rem;
    }
  </style>

  <body>
    <nav class="navbar" style="position:relative;">
      <div class="nav-container">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand"><span class="nav-logo">🐾</span> Paw
          Furr-Ever</a>
      </div>
    </nav>
    <div class="error-page">
      <div class="error-code">404</div>
      <div class="error-emoji">
        <img src="${pageContext.request.contextPath}/images/Dogs/hehe.png" alt="Happy dog">
      </div>
      <h1 class="error-title">Page Not Found</h1>
      <p class="error-msg">Looks like this page took a walk and didn't come back!</p>
      <a href="${pageContext.request.contextPath}/home" class="btn btn--primary btn--lg">Go Back Home</a>
    </div>
  </body>

  </html>