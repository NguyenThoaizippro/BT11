<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Hàng Thành Công</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-sm border">
                <div class="card-body p-4 text-center">
                    <i class="bi bi-check-circle-fill text-success fs-1"></i>
                    <h2 class="h4 fw-bold mt-2">ĐẶT HÀNG THÀNH CÔNG!</h2>
                    <p class="text-muted">
                        Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đang ở trạng thái
                        <strong>Đơn hàng mới</strong>.
                    </p>

                    <table class="table table-bordered mt-3 text-start">
                        <tbody>
                            <tr>
                                <th style="width: 180px;">Mã đơn hàng</th>
                                <td>#${order.orderId}</td>
                            </tr>
                            <tr>
                                <th>Phương thức thanh toán</th>
                                <td>Thanh toán khi nhận hàng (COD)</td>
                            </tr>
                            <tr>
                                <th>Người nhận</th>
                                <td>
                                    <c:out value="${order.receiverName}"/> -
                                    <c:out value="${order.receiverPhone}"/>
                                </td>
                            </tr>
                            <tr>
                                <th>Địa chỉ giao hàng</th>
                                <td><c:out value="${order.receiverAddress}"/></td>
                            </tr>
                            <tr>
                                <th>Tổng cộng</th>
                                <td class="fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="number"/> $</td>
                            </tr>
                        </tbody>
                    </table>

                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                        <i class="bi bi-house me-1"></i> Về trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
