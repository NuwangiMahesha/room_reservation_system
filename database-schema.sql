-- Ocean View Resort Database Schema
-- MySQL Database Setup Script

-- Create Database
CREATE DATABASE IF NOT EXISTS oceanview_resort;
USE oceanview_resort;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reservations Table
CREATE TABLE IF NOT EXISTS reservations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    reservation_number VARCHAR(255) UNIQUE NOT NULL,
    guest_name VARCHAR(255) NOT NULL,
    address VARCHAR(500) NOT NULL,
    contact_number VARCHAR(10) NOT NULL,
    email VARCHAR(255),
    room_type VARCHAR(50) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'CONFIRMED',
    number_of_guests INT,
    special_requests TEXT,
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_reservation_number (reservation_number),
    INDEX idx_guest_name (guest_name),
    INDEX idx_status (status),
    INDEX idx_room_type (room_type),
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_check_out_date (check_out_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Verify Tables Created
SHOW TABLES;

-- Display Table Structures
DESCRIBE users;
DESCRIBE reservations;
