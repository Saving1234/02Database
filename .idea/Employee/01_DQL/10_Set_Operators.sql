-- SET
-- 단순함.
-- 여러 SELECT 결과를 결합할 때 사용.
-- 컬럼의 갯수와 같은 위치의 @@데이터 타입@@이 호환되어야 함. (이름 일치가 아님.)
-- UNIION : 중복제거
-- UNION ALL : 중복 유지

SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status

FROM tbl_menu
where category_code = 10


UNION
-- 위 아래 합쳐줌. 중복없이.

SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status

FROM tbl_menu
where menu_price < 9000;



SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status

FROM tbl_menu
where category_code = 10


UNION ALL
-- 위 아래 합쳐줌. 중복있게.

SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status

FROM tbl_menu
where menu_price < 9000;
-- MINUS 라고 차집합이 MYSQL에는 없다
-- 전체적인 테이블.
-- 합쳐서 무엇인가를 보고싶을 때.

-- 교집합


SELECT a.menu_code,
       a.menu_name,
       a.menu_price,
       a.category_code,
       a.orderable_status

FROM tbl_menu a

         join (SELECT menu_code,
                      menu_name,
                      menu_price,
                      category_code,
                      orderable_status

               FROM tbl_menu
               WHERE menu_price < 9000) b on (a.menu_code = b.menu_code);



