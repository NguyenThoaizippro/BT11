<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Tác Giả - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h3 class="h4 fw-bold text-dark mb-0">QUẢN LÝ DANH SÁCH TÁC GIẢ</h3>
            <small class="text-muted">Tổng số: ${totalAuthors} tác giả trong hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/authors/add" class="btn btn-primary">
            <i class="bi bi-person-plus me-1"></i> Thêm Tác Giả Mới
        </a>
    </div>

    <c:if test="${param.msg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Thêm tác giả mới thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Cập nhật thông tin tác giả thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-trash me-1"></i> Đã xóa tác giả khỏi hệ thống!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 80px;" class="text-center">ID</th>
                            <th>Tên Tác Giả</th>
                            <th>Ngày Sinh</th>
                            <th class="text-center">Số Sách Tác Giả Tham Gia</th>
                            <th style="width: 160px;" class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="author" items="${authors}">
                            <tr>
                                <td class="text-center fw-bold text-muted">${author.authorId}</td>
                                <td class="fw-semibold text-primary">
                                    <i class="bi bi-person-badge me-1"></i>
                                    <c:out value="${author.authorName}"/>
                                </td>
                                <td>
                                    <c:out value="${author.dateOfBirth != null ? author.dateOfBirth : 'Chưa cập nhật'}"/>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-info text-dark">
                                        ${author.bookCount} cuốn sách
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/authors/edit?id=${author.authorId}" class="btn btn-outline-primary btn-sm me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/authors/delete?id=${author.authorId}" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa tác giả này?');" title="Xóa">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Phân trang Admin Authors -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Author admin navigation" class="d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/authors?page=${currentPage - 1}">Trước</a>
                </li>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/authors?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/authors?page=${currentPage + 1}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>
