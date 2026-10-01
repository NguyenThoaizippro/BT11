<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực Mã OTP - Kích Hoạt Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .otp-card {
            max-width: 440px;
            width: 100%;
        }
        .otp-input {
            letter-spacing: 8px;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="otp-card p-3">
        <div class="card shadow-sm border-0">
            <div class="card-body p-4 text-center">
                <i class="bi bi-shield-check text-primary fs-1"></i>
                <h4 class="fw-bold text-dark mt-2">XÁC THỰC MÃ OTP</h4>
                <p class="text-muted small">
                    Mã xác thực gồm 6 chữ số đã được gửi tới email của bạn. Vui lòng nhập mã để kích hoạt tài khoản.
                </p>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small text-start" role="alert">
                        <i class="bi bi-exclamation-triangle me-1"></i> <c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="mt-4">
                    <div class="mb-4">
                        <label for="otp" class="form-label fw-semibold text-secondary">Nhập 6 số OTP:</label>
                        <input type="text" class="form-control otp-input" id="otp" name="otp" maxlength="6" placeholder="______" required autofocus autocomplete="off">
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                        <i class="bi bi-check2-circle me-1"></i> Kích Hoạt Tài Khoản
                    </button>
                </form>

                <div class="mt-4 p-2 bg-light border rounded small text-secondary text-start">
                    <i class="bi bi-info-circle me-1 text-primary"></i> <strong>Lưu ý kiểm thử:</strong> Mã OTP đồng thời được in trực tiếp ra <strong>Console / Terminal</strong> của máy chủ để bạn kiểm thử nhanh chóng ngay cả khi không có kết nối internet.
                </div>

                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/register" class="text-secondary small text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại form đăng ký
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
