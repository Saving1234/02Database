SELECT a.emp_id,
       a.emp_name,
       a.job_code,
       b.job_code,
       b.job_name

FROM tbl_employee a
         INNER JOIN
     tbl_job b
ORDER BY a.emp_id;

SELECT a.emp_id,
       a.emp_name,
       a.dept_code,
       b.dept_id,
       b.dept_title

FROM tbl_employee a
         LEFT JOIN tbl_department b
                   on a.dept_code = b.dept_id
ORDER BY a.emp_id;

SELECT a.emp_name,
       a.bonus,
       a.dept_code,
       b.dept_id,
       b.dept_title,
       b.location_id,
       c.local_code,
       c.local_name

FROM tbl_employee a
         LEFT JOIN tbl_department b on a.dept_code = b.dept_id
         LEFT JOIN tbl_location c on b.location_id = c.local_code
where a.bonus IS NOT NULL;
