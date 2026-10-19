SELECT SUBSTRING_INDEX(email, '@', 1),
       emp_name,
       emp_id,
       email
FROM tbl_employee;

SELECT emp_name                as 사원명,
       SUBSTRING(emp_no, 1, 2) AS 생년,
       SUBSTRING(emp_no, 3, 2) AS 생월,
       SUBSTRING(emp_no, 5, 2) AS 생일


FROM tbl_employee;

SELECT emp_name AS 이름,
       PERIOD_DIFF(
               CONCAT(YEAR(NOW()), LPAD(MONTH(NOW()), 2, '0')),
               CONCAT(YEAR(hire_date), LPAD(MONTH(hire_date), 2, '0'))
       )        AS 개월수
FROM tbl_employee;
-- 연도 추출. 월 , 2자리수로 만드는데 0을 붙여서 완성.
-- 연도와 2자리수 월을 붙임. -> 예 : 2026.10.
-- HIREDATE의 연도 월과 NOW의 연도월 계산.
-- 계산한 값을 개월 수라는 쿼리명에 넣음.

SELECT
    emp_id,
   CONCAT('￦',FORMAT(salary, 0))


    FROM tbl_employee;

SELECT FORMAT(1234567.84514519, 7);

-- 5번

SELECT
    emp_name,
    salary

    FROM tbl_employee
where TRUNCATE(salary*1.15,-5);
-- 테이블 지울때도 사용
SELECT TRUNCATE(1234.5678, -1);