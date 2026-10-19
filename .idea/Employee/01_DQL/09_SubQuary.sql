-- subquery
-- 다른 sql 문 안에 작성하는 select 문.
-- 서브쿼리의 결과를 메인 쿼리의 조건이나 조회 대상으로 사용.
-- from 절에 서브쿼리를 작성할 경우에는 as를 꼭 써야 함!


SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu

WHERE category_code = (SELECT category_code
                       FROM tbl_menu
                       WHERE menu_name = '민트미역국');
-- 다 조회하는데, 카테고리코드만 민트미역국의 코드로만 조회해라.

-- 메인쿼리가 동작하면서 서브쿼리가 동작. 상관쿼리.
-- 반대는 서브쿼리가 먼저 동작. 비상관쿼리.


select category_code
from tbl_menu
where menu_name = '민트미역국';

select *
from tbl_menu
where category_code = (SELECT category_code
                       FROM tbl_menu
                       WHERE menu_name = '민트미역국');

-- 다양한 위치에서 서브쿼리 활용
-- 1. select 절 : 스칼라 서브쿼리.
-- 한 행, 한 컬럼의 값을 반환하며 조회의 결과를 컬럼처럼 사용

-- 상관쿼리. selct

select a.menu_code,
       a.menu_name,
       a.menu_price,
       (select b.category_name
        from tbl_category b
        where b.category_code = a.category_code)


from tbl_menu a


-- from 절
-- 인라인 뷰 (파생테이블)
--  서브쿼리의 조회 결과를 하나의 테이블처럼 사용. 별칭을 꼭 지정.


select x.category_code,
       x.menu_count,
       x.`floor(avg(menu_price))`

from (select category_code, count(*) as menu_count, floor(avg(menu_price))
      from tbl_menu
      group by category_code) as x;

-- where. 가격은  menu price 평균보다 높은 가격만 조회.

select menu_code,
       menu_name,
       menu_price
from tbl_menu
where menu_price > (select avg(menu_price)
                    from tbl_menu);


-- having
-- 그룹바이의 조건.
-- 집계한 결과에서의 평균가격이 , 메뉴 가격의 평균보다 높은 것만 보여줘라.

select category_code,
       floor(avg(menu_price)) as avg_price
from tbl_menu
group by category_code
having avg(menu_price) > (select avg(menu_price) from tbl_menu);


-- 상관 서브쿼리.
-- 내부 쿼리가 외부 쿼리의 값을 참조하는 형태.

-- 카테고리별로 평균 가격보다 높으느 가격의 메뉴조회.

SELECT menu_code, menu_name, menu_price, category_code, orderable_status

FROM tbl_menu a
where menu_price > (select avg(menu_price)
                    from tbl_menu
                    where category_code = a.category_code)
-- 카테고리와 같은 것 중 메뉴 평균을 매긴 것이 메뉴 가격이 더 크면 메뉴 코드 등 출력.


-- exists()
-- 서브쿼리의 조회결과가 있으면 true
-- 없으면 false

select category_name,
       category_code
       from tbl_category a
where
    exists((
        select 1 from tbl_menu  b
                               where b.category_code = a.category_code
    ));

-- common table expression
-- from절에 써놓았던 것처럼
-- 파생테이블과 비슷한 개념. 쿼리 가독성과 재사용성을 위해.

select category_name,
       category_name
from tbl_menu a join tbl_category b
on a.category_code = b.category_code;

-- CTE

with  menucate as (

    select menu_name,
           category_name
    from tbl_menu a
        join tbl_category b
                         on a.category_code = b.category_code)

-- 지정했던 테이블 명.
select * from menucate
 order by menu_name

