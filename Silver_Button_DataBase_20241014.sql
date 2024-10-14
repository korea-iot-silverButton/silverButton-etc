create database if not exists silver_button;
use silver_button;

create table users (
  user_id varchar(50) primary key,
  user_password varchar(50) not null,
  user_email varchar(50) not null ,
  user_nickname varchar(50) not null,
  user_name varchar(50) not null,
  phone_number varchar(50) not null,
  date_of_birth DATE not null, 
  gender ENUM('M', 'L') not null,
  profile_image VARCHAR(50)not null
);

create table dependents  (
  dependent_id varchar(50) primary key,
  dependent_name varchar(50),
  gender ENUM('M', 'L'),
  phone_number varchar(50),
  date_of_birth DATE
);

create table users_dependents_matching (
   user_id varchar(50),
    dependent_id varchar(50),
    foreign key (user_id) references users(user_id),
    foreign key (dependent_id) references dependents(dependent_id)
);

create table caregivers (
    caregiver_id varchar(50) primary key,
    name varchar(50) not null,
    gender enum ('M', 'L') not null,
    phone_number varchar(50) not null,
    email varchar(50) not null,
    license_number VARCHAR(50) not null,
    specialization varchar(50) not null,
    profile_image varchar(50) not null,
    nickname varchar(50) not null,
    date_of_birth DATE not null
);

create table dependents_caregivers_matching(
   dependent_id varchar(50),
    caregiver_id varchar(50),
    foreign key (dependent_id) references dependents(dependent_id),
    foreign key (caregiver_id) references caregivers(caregiver_id)
);


create table calendar(
    dependent_id varchar(50),
    # 노인과 보호사가 매칭되어어야만 보호사는 캘린더 화면 열기 가능하도록 스크립트
    # 노인 아이디만 알고있어도 매칭테이블을 통해 연결된 일반인과 보호사의 id 알 수 있다.
    schedule_date date,
    to_do varchar(255),
    foreign key (dependent_id) references dependents(dependent_id)
    #임계구역 설정해줄것 
);

CREATE TABLE medicine_information (
    medicine_id VARCHAR(255),
    medicine_ingredient VARCHAR(255), 
    medicine_take VARCHAR(255), 
    medicine_sideeffect VARCHAR(255), 
    medicine_caution VARCHAR(255), 
    medicine_save VARCHAR(255), 
    medicine_efficacy VARCHAR(255), 
    PRIMARY KEY (medicine_id)
);

CREATE TABLE user_medicine (
    user_id VARCHAR(50),
    dependent_id varchar(50),
    caregiver_id varchar(50),
    medicine_id VARCHAR(255), 
    dosage VARCHAR(100),
    frequency VARCHAR(50), 
    start_date DATE,
    end_date DATE, 
    instructions TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    foreign key (dependent_id) references dependents(dependent_id),
    foreign key (caregiver_id) references caregivers(caregiver_id),
    FOREIGN KEY (medicine_id) REFERENCES medicine_information(medicine_id)
);


CREATE TABLE board(
   user_id VARCHAR(50),
    dependent_id varchar(50),
    caregiver_id varchar(50),
    board_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   likes INT DEFAULT 0,
    views INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    foreign key (dependent_id) references dependents(dependent_id),
    foreign key (caregiver_id) references caregivers(caregiver_id)
);

CREATE TABLE board_list(#board_id만 알면 나머지는 where문으로 호출 가능
   board_id INT,
    foreign key(board_id) references board(board_id)
);

create table board_comment(
   comment_id INT PRIMARY KEY AUTO_INCREMENT,
    board_id INT NOT NULL,
    who_commentit_id varchar(50),
   content VARCHAR(200),
    foreign key(board_id) references board(board_id)
);

create table board_like(
   board_id int not null,
    who_likeit_id varchar(50), #id값을 여기 저장, 굳이 참조키 지정 필요없을 듯
    foreign key(board_id) references board(board_id)
);