-- Ocean View Resort - Useful Database Queries
-- Collection of common queries for database management

USE oceanview_resort;

-- ============================================
-- USER QUERIES
-- ============================================

-- View all users
SELECT id, username, full_name, role, active, created_at 
FROM users 
ORDER BY created_at DESC;

-- Find user by username
SELECT * FROM users WHERE username = 'admin';

-- Count users by role
SELECT role, COUNT(*) as count 
FROM users 
GROUP BY role;

-- Find active users
SELECT username, full_name, role 
FROM users 
WHERE active = true;

-- ============================================
-- RESERVATION QUERIES
-- ============================================

-- View all reservations
SELECT id, reservation_number, guest_name, room_type, 
       check_in_date, check_out_date, status, total_amount
FROM reservations 
ORDER BY created_at DESC;

-- Find reservation by number
SELECT * FROM reservations 
WHERE reservation_number = 'RES1001';

-- Search reservations by guest name
SELECT reservation_number, guest_name, room_type, status
FROM reservations 
WHERE guest_name LIKE '%John%';

-- View confirmed reservations
SELECT reservation_number, guest_name, room_type, 
       check_in_date, check_out_date, total_amount
FROM reservations 
WHERE status = 'CONFIRMED'
ORDER BY check_in_date;

-- View current checked-in guests
SELECT reservation_number, guest_name, room_type, 
       check_in_date, check_out_date
FROM reservations 
WHERE status = 'CHECKED_IN'
ORDER BY check_out_date;

-- Upcoming check-ins (next 7 days)
SELECT reservation_number, guest_name, room_type, 
       check_in_date, contact_number
FROM reservations 
WHERE check_in_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
  AND status = 'CONFIRMED'
ORDER BY check_in_date;

-- Upcoming check-outs (today)
SELECT reservation_number, guest_name, room_type, 
       check_out_date, total_amount
FROM reservations 
WHERE check_out_date = CURDATE()
  AND status = 'CHECKED_IN'
ORDER BY guest_name;

-- ============================================
-- ANALYTICS QUERIES
-- ============================================

-- Total revenue by room type
SELECT room_type, 
       COUNT(*) as total_bookings,
       SUM(total_amount) as total_revenue
FROM reservations 
WHERE status IN ('CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT')
GROUP BY room_type
ORDER BY total_revenue DESC;

-- Monthly revenue
SELECT DATE_FORMAT(check_in_date, '%Y-%m') as month,
       COUNT(*) as bookings,
       SUM(total_amount) as revenue
FROM reservations 
WHERE status IN ('CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT')
GROUP BY DATE_FORMAT(check_in_date, '%Y-%m')
ORDER BY month DESC;

-- Reservation status summary
SELECT status, COUNT(*) as count
FROM reservations 
GROUP BY status
ORDER BY count DESC;

-- Average stay duration by room type
SELECT room_type,
       AVG(DATEDIFF(check_out_date, check_in_date)) as avg_nights,
       COUNT(*) as total_bookings
FROM reservations 
GROUP BY room_type
ORDER BY avg_nights DESC;

-- Top guests by total spending
SELECT guest_name, 
       COUNT(*) as total_reservations,
       SUM(total_amount) as total_spent
FROM reservations 
WHERE status IN ('CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT')
GROUP BY guest_name
ORDER BY total_spent DESC
LIMIT 10;

-- ============================================
-- AVAILABILITY QUERIES
-- ============================================

-- Check room availability for specific dates
-- Replace dates with your desired check-in and check-out dates
SELECT room_type, COUNT(*) as occupied_rooms
FROM reservations 
WHERE status IN ('CONFIRMED', 'CHECKED_IN')
  AND check_in_date <= '2026-01-20'
  AND check_out_date >= '2026-01-15'
GROUP BY room_type;

-- Find overlapping reservations for a room type
SELECT r1.reservation_number, r1.guest_name, 
       r1.check_in_date, r1.check_out_date,
       r2.reservation_number as overlapping_reservation,
       r2.guest_name as overlapping_guest
FROM reservations r1
JOIN reservations r2 ON r1.room_type = r2.room_type 
  AND r1.id != r2.id
  AND r1.check_in_date < r2.check_out_date
  AND r1.check_out_date > r2.check_in_date
WHERE r1.status IN ('CONFIRMED', 'CHECKED_IN')
  AND r2.status IN ('CONFIRMED', 'CHECKED_IN')
ORDER BY r1.room_type, r1.check_in_date;

-- ============================================
-- MAINTENANCE QUERIES
-- ============================================

-- Delete old cancelled reservations (older than 1 year)
-- DELETE FROM reservations 
-- WHERE status = 'CANCELLED' 
--   AND created_at < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Update reservation status to NO_SHOW for past check-ins
-- UPDATE reservations 
-- SET status = 'NO_SHOW'
-- WHERE status = 'CONFIRMED' 
--   AND check_in_date < CURDATE();

-- Archive old checked-out reservations
-- CREATE TABLE IF NOT EXISTS reservations_archive LIKE reservations;
-- INSERT INTO reservations_archive 
-- SELECT * FROM reservations 
-- WHERE status = 'CHECKED_OUT' 
--   AND check_out_date < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- ============================================
-- DATABASE STATISTICS
-- ============================================

-- Table sizes
SELECT 
    table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'oceanview_resort'
ORDER BY (data_length + index_length) DESC;

-- Row counts
SELECT 
    'users' as table_name, COUNT(*) as row_count FROM users
UNION ALL
SELECT 
    'reservations' as table_name, COUNT(*) as row_count FROM reservations;

-- Database size
SELECT 
    SUM(ROUND(((data_length + index_length) / 1024 / 1024), 2)) AS 'Total Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'oceanview_resort';
