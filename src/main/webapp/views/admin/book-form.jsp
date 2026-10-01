<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${action == 'edit' ? 'Chỉnh Sửa Sách' : 'Thêm Sách Mới'} - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h3 class="h4 fw-bold text-dark mb-0">${action == 'edit' ? 'CHỈNH SỬA CUỐN SÁCH' : 'THÊM CUỐN SÁCH MỚI'}</h3>
        <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
        </a>
    </div>

    <div class="card shadow-sm border">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/admin/books/${action == 'edit' ? 'edit' : 'add'}" method="post" enctype="multipart/form-data">
                <c:if test="${action == 'edit'}">
                    <input type="hidden" name="bookid" value="${book.bookid}"/>
                </c:if>

                <div class="row g-3">
                    <div class="col-md-8">
                        <label for="title" class="form-label fw-semibold">Tiêu đề sách (*):</label>
                        <input type="text" class="form-control" id="title" name="title" value="${book.title}" placeholder="Nhập tiêu đề cuốn sách" required>
                    </div>

                    <div class="col-md-4">
                        <label for="isbn" class="form-label fw-semibold">Mã ISBN:</label>
                        <input type="number" class="form-control" id="isbn" name="isbn" value="${book.isbn}" placeholder="Ví dụ: 978013235">
                    </div>

                    <div class="col-md-4">
                        <label for="publisher" class="form-label fw-semibold">Nhà xuất bản:</label>
                        <input type="text" class="form-control" id="publisher" name="publisher" value="${book.publisher}" placeholder="Ví dụ: Addison-Wesley">
                    </div>

                    <div class="col-md-4">
                        <label for="price" class="form-label fw-semibold">Giá bán ($):</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" value="${book.price}" placeholder="Ví dụ: 45.00">
                    </div>

                    <div class="col-md-4">
                        <label for="quantity" class="form-label fw-semibold">Số lượng trong kho:</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" value="${book.quantity != null ? book.quantity : 10}" placeholder="Ví dụ: 20">
                    </div>

                    <div class="col-md-4">
                        <label for="publishDate" class="form-label fw-semibold">Ngày xuất bản:</label>
                        <input type="date" class="form-control" id="publishDate" name="publishDate" value="${book.publishDate}">
                    </div>

                    <div class="col-md-8">
                        <label for="authorIds" class="form-label fw-semibold">Chọn tác giả (Giữ Ctrl / Cmd để chọn nhiều tác giả):</label>
                        <select multiple class="form-select" id="authorIds" name="authorIds" size="4">
                            <c:forEach var="a" items="${authors}">
                                <c:set var="selected" value="false"/>
                                <c:if test="${not empty book.authors}">
                                    <c:forEach var="ba" items="${book.authors}">
                                        <c:if test="${ba.authorId == a.authorId}">
                                            <c:set var="selected" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <option value="${a.authorId}" ${selected ? 'selected' : ''}>
                                    <c:out value="${a.authorName}"/>
                                </option>
                            </c:forEach>
                        </select>
                        <div class="form-text">Bạn có thể chọn 1 hoặc nhiều tác giả đồng thời cho cuốn sách này.</div>
                    </div>

                    <div class="col-md-6">
                        <label for="coverImageFile" class="form-label fw-semibold">Tải lên file ảnh bìa (Cover Image):</label>
                        <input type="file" class="form-control" id="coverImageFile" name="coverImageFile" accept="image/*">
                    </div>

                    <div class="col-md-6">
                        <label for="coverImageUrl" class="form-label fw-semibold">Hoặc nhập link URL ảnh online:</label>
                        <input type="text" class="form-control" id="coverImageUrl" name="coverImageUrl" value="${book.coverImage}" placeholder="https://images.unsplash.com/...">
                    </div>

                    <div class="col-12">
                        <label for="description" class="form-label fw-semibold">Mô tả nội dung cuốn sách:</label>
                        <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập tóm tắt hoặc nội dung cuốn sách...">${book.description}</textarea>
                    </div>

                    <div class="col-12 mt-4 pt-3 border-top">
                        <button type="submit" class="btn btn-primary px-4 me-2">
                            <i class="bi bi-check2-circle me-1"></i> ${action == 'edit' ? 'Lưu Cập Nhật' : 'Thêm Sách'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary px-4">
                            Hủy bỏ
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
