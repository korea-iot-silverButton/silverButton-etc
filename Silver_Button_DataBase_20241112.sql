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
  id BIGINT PRIMARY KEY AUTO_INCREMENT,   -- 게시글의 id (번호)값 
  user_id BIGINT,   -- 유저의 id 값을 참조 유저구분
  title VARCHAR(100) NOT NULL, -- 제목
  content TEXT NOT NULL,  -- 게시글 내용
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- 작성시간
  likes INT DEFAULT 0,  -- 좋아요 횟수
  views INT DEFAULT 0, -- 조회수
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comment (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,  -- 댓글의 id 
  board_id BIGINT NOT NULL,  -- 게시글의 id값을 참조 게시글 구분
  writer VARCHAR(50),   -- 작성자
  content varchar(200),   --  댓글 내용
  FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE 
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

select * from users;