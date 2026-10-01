-- ==========================================================
-- ĐỔI TRẠNG THÁI ĐƠN HÀNG ĐỂ QUAN SÁT GIAO DIỆN /orders
-- Cách dùng: chạy TỪNG nhóm lệnh (SET @oid + UPDATE + SELECT)
-- trong mysql client, làm mới trình duyệt sau mỗi lần UPDATE:
--   mysql -u root db_kiemtra_01
--   Hoặc 1 dòng: mysql -u root db_kiemtra_01 -e "<SET...; UPDATE...; SELECT...>"
-- ==========================================================

-- Lấy mã đơn MỚI NHẤT vào biến @oid (mỗi phiên mysql)
SET @oid = (SELECT MAX(order_id) FROM `orders`);
SELECT @oid AS order_id;

-- 1. Đơn hàng mới (trạng thái mặc định khi đặt hàng)
UPDATE `orders` SET `status` = 'NEW' WHERE `order_id` = @oid;

-- 2. Đã xác nhận
UPDATE `orders` SET `status` = 'CONFIRMED' WHERE `order_id` = @oid;

-- 3. Chuẩn bị hàng
UPDATE `orders` SET `status` = 'PREPARING' WHERE `order_id` = @oid;

-- 4. Vận chuyển
UPDATE `orders` SET `status` = 'SHIPPING' WHERE `order_id` = @oid;

-- 5. Giao hàng
UPDATE `orders` SET `status` = 'DELIVERING' WHERE `order_id` = @oid;

-- 6. Đã giao
UPDATE `orders` SET `status` = 'DELIVERED' WHERE `order_id` = @oid;

-- 7. Đơn hàng hủy
UPDATE `orders` SET `status` = 'CANCELLED' WHERE `order_id` = @oid;

-- 8. Đơn hàng hoàn
UPDATE `orders` SET `status` = 'RETURNED' WHERE `order_id` = @oid;

-- Kiểm tra kết quả cuối cùng
SELECT `order_id`, `status`, `total_amount`, `created_at`
FROM `orders` ORDER BY `order_id` DESC;
