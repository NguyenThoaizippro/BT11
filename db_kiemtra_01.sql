-- ==========================================================
-- CSDL ĐỀ THI QUÁ TRÌNH LẬP TRÌNH WEB (ĐỀ SỐ 01 - HK1 2026-2027)
-- Sinh viên: Nguyễn Ngọc Thoại | MSSV: 24110342 | Mã đề: Đề số 01
-- ==========================================================

CREATE DATABASE IF NOT EXISTS `db_kiemtra_01` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_kiemtra_01`;

-- 1. Bảng books
DROP TABLE IF EXISTS `order_details`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `rating`;
DROP TABLE IF EXISTS `book_author`;
DROP TABLE IF EXISTS `books`;
DROP TABLE IF EXISTS `author`;
DROP TABLE IF EXISTS `users`;

CREATE TABLE `books` (
  `bookid` INT NOT NULL AUTO_INCREMENT,
  `isbn` INT NULL,
  `title` VARCHAR(200) NULL,
  `publisher` VARCHAR(100) NULL,
  `price` DECIMAL(6, 2) NULL,
  `description` TEXT NULL,
  `publish_date` DATE NULL,
  `cover_image` VARCHAR(255) NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`bookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Bảng users
CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `fullname` VARCHAR(50) NULL,
  `phone` INT NULL,
  `passwd` VARCHAR(255) NOT NULL,
  `signup_date` DATETIME NULL,
  `last_login` DATETIME NULL,
  `is_admin` BIT DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2b. Bảng orders (đơn hàng COD)
CREATE TABLE `orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `receiver_name` VARCHAR(50) NULL,
  `receiver_phone` VARCHAR(15) NULL,
  `receiver_address` VARCHAR(255) NULL,
  `note` VARCHAR(255) NULL,
  `payment_method` VARCHAR(20) NULL,
  `total_amount` DECIMAL(12, 2) NULL,
  `status` VARCHAR(20) NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2c. Bảng order_details (chi tiết đơn hàng)
CREATE TABLE `order_details` (
  `detail_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `book_title` VARCHAR(200) NULL,
  `quantity` INT NULL,
  `unit_price` DECIMAL(6, 2) NULL,
  PRIMARY KEY (`detail_id`),
  CONSTRAINT `fk_od_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng author
CREATE TABLE `author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(100) NULL,
  `date_of_birth` DATE NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Bảng book_author (Quan hệ N-N giữa Books và Author)
CREATE TABLE `book_author` (
  `bookid` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`bookid`, `author_id`),
  CONSTRAINT `fk_ba_book` FOREIGN KEY (`bookid`) REFERENCES `books` (`bookid`) ON DELETE CASCADE,
  CONSTRAINT `fk_ba_author` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Bảng rating (Quan hệ N-N giữa Users và Books)
