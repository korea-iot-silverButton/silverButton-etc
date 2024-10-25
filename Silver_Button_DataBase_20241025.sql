create database if not exists silver_button;
use silver_button;

create table users (
  user_id varchar(50) not null,
  user_password varchar(50) not null,
  user_email varchar(50) not null ,
  user_nickname varchar(50) not null,
  user_name varchar(50) not null,
  phone_number varchar(50),
  date_of_birth DATE, 
  gender ENUM('M', 'L') not null,
  profile_image VARCHAR(255) not null,
  nickname varchar(50) not null unique,
  users_unique_id bigint auto_increment primary key
);

create table dependents  (
  dependent_id varchar(50) NOT NULL,
  dependent_name varchar(50) NOT NULL,
  gender ENUM('M', 'L') NOT NULL,
  phone_number varchar(50),
  date_of_birth DATE,
  profile_image VARCHAR(255) not null,
  nickname varchar(50) not null unique,
  dependents_unique_id bigint auto_increment primary key
);

create table users_dependents_matching (
	users_unique_id bigint,
    dependents_unique_id bigint,
    foreign key (users_unique_id) references users(users_unique_id),
    foreign key (dependents_unique_id) references dependents(dependents_unique_id)
);

create table caregivers (
    caregiver_id varchar(50) NOT NULL,
    name varchar(50) not null,
    gender enum ('M', 'L') not null,
    phone_number varchar(50),
    email varchar(50),
    license_number VARCHAR(50) not null,
    specialization varchar(50) not null,
    profile_image varchar(255) not null,
    nickname varchar(50) not null unique,
    date_of_birth DATE not null,
    caregivers_unique_id bigint auto_increment primary key
);

create table dependents_caregivers_matching(
	dependents_unique_id bigint,
    caregivers_unique_id bigint,
    foreign key (dependents_unique_id) references dependents(dependents_unique_id),
    foreign key (caregivers_unique_id) references caregivers(caregivers_unique_id)
);


create table calendar(
    dependents_unique_id bigint,
    # 노인과 보호사가 매칭되어어야만 보호사는 캘린더 화면 열기 가능하도록 스크립트
    # 노인 아이디만 알고있어도 매칭테이블을 통해 연결된 일반인과 보호사의 id 알 수 있다.
    schedule_date date,
    to_do varchar(255),
    foreign key (dependents_unique_id) references dependents(dependents_unique_id)
    #임계구역 설정해줄것 
);

CREATE TABLE medicine_information (
    medicine_id VARCHAR(255) PRIMARY KEY,
    medicine_ingredient VARCHAR(255), 
    medicine_take VARCHAR(255), 
    medicine_sideeffect VARCHAR(255), 
    medicine_caution VARCHAR(255), 
    medicine_save VARCHAR(255), 
    medicine_efficacy VARCHAR(255)
);

CREATE TABLE user_medicine (
    users_unique_id bigint,
    dependents_unique_id bigint,
    caregivers_unique_id bigint,
    medicine_id VARCHAR(255), 
    dosage VARCHAR(100),
    frequency VARCHAR(50), 
    start_date DATE,
    end_date DATE, 
    instructions TEXT,
    FOREIGN KEY (users_unique_id) REFERENCES users(users_unique_id),
    foreign key (dependents_unique_id) references dependents(dependents_unique_id),
    foreign key (caregivers_unique_id) references caregivers(caregivers_unique_id),
    FOREIGN KEY (medicine_id) REFERENCES medicine_information(medicine_id)
);

CREATE TABLE board(
	users_unique_id bigint,
    dependents_unique_id bigint,
    caregivers_unique_id bigint,
    board_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    likes INT DEFAULT 0,
    views INT DEFAULT 0,
    FOREIGN KEY (users_unique_id) REFERENCES users(users_unique_id),
    foreign key (dependents_unique_id) references dependents(dependents_unique_id),
    foreign key (caregivers_unique_id) references caregivers(caregivers_unique_id)
);

create table board_comment(
    comment_id BigINT PRIMARY KEY AUTO_INCREMENT,
    board_id BigINT NOT NULL,
    writer varchar(50),
	content TEXT,
    foreign key(board_id) references board(board_id)
);

create table board_like(
    board_id bigint not null,
    who_likeit_id varchar(50), 
    foreign key(board_id) references board(board_id)
);

create table letter(
   sender varchar(50) not null,
   receiver varchar(50) not null,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   content text,
   title varchar(50),
   letter_id bigint auto_increment primary key
);