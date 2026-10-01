<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đặt Hàng</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h2 class="h4 fw-bold text-dark mb-0"><i class="bi bi-box-seam me-2"></i>LỊCH SỬ ĐẶT HÀNG</h2>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Trang chủ
        </a>
    </div>

    <!-- Bộ lọc trạng thái: Tất cả + 8 trạng thái đơn -->
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/orders"
           class="btn btn-sm ${empty param.status ? 'btn-dark' : 'btn-outline-dark'} me-1 mb-1">
            <i class="bi bi-funnel me-1"></i> Tất cả
        </a>
        <c:forEach var="entry" items="${statusMap}">
            <a href="${pageContext.request.contextPath}/orders?status=${entry.key}"
               class="btn btn-sm ${param.status == entry.key ? 'btn-dark' : 'btn-outline-dark'} me-1 mb-1">
                <c:out value="${entry.value}"/>
            </a>
        </c:forEach>
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="alert alert-secondary">
                <i class="bi bi-inbox me-1"></i>
                <c:choose>
                    <c:when test="${not empty param.status}">
                        Không có đơn hàng nào ở trạng thái "<c:out value="${statusLabel}"/>".
                    </c:when>
                    <c:otherwise>
                        Bạn chưa có đơn hàng nào.
                        <a href="${pageContext.request.contextPath}/home" class="alert-link fw-semibold">Mua sắm ngay</a>.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card shadow-sm border">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped mb-0 align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 100px;">Mã đơn</th>
                                <th style="width: 170px;">Ngày đặt</th>
                                <th style="width: 110px;">Số sản phẩm</th>
                                <th style="width: 150px;">Tổng tiền</th>
                                <th style="width: 170px;">Trạng thái</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td class="fw-semibold">#${o.orderId}</td>
                                <td><fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>${o.itemCount}</td>
                                <td class="fw-semibold"><fmt:formatNumber value="${o.totalAmount}" type="number"/> $</td>
                                <td><span class="badge ${o.statusColor}">${o.statusLabel}</span></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order-detail?id=${o.orderId}"
                                       class="btn btn-outline-primary btn-sm">
                                        <i class="bi bi-eye me-1"></i> Chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
