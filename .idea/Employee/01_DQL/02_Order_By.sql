    -- Order By
    -- 특정 컬럼이나 값을 기준으로 조회 결과 정렬할 때 사용
    --  ASC : 오름차순 (생략가능) , DESC  내림차순


    SELECT
        menu_name,
        menu_code,
        menu_price
    FROM tbl_menu
  ORDER BY
      menu_name DESC ;


    SELECT
        menu_name,
        menu_code,
        menu_price
    FROM tbl_menu
    ORDER BY
        menu_price DESC,
        menu_name ASC;

-- menu_code, 이름, 가격 조회
-- 가격 1000원 단위로 보여주세요.

    SELECT
        menu_name,
        menu_code,
        menu_price/1000 as menu_price천원단위
    FROM tbl_menu
    ORDER BY
        menu_price천원단위;

-- 내장함수.
-- 첫번째 인자는 조건.첫번째 인자가 몇번째 위치에 있는지 반환.
select field('A', 'A', 'B', 'C');
select field('B', 'A', 'B', 'C');

SELECT *
from
    tbl_menu
order by
    field(orderable_status, 'N', 'Y'); -- 이해 못함. 정렬을 어떤식으로 하게되는지.

