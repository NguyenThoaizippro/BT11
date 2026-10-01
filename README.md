# BÀI THI QUÁ TRÌNH LẬP TRÌNH WEB (ĐỀ SỐ 01 - HK1 2026-2027)

- **Sinh viên:** Nguyễn Ngọc Thoại
- **MSSV:** 24110342
- **Lớp học phần:** Lập Trình Web
- **Mã đề thi:** Đề số 01 (Nhà Sách Trực Tuyến - BookStore)
- **Quy tắc đặt tên mã nguồn:** Toàn bộ Class, DAO, Service, Controller, Entity đều có hậu tố `_24110342.java`.

---

## 1. Môi Trường Công Nghệ & Khả Năng Tương Thích
- **Hệ điều hành:** macOS / Windows / Linux
- **Máy chủ Web:** Apache Tomcat 11.0.x (Jakarta Servlet 6.0)
- **Cơ sở dữ liệu:** MySQL Server 8.x (Port `3306`, user `root`, password `""`)
- **Tên Database:** `db_kiemtra_01`
- **Công nghệ ORM:** JPA / Hibernate 7.4.6.Final (`persistence.xml`)
- **Giao diện / Decorator:** SiteMesh 3.2.3 (`ConfigurableSiteMeshFilter`, `decorators/web.jsp`, `decorators/admin.jsp`)
- **Quản trị phụ thuộc:** Apache Maven Wrapper / Maven 3.9+

---

## 2. Cấu Trúc Mã Nguồn Chuẩn Hóa Theo MSSV 24110342

### 2.1. Phân Hệ Thực Thể (JPA Entities)
- `Book_24110342.java`: Ánh xạ bảng `books`, quan hệ `@ManyToMany` với `Author_24110342`, `@OneToMany` với `Rating_24110342`.
- `Author_24110342.java`: Ánh xạ bảng `author`.
- `User_24110342.java`: Ánh xạ bảng `users` (quản lý mật khẩu BCrypt, vai trò `isAdmin`).
- `Rating_24110342.java`: Ánh xạ bảng `rating` (khóa phức hợp `@IdClass(RatingId_24110342.class)`).
- `RatingId_24110342.java`: Khóa chính phức hợp (`bookid`, `id` user).

### 2.2. Phân Hệ Tương Tác CSDL (DAOs)
- `IBookDao_24110342.java` & `BookDaoImpl_24110342.java`
- `IAuthorDao_24110342.java` & `AuthorDaoImpl_24110342.java`
- `IUserDao_24110342.java` & `UserDaoImpl_24110342.java`
- `IRatingDao_24110342.java` & `RatingDaoImpl_24110342.java`

### 2.3. Phân Hệ Nghiệp Vụ (Services)
- `IBookService_24110342.java` & `BookServiceImpl_24110342.java`
- `IAuthorService_24110342.java` & `AuthorServiceImpl_24110342.java`
- `IUserService_24110342.java` & `UserServiceImpl_24110342.java`
- `IRatingService_24110342.java` & `RatingServiceImpl_24110342.java`
- `EmailService_24110342.java` & `EmailServiceImpl_24110342.java` (Brevo SMTP TLS 1.2 + Terminal Console fallback)

### 2.4. Phân Hệ Điều Khiển (Controllers & Filters)
- `HomeController_24110342.java`: Trang chủ phân trang 6 cuốn sách/trang (`/home`, `/`).
- `BookDetailController_24110342.java`: Chi tiết sách & Reviews (`/book-detail`).
- `LoginController_24110342.java` & `LogoutController_24110342.java`: Đăng nhập/Đăng xuất Session (`/login`, `/logout`).
- `RegisterController_24110342.java` & `VerifyOtpController_24110342.java`: Đăng ký & xác thực mã OTP 6 số qua email thật (`/register`, `/verify-otp`).
- `AdminFilter_24110342.java`: Bộ lọc phân quyền bảo vệ `/admin/*`.
- `AdminBookController_24110342.java`: CRUD Sách có upload ảnh bìa (`/admin/books`).
- `AdminAuthorController_24110342.java`: CRUD Tác giả (`/admin/authors`).
- `ImageController_24110342.java`: Phục vụ xem ảnh upload (`/image`).

