CREATE DATABASE IF NOT EXISTS silver_button;
USE silver_button;

CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(50) NOT NULL,
  user_password VARCHAR(50) NOT NULL,
  user_email VARCHAR(50) NOT NULL,
  user_nickname VARCHAR(50) NOT NULL,
  user_name VARCHAR(50) NOT NULL,
  phone_number VARCHAR(50),
  birth_date DATE,
  gender ENUM('M', 'L') NOT NULL,
  profile_image VARCHAR(255) NOT NULL
);

CREATE TABLE dependents (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  dependent_id VARCHAR(50) NOT NULL,
  dependent_name VARCHAR(50) NOT NULL,
  gender ENUM('M', 'L') NOT NULL,
  phone_number VARCHAR(50),
  birth_date DATE,
  profile_image VARCHAR(255) NOT NULL,
  nickname VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE user_dependent (
  PRIMARY KEY (user_id, depentent_id),
  user_id BIGINT,
  dependent_id BIGINT,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (dependent_id) REFERENCES dependents(dependent_id) ON DELETE CASCADE
);

CREATE TABLE caregivers (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  caregiver_id VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  gender ENUM('M', 'L') NOT NULL,
  phone_number VARCHAR(50),
  caregiver_email VARCHAR(50),
  license_number VARCHAR(50) NOT NULL,
  specialization VARCHAR(50) NOT NULL,
  profile_image VARCHAR(255) NOT NULL,
  nickname VARCHAR(50) NOT NULL UNIQUE,
  birth_date DATE NOT NULL
);

CREATE TABLE dependent_caregiver (
  PRIMARY KEY (dependent_id, caregiver_id),
  dependent_id BIGINT,
  caregiver_id BIGINT,
  FOREIGN KEY (dependent_id) REFERENCES dependents(dependent_id) ON DELETE CASCADE,
  FOREIGN KEY (caregiver_id) REFERENCES caregivers(caregiver_id) ON DELETE CASCADE
);

CREATE TABLE schedules (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  dependent_id BIGINT,
  schedule_date DATE NOT NULL,
  task VARCHAR(255),
  FOREIGN KEY (id) REFERENCES dependents(id) ON DELETE CASCADE
);

CREATE TABLE medicines (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
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
  dependents__id BIGINT,
  caregivers_id BIGINT,
  usser_id VARCHAR(255),
  dosage VARCHAR(100),
  frequency VARCHAR(50),
  start_date DATE,
  end_date DATE,
  instructions TEXT,
  FOREIGN KEY (users_unique_id) REFERENCES users(users_unique_id),
  FOREIGN KEY (dependents_id) REFERENCES dependents(dependents_unique_id) ON DELETE CASCADE,
  FOREIGN KEY (caregivers_id) REFERENCES caregivers(caregivers_unique_id) ON DELETE CASCADE,
  FOREIGN KEY (id) REFERENCES medicine_information(medicine_id)
);

CREATE TABLE board (
  board_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT,
  dependents_id BIGINT,
  caregivers_id BIGINT,
  title VARCHAR(100) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  likes INT DEFAULT 0,
  views INT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (dependent_id) REFERENCES dependents(id) ON DELETE CASCADE,
  FOREIGN KEY (caregiver_id) REFERENCES caregivers(id) ON DELETE CASCADE
);

CREATE TABLE comment (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  board_id BIGINT NOT NULL,
  writer VARCHAR(50),
  content TEXT,
  FOREIGN KEY (board_id) REFERENCES board(board_id) ON DELETE CASCADE
);

CREATE TABLE board_like (
  PRIMARY KEY (board_id, liker_id),
  board_id BIGINT,
  liker_id VARCHAR(50),
  FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE
);

-- CREATE TABLE message (
--   id BIGINT AUTO_INCREMENT PRIMARY KEY,
--   sender_id VARCHAR(50) NOT NULL,
--   receiver_id VARCHAR(50) NOT NULL,
--   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   content TEXT,
--   title VARCHAR(50),
--   FOREIGN KEY (sender_id) REFERENCES users(id),
--   FOREIGN KEY (sender_id) REFERENCES dependents(id),
--   FOREIGN KEY (sender_id) REFERENCES caregivers(id),
--   FOREIGN KEY (receiver_id) REFERENCES users(id),
--   FOREIGN KEY (receiver_id) REFERENCES dependents(id),
--   FOREIGN KEY (receiver_id) REFERENCES caregivers(id)
-- );
