<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Danh Sách Sách</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h2 class="h4 fw-bold text-dark mb-0">DANH MỤC SÁCH NỔI BẬT</h2>
            <small class="text-muted">Hiển thị 6 sản phẩm / trang — Tổng cộng ${totalBooks} cuốn sách</small>
        </div>
        <c:if test="${sessionScope.account != null && sessionScope.account.isAdmin}">
            <a href="${pageContext.request.contextPath}/admin/books/add" class="btn btn-primary btn-sm">
                <i class="bi bi-plus-circle me-1"></i> Thêm sách mới
            </a>
        </c:if>
    </div>

    <!-- Lưới 6 sản phẩm / trang bám sát định dạng mẫu của Đề thi (Câu 3) -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-5">
        <c:forEach var="book" items="${books}">
            <div class="col">
                <div class="card h-100 shadow-sm book-card border">
                    <!-- [cover_image] -->
                    <c:choose>
                        <c:when test="${not empty book.coverImage && fn:startsWith(book.coverImage, 'http')}">
                            <img src="${book.coverImage}" class="card-img-top book-cover" alt="${book.title}">
                        </c:when>
                        <c:when test="${not empty book.coverImage}">
                            <img src="${pageContext.request.contextPath}/image?fname=${book.coverImage}" class="card-img-top book-cover" alt="${book.title}">
                        </c:when>
                        <c:otherwise>
                            <div class="book-cover d-flex align-items-center justify-content-center text-muted">
                                <i class="bi bi-image fs-1"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="card-body">
                        <!-- Tiêu đề: (Bấm vào tiêu đề để sang trang chi tiết ở Câu 4) -->
                        <h5 class="card-title fs-6 fw-bold">
                            <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookid}" class="text-decoration-none text-primary">
                                <c:out value="${book.title}"/>
                            </a>
                        </h5>

                        <ul class="list-unstyled small mb-3">
                            <li><strong>Mã isbn:</strong> <c:out value="${book.isbn != null ? book.isbn : 'Đang cập nhật'}"/></li>
                            <li><strong>Tác giả:</strong> <c:out value="${book.authorNames}"/></li>
                            <li><strong>Publisher:</strong> <c:out value="${book.publisher != null ? book.publisher : 'Đang cập nhật'}"/></li>
                            <li><strong>Publisher_date:</strong> <c:out value="${book.publishDate != null ? book.publishDate : 'Đang cập nhật'}"/></li>
                            <li><strong>Quantity:</strong> <span class="badge bg-secondary"><c:out value="${book.quantity != null ? book.quantity : 0}"/></span></li>
                        </ul>

                        <div class="pt-2 border-top">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="text-warning small">
                                    <i class="bi bi-star-fill"></i>
                                    <span class="text-dark fw-semibold">Review (${book.reviewCount})</span>
                                </span>
                            </div>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookid}"
                                   class="btn btn-outline-primary btn-sm flex-grow-1">Chi tiết</a>
                                <form action="${pageContext.request.contextPath}/cart" method="post" class="flex-grow-1 m-0">
                                    <input type="hidden" name="action" value="add"/>
                                    <input type="hidden" name="bookId" value="${book.bookid}"/>
                                    <input type="hidden" name="qty" value="1"/>
                                    <button type="submit" class="btn btn-outline-secondary btn-sm w-100"
                                            ${book.quantity == null || book.quantity == 0 ? 'disabled' : ''}>
                                        <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang (Pagination) chuẩn 6 sản phẩm / trang -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage - 1}">Trước</a>
                </li>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/home?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage + 1}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>
