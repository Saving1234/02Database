select
    emp_name


    from tbl_employee
where
    dept_code = 'D9';

SELECT
    emp_name,
    dept_code,
    salary
    FROM tbl_employee
WHERE dept_code = 'D6' AND
      salary >200;

SELECT
    emp_id,
    emp_name,
    salary,
    bonus
    FROM  tbl_employee
WHERE bonus  is null;

-- 4
select
    emp_id,
    emp_name,
    salary,
    dept_code,
    job_code

    from tbl_employee
where salary >=3500000 AND
      salary <= 5500000;

-- 5
SELECT
    emp_name,
    emp_no,
    dept_code
    FROM tbl_employee
WHERE emp_name LIKE ('%하%');

-- 6

SELECT DISTINCT
    dept_code
    FROM tbl_employee
ORDER BY dept_code;

-- 7

SELECT
    emp_id,
    emp_name,
    salary
    FROM tbl_employee
ORDER BY salary , emp_id ASC
LIMIT 5;

-- 8

SELECT
    emp_id,
    emp_name,
    dept_code,
    hire_date
    FROM tbl_employee
WHERE (dept_code = 'D5' OR dept_code ='D9')
AND hire_date > '2000-01-01'
ORDER BY  hire_date;

-- 9

select DISTINCT

    job_code
    from tbl_employee
where bonus IS NOT NULL
ORDER BY job_code;

-- 10

SELECT
    emp_id,
    emp_name,
    salary
    FROM tbl_employee
WHERE ent_date IS NULL
ORDER BY salary ASC , emp_id ASC
LIMIT 3 OFFSET 3; -- LIMIT 3, 3이라고 해도 됨.








