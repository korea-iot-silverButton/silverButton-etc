-- select * from schedules where (dependent_id=(select caregiver_id from matchings where dependent_id="2")) OR dependent_id="2";
-- 위는 중첩 select, 아래는 join문 사용
SELECT 
    s.schedule_date, 
    s.task
FROM 
    schedules s
LEFT JOIN 
    matchings m ON s.dependent_id = m.dependent_id OR s.dependent_id = m.caregiver_id
WHERE 
    m.dependent_id = 2;


-- 특정 날짜로 조회
select * from schedules WHERE id= "2" AND YEAR(schedule_date) = 2024 AND MONTH(schedule_date) = 11;

-- matching된 테이블로 특정 날짜 동안 출력
SELECT 
    s.schedule_date, 
    s.task
FROM 
    schedules s
LEFT JOIN 
    matchings m ON s.dependent_id = m.dependent_id OR s.dependent_id = m.caregiver_id
WHERE 
    m.dependent_id = 2
    AND YEAR(schedule_date) = 2024
    AND MONTH(s.schedule_date)= 11;