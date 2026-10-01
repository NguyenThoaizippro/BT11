<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quản Trị Hệ Thống</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
        }
        main {
            flex: 1;
        }
        footer {
            background-color: #212529;
            color: #f8f9fa;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Admin Header -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid px-4">
                <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/books">
                    <i class="bi bi-gear-fill me-1"></i> ADMIN DASHBOARD (ĐỀ 01)
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="adminNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/admin/books">
                                <i class="bi bi-journal-text me-1"></i> Quản Lý Sách
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/admin/authors">
                                <i class="bi bi-people me-1"></i> Quản Lý Tác Giả
                            </a>
                        </li>
                    </ul>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house me-1"></i> Xem Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="py-4">
        <div class="container-fluid px-4">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- Footer chứa thông tin bắt buộc: Họ tên, MSSV, Mã đề -->
    <footer class="py-3 mt-auto text-center border-top">
        <div class="container">
            <div class="fw-bold mb-1">
                Họ tên: Nguyễn Ngọc Thoại &nbsp;|&nbsp; MSSV: 24110342 &nbsp;|&nbsp; Mã đề: Đề số 01
            </div>
            <div class="text-secondary small">
                Trang Quản Trị Hệ Thống – Đề thi Quá trình HK1 2026-2027
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
