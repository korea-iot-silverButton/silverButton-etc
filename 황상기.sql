CREATE DATABASE IF NOT EXISTS silver_button;
drop database silver_button;
use silver_button;
SET foreign_key_checks= 1;
 -- 게시글 조건별 조회
select * from board order by id desc ;      -- 게시글 전체 조회     
select * from board where user_id = ?order by id desc;   -- 게시글 작성자별 조회 id값별로 내림차순
select * from board where title like '%title%' order by id desc;  --  게시글 제목별 조회 id값 별로 내림차순

-- 게시글 생성 
insert into board(user_id, title, content) values (1,'실버버튼프로젝트','실버니아');
insert into comment(board_id,writer,content) values(1,'tkdrl9900','실버니아');
insert into board_like(board_id,liker_id) values(1,'tkdrl9900');

 -- 게시판 조건별 수정
update board set content = '실버' where user_id;   -- 작성자의 보드데이블 내용 수정
update board set title = '실버' where user_id;   -- 작성자의 보드데이블 제목 수정

-- 게시판 삭제
delete from board where user_id;    --  작성자의 테이블 삭제

--  댓글 조회 -- 
select * from comment order by id desc;    --  댓글 전체 조회 //  게시글 단일조회시 댓글 전체 조회
-- 댓글 삭제
delete from comment where user_id;  --  댓글 작성자의 댓글 삭제


select * from board_like;  -- 좋아요 테이블 조회  -- 참조 용도





