<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sách - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h3 class="h4 fw-bold text-dark mb-0">QUẢN LÝ DANH SÁCH SÁCH</h3>
            <small class="text-muted">Tổng số: ${totalBooks} cuốn sách trong hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/books/add" class="btn btn-primary">
            <i class="bi bi-plus-lg me-1"></i> Thêm Sách Mới
        </a>
    </div>

    <c:if test="${param.msg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Thêm sách mới thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Cập nhật thông tin sách thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-trash me-1"></i> Đã xóa cuốn sách khỏi hệ thống!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 60px;" class="text-center">ID</th>
                            <th style="width: 80px;" class="text-center">Bìa</th>
                            <th>Tiêu đề sách</th>
                            <th>Mã ISBN</th>
                            <th>Tác giả</th>
                            <th>Nhà xuất bản</th>
                            <th class="text-end">Giá bán</th>
                            <th class="text-center">Số lượng</th>
                            <th style="width: 150px;" class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${books}">
                            <tr>
                                <td class="text-center fw-bold text-muted">${book.bookid}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty book.coverImage && fn:startsWith(book.coverImage, 'http')}">
                                            <img src="${book.coverImage}" class="rounded border" style="width: 50px; height: 65px; object-fit: cover;" alt="cover">
                                        </c:when>
                                        <c:when test="${not empty book.coverImage}">
                                            <img src="${pageContext.request.contextPath}/image?fname=${book.coverImage}" class="rounded border" style="width: 50px; height: 65px; object-fit: cover;" alt="cover">
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted border">No img</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookid}" target="_blank" class="fw-bold text-decoration-none text-dark">
                                        <c:out value="${book.title}"/>
                                    </a>
                                </td>
                                <td><code><c:out value="${book.isbn}"/></code></td>
                                <td class="text-primary"><c:out value="${book.authorNames}"/></td>
                                <td><c:out value="${book.publisher}"/></td>
                                <td class="text-end text-success fw-bold">$<c:out value="${book.price}"/></td>
                                <td class="text-center"><span class="badge bg-secondary">${book.quantity}</span></td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/books/edit?id=${book.bookid}" class="btn btn-outline-primary btn-sm me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/books/delete?id=${book.bookid}" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa cuốn sách này?');" title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Phân trang Admin Books -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Book admin navigation" class="d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/books?page=${currentPage - 1}">Trước</a>
                </li>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/books?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/books?page=${currentPage + 1}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>