---

## 3. Hướng Dẫn Cài Đặt & Chạy Thử Dự Án

### Bước 1: Khởi tạo Cơ sở dữ liệu MySQL
1. Khởi động dịch vụ MySQL:
   ```bash
   brew services start mysql@8.4   # hoặc mysql start trên Windows
   ```
2. Import file database:
   ```bash
   mysql -u root -p < db_kiemtra_01.sql
   ```

### Bước 2: Biên dịch dự án bằng Maven
```bash
mvn clean package -DskipTests
```
Kết quả tạo ra file `target/bai_kiem_tra.war` (BUILD SUCCESS).

### Bước 3: Triển khai lên Tomcat 11
Copy file `target/bai_kiem_tra.war` vào thư mục `webapps/` của Apache Tomcat 11:
```bash
cp target/bai_kiem_tra.war /path/to/apache-tomcat-11.0.4/webapps/
```
Khởi động Tomcat và truy cập:
- Trang chủ: `http://localhost:8080/bai_kiem_tra/home`
- Đăng nhập: `http://localhost:8080/bai_kiem_tra/login`
- Đăng ký tài khoản: `http://localhost:8080/bai_kiem_tra/register`
- Quản trị Admin: `http://localhost:8080/bai_kiem_tra/admin/books`

---

## 4. Tài Khoản Kiểm Thử Mẫu
- **Tài khoản Admin:**
  - Email: `admin@example.com`
  - Mật khẩu: `123456`
  - Quyền: Quản trị viên (truy cập toàn bộ `/admin/*`)
- **Tài khoản Khách hàng (User):**
  - Email: `user@example.com`
  - Mật khẩu: `123456`
  - Quyền: Xem sách, xem reviews, gửi đánh giá cho sách.
- **Đăng ký tài khoản mới:**
  - Nhập email của bạn, mã OTP 6 số sẽ được gửi về hộp thư đến hoặc in trực tiếp ra Terminal Console của máy chủ.

---

## 5. Báo Cáo Kết Quả Thi
- File tài liệu Word hoàn chỉnh: `24110342.docx` (định dạng chuẩn học thuật, bảng phân bổ mã nguồn, hướng dẫn chụp ảnh code chi tiết và khung chèn ảnh cho từng câu từ Câu 1 đến Câu 6).

---

## 6. Chức năng Vai Trò User: Giỏ Hàng — Thanh Toán COD — Lịch Sử Đặt Hàng

### 6.1. Đường dẫn mới
| Method | URL | Yêu cầu | Chức năng |
|---|---|---|---|
| GET | `/cart` | – | Xem giỏ hàng |
| POST | `/cart` | – | `action=add\|update\|delete` + `bookId` + `qty` |
| GET | `/checkout` | Đăng nhập | Form thanh toán COD |
| POST | `/checkout` | Đăng nhập | Tạo đơn, trừ tồn kho, xóa giỏ |
| GET | `/checkout?success=<orderId>` | Đăng nhập | Trang xác nhận đặt hàng |
| GET | `/orders` | Đăng nhập | Lịch sử đặt hàng, lọc `?status=<STATUS>` |
| GET | `/order-detail?id=<orderId>` | Đăng nhập | Chi tiết đơn hàng |

### 6.2. Giới hạn số lượng
`1 ≤ số lượng ≤ tồn kho (books.quantity)`; tổng số lượng 1 sách trong giỏ không được vượt tồn kho.

### 6.3. 8 trạng thái đơn hàng
`NEW` (Đơn hàng mới), `CONFIRMED` (Đã xác nhận), `PREPARING` (Chuẩn bị hàng),
`SHIPPING` (Đang vận chuyển), `DELIVERING` (Đang giao hàng), `DELIVERED` (Đã giao),
`CANCELLED` (Đơn hàng hủy), `RETURNED` (Đơn hàng hoàn).

Đổi trạng thái trong DB để quan sát (xem `order_status_samples.sql`):

    mysql -u root db_kiemtra_01 -e "SET @oid=(SELECT MAX(order_id) FROM orders); UPDATE orders SET status='DELIVERED' WHERE order_id=@oid;"

Sau đó mở `http://localhost:8080/bai_kiem_tra/orders?status=DELIVERED`.
