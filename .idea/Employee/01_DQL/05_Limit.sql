 -- Limit
 -- 조회할 행의 갯수를 제한할 때 사용
 -- LIMIT (갯수) : 처음부터 지정한 갯수만큼 조회
 -- LIMIT (시작위치), (갯수) : 시작위치부터 지정한 갯수만큼 조회.

 SELECT
     menu_name,
     menu_price,
     menu_code

     FROM tbl_menu
 ORDER BY

     menu_price;

-- LIMIT으로 지정한 갯수만큼 조회하려면 정렬을 한 상태여야함.
-- 뒤부터 조회할지, 앞부터 조회할지 정해야하니까.

 SELECT
     menu_name,
     menu_price,
     menu_code

 FROM tbl_menu
 ORDER BY

     menu_price
 LIMIT 5;

 SELECT
     menu_name,
     menu_price,
     menu_code

 FROM tbl_menu
 ORDER BY

     menu_price
 LIMIT 1,4;


