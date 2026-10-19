-- DISTINCT : 조회한 결과에서 중복된 행을 제거할 때 사용.
-- 여러 컬럼을 조회하면 컬럼 값의 중복비율 기준으로 중복을 판단.
-- 중복 제거.

USE menudb;
SELECT
    category_code
FROM menudb.tbl_menu;

SELECT
   distinct category_code
FROM menudb.tbl_menu; -- 중복된 값 제거

select
    tbl_category.ref_category_code
from tbl_category;

select
  distinct  tbl_category.ref_category_code
from tbl_category; -- null도 중복 제거가 됨.

-- category와 orderable이 같은 경우 중복 제거.

SELECT distinct
    category_code,
    orderable_status
FROM menudb.tbl_menu
order by category_code;

SELECT distinct
    category_code,
    orderable_status
FROM menudb.tbl_menu
order by category_code; -- 궁금.