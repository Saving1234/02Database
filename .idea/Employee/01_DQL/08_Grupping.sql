#  집계

-- GROUP BY
-- 같은 값을 가진 행을 하나의 그룹으로 묶을 때.
-- 통계, 집계를 계상할 때 사용
-- HAVING : 그룹화 한 이후에 결과를 필터링.
-- WHERE : 그룹화를 하기 전에 데이터를 필터링.

-- 같은 값을 묶고 싶다.
-- 카운트. 몇 번썼는지.


SELECT category_code,
       count(*)
FROM tbl_menu
group by category_code;

# 합치기


SELECT category_code,
       count(*),
       sum(menu_price),
       avg(menu_price)
FROM tbl_menu
group by category_code;

-- having

-- 그룹핑을 한 이후에 조건을 작성할 때 사용.

select category_code

from tbl_menu
group by category_code
having category_code between 5 and 8;
-- 5~8번까지.

-- rollup
-- 각 그룹에 대한 소계나 총계를 계산하여 resultset에 포함해준다.
-- 다형성같은?? tbl ㅊㅁ

SELECT category_code,

       sum(menu_price)

FROM tbl_menu
group by category_code with rollup; -- 총합도 출력됨. 코드의 메뉴들의 합.

SELECT menu_price, category_code,
    count(*),
       sum(menu_price)

from tbl_menu
group by menu_price, category_code  with rollup order by  category_code asc ;
-- 먼저나온 메뉴의 합을 더하고, 지금까지 나온 동일메뉴의 총합도 더해서 보여줌. (rollup 특성. 오른쪽의 값을 제거하면서 총합을 보여줌.)
-- rollup은 총합을 나타내는 것이기에, sum에 대해서만 작용. count는 rollup에 따라,(sum)에 들어간 것을 기준으로 카운트를 보여줌.
-- 질문. rollup이 안나옴.
