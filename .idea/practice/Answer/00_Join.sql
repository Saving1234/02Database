/* Q1)
직원의 사번, 사원명, 직급명을 조회하시오.
사번을 기준으로 오름차순 정렬하시오.
[테이블 정보]
- tbl_employee: 사번(emp_id), 사원명(emp_name), 직급코드(job_code)
- tbl_job: 직급코드(job_code), 직급명(job_name)
(힌트: INNER JOIN)
*/

/* Q2)
모든 직원의 사번, 사원명, 부서명을 조회하시오.
부서가 배정되지 않은 직원도 결과에 포함하고, 사번을 기준으로 오름차순 정렬하시오.
[테이블 정보]
- tbl_employee: 사번(emp_id), 사원명(emp_name), 부서코드(dept_code)
- tbl_department: 부서코드(dept_id), 부서명(dept_title)
(힌트: LEFT JOIN)
*/

/* Q3)
보너스를 받는 모든 직원의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
부서가 배정되지 않은 직원도 결과에 포함하시오.
[테이블 정보]
- tbl_employee: 사원명(emp_name), 보너스포인트(bonus), 부서코드(dept_code)
- tbl_department: 부서코드(dept_id), 부서명(dept_title), 지역코드(location_id)
- tbl_location: 지역코드(local_code), 근무지역명(local_name)
(힌트: IS NOT NULL, LEFT JOIN)
*/

/* Q4)
한국(KO)과 일본(JP)에 근무하는 직원의 사원명, 부서명, 지역명, 국가명을 조회하시오.
국가코드, 부서코드, 사번 순으로 오름차순 정렬하시오.
[테이블 정보]
- tbl_employee: 사번(emp_id), 사원명(emp_name), 부서코드(dept_code)
- tbl_department: 부서코드(dept_id), 부서명(dept_title), 지역코드(location_id)
- tbl_location: 지역코드(local_code), 지역명(local_name), 국가코드(national_code)
- tbl_national: 국가코드(national_code), 국가명(national_name)
(힌트: 여러 테이블 JOIN, IN)
*/

/* Q5)
모든 직원의 사번, 사원명, 관리자명을 조회하시오.
관리자가 없거나 관리자 정보가 등록되지 않은 직원도 결과에 포함하고,
사번을 기준으로 오름차순 정렬하시오.
[테이블 정보]
- tbl_employee: 사번(emp_id), 사원명(emp_name), 관리자사번(manager_id)
- 같은 tbl_employee 테이블을 서로 다른 별칭으로 두 번 사용한다.
(힌트: SELF JOIN, LEFT JOIN)
*/


/* Q1)
전체 직원 수와 전 직원 급여의 합계를 조회하시오.
(힌트: COUNT, SUM)
*/

select count(*) as 전체직원수, sum(salary) 합계
from tbl_employee;


/* Q2)
부서코드별로 부서코드, 급여 합계, 평균 급여(소수점 이하 버림), 직원 수를 조회하시오.
부서가 배정되지 않은 직원도 하나의 그룹으로 포함하고,
부서코드를 기준으로 오름차순 정렬하시오.
(힌트: GROUP BY, SUM, AVG, FLOOR, COUNT)
*/

select dept_code, sum(salary), floor(avg(salary)), count(*)
from tbl_employee
group by dept_code
order by tbl_employee.dept_code;


/* Q3)
보너스를 받는 직원만 대상으로 직급코드별 직원 수를 조회하시오.
직급코드를 기준으로 오름차순 정렬하시오.
(힌트: WHERE, GROUP BY, COUNT)
*/

select job_code, count(*) as 직원
from tbl_employee
where bonus is not null
group by job_code
order by job_code;


/* Q4)
부서별 평균 급여가 300만원 이상인 부서의 부서명, 직원 수,
평균 급여(소수점 이하 버림)를 조회하시오.
평균 급여를 기준으로 내림차순 정렬하시오.
(힌트: JOIN, GROUP BY, HAVING)
*/

#     SELECT
#         b.dept_title, count(*) 직원수, avg(salary)
#         FROM tbl_employee a LEFT JOIN  tbl_department b
#         group by b.dept_title;


/* Q5)
직급별 직급명, 직원 수, 급여 합계를 조회하고 마지막 행에 전체 직원 수와
전체 급여 합계가 표시되도록 하시오.
(힌트: JOIN, GROUP BY, WITH ROLLUP, COALESCE)
*/


/* Q1)
사원명이 '노옹철'인 직원과 같은 부서에 속한 직원의 사원명과 부서코드를 조회하시오.
(힌트: WHERE절의 서브쿼리)
*/

SELECT emp_name,
       dept_code
FROM tbl_employee
where dept_code =
      (SELECT dept_code
       FROM tbl_employee
       where emp_name = '노옹철');


/* Q2)
전 직원의 평균 급여보다 많은 급여를 받는 직원의 사번, 사원명, 직급코드,
급여를 조회하고 급여를 기준으로 내림차순 정렬하시오.
(힌트: AVG를 사용한 서브쿼리)
*/

SELECT emp_id,
       emp_name,
       job_code,
       salary

FROM tbl_employee
WHERE salary > (SELECT AVG(salary) FROM tbl_employee)
ORDER BY salary DESC;


/* Q3)
부서별 급여 합계를 먼저 구한 뒤, 급여 합계가 가장 큰 부서의 부서명과
급여 합계를 조회하시오.
(힌트: FROM절 서브쿼리, GROUP BY, JOIN, ORDER BY, LIMIT)
*/

SELECT D.dept_title, T.dept_sum
FROM (
         -- 1단계: 부서별 급여 합계를 먼저 구하는 '가상 테이블' 생성
         SELECT dept_code, SUM(salary) AS dept_sum
         FROM tbl_employee
         GROUP BY dept_code
     ) AS T
         INNER JOIN tbl_department D ON T.dept_code = D.dept_id -- 2단계: 부서명을 가져오기 위한 조인
ORDER BY T.dept_sum DESC -- 3단계: 급여 합계가 가장 큰 순서대로 정렬
LIMIT 1; -- 4단계: 맨 상위 1개(가장 큰 부서)만 추출

SELECT dept_code, SUM(salary) AS dept_sum
FROM tbl_employee
GROUP BY dept_code;


/* Q4)
부서가 배정된 직원 중 각 부서의 최고 급여를 받는 직원의 사원명, 직급명,
부서명, 급여를 조회하시오. 최고 급여가 같은 직원은 모두 조회하시오.
(힌트: 상관 서브쿼리, MAX, JOIN)
*/

/* Q5)
보너스를 받는 직원의 부서코드를 CTE로 먼저 정의하시오.
그 CTE와 EXISTS를 사용하여 보너스를 받는 직원이 한 명 이상 있는 부서의
부서코드와 부서명을 조회하고, 부서코드를 기준으로 오름차순 정렬하시오.
(힌트: WITH, EXISTS)
*/

with bonus_employee as (
    select
        tbl_employee.dept_code
    from tbl_employee
    where bonus is not null and
          dept_code is not null
)
select
    dept_id,
    dept_title
    from tbl_department d
where exists(
    select 1 from bonus_employee b
            where b.dept_code = d.dept_id
)  order by d.dept_id;

-- 밑에가 조건이 맞으면 true 1이라는 것이 그 이유인가?