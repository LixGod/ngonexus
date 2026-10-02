use pbl;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    mobile VARCHAR(10) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR(255) NOT NULL,
    representative_id VARCHAR(255) NOT NULL,
    action ENUM('update', 'delete') NOT NULL
);

CREATE TABLE representative (
    representative_id INT PRIMARY KEY,
    representative_name VARCHAR(100),
    ngo_name VARCHAR(100)
);

CREATE TABLE event_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    mobile_number VARCHAR(10) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    event VARCHAR(255) NOT NULL
);

CREATE TABLE ngo_registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organisation_id VARCHAR(255) NOT NULL,
    ngo_name VARCHAR(255) NOT NULL,
    contact_number VARCHAR(10) NOT NULL,
    address TEXT NOT NULL
);
