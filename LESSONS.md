# LESSONS.md — Bài Kiểm Tra Quá Trình (Đề số 01)

1. **Lombok 1.18.32 vs Java 26**: Lombok 1.18.32 bị lỗi `TypeTag :: UNKNOWN` trên JDK 26 -> Nâng cấp lên `lombok:1.18.46` giải quyết triệt để.
2. **Hibernate 7.4.6 Byte Buddy Runtime**: Hibernate 7 trên JDK 26 cần thư viện bytecode enhancement tương thích -> Thêm trực tiếp `net.bytebuddy:byte-buddy:1.18.11` vào `pom.xml`.
3. **Hibernate MultipleBagFetchException**: Xảy ra khi dùng JOIN FETCH đồng thời 2 collection quan hệ `List` (`authors` và `ratings`) trong 1 câu JPQL -> Tách truy vấn 2 bước nạp vào 1st-level cache.
4. **SiteMesh 3 trên Tomcat 11**: `SiteMeshFilter` mặc định của SiteMesh 3.2.3 có thể gây trắng trang do can thiệp response wrapper -> Sử dụng `ConfigurableSiteMeshFilter` custom kế thừa `GenericFilterBean` và map `/*`.
5. **Brevo SMTP TLS 1.2**: Brevo SMTP Relay `smtp-relay.brevo.com:587` yêu cầu TLSv1.2 và port 587 -> Cấu hình `mail.smtp.starttls.enable=true`, `mail.smtp.ssl.protocols=TLSv1.2` và `mail.smtp.auth=true`.
6. **Fallback OTP Console**: Để quá trình thi cử hoặc chấm bài offline không bị gián đoạn do sự cố mạng, luôn in mã OTP 6 số ra Terminal song song với việc gửi SMTP thật.
7. **Thứ tự sắp xếp ID (ORDER BY ASC)**: Toàn bộ danh sách sách, tác giả và người dùng được sắp xếp theo `id ASC` để hiển thị theo chiều thuận tự nhiên (1, 2, 3...) thay vì `DESC` gây đảo ngược thứ tự trên giao diện quản trị.
8. **Reflected XSS qua `${param.*}` trong attribute HTML**: Không render query param thô vào attribute (vd `value="${param.redirect}"`) — luôn bọc `<c:out value="..."/>` để escape; `c:out` đã khai báo taglib sẵn trong JSP.
9. **JSP EL không gọi được static method**: `${OrderStatus.label(...)}` không hoạt động -> đặt getter delegate trên entity (`getStatusLabel()`, `getStatusColor()`) để EL gọi như property.
10. **Entity LAZY collection trả về cho JSP**: truy cập `order.details` sau khi `em.close()` gây LazyInitializationException -> DAO phải `LEFT JOIN FETCH o.details` khi trả dữ liệu cho view.
11. **Session Cart không được giữ entity JPA**: lưu `Book_24110342` vào session dễ dính LazyInitialization/serialization -> chỉ copy scalar (bookId, title, price, qty, stock) sang `CartItem_24110342`.
