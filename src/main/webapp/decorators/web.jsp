<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Nhà Sách Online</title>
    <!-- Bootstrap 5 CSS CDN (Bản chuẩn mặc định, không màu mè gradient/neon) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        main {
            flex: 1;
        }
        .book-card {
            height: 100%;
            transition: border-color 0.2s;
        }
        .book-card:hover {
            border-color: #0d6efd;
        }
        .book-cover {
            height: 240px;
            object-fit: cover;
            background-color: #e9ecef;
        }
        footer {
            background-color: #212529;
            color: #f8f9fa;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Header (Menu: Trang Chủ, Sản phẩm, Đăng nhập / Tên User & Đăng xuất, Trang quản trị) -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-book-half me-1"></i> NHÀ SÁCH ĐỀ 01
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarMain">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">Sản phẩm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                                <c:if test="${not empty sessionScope.cart && sessionScope.cart.totalQuantity() > 0}">
                                    <span class="badge bg-danger">${sessionScope.cart.totalQuantity()}</span>
                                </c:if>
                            </a>
                        </li>
                        <c:if test="${sessionScope.account != null && sessionScope.account.isAdmin}">
                            <li class="nav-item">
                                <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/books">
                                    <i class="bi bi-shield-lock me-1"></i> Trang quản trị
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    <ul class="navbar-nav ms-auto">
                        <c:choose>
                            <c:when test="${sessionScope.account != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-1"></i>
                                        <c:out value="${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.email}" />
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <c:if test="${sessionScope.account.isAdmin}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/books">Vào Quản Trị</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                        </c:if>
                                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                                </li>
                                <li class="nav-item">
                                    <a class="btn btn-outline-light btn-sm ms-2" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Content chính -->
    <main class="py-4">
        <div class="container">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- Footer chứa thông tin bắt buộc theo Câu 1: Họ tên, MSSV, Mã đề -->
    <footer class="py-3 mt-auto text-center border-top">
        <div class="container">
            <div class="fw-bold mb-1">
                Họ tên: Nguyễn Ngọc Thoại &nbsp;|&nbsp; MSSV: 24110342 &nbsp;|&nbsp; Mã đề: Đề số 01
            </div>
            <div class="text-secondary small">
                Đề thi Quá trình – HK1 – 2026-2027 – Môn Lập Trình Web – Thời gian làm bài: 180 phút
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
