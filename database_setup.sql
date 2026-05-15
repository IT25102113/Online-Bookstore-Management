-- ============================================================
-- BookLeaf - Online Bookstore Management System
-- Database: bookleaf_db
-- Run this script in MySQL Workbench or phpMyAdmin
-- ============================================================

CREATE DATABASE IF NOT EXISTS BOOKLEAFPROJECT_db;
USE BOOKLEAFPROJECT_db;

-- Note: Tables are auto-created by JPA/Hibernate (ddl-auto=update)
-- This script adds sample data for testing purposes.

-- ============================================================
-- IMPORTANT: If upgrading from previous version, run these first:
-- ALTER TABLE users ADD COLUMN approved BOOLEAN NOT NULL DEFAULT TRUE;
-- ALTER TABLE users MODIFY COLUMN role ENUM('ADMIN', 'CUSTOMER', 'AUTHOR');
-- ALTER TABLE orders MODIFY COLUMN order_status ENUM('PENDING', 'CONFIRMED', 'PROCESSING', 'READY_FOR_SHIPPING', 'SHIPPED', 'OUT_FOR_DELIVERY', 'DELIVERED', 'EMAIL_SENT', 'CANCELLED');
-- ============================================================

-- ============================================================
-- SAMPLE AUTHORS
-- ============================================================
INSERT INTO authors (name, bio) VALUES
('Martin Wickramasinghe', 'One of the most prominent Sri Lankan novelists and authors. Known for the Koggala trilogy.'),
('W. A. Silva', 'A popular Sri Lankan author known for his romantic and historical novels.'),
('Ediriweera Sarachchandra', 'Sri Lankan playwright, novelist, and poet. Known for Maname and Sinhabahu.'),
('Mahagama Sekara', 'Sri Lankan poet, lyricist, novelist, and artist.'),
('Sybil Wettasinghe', 'Sri Lankan children''s book author and illustrator.'),
('Kumaratunga Munidasa', 'Sri Lankan linguist, writer, and poet.');

-- ============================================================
-- SAMPLE BOOKS
-- ============================================================
INSERT INTO books (title, isbn, category, description, price, quantity, has_ebook, author_id, image_url) VALUES
('Madol Doova', '978-9550000001', 'Novel', 'A famous children''s novel in Sri Lanka about the adventures of Upali and Jinna.', 1200.00, 50, true, 1, 'https://placehold.co/400x600/546b41/FFF?text=Madol\nDoova'),
('Gamperaliya', '978-9550000002', 'Classic', 'The first novel of the Koggala trilogy, depicting the transformation of the Sri Lankan village.', 1500.00, 40, true, 1, 'https://placehold.co/400x600/99ad7a/FFF?text=Gamperaliya'),
('Kalu Kurulla', '978-9550000003', 'Fiction', 'A classic novel by W. A. Silva that captures romance and social dynamics.', 1100.00, 75, true, 2, 'https://placehold.co/400x600/dcccac/3A4D2E?text=Kalu\nKurulla'),
('Maname', '978-9550000004', 'Drama', 'A script of the famous Sri Lankan stage drama based on the Chulla Dhanuddhara Jataka.', 800.00, 60, true, 3, 'https://placehold.co/400x600/3A4D2E/FFF?text=Maname'),
('Thunman Handiya', '978-9550000005', 'Novel', 'A beautifully written autobiographical novel by Mahagama Sekara.', 950.00, 35, false, 4, 'https://placehold.co/400x600/546b41/FFF?text=Thunman\nHandiya'),
('Kuda Hora', '978-9550000006', 'Children', 'An award-winning children''s book known worldwide for its unique illustrations.', 650.00, 45, true, 5, 'https://placehold.co/400x600/99ad7a/FFF?text=Kuda\nHora'),
('Hath Pana', '978-9550000007', 'Children', 'A classic children''s story by Kumaratunga Munidasa.', 500.00, 55, true, 6, 'https://placehold.co/400x600/dcccac/3A4D2E?text=Hath\nPana'),
('Yuganthaya', '978-9550000008', 'Classic', 'The final novel of the Koggala trilogy by Martin Wickramasinghe.', 1400.00, 30, true, 1, 'https://placehold.co/400x600/3A4D2E/FFF?text=Yuganthaya');

-- ============================================================
-- SAMPLE CUSTOMER (password: "password123" hashed with BCrypt)
-- ============================================================
INSERT INTO users (full_name, email, password, phone, role, approved) VALUES
('Kasun Perera', 'kasun@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '+94 771234567', 'CUSTOMER', true);

-- ============================================================
-- SAMPLE DISCOUNTS
-- ============================================================
INSERT INTO discounts (name, description, discount_type, percentage, start_date, end_date, price_cap, active) VALUES
('Avurudu Sale 2026', 'Special Sinhala and Tamil New Year discount on all books!', 'SEASONAL', 15.0, '2026-04-01', '2026-04-30', NULL, true),
('Welcome Bonus', 'Special discount for new members - 10% off your first month!', 'NEW_USER_BONUS', 10.0, NULL, NULL, NULL, true),
('Big Spender Reward', 'Get 20% off when your cart exceeds Rs. 5000!', 'PRICE_CAP', 20.0, NULL, NULL, 5000.00, true);
