-- WHERE
-- 조건에 맞는 행만 조회할 때 사용.
-- BETWEEN, IN, LIKE.

SELECT tbl_menu.menu_name,
       tbl_menu.menu_price,
       tbl_menu.orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y';

-- 조건식.

SELECT menu_name,
       menu_price
FROM tbl_menu
WHERE menu_price = 13000;


SELECT menu_name,
       menu_price
FROM tbl_menu
WHERE menu_price < 13000;

SELECT menu_name,
       menu_price
FROM tbl_menu
WHERE menu_price != 13000;


-- 논리연산. AND, OR.

SELECT menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y'
   OR category_code = 10
ORDER BY menu_price;

-- 우선순위
-- OR/ AND 중에 AND가 먼저 수행됨.
-- () 쳐도 됨.

SELECT 1 AND 0; -- 1 true. 0 FALSE.

SELECT (1 OR 0) AND 0; -- AND가 먼저

SELECT menu_name,
       menu_price,
       category_code
FROM tbl_menu
WHERE menu_price >= 10000
  AND menu_price <= 25000
order by menu_price ASC;


-- between 연산자 쓰면 기호 안써도 됨.
-- not 부정 표현.

SELECT menu_name,
       menu_price,
       category_code
FROM tbl_menu
WHERE menu_price not between 10000 AND
          25000
order by menu_price ASC;

-- 연산자.

-- LIKE 연산자

-- _ : 딱 한글자
-- % : 글자수 제한 없음

SELECT menu_name
FROM tbl_menu
WHERE menu_name LIKE '%마늘%'; -- 중간에 마늘이 들어있는 메뉴 이름을 찾아라

SELECT menu_name
FROM tbl_menu
WHERE menu_name LIKE '_마늘%'; -- 앞에 어떤 한글자가 오고 '마늘'의 온 모든 이름을 찾아라

SELECT menu_name
FROM tbl_menu
WHERE menu_name LIKE '생%';
-- 앞에 '생'이 있는 온 모든 이름을 찾아라

-- IN 연산자;
-- 여러 값 중에 하나라도 일치하면 가져와라.
-- contains 같은.


SELECT tbl_menu.menu_name,
       tbl_menu.category_code
FROM tbl_menu
WHERE category_code IN (4, 5, 6);

SELECT tbl_menu.menu_name,
       tbl_menu.category_code
FROM tbl_menu
WHERE category_code not IN (4, 5, 6)
order by category_code;

-- null이 비어있음. 여기서도 null이 비어있는 것.

-- IS NULL : NULL 값을 확인하는 메서드? 쿼리.

SELECT
    tbl_category.category_name,
    tbl_category.category_code
FROM
    tbl_category
WHERE ref_category_code is null;

SELECT
    tbl_category.category_name,
    tbl_category.category_code
FROM
    tbl_category
WHERE ref_category_code is not null;



