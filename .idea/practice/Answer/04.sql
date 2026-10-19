insert into tbl_employee
values (901, '이지영', 910123 - 1234567, 'lee_jy@gmail.com', 01055551234, 'D2', 'J2', 's3', 3500000, 0.15, 201,
        '2026-10-15', NULL, 'N');

UPDATE tbl_employee
SET salary= (SELECT salary FROM (SELECT salary FROM tbl_employee WHERE emp_name = '유재식') AS A),
    bonus = (SELECT bonus FROM (SELECT bonus FROM tbl_employee WHERE emp_name = '유재식') AS B)
WHERE emp_name = '하이유';

UPDATE tbl_employee
SET salary = (SELECT salary FROM (SELECT salary FROM tbl_employee WHERE emp_name = '유재식') AS a),
    bonus  = (SELECT bonus FROM (SELECT bonus FROM tbl_employee WHERE emp_name = '유재식') AS b)
WHERE emp_name IN ('노옹철', '전형돈', '정중하', '하동운');

DELETE
FROM tbl_employee
WHERE emp_id = 901;

DELETE
FROM tbl_employee
WHERE dept_code = 'D1';


#  조회

SELECT A.emp_id,
       A.emp_name,
       A.job_code,
       B.job_code,
       B.job_name
FROM tbl_employee A
         JOIN tbl_job B
              ON A.job_code = B.job_code
ORDER BY A.emp_id;

SELECT A.emp_id,
       A.emp_name,
       A.dept_code,
       B.dept_id,
       B.dept_title
FROM tbl_employee A
         LEFT JOIN tbl_department B
                   ON A.dept_code = B.dept_id
ORDER BY A.emp_id;
-- 오답 LEFT JOIN 에 WHERE라고 하였음. 이유 : INNERJOIN에서 WHERE로 했을 때
-- 잘 되어왔기에, 당연히 LEFTJOIN도 그런 줄 알았지만 컴파일 오류 뜸.
-- 곰곰히 생각해본 결과, WHERE 대신 ON도 조건문 역할을 한다고 들었음.
-- 그래서 한번 써봤는데 조회 성공.
-- 알게 된 것. LEFT/RIGHT JOIN은 조건 형식이 ON이다.
-- INNER JOIN도 확인하기 위해 ON을 넣어서 실행시키자 오류 뜨지 않았음. -> JOIN은 ON으로 통일하자는.

-- 3

SELECT A.emp_name,
       A.bonus,
       A.dept_code,
       B.dept_id,
       B.dept_title,
       B.location_idm,
       C. local_code,
       C.local_name
FROM tbl_employee A
         LEFT JOIN tbl_department B ON A.dept_code IS NOT NULL
         LEFT JOIN tbl_location C ON A.dept_code = B.dept_id

ORDER BY emp_id;

-- 오답. 컬럼명에 한 글자를 더 넣었음.
-- 이유 : 컬럼명을 쓸 때 지금껏 틀린 적이 없었기에, 빠르게 써 내려갔기에.
-- 에러 메시지 :  Unknown column 'B.location_idm' in 'field list'
-- 이 메시지가 무엇을 의미하는지 몰랐기에, AI에게 물어보고 받은 답변이 찾으려는 B의 컬럼이 존재하지 않는다.
-- 그래서 컬럼을 하나씩 살펴봤고, B 별칭의 테이블 컬럼을 살펴본 결과, 한 컬럼의 한글자가 더 더해져있는 것을 발견하여 지움.
-- 알게 된 것. 에러메시지 하나를 읽을 수 있게 되었고. 그 메시지가 뜨게 되면 컬럼명을 확인 하자.

-- 4

SELECT
    A.emp_id, A.emp_name, A.dept_code,
    B.dept_id, B.dept_title, B.location_id,
    C.local_code, C.local_name, C.national_code,
    D.national_code, D.national_name
    FROM tbl_employee A JOIN tbl_department B ON A.dept_code = B.dept_id
    JOIN tbl_location C ON B.location_id = C.local_code
        JOIN tbl_national D ON C.national_code = D.national_code
 IN ('KO', 'JP')
ORDER BY C.national_code, B.dept_id, A.emp_id;


-- 5

SELECT
    A.emp_id, A.emp_name, A.manager_id,
    B.emp_id, B.emp_name, B.manager_id
    FROM tbl_employee A LEFT JOIN tbl_employee B
ON A.manager_id= B.manager_id
ORDER BY A.emp_id;


-- 1

SELECT COUNT(*) 전체직원, SUM(salary) FROM tbl_employee;

-- 2

SELECT dept_code, SUM(salary), FLOOR(AVG(salary)), COUNT(*) 직원수 FROM tbl_employee
GROUP BY dept_code
order by dept_code;

-- 3

SELECT COUNT(*) 보너스받는직원수 FROM tbl_employee
WHERE BONUS IS NOT NULL
ORDER BY job_code;

-- 4

SELECT B.dept_title, COUNT(*) 직원수, FLOOR(AVG(A.salary))
FROM tbl_employee A JOIN tbl_department B
    ON A.dept_code = B.dept_id
GROUP BY B.dept_title
HAVING AVG(A.salary)> 3000000;




SELECT
    B.job_name , COUNT(*)직원수, SUM(salary)
    FROM tbl_employee A JOIN tbl_job B
    ON A.job_code = B.job_code
GROUP BY B.job_name WITH ROLLUP-- 공통된 것을 하나로 묶어 그룹으로 만든다.
HAVING SUM(salary) > 3000000;

-- GROUP BY WITH ROLL UP
-- WITH ROLL UP을 HAVING 밑에 썼음.
-- WITH ROLL UP을 아래에 적었지만 빨간줄이 뜸.
-- 그래서 AI에게 GROUP BY와 WITH ROLL UP을 같이 쓸 때의 예안을 보여달라고 했을 때,
-- WITH ROLLUP은 GROUP BY 옆에 놓기만 하면 된다고 하여, 옆에 놓자 실행됨.


-- 1
SELECT emp_name, dept_code FROM tbl_employee
WHERE  dept_code =  (SELECT dept_code FROM tbl_employee WHERE emp_name = '노옹철');

-- 2
-- WHERE문에 AVG 같은 함수를 넣으려면 WHERE 서브쿼리?를 써야함.
 SELECT
         emp_id, emp_name, job_code, salary
     FROM tbl_employee
   WHERE salary >(SELECT AVG(salary) FROM tbl_employee);

-- 3

-- 급여 합계
-- 급여 합계.
--
#
# SELECT
#     DEPT_BEST.dept_title, DEPT_BEST.`AVG(A.salary)`
#     FROM (SELECT AVG(A.salary) B.dept_title FROM tbl_employee A JOIN tbl_department B
# ON A.dept_code = B.dept_id
#    GROUP BY B.dept_title
# ) AS DEPT_BEST
# ORDER BY DEPT_BEST.`AVG(A.salary)`
#     LIMIT 1;

-- 4
















