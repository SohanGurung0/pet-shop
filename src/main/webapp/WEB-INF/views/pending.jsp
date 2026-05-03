<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/head.jsp">
  <jsp:param name="pageTitle" value="Account Pending — Paw Furr-Ever" />
  <jsp:param name="cssFile" value="auth.css" />
</jsp:include>
<body class="auth-body">
<div style="display:flex; align-items:center; justify-content:center; min-height:100vh; text-align:center; padding:2rem;">
  <div class="auth-form-container" style="max-width:480px;">
    <div style="font-size:4rem; margin-bottom:1rem;">⏳</div>
    <h1 style="font-size:2rem; font-weight:700; color:var(--color-text); margin-bottom:.5rem;">Account Pending Approval</h1>
    <p style="color:var(--color-muted); margin-bottom:2rem; line-height:1.6;">
      Thank you for registering with Paw Furr-Ever! Your account is currently awaiting review by our admin team.
      You'll be able to log in as soon as your account is approved.
    </p>
    <a href="${pageContext.request.contextPath}/login" class="btn btn--primary btn--full">Back to Login</a>
  </div>
</div>
</body>
</html>
