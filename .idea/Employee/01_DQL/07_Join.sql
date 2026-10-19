-- join
-- 관련 컬럼을 기준으로 여러 테이블의 데이터를 조회할 때 사용

-- join 종류
-- INNER JOIN : 양쪽 테이블에 모두 존재하는 데이터 행만 조회.
-- LEFT/RIGHT JOIN : 기준 테이블의 일치하지 않는 데이터(행)도 포함

-- INNER JOIN은
-- INNER 생략 가능.

SELECT a.menu_name, b.category_code
fROM tbl_menu a
         INNER JOIN tbl_category b
                    on a.category_code = b.category_code;
-- on 뒤에 조건이 온다.

-- SELECT a.menu_name, b.category_code fROM  tbl_menu a
 -- INNER JOIN tbl_category b
                                                        --  on a.category_code = b.category_code;
-- on 뒤에 조건이 온다.


-- LEFT JOIN
-- tbl_ category에 있는 모든 카테고리를 출력하고,
-- tbl_menu에도 같은 카테고리코드가 있으면 해당 메뉴이름을 출력한다.
-- 이건 ai에게 묻기.
SELECT a.category_name, b.menu_name
fROM menudb.tbl_category a
         LEFT JOIN tbl_menu b
                    on a.category_code = b.category_code;


SELECT a.category_name, b.menu_name
fROM menudb.tbl_category a
         RIGHT JOIN tbl_menu b
                   on a.category_code = b.category_code;

-- 이해안됨.
-- 왜 오른쪽을 더 출력했는데, 왼쪽 것에 오른쪽이 나오는지.
-- 조건은 a의 카테고리 코드와 b의 카테고리 코드가 같다.

SELECT a.menu_name, b.category_name
fROM tbl_menu a
         RIGHT JOIN tbl_category b
                    on a.category_code = b.category_code;

-- A 기준으로 A의 한 행이  B의 모든 행에 접근하여 조회.
SELECT a.menu_name, b.category_name
fROM tbl_menu a
         CROSS JOIN tbl_category b;



-- using(비교할 컬럼명)
-- 같은 이름의 컬럼을 연결하는데 같을 수도 있고, 다를 수도 있음.
-- 같은 걸 위주로 하긴 함.

SELECT a.menu_name, b.category_name
fROM tbl_menu a
         JOIN tbl_category b
USING (category_code);

-- self join
-- 자신의 테이블을 자신이 조인함.??

-- categorycode보면 1 식사 2 음료 3 디저트 인데 1~3에 null로 값을 비우고, 그 아래에 4한식 등에 1,2,3을 컬럼명 (상위) 하나 넣어서 카테고리를 만든다.

select
    a.category_code,
    b.category_name
from tbl_category a
join tbl_category b
on a.ref_category_code = b.category_code;

