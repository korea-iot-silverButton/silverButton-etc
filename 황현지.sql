SELECT * FROM message; -- 모든 쪽지 리스트 조회

SELECT * FROM users WHERE role = '요양사'; -- 모든 요양사 조회

 -- 특정 요양사 정보 조회
 SELECT 
  id AS 요양사_ID,
  name AS 이름,
  phone_number AS 전화번호,
  email AS 이메일,
  nickname AS 닉네임,
  birth_date AS 생년월일,
  gender AS 성별,
  profile_image AS 프로필_이미지,
  license_number AS 자격증_번호,
  specialization AS 전문분야
FROM users
WHERE role = '요양사' AND id = 2;

SELECT  -- 특정 쪽지 조회
  m.id, 
  s.name AS sender_name,
  m.title, 
  m.content, 
  m.created_at
FROM message m
JOIN users s ON m.sender_id = s.user_id
JOIN users r ON m.receiver_id = r.user_id
WHERE m.sender_id = 1 OR m.receiver_id = 1; -- 예시

SELECT  -- 매칭 정보 조회
  m.dependent_id AS 노인_ID,
  d.name AS 노인_이름,
  d.phone_number AS 노인_전화번호,
  m.caregiver_id AS 요양사_ID,
  c.name AS 요양사_이름,
  c.phone_number AS 요양사_전화번호,
  c.license_number AS요양사_자격증번호,
  c.specialization AS 요양사_전문분야
FROM matchings m
JOIN users d ON m.dependent_id = d.id
JOIN users c ON m.caregiver_id = c.id
WHERE m.dependent_id = 1 AND m.caregiver_id = 2; -- 예시

-- 쪽지 삭제
DELETE FROM message
WHERE id = 5;  -- 삭제할 쪽지 ID

-- 받은 쪽지 리스트 조회
SELECT 
  m.id AS 메시지_ID,
  s.name AS 발신자_이름,
  m.title AS 제목,
  m.content AS 내용,
  m.created_at AS 받은_시간
FROM message m
JOIN users s ON m.sender_id = s.id
WHERE m.receiver_id = 1  -- id가 1번인 사용자가 받은 메시지만 필터링
ORDER BY m.created_at DESC;

-- 보낸 쪽지 리스트 조회
SELECT 
  m.id AS 메시지_ID,
  r.name AS 수신자_이름,
  m.title AS 제목,
  m.content AS 내용,
  m.created_at AS 보낸_시간
FROM message m
JOIN users r ON m.receiver_id = r.id
WHERE m.sender_id = 1  -- 여기서 1은 특정 사용자의 ID
ORDER BY m.created_at DESC;

-- 요양사 매칭 취소
DELETE FROM matchings
WHERE dependent_id = 1 AND caregiver_id = 2;