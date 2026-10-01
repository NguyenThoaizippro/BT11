<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Hệ Thống Nhà Sách</title>
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
    <div class="auth-card p-3">
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
                        <i class="bi bi-book-half text-primary fs-1"></i>
                        <h4 class="fw-bold text-dark mt-2">ĐĂNG NHẬP</h4>
                    </a>
                    <p class="text-muted small">Nhà Sách Đề 01 – Sinh viên: Nguyễn Ngọc Thoại (24110342)</p>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success py-2 small" role="alert">
                        <i class="bi bi-check-circle me-1"></i> <c:out value="${message}"/>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small" role="alert">
                        <i class="bi bi-exclamation-triangle me-1"></i> <c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="redirect" value="<c:out value='${param.redirect}'/>"/>
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Email:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" value="${email}" placeholder="name@example.com" required autofocus>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold">Mật khẩu:</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                    </button>
                </form>

                <div class="mt-4 pt-3 border-top text-center">
                    <span class="text-muted small">Chưa có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-decoration-none ms-1">Đăng ký ngay</a>
                </div>

                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/home" class="text-secondary small text-decoration-none">
                        <i class="bi bi-house me-1"></i> Về trang chủ
                    </a>
                </div>

                <!-- Gợi ý tài khoản kiểm thử cho Giảng viên / Người chấm -->
                <div class="mt-4 p-2 bg-light border rounded small text-secondary">
                    <div class="fw-semibold text-dark"><i class="bi bi-info-circle me-1"></i> Tài khoản mẫu:</div>
                    <div>• <strong>Admin:</strong> admin@example.com / 123456</div>
                    <div>• <strong>User:</strong> user@example.com / 123456</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
