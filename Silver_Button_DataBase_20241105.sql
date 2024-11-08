create database if not exists silver_button;
use silver_button;

create table users (
  user_id varchar(50) not null,
  user_password varchar(50) not null,
  user_email varchar(50) not null ,
  user_nickname varchar(50) not null,
  user_name varchar(50) not null,
  phone_number varchar(50),
  birth_date DATE, 	
  gender ENUM('M', 'L') not null,
  profile_image VARCHAR(255) not null,
  id bigint auto_increment primary key
);

create table dependents  (
  dependent_id varchar(50) NOT NULL,
  dependent_name varchar(50) NOT NULL,
  gender ENUM('M', 'L') NOT NULL,
  phone_number varchar(50),
  birth_date DATE,
  profile_image VARCHAR(255) not null,
  nickname varchar(50) not null unique,
  id bigint auto_increment primary key
);

create table user_dependent (
	user_id bigint,
    dependent_id bigint,
    foreign key (users_unique_id) references users(users_unique_id)  on delete cascade,
    foreign key (dependents_unique_id) references dependents(dependents_unique_id) on delete cascade,
      primary key (user_id, depentent_id)
);

create table caregivers (
    caregiver_id varchar(50) NOT NULL,
    name varchar(50) not null,
    gender enum ('M', 'L') not null,
    phone_number varchar(50),
    caregiver_email varchar(50),
    license_number VARCHAR(50) not null,
    specialization varchar(50) not null,
    profile_image varchar(255) not null,
    nickname varchar(50) not null unique,
    birth_date DATE not null,
    id bigint auto_increment primary key
);

create table dependent_caregiver(
	dependent_id bigint,
    caregiver_id bigint,
    foreign key (dependents_unique_id) references dependents(dependents_unique_id)on delete cascade,
    foreign key (caregivers_unique_id) references caregivers(caregivers_unique_id)on delete cascade,
    primary key (dependent_id, caregiver_id)
);


create table schedules(
    id bigint,
    # 노인과 보호사가 매칭되어어야만 보호사는 캘린더 화면 열기 가능하도록 스크립트
    # 노인 아이디만 알고있어도 매칭테이블을 통해 연결된 일반인과 보호사의 id 알 수 있다.
    schedule_date date not null,
    task varchar(255),
    foreign key (dependent_id) references dependents(dependents_unique_id) on delete cascade
    #임계구역 설정해줄것 
);

CREATE TABLE medicines (
    id bigint PRIMARY KEY auto_increment,
    medicine_id bigint unique,
    ingredient VARCHAR(255), 
	 dosage_info VARCHAR(255), 
    side_effects VARCHAR(255), 
    caution VARCHAR(255), 
    stroage_method VARCHAR(255), 
    efficacy VARCHAR(255) -- 효능
);

CREATE TABLE medicine_schedule (
    id bigint,
    dependents__id bigint,
    caregivers_id bigint,
    usser_id VARCHAR(255), 
    dosage VARCHAR(100),
    frequency VARCHAR(50), 
    start_date DATE,
    end_date DATE, 
    instructions TEXT,
    FOREIGN KEY (users_unique_id) REFERENCES users(users_unique_id),
    foreign key (dependents_id) references dependents(dependents_unique_id) on delete cascade,
    foreign key (caregivers_id) references caregivers(caregivers_unique_id)on delete cascade,
    FOREIGN KEY (id) REFERENCES medicine_information(medicine_id)
);

CREATE TABLE board(
	id bigint,
    dependents_unique_id bigint,
    caregivers_unique_id bigint,
    board_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    likes INT DEFAULT 0,
    views INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    foreign key (dependent_id) references dependents(dependent_id) on delete cascade,
    foreign key (caregiver_id) references caregivers(caregiver_id)on delete cascade
);

create table comment(
	id BigINT PRIMARY KEY AUTO_INCREMENT,
    board_id BIGINT NOT NULL,
    writer varchar(50),
	content TEXT,
    foreign key(board_id) references board(board_id)on delete cascade
);

create table board_like(
    board_id bigint primary key,
	liker_id varchar(50) primary key, 
    foreign key(board_id) references board(board_id)
);

create table message(
   sender_id varchar(50) not null ,
   receiver_id varchar(50) not null,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   content text,
   title varchar(50),
	id bigint auto_increment primary key,
     foreign key(sender_id) references users(id),
     foreign key(sender_id) references dependents(id),
     foreign key(sender_id) references caregivers(id),
      foreign key(receiver_id) references users(id),
      foreign key(receiver_id) references dependents(id),
      foreign key(receiver_id) references caregivers(id)
    
);