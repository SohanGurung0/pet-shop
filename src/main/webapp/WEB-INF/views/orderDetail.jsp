<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="pageTitle" value="Order Details — Paw Furr-Ever" />
</jsp:include>

<body>

    <jsp:include page="/WEB-INF/templates/nav.jsp">
        <jsp:param name="activeLink" value="orders" />
    </jsp:include>

    <div class="page-header">
        <div class="container">
            <h1 class="page-title">📦 Order #${order.id}</h1>
        </div>
    </div>

    <div class="container order-detail-container">
        <div class="order-detail-layout">
            
            <%-- Order Information --%>
            <div class="order-info-section card">
                <div class="info-grid">
                    <div class="info-item">
                        <label>Status</label>
                        <span class="order-status-badge status--${order.status}">${order.status}</span>
                    </div>
                    <div class="info-item">
                        <label>Order Date</label>
                        <span><fmt:formatDate value="${order.createdAt}" pattern="MMM dd, yyyy HH:mm" /></span>
                    </div>
                    <div class="info-item">
                        <label>Payment Method</label>
                        <span>${order.paymentMethod}</span>
                    </div>
                    <div class="info-item">
                        <label>Shipping Address</label>
                        <span>${order.shippingAddress}</span>
                    </div>
                </div>
            </div>

            <%-- Order Items --%>
            <div class="order-items-section card">
                <h2 class="section-title">Order Items</h2>
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.items}">
                            <tr>
                                <td>
                                    <div class="product-cell">
                                        <img src="${pageContext.request.contextPath}/${item.productImageUrl}" alt="${item.productName}" class="item-thumb" onerror="this.src='${pageContext.request.contextPath}/images/default-product.png'" />
                                        <span>${item.productName}</span>
                                    </div>
                                </td>
                                <td>Rs. <fmt:formatNumber value="${item.unitPrice}" minFractionDigits="2" maxFractionDigits="2" /></td>
                                <td>${item.quantity}</td>
                                <td>Rs. <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr class="total-row">
                            <td colspan="3">Total Amount</td>
                            <td>Rs. <fmt:formatNumber value="${order.totalPrice}" minFractionDigits="2" maxFractionDigits="2" /></td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div class="detail-actions">
                <a href="${pageContext.request.contextPath}/orders" class="btn btn--outline">Back to My Orders</a>
                <a href="${pageContext.request.contextPath}/products" class="btn btn--primary">Continue Shopping</a>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/templates/footer.jsp" />

    <style>
        .order-detail-container {
            margin: 2rem auto;
            max-width: 900px;
        }

        .card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
        }

        .info-item label {
            display: block;
            font-size: 0.85rem;
            color: #888;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-item span {
            font-weight: 600;
            color: var(--color-primary-dark);
        }

        .section-title {
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table th {
            text-align: left;
            padding: 1rem;
            border-bottom: 2px solid var(--color-bg);
            color: #666;
            font-size: 0.9rem;
        }

        .items-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--color-bg);
        }

        .product-cell {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .item-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 6px;
        }

        .total-row td {
            font-weight: 700;
            font-size: 1.2rem;
            padding-top: 2rem;
            border-bottom: none;
        }

        .total-row td:last-child {
            color: var(--color-primary);
        }

        .detail-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .order-status-badge {
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status--pending { background: #fef3c7; color: #92400e; }
        .status--confirmed { background: #dbeafe; color: #1e40af; }
        .status--shipped { background: #f3e8ff; color: #6b21a8; }
        .status--delivered { background: #dcfce7; color: #166534; }
        .status--cancelled { background: #fee2e2; color: #991b1b; }

        @media (max-width: 600px) {
            .items-table th:nth-child(2),
            .items-table td:nth-child(2) {
                display: none;
            }
            .detail-actions {
                flex-direction: column;
            }
        }
    </style>

</body>
</html>
