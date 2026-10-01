<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - Kích Hoạt OTP Qua Mail</title>
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
        .auth-card {
            max-width: 460px;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="auth-card p-3 my-4">
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
                        <i class="bi bi-person-plus text-primary fs-1"></i>
                        <h4 class="fw-bold text-dark mt-2">ĐĂNG KÝ TÀI KHOẢN</h4>
                    </a>
                    <p class="text-muted small">Kích hoạt tài khoản bằng mã OTP gửi qua email (Câu 2)</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small" role="alert">
                        <i class="bi bi-exclamation-triangle me-1"></i> <c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold">Họ và tên:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" id="fullname" name="fullname" value="${fullname}" placeholder="Nguyễn Văn A" required autofocus>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Email nhận OTP:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" value="${email}" placeholder="yourname@gmail.com" required>
                        </div>
                        <div class="form-text">Mã OTP xác thực sẽ được gửi trực tiếp đến địa chỉ email này.</div>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                            <input type="number" class="form-control" id="phone" name="phone" value="${phone}" placeholder="0901234567">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold">Mật khẩu:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required minlength="6">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="repassword" class="form-label fw-semibold">Xác nhận mật khẩu:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                            <input type="password" class="form-control" id="repassword" name="repassword" placeholder="Nhập lại mật khẩu" required minlength="6">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                        <i class="bi bi-envelope-paper me-1"></i> Đăng Ký & Nhận Mã OTP
                    </button>
                </form>

                <div class="mt-4 pt-3 border-top text-center">
                    <span class="text-muted small">Đã có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none ms-1">Đăng nhập</a>
                </div>

                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/home" class="text-secondary small text-decoration-none">
                        <i class="bi bi-house me-1"></i> Về trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
