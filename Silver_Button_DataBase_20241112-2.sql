CREATE DATABASE IF NOT EXISTS silver_button;
USE silver_button;

CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL, 
  name VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  email VARCHAR(50) UNIQUE,
  nickname VARCHAR(50) UNIQUE,
  birth_date DATE,
  gender ENUM('M', 'F') NOT NULL,
  profile_image VARCHAR(255),
  role ENUM('노인', '보호자', '요양사') NOT NULL,
  license_number VARCHAR(50),
  specialization VARCHAR(50),
  protector_id BIGINT,
  FOREIGN KEY (protector_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE matchings (
  dependent_id BIGINT NOT NULL, 
  caregiver_id BIGINT NOT NULL,
  FOREIGN KEY (dependent_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (caregiver_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE schedules (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  dependent_id BIGINT,
  schedule_date DATE NOT NULL,
  task VARCHAR(255),
  FOREIGN KEY (dependent_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE medicines (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  medicine_name varchar(255),
  medicine_id BIGINT UNIQUE,
  ingredient VARCHAR(255),
  dosage_info VARCHAR(255),
  side_effects VARCHAR(255),
  caution VARCHAR(255),
  stroage_method VARCHAR(255),
  efficacy VARCHAR(255)
);

CREATE TABLE medicine_schedule (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT,
  dosage VARCHAR(100),
  frequency VARCHAR(50),
  start_date DATE,
  end_date DATE,
  instructions TEXT,
  FOREIGN KEY (id) REFERENCES medicines(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE board (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT,
  title VARCHAR(100) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  likes INT DEFAULT 0,
  views INT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comment (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  board_id BIGINT NOT NULL,
  writer VARCHAR(50),
  content TEXT,
  FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE
);

CREATE TABLE board_like (
  PRIMARY KEY (board_id),
  board_id BIGINT,
  liker_id VARCHAR(50),
  FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE
);

CREATE TABLE message (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  sender_id BIGINT NOT NULL,
  receiver_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  content TEXT,
  title VARCHAR(50),
  FOREIGN KEY (sender_id) REFERENCES users(id),
  FOREIGN KEY (receiver_id) REFERENCES users(id)
);

select * from users;