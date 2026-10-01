<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${action == 'edit' ? 'Chỉnh Sửa Tác Giả' : 'Thêm Tác Giả Mới'} - Admin</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h3 class="h4 fw-bold text-dark mb-0">${action == 'edit' ? 'CHỈNH SỬA THÔNG TIN TÁC GIẢ' : 'THÊM TÁC GIẢ MỚI'}</h3>
        <a href="${pageContext.request.contextPath}/admin/authors" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
        </a>
    </div>

    <div class="card shadow-sm border" style="max-width: 600px;">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/admin/authors/${action == 'edit' ? 'edit' : 'add'}" method="post">
                <c:if test="${action == 'edit'}">
                    <input type="hidden" name="authorId" value="${author.authorId}"/>
                </c:if>

                <div class="mb-3">
                    <label for="authorName" class="form-label fw-semibold">Tên tác giả (*):</label>
                    <input type="text" class="form-control" id="authorName" name="authorName" value="${author.authorName}" placeholder="Nhập họ và tên tác giả" required autofocus>
                </div>

                <div class="mb-4">
                    <label for="dateOfBirth" class="form-label fw-semibold">Ngày tháng năm sinh:</label>
                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${author.dateOfBirth}">
                </div>

                <div class="pt-3 border-top">
                    <button type="submit" class="btn btn-primary px-4 me-2">
                        <i class="bi bi-check2-circle me-1"></i> ${action == 'edit' ? 'Lưu Cập Nhật' : 'Thêm Tác Giả'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/authors" class="btn btn-secondary px-4">
                        Hủy bỏ
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
