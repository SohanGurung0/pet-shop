<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="pageTitle" value="My Orders — Paw Furr-Ever" />
</jsp:include>

<body>

    <jsp:include page="/WEB-INF/templates/nav.jsp">
        <jsp:param name="activeLink" value="orders" />
    </jsp:include>

    <div class="page-header">
        <div class="container">
            <h1 class="page-title">📜 My Orders</h1>
        </div>
    </div>

    <div class="container orders-container">
        <c:choose>
            <c:when test="${not empty orders}">
                <div class="orders-list">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <div class="order-meta">
                                    <span class="order-id">Order #${order.id}</span>
                                    <span class="order-date">
                                        <fmt:formatDate value="${order.createdAt}" pattern="MMM dd, yyyy" />
                                    </span>
                                </div>
                                <div class="order-status-badge status--${order.status}">
                                    ${order.status}
                                </div>
                            </div>
                            
                            <div class="order-body">
                                <div class="order-info">
                                    <p><strong>Total:</strong> Rs. <fmt:formatNumber value="${order.totalPrice}" minFractionDigits="2" maxFractionDigits="2" /></p>
                                    <p><strong>Address:</strong> <c:out value="${order.shippingAddress}" /></p>
                                </div>
                                <div class="order-actions">
                                    <a href="${pageContext.request.contextPath}/orders?id=${order.id}" class="btn btn--outline btn--sm">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state-box">
                    <div class="empty-state-icon">📦</div>
                    <h3>No orders yet</h3>
                    <p>You haven't placed any orders. Start shopping today!</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn--primary">Browse Products</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="/WEB-INF/templates/footer.jsp" />

    <style>
        .orders-container {
            margin: 2rem auto;
            max-width: 800px;
        }

        .order-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-bottom: 1.5rem;
            overflow: hidden;
            border: 1px solid var(--color-bg);
            transition: transform 0.2s;
        }

        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }

        .order-header {
            padding: 1.25rem;
            background: #fafafa;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--color-bg);
        }

        .order-id {
            font-weight: 700;
            color: var(--color-primary-dark);
            font-size: 1.1rem;
            display: block;
        }

        .order-date {
            font-size: 0.85rem;
            color: #666;
        }

        .order-status-badge {
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status--pending { background: #fef3c7; color: #92400e; }
        .status--confirmed { background: #dbeafe; color: #1e40af; }
        .status--shipped { background: #f3e8ff; color: #6b21a8; }
        .status--delivered { background: #dcfce7; color: #166534; }
        .status--cancelled { background: #fee2e2; color: #991b1b; }

        .order-body {
            padding: 1.25rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .order-info p {
            margin: 0.5rem 0;
            font-size: 0.95rem;
        }

        @media (max-width: 600px) {
            .order-body {
                flex-direction: column;
                align-items: flex-start;
                gap: 1.5rem;
            }
            .order-actions {
                width: 100%;
            }
            .order-actions .btn {
                width: 100%;
            }
        }
    </style>

</body>
</html>
