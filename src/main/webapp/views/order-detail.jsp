<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Đơn Hàng #${order.orderId}</title>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại lịch sử đặt hàng
        </a>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h2 class="h4 fw-bold text-dark mb-0">CHI TIẾT ĐƠN HÀNG #${order.orderId}</h2>
        <span class="badge ${order.statusColor} fs-6">${order.statusLabel}</span>
    </div>

    <div class="row g-4">
        <div class="col-lg-5">
            <div class="card shadow-sm border">
                <div class="card-header bg-white fw-bold">
                    <i class="bi bi-person-vcard me-1"></i> Thông tin giao hàng
                </div>
                <div class="card-body">
                    <table class="table table-sm table-borderless mb-0">
                        <tbody>
                            <tr>
                                <th style="width: 150px;">Ngày đặt</th>
                                <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            </tr>
                            <tr>
                                <th>Người nhận</th>
                                <td><c:out value="${order.receiverName}"/></td>
                            </tr>
                            <tr>
                                <th>Số điện thoại</th>
                                <td><c:out value="${order.receiverPhone}"/></td>
                            </tr>
                            <tr>
                                <th>Địa chỉ</th>
                                <td><c:out value="${order.receiverAddress}"/></td>
                            </tr>
                            <tr>
                                <th>Thanh toán</th>
                                <td><i class="bi bi-cash-coin me-1"></i> COD (tiền mặt khi nhận)</td>
                            </tr>
                            <tr>
                                <th>Ghi chú</th>
                                <td><c:out value="${not empty order.note ? order.note : 'Không có'}"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card shadow-sm border">
                <div class="card-header bg-white fw-bold">
                    <i class="bi bi-list-check me-1"></i> Sản phẩm trong đơn
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered mb-0 align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 60px;">STT</th>
                                <th>Tên sách</th>
                                <th style="width: 120px;">Đơn giá</th>
                                <th style="width: 70px;">SL</th>
                                <th style="width: 130px;">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="d" items="${order.details}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/book-detail?id=${d.bookId}"
                                       class="text-decoration-none">
                                        <c:out value="${d.bookTitle}"/>
                                    </a>
                                </td>
                                <td><fmt:formatNumber value="${d.unitPrice}" type="number"/> $</td>
                                <td>${d.quantity}</td>
                                <td class="fw-semibold"><fmt:formatNumber value="${d.lineTotal}" type="number"/> $</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="table-light">
                                <th colspan="4" class="text-end">Tổng cộng</th>
                                <th><fmt:formatNumber value="${order.totalAmount}" type="number"/> $</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
