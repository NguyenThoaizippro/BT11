<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h2 class="h4 fw-bold text-dark mb-0"><i class="bi bi-cart3 me-2"></i>GIỎ HÀNG CỦA BẠN</h2>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Tiếp tục mua sắm
        </a>
    </div>

    <c:if test="${param.success == 'add'}">
        <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i> Đã thêm sản phẩm vào giỏ hàng.</div>
    </c:if>
    <c:if test="${param.success == 'update'}">
        <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i> Đã cập nhật số lượng sản phẩm.</div>
    </c:if>
    <c:if test="${param.success == 'delete'}">
        <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i> Đã xóa sản phẩm khỏi giỏ hàng.</div>
    </c:if>
    <c:if test="${param.error == 'stock'}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-1"></i> Số lượng vượt quá số lượng tồn kho còn lại!</div>
    </c:if>
    <c:if test="${param.error == 'invalid'}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-1"></i> Số lượng phải là số nguyên từ 1 trở lên.</div>
    </c:if>

    <c:choose>
        <c:when test="${empty sessionScope.cart || empty sessionScope.cart.items}">
            <div class="alert alert-secondary">
                <i class="bi bi-cart-x me-1"></i> Giỏ hàng đang trống.
                <a href="${pageContext.request.contextPath}/home" class="alert-link fw-semibold">Thêm sản phẩm ngay</a>.
            </div>
        </c:when>
        <c:otherwise>
            <div class="card shadow-sm border">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped mb-0 align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 60px;">STT</th>
                                <th>Tên sách</th>
                                <th style="width: 130px;">Đơn giá</th>
                                <th style="width: 230px;">Số lượng</th>
                                <th style="width: 140px;">Thành tiền</th>
                                <th style="width: 100px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${sessionScope.cart.items}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/book-detail?id=${item.bookId}" class="text-decoration-none">
                                        <c:out value="${item.title}"/>
                                    </a>
                                    <div class="text-muted small">Tồn kho: <c:out value="${item.stockQty}"/></div>
                                </td>
                                <td><fmt:formatNumber value="${item.unitPrice}" type="number"/> $</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex gap-1">
                                        <input type="hidden" name="action" value="update"/>
                                        <input type="hidden" name="bookId" value="${item.bookId}"/>
                                        <input type="number" name="qty" class="form-control form-control-sm" style="width: 80px;"
                                               value="${item.quantity}" min="1" max="${item.stockQty}" required/>
                                        <button type="submit" class="btn btn-primary btn-sm">
                                            <i class="bi bi-arrow-repeat"></i> Cập nhật
                                        </button>
                                    </form>
                                </td>
                                <td class="fw-semibold"><fmt:formatNumber value="${item.lineTotal}" type="number"/> $</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="bookId" value="${item.bookId}"/>
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>Tổng số lượng: <strong>${sessionScope.cart.totalQuantity()}</strong> cuốn</div>
                    <div class="fs-5 fw-bold text-dark">
                        Tổng cộng: <fmt:formatNumber value="${sessionScope.cart.totalPrice()}" type="number"/> $
                    </div>
                </div>
            </div>

            <div class="text-end mt-3">
                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary">
                    <i class="bi bi-credit-card me-1"></i> Tiến hành thanh toán (COD)
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
