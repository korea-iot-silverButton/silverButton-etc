CREATE DATABASE IF NOT EXISTS silver_button;
USE silver_button;

CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL unique,
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

CREATE TABLE medicine_schedule (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(255), 
    item_seq VARCHAR(50),
    item_name VARCHAR(50),
    use_method_qesitm VARCHAR(500),
    atpn_qesitm VARCHAR(500),
    se_qesitm VARCHAR(255),
    deposit_method_qesitm VARCHAR(255),
    intrc_qesitm VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE health_magazine (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,         
    thumbnail_image_url VARCHAR(255) NOT NULL, 
    title VARCHAR(255) NOT NULL,               
    content TEXT NOT NULL,                     
    published_date DATETIME NOT NULL,          
    source VARCHAR(255) NOT NULL,              
    view_count INT DEFAULT 0,                 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE board (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT,
  title VARCHAR(100) NOT NULL,
  content TEXT NOT NULL,
  image_url LONGTEXT DEFAULT NULL, -- 이미지를 저장할 열 추가
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  likes INT DEFAULT 0,
  views INT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comment (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  board_id BIGINT NOT NULL,
  writer BIGINT NOT NULL,
  content varchar(200),
  FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE,
  FOREIGN KEY (writer) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE board_like (
  id  bigint primary key auto_increment,   -- 좋아요 id  (관리번호)
  board_id BIGINT,   -- 좋아요 눌린 게시글
  liker_id bigint,    -- 좋아요 누른 사람
  FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE ON update cascade,
  foreign key(liker_id) references users(id) ON UPDATE CASCADE
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