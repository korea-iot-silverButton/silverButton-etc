-- 약품 이름으로 조회
SELECT * FROM medicines
WHERE itemName LIKE '%약품 이름(ex.가스디알정50밀리그램)%' ;

-- 제품명또는 약품 효능으로 약품 검색 
SELECT * FROM medicines 
WHERE itemName LIKE '%약품 이름(ex.가스디알정50밀리그램)%' 
   OR efcyQesitm  LIKE '%효능(ex.식욕감퇴(식욕부진), 위부팽만감, 소화불량에 사용)%';

-- 특정 사용자의 특정 약품 삭제
DELETE FROM medicine_schedule 
WHERE user_id = 1 
  AND medicine_id = 12345;
  
-- 약품 모양으로 조회 
SELECT * FROM medicines
WHERE 
   drug_shape LIKE concat('%', IFNULL(NULLIF(@search_keyword, ''), ''), '%')
   AND color_class1 LIKE concat('%', IFNULL(NULLIF(@search_keyword, ''), ''), '%')
   AND line_front LIKE concat('%', IFNULL(NULLIF(@search_keyword, ''), ''), '%'); 
/*
   NULLIF(a, b)
    : a와 b가 같으면 NULL, 그렇지 않으면 a 반환
    
    IFNULL(a, b)
    : a가 NULL이면 b 반환, a가 NULL이 아니면 a 반환
*/

-- 특정 사용자의 약품 이름으로 복용중인 약품 조회
SELECT * FROM medicine_schedule
WHERE itemName LIKE '%약품 이름%' ;

-- 특정 사용자의 메디슨 스케쥴 수정 
UPDATE medicine_schedule
SET 
  useMethodQesitm = '2정',               -- 수정된 복용량 
  frequency = '하루 1회',        -- 수정된 복용 빈도 
  start_date = '2024-11-15',     -- 수정된 첫 복용 날짜
  end_date = '2024-11-22',       -- 수정된 마지막 복용 날짜 
  instructions = '식사 30분 전 복용' -- 수정된 복용 안내 
WHERE 
  user_id = 1                   -- 사용자 ID 
  AND medicine_id = 1;         -- 약품 ID 

-- 특정 사용자가 복용중인 약품 전체 조회
SELECT * 
FROM medicine_schedule ms
JOIN medicines m ON ms.itemName = m.itemName
WHERE ms.user_id = user_id;


  
  
	






  
  
  





