<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <jsp:include page="/WEB-INF/templates/head.jsp">
                <jsp:param name="pageTitle" value="Manage Orders — Admin" />
                <jsp:param name="cssFile" value="admin.css" />
            </jsp:include>

            <body class="admin-body">

                <div class="admin-layout">
                    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp">
                        <jsp:param name="activeLink" value="orders" />
                    </jsp:include>

                    <main class="admin-main">
                        <div class="admin-topbar">
                            <div>
                                <h1 class="admin-page-title">Order Management</h1>
                                <p class="admin-page-subtitle">Manage all customer orders and update their status.</p>
                            </div>
                        </div>

                        <c:if test="${not empty sessionScope.successMsg}">
                            <div class="alert alert--success">${sessionScope.successMsg}</div>
                            <c:remove var="successMsg" scope="session" />
                        </c:if>
                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert alert--error">${sessionScope.errorMsg}</div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <div class="admin-card overflow-x">
                            <table class="admin-table admin-table--striped">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>#${order.id}</td>
                                            <td>
                                                <strong>${order.userName}</strong>
                                                <div class="text-muted small">User ID: ${order.userId}</div>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${order.createdAt}" pattern="MMM dd, yyyy" />
                                            </td>
                                            <td>Rs.
                                                <fmt:formatNumber value="${order.totalPrice}" minFractionDigits="2"
                                                    maxFractionDigits="2" />
                                            </td>
                                            <td>
                                                <span
                                                    class="status-badge status-badge--${order.status}">${order.status}</span>
                                            </td>
                                            <td>
                                                <div class="table-actions">
                                                    <c:if test="${order.status == 'pending'}">
                                                        <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&id=${order.id}&status=confirmed"
                                                            class="btn btn--sm btn--primary">Confirm</a>
                                                    </c:if>
                                                    <c:if test="${order.status == 'confirmed'}">
                                                        <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&id=${order.id}&status=shipped"
                                                            class="btn btn--sm btn--outline">Ship</a>
                                                    </c:if>
                                                    <c:if test="${order.status == 'shipped'}">
                                                        <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&id=${order.id}&status=delivered"
                                                            class="btn btn--sm btn--success">Deliver</a>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/orders?id=${order.id}"
                                                        class="btn btn--sm btn--ghost">View</a>
                                                    <a href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${order.id}"
                                                        class="btn btn--sm btn--danger"
                                                        onclick="return confirm('Are you sure you want to delete this order? This action cannot be undone.')">Delete</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="6" class="text-center">No orders found.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </main>
                </div>

            </body>

            </html>