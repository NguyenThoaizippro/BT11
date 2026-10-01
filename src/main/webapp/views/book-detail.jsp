<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sách - <c:out value="${book.title}"/></title>
</head>
<body>
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại trang chủ
        </a>
    </div>

    <c:if test="${param.success == 'reviewed'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-1"></i> Cảm ơn bạn! Đánh giá của bạn đã được ghi nhận thành công.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Khung chi tiết sách theo đúng mẫu Đề bài (Câu 4) -->
    <div class="card shadow-sm border mb-4">
        <div class="card-body">
            <div class="row">
                <!-- [cover_image] -->
                <div class="col-md-4 text-center mb-3 mb-md-0">
                    <c:choose>
                        <c:when test="${not empty book.coverImage && fn:startsWith(book.coverImage, 'http')}">
                            <img src="${book.coverImage}" class="img-fluid rounded border shadow-sm" style="max-height: 380px; width: 100%; object-fit: cover;" alt="${book.title}">
                        </c:when>
                        <c:when test="${not empty book.coverImage}">
                            <img src="${pageContext.request.contextPath}/image?fname=${book.coverImage}" class="img-fluid rounded border shadow-sm" style="max-height: 380px; width: 100%; object-fit: cover;" alt="${book.title}">
                        </c:when>
                        <c:otherwise>
                            <div class="bg-light rounded border d-flex align-items-center justify-content-center text-muted" style="height: 350px;">
                                <i class="bi bi-image fs-1"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Thông tin cuốn sách -->
                <div class="col-md-8">
                    <h3 class="fw-bold text-dark mb-3"><c:out value="${book.title}"/></h3>
                    <table class="table table-borderless table-sm mb-3">
                        <tbody>
                            <tr>
                                <th style="width: 140px;">Mã isbn:</th>
                                <td><c:out value="${book.isbn != null ? book.isbn : 'Đang cập nhật'}"/></td>
                            </tr>
                            <tr>
                                <th>Tác giả:</th>
                                <td class="text-primary fw-semibold"><c:out value="${book.authorNames}"/></td>
                            </tr>
                            <tr>
                                <th>Publisher:</th>
                                <td><c:out value="${book.publisher != null ? book.publisher : 'Đang cập nhật'}"/></td>
                            </tr>
                            <tr>
                                <th>Publisher_date:</th>
                                <td><c:out value="${book.publishDate != null ? book.publishDate : 'Đang cập nhật'}"/></td>
                            </tr>
                            <tr>
                                <th>Quantity:</th>
                                <td><span class="badge bg-secondary fs-6"><c:out value="${book.quantity != null ? book.quantity : 0}"/></span></td>
                            </tr>
                            <tr>
                                <th>Reviews (${reviewCount}):</th>
                                <td>
                                    <span class="text-warning">
                                        <i class="bi bi-star-fill"></i>
                                    </span>
                                    <strong>${reviewCount}</strong> lượt nhận xét từ bạn đọc
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <c:if test="${not empty book.description}">
                        <div class="p-3 bg-light rounded border">
                            <h6 class="fw-bold mb-1">Mô tả nội dung:</h6>
                            <p class="text-secondary small mb-0"><c:out value="${book.description}"/></p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Mục Reviews theo đúng mẫu: [users]: [review_text] -->
    <div class="card shadow-sm border mb-4">
        <div class="card-header bg-white fw-bold">
            <i class="bi bi-chat-left-text me-1"></i> Reviews (${reviewCount})
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty ratings}">
                    <div class="list-group list-group-flush">
                        <c:forEach var="r" items="${ratings}">
                            <div class="list-group-item px-0 py-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="fw-bold text-dark">
                                        <i class="bi bi-person-circle me-1"></i>
                                        <c:out value="${r.user != null && r.user.fullname != null ? r.user.fullname : (r.user != null ? r.user.email : 'Ẩn danh')}"/>
                                    </span>
                                    <span class="text-warning small">
                                        <c:forEach begin="1" end="${r.rating != null ? r.rating : 5}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:forEach>
                                    </span>
                                </div>
                                <p class="text-secondary mb-0 ps-3 border-start border-3 border-primary">
                                    <c:out value="${r.reviewText}"/>
                                </p>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-muted mb-0 fst-italic">Chưa có đánh giá nào cho cuốn sách này. Hãy là người đầu tiên gửi nhận xét!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Form thêm reviews theo đúng mẫu Đề bài -->
    <div class="card shadow-sm border">
        <div class="card-header bg-white fw-bold">
            <i class="bi bi-pencil-square me-1"></i> Form thêm reviews
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${sessionScope.account != null}">
                    <form action="${pageContext.request.contextPath}/book-detail" method="post">
                        <input type="hidden" name="bookId" value="${book.bookid}"/>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Đánh giá sao:</label>
                            <select name="rating" class="form-select form-select-sm" style="max-width: 200px;">
                                <option value="5">⭐⭐⭐⭐⭐ (5 sao - Tuyệt vời)</option>
                                <option value="4">⭐⭐⭐⭐ (4 sao - Rất tốt)</option>
                                <option value="3">⭐⭐⭐ (3 sao - Bình thường)</option>
                                <option value="2">⭐⭐ (2 sao - Tạm được)</option>
                                <option value="1">⭐ (1 sao - Kém)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="reviewText" class="form-label fw-semibold">Nội dung nhận xét:</label>
                            <textarea class="form-control" id="reviewText" name="reviewText" rows="3" placeholder="Nhập cảm nhận của bạn về cuốn sách này..." required></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-send me-1"></i> Submit
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-secondary mb-0">
                        <i class="bi bi-info-circle me-1"></i> Bạn cần <a href="${pageContext.request.contextPath}/login?redirect=${pageContext.request.contextPath}/book-detail?id=${book.bookid}" class="alert-link fw-semibold">đăng nhập</a> để gửi nhận xét cho cuốn sách này.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