CREATE TABLE `rating` (
  `userid` INT NOT NULL,
  `bookid` INT NOT NULL,
  `rating` TINYINT NULL,
  `review_text` TEXT NULL,
  PRIMARY KEY (`userid`, `bookid`),
  CONSTRAINT `fk_rating_user` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rating_book` FOREIGN KEY (`bookid`) REFERENCES `books` (`bookid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==========================================================
-- DỮ LIỆU MẪU (SEED DATA)
-- ==========================================================

-- Thêm Users mẫu (Mật khẩu: 123456 mã hóa BCrypt)
-- Hash BCrypt của '123456': $2a$10$wY9qL9Bwz0WjSg7fV3tPcuXjV1lE5cM7P8nZzJqY9uK2lF6oH4x6K hoặc plain fallback
INSERT INTO `users` (`id`, `email`, `fullname`, `phone`, `passwd`, `signup_date`, `last_login`, `is_admin`) VALUES
(1, 'admin@example.com', 'Quản Trị Viên', 901234567, '$2a$10$suTjchRCPhZUdach.LeCsuDvf/aB/4UqTUh9MiqWX9Ds40jJjOyWC', NOW(), NOW(), 1),
(2, 'user@example.com', 'Nguyễn Ngọc Thoại', 987654321, '$2a$10$suTjchRCPhZUdach.LeCsuDvf/aB/4UqTUh9MiqWX9Ds40jJjOyWC', NOW(), NOW(), 0),
(3, 'tranvanb@example.com', 'Trần Văn B', 912345678, '$2a$10$suTjchRCPhZUdach.LeCsuDvf/aB/4UqTUh9MiqWX9Ds40jJjOyWC', NOW(), NOW(), 0),
(4, 'lethic@example.com', 'Lê Thị C', 934567890, '$2a$10$suTjchRCPhZUdach.LeCsuDvf/aB/4UqTUh9MiqWX9Ds40jJjOyWC', NOW(), NOW(), 0);

-- Thêm 8 Tác giả mẫu (Authors)
INSERT INTO `author` (`author_id`, `author_name`, `date_of_birth`) VALUES
(1, 'Robert C. Martin', '1952-12-05'),
(2, 'Martin Fowler', '1963-12-18'),
(3, 'Joshua Bloch', '1961-08-28'),
(4, 'Brian Goetz', '1965-04-10'),
(5, 'Kathy Sierra', '1957-02-15'),
(6, 'Cay S. Horstmann', '1959-06-16'),
(7, 'Thomas H. Cormen', '1956-03-30'),
(8, 'Andrew S. Tanenbaum', '1944-03-16');

-- Thêm ĐÚNG 20 Cuốn Sách Mẫu (Books)
INSERT INTO `books` (`bookid`, `isbn`, `title`, `publisher`, `price`, `description`, `publish_date`, `cover_image`, `quantity`) VALUES
(1, 978013235, 'Clean Code: A Handbook of Agile Software Craftsmanship', 'Prentice Hall', 42.50, 'Thực hành viết mã sạch, dễ bảo trì và mở rộng cho lập trình viên chuyên nghiệp.', '2008-08-01', 'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?w=500&auto=format&fit=crop', 25),
(2, 978020161, 'The Pragmatic Programmer: Your Journey to Mastery', 'Addison-Wesley', 49.99, 'Hành trình từ một lập trình viên bình thường trở thành bậc thầy phát triển phần mềm.', '1999-10-30', 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500&auto=format&fit=crop', 18),
(3, 978013468, 'Effective Java (3rd Edition)', 'Addison-Wesley', 45.00, 'Tuyển tập 90 nguyên tắc vàng để viết Java hiện đại, hiệu quả và tối ưu nhất.', '2018-01-06', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500&auto=format&fit=crop', 30),
(4, 978020163, 'Design Patterns: Elements of Reusable Object-Oriented Software', 'Addison-Wesley', 54.00, 'Kinh thánh về 23 mẫu thiết kế hướng đối tượng kinh điển của nhóm Gang of Four.', '1994-10-21', 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500&auto=format&fit=crop', 12),
(5, 978013475, 'Refactoring: Improving the Design of Existing Code', 'Addison-Wesley', 52.00, 'Phương pháp cải tiến và tái cấu trúc mã nguồn cũ mà không làm thay đổi hành vi.', '2018-11-20', 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=500&auto=format&fit=crop', 20),
(6, 978032134, 'Java Concurrency in Practice', 'Addison-Wesley', 48.50, 'Cẩm nang toàn diện về lập trình đa luồng và đồng thời an toàn trong Java.', '2006-05-19', 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?w=500&auto=format&fit=crop', 15),
(7, 978059600, 'Head First Java: A Brain-Friendly Guide', 'O Reilly Media', 38.00, 'Học Java trực quan, sinh động và dễ hiểu nhất dành cho người mới bắt đầu.', '2005-02-09', 'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=500&auto=format&fit=crop', 40),
(8, 978013516, 'Core Java Volume I: Fundamentals (12th Edition)', 'Prentice Hall', 55.00, 'Kiến thức nền tảng vững chắc và chuyên sâu về ngôn ngữ và thư viện lõi Java.', '2021-09-15', 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=500&auto=format&fit=crop', 22),
(9, 978026203, 'Introduction to Algorithms (CLRS)', 'MIT Press', 85.00, 'Giáo trình giải thuật toàn diện và chuẩn mực nhất của viện công nghệ MIT.', '2009-07-31', 'https://images.unsplash.com/photo-1463320726281-696a485928c7?w=500&auto=format&fit=crop', 10),
(10, 978013359, 'Modern Operating Systems (4th Edition)', 'Pearson', 78.00, 'Nguyên lý thiết kế và vận hành các hệ điều hành máy tính hiện đại.', '2014-03-21', 'https://images.unsplash.com/photo-1507842229451-79b1be8d6293?w=500&auto=format&fit=crop', 16),
(11, 978013212, 'Computer Networks (5th Edition)', 'Prentice Hall', 72.00, 'Cấu trúc tầng, giao thức mạng máy tính và Internet toàn cầu.', '2010-09-27', 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=500&auto=format&fit=crop', 14),
(12, 978013449, 'Clean Architecture: A Craftsman Guide to Software Structure', 'Prentice Hall', 44.00, 'Kiến trúc phần mềm phân tầng độc lập UI, Framework và CSDL.', '2017-09-17', 'https://images.unsplash.com/photo-1519682337058-a94d519337bc?w=500&auto=format&fit=crop', 28),
(13, 978161729, 'Spring in Action (6th Edition)', 'Manning', 49.50, 'Xây dựng ứng dụng doanh nghiệp với Spring Boot 3 và hệ sinh thái Spring.', '2021-11-16', 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=500&auto=format&fit=crop', 35),
(14, 978149205, 'Learning SQL: Generate, Manipulate, and Retrieve Data', 'O Reilly Media', 36.00, 'Học SQL từ cơ bản đến nâng cao cho MySQL, PostgreSQL và SQL Server.', '2020-04-14', 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500&auto=format&fit=crop', 24),
(15, 978007802, 'Database System Concepts (7th Edition)', 'McGraw-Hill', 89.00, 'Giáo trình cốt lõi về hệ quản trị cơ sở dữ liệu quan hệ và NoSQL.', '2019-03-12', 'https://images.unsplash.com/photo-1513001900722-370f803f498d?w=500&auto=format&fit=crop', 9),
(16, 978144937, 'Designing Data-Intensive Applications', 'O Reilly Media', 59.99, 'Thiết kế các hệ thống dữ liệu phân tán quy mô lớn, tin cậy và có khả năng mở rộng.', '2017-03-16', 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=500&auto=format&fit=crop', 19),
(17, 978149190, 'You Don\'t Know JS Yet: Get Started', 'Independently Published', 25.00, 'Hiểu sâu bản chất JavaScript từ scope, closure cho đến prototype.', '2020-01-28', 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=500&auto=format&fit=crop', 33),
(18, 978026251, 'Structure and Interpretation of Computer Programs (SICP)', 'MIT Press', 65.00, 'Nguyên lý tư duy lập trình và xây dựng các hệ thống tính toán trừu tượng.', '1996-07-25', 'https://images.unsplash.com/photo-1531988042231-d39a9cc12a9a?w=500&auto=format&fit=crop', 11),
(19, 978020183, 'The Mythical Man-Month: Essays on Software Engineering', 'Addison-Wesley', 34.00, 'Những bài học kinh nghiệm bất hủ trong quản lý dự án công nghệ thông tin.', '1995-08-02', 'https://images.unsplash.com/photo-1526243741027-444d633d7365?w=500&auto=format&fit=crop', 17),
(20, 978032112, 'Domain-Driven Design: Tackling Complexity in Software', 'Addison-Wesley', 58.00, 'Phương pháp thiết kế hướng miền giải quyết độ phức tạp cốt lõi của phần mềm.', '2003-08-30', 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500&auto=format&fit=crop', 15);

-- Liên kết sách và tác giả (book_author)
INSERT INTO `book_author` (`bookid`, `author_id`) VALUES
(1, 1),  -- Clean Code -> Robert C. Martin
(2, 2),  -- Pragmatic Programmer -> Martin Fowler
(3, 3),  -- Effective Java -> Joshua Bloch
(4, 2),  -- Design Patterns -> Martin Fowler
(5, 2),  -- Refactoring -> Martin Fowler
(6, 4),  -- Java Concurrency -> Brian Goetz
(6, 3),  -- Java Concurrency -> Joshua Bloch
(7, 5),  -- Head First Java -> Kathy Sierra
(8, 6),  -- Core Java -> Cay S. Horstmann
(9, 7),  -- CLRS -> Thomas H. Cormen
(10, 8), -- Operating Systems -> Andrew S. Tanenbaum
(11, 8), -- Computer Networks -> Andrew S. Tanenbaum
(12, 1), -- Clean Architecture -> Robert C. Martin
(13, 4), -- Spring in Action -> Brian Goetz
(14, 2), -- Learning SQL -> Martin Fowler
(15, 7), -- Database System Concepts -> Thomas H. Cormen
(16, 2), -- Designing Data-Intensive Applications -> Martin Fowler
(17, 5), -- You Don't Know JS -> Kathy Sierra
(18, 7), -- SICP -> Thomas H. Cormen
(19, 1), -- Mythical Man-Month -> Robert C. Martin
(20, 2); -- Domain-Driven Design -> Martin Fowler

-- Thêm các đánh giá mẫu (rating)
INSERT INTO `rating` (`userid`, `bookid`, `rating`, `review_text`) VALUES
(2, 1, 5, 'Sách kinh điển mà bất kỳ lập trình viên nào cũng nên đọc ít nhất một lần!'),
(3, 1, 5, 'Các ví dụ refactoring cực kỳ trực quan và giá trị.'),
(4, 1, 4, 'Rất hữu ích cho công việc thực tế, giao hàng nhanh.'),
(2, 2, 5, 'Những lời khuyên thực tế và tư duy lập trình chuyên nghiệp rất bổ ích.'),
(3, 2, 5, 'Đọc đi đọc lại vẫn học được những điều mới mẻ.'),
(2, 3, 5, 'Kinh thánh của dân lập trình Java. Các item giải thích cực kỳ sâu sắc.'),
(4, 3, 5, 'Must read cho Java Developer, sách viết rất chặt chẽ.'),
(3, 4, 4, 'Các mẫu thiết kế giải quyết được nhiều bài toán phức tạp trong dự án.'),
(2, 5, 5, 'Cuốn sách bắt buộc phải đọc nếu muốn dọn dẹp mã nguồn cũ.'),
(4, 6, 5, 'Giải thích bản chất luồng và đồng bộ hóa trong Java chuẩn xác tuyệt đối.');
