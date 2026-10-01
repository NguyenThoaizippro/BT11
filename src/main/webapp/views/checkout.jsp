<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng (COD)</title>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại giỏ hàng
        </a>
    </div>

    <h2 class="h4 fw-bold text-dark mb-4 pb-2 border-bottom">
        <i class="bi bi-credit-card me-2"></i> THANH TOÁN ĐƠN HÀNG (COD)
    </h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <i class="bi bi-exclamation-triangle me-1"></i> <c:out value="${errorMessage}"/>
        </div>
    </c:if>

    <div class="row g-4">
        <div class="col-lg-7">
            <div class="card shadow-sm border">
                <div class="card-header bg-white fw-bold">
                    <i class="bi bi-person-vcard me-1"></i> Thông tin người nhận
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="mb-3">
                            <label for="receiverName" class="form-label fw-semibold">Họ tên người nhận <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="receiverName" name="receiverName"
                                   value="<c:out value='${receiverName}'/>" required maxlength="50"/>
                        </div>
                        <div class="mb-3">
                            <label for="receiverPhone" class="form-label fw-semibold">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="receiverPhone" name="receiverPhone"
                                   value="<c:out value='${receiverPhone}'/>" required maxlength="15" placeholder="9-11 chữ số"/>
                        </div>
                        <div class="mb-3">
                            <label for="receiverAddress" class="form-label fw-semibold">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="receiverAddress" name="receiverAddress"
                                   value="<c:out value='${receiverAddress}'/>" required maxlength="255"
                                   placeholder="Số nhà, đường, quận/huyện, tỉnh/thành"/>
                        </div>
                        <div class="mb-3">
                            <label for="note" class="form-label fw-semibold">Ghi chú (không bắt buộc)</label>
                            <textarea class="form-control" id="note" name="note" rows="2" maxlength="255"
                                      placeholder="Ví dụ: gọi trước khi giao..."><c:out value="${note}"/></textarea>
                        </div>
                        <div class="mb-3">
                            <span class="form-label fw-semibold d-block">Phương thức thanh toán:</span>
                            <div class="form-control bg-light text-dark">
                                <i class="bi bi-cash-coin me-1"></i> Thanh toán khi nhận hàng (COD)
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                            <i class="bi bi-bag-check me-1"></i> Đặt hàng
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card shadow-sm border">
                <div class="card-header bg-white fw-bold">
                    <i class="bi bi-bag me-1"></i> Đơn hàng của bạn
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty sessionScope.cart || empty sessionScope.cart.items}">
                            <p class="text-muted mb-0 fst-italic">Giỏ hàng trống.</p>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush mb-3">
                                <c:forEach var="item" items="${sessionScope.cart.items}">
                                    <li class="list-group-item px-0 d-flex justify-content-between">
                                        <span><c:out value="${item.title}"/> <span class="text-muted">x${item.quantity}</span></span>
                                        <span class="fw-semibold"><fmt:formatNumber value="${item.lineTotal}" type="number"/> $</span>
                                    </li>
                                </c:forEach>
                            </ul>
                            <div class="d-flex justify-content-between fs-5 fw-bold">
                                <span>Tổng cộng</span>
                                <span><fmt:formatNumber value="${sessionScope.cart.totalPrice()}" type="number"/> $</span>
                            </div>
                            <p class="text-muted small mt-2 mb-0">
                                <i class="bi bi-info-circle me-1"></i> Bạn sẽ trả tiền mặt khi nhận hàng.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
