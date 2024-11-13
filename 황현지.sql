SELECT  -- 요양사/보호자/노인의 모든 쪽지 리스트 조회
  m.id AS 메시지, 
  s.name AS 발신자,
  r.name AS 수신자,
  m.title AS 제목, 
  m.content AS 내용, 
  m.created_at AS 시간
FROM message m
JOIN users s ON m.sender_id = s.id  -- 발신자 정보
JOIN users r ON m.receiver_id = r.id  -- 수신자 정보
WHERE s.role = '요양사' OR r.role = '요양사' -- 요양사/노인/보호자 역할에 따라 수정 
ORDER BY m.created_at DESC;

SELECT -- 요양사/보호자/노인의 받은 쪽지 리스트 조회
  m.id AS 메시지,
  s.name AS 발신자,
  m.title AS 제목,
  m.content AS 내용,
  m.created_at AS 시간
FROM message m
JOIN users s ON m.sender_id = s.id
JOIN users r ON m.receiver_id = r.id
WHERE r.role = '요양사' -- 요양사/노인/보호자 역할에 따라 수정 
ORDER BY m.created_at DESC;

SELECT -- 요양사/보호자/노인의 보낸 쪽지 리스트 조회
  m.id AS 메시지,
  r.name AS 수신자,
  m.title AS 제목,
  m.content AS 내용,
  m.created_at AS 시간
FROM message m
JOIN users s ON m.sender_id = s.id
JOIN users r ON m.receiver_id = r.id
WHERE r.role = '요양사' -- 요양사/노인/보호자 역할에 따라 수정 
ORDER BY m.created_at DESC;

SELECT * FROM users WHERE role = '요양사'; -- 모든 요양사 조회

SELECT -- 특정 쪽지 조회
  m.id AS 메시지, 
  s.name AS 발신자, -- 보낸쪽지조회는 r.name 
  m.title AS 제목, 
  m.content AS 내용, 
  m.created_at AS 시간
FROM message m
JOIN users s ON m.sender_id = s.id 
JOIN users r ON m.receiver_id = r.id
WHERE m.id = 1;  -- 조회하려는 쪽지 ID


SELECT  -- 매칭 정보 조회
  m.dependent_id AS 노인_ID,
  d.name AS 노인_이름,
  d.phone AS 노인_전화번호,
  m.caregiver_id AS 요양사_ID,
  c.name AS 요양사_이름,
  c.phone AS 요양사_전화번호,
  c.license_number AS 요양사_자격증번호,
  c.specialization AS 요양사_전문분야
FROM matchings m
JOIN users d ON m.dependent_id = d.id
JOIN users c ON m.caregiver_id = c.id
WHERE m.dependent_id = 1 AND m.caregiver_id = 2; -- 예시

-- 쪽지 삭제
DELETE FROM message
WHERE id = 5;  -- 삭제할 쪽지 ID

-- 요양사 매칭 취소
DELETE FROM matchings
WHERE dependent_id = 1 AND caregiver_id = 2;

SELECT -- 특정 요양사 정보 조회*******************이름변경
  id AS 요양사,
  name AS 이름,
  phone AS 전화번호,
  email AS 이메일,
  nickname AS 닉네임,
  birth_date AS 생년월일,
  gender AS 성별,
  profile_image AS 프로필,
  license_number AS 자격증번호,
  specialization AS 전문분야
FROM users
WHERE role = '요양사' AND id = 2;