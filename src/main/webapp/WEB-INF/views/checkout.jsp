<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="/WEB-INF/templates/head.jsp">
    <jsp:param name="pageTitle" value="Checkout — Paw Furr-Ever" />
</jsp:include>

<body>

    <jsp:include page="/WEB-INF/templates/nav.jsp">
        <jsp:param name="activeLink" value="cart" />
    </jsp:include>

    <div class="page-header">
        <div class="container">
            <h1 class="page-title">📦 Checkout</h1>
        </div>
    </div>

    <div class="container checkout-container">
        <div class="checkout-layout">
            
            <%-- Checkout Form --%>
            <div class="checkout-form-section card">
                <h2 class="section-title">Delivery Details</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert--danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" class="form-input" value="${sessionScope.loggedUser.fullName}" readonly />
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" class="form-input" value="${sessionScope.loggedUser.phone}" readonly />
                    </div>

                    <div class="form-group">
                        <label for="address">Delivery Address</label>
                        <textarea name="address" id="address" class="form-input" rows="4" placeholder="Enter your full street address, city, and landmarks..." required></textarea>
                    </div>

                    <div class="payment-section">
                        <h3 class="subsection-title">Payment Method</h3>
                        <div class="payment-option selected">
                            <input type="radio" name="payment" id="cod" value="COD" checked />
                            <label for="cod">
                                <span class="payment-icon">💵</span>
                                <div class="payment-details">
                                    <strong>Cash on Delivery (COD)</strong>
                                    <span>Pay when your package arrives.</span>
                                </div>
                            </label>
                        </div>
                        <p class="payment-hint">Other payment methods coming soon!</p>
                    </div>

                    <div class="checkout-actions">
                        <button type="submit" class="btn btn--primary btn--lg btn--full">Confirm Order</button>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn--ghost btn--full" style="margin-top: 1rem;">Back to Cart</a>
                    </div>
                </form>
            </div>

            <%-- Order Summary --%>
            <aside class="order-summary-section card">
                <h2 class="section-title">Order Summary</h2>
                
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>Rs. <fmt:formatNumber value="${subtotal}" minFractionDigits="2" maxFractionDigits="2" /></span>
                </div>
                
                <div class="summary-row">
                    <span>Delivery Fee</span>
                    <span>
                        <c:choose>
                            <c:when test="${deliveryFee == 0}">FREE</c:when>
                            <c:otherwise>Rs. <fmt:formatNumber value="${deliveryFee}" minFractionDigits="2" maxFractionDigits="2" /></c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="summary-divider"></div>
                
                <div class="summary-row summary-row--total">
                    <span>Total</span>
                    <span class="total-price">Rs. <fmt:formatNumber value="${finalTotal}" minFractionDigits="2" maxFractionDigits="2" /></span>
                </div>

                <div class="order-guarantee">
                    <span class="guarantee-icon">🛡️</span>
                    <p>Secure transaction guaranteed. Your details are safe with us.</p>
                </div>
            </aside>
        </div>
    </div>

    <jsp:include page="/WEB-INF/templates/footer.jsp" />

    <style>
        .checkout-layout {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 2rem;
            margin: 2rem 0;
        }

        .card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-bg);
            padding-bottom: 0.5rem;
        }

        .subsection-title {
            font-size: 1.1rem;
            margin: 2rem 0 1rem;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 2px solid var(--color-bg);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .payment-option.selected {
            border-color: var(--color-primary);
            background: var(--color-bg);
        }

        .payment-option label {
            display: flex;
            align-items: center;
            gap: 1rem;
            width: 100%;
            cursor: pointer;
        }

        .payment-icon {
            font-size: 1.5rem;
        }

        .payment-details strong {
            display: block;
        }

        .payment-details span {
            font-size: 0.85rem;
            color: #666;
        }

        .payment-hint {
            font-size: 0.85rem;
            color: #888;
            margin-top: 0.5rem;
            font-style: italic;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .summary-divider {
            height: 1px;
            background: var(--color-bg);
            margin: 1rem 0;
        }

        .summary-row--total {
            font-weight: 700;
            font-size: 1.25rem;
        }

        .total-price {
            color: var(--color-primary);
        }

        .order-guarantee {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            align-items: center;
            background: #f0fdf4;
            padding: 1rem;
            border-radius: 8px;
            color: #166534;
            font-size: 0.9rem;
        }

        .guarantee-icon {
            font-size: 1.5rem;
        }

        @media (max-width: 992px) {
            .checkout-layout {
                grid-template-columns: 1fr;
            }
            .order-summary-section {
                order: -1;
            }
        }
    </style>

</body>
</html>
