-- view
-- select 문을 이름과 함께 저장해서 테이블처럼 사용하는 가상테이블.

-- 장점
-- 복잡한 select 문을 단순하게 재사용 가능하다.
--  사용자에게 필요한 컬럼과 행만 공개할 수 있다.



create view hansik as  -- view 이름 만들어주고 as 후에 select.
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
    from tbl_menu
where category_code =4
with check option; -- view로 입력, 수정을 한 것을  행이 view의 where 조건을 만족하도록 검사. -- 조회 목적으로 만듬.

select * from hansik;

insert into tbl_menu(menu_name, menu_price, category_code, orderable_status)
values ('뷰확인용 닭칼국수 김밥', 5000, 4, 'Y');

-- 마지막에 넣었던 뷰 값을 출력을 해준다?
SET @menu_code = LAST_INSERT_ID();


-- 37번인줄알고 들어가봤는데, 아니였음.

SELECT * FROM  hansik WHERE menu_code =37;

DELETE FROM tbl_menu WHERE menu_code = 37;

SELECT * FROM tbl_menu WHERE menu_name = '뷰확인용 닭칼국수 김밥';



insert into hansik(menu_name, menu_price, category_code, orderable_status)
values ('뷰확인용 닭칼국수 김', 5000, 4, 'Y');


-- with check option으로 view의 where절의 조건을 만족하지 못해 생성 불가
-- 근데 나는 with 그것을 하지 못해서 생성됨.
insert into hansik(menu_name, menu_price, category_code, orderable_status)
values ('뷰확인용 락토핏 에이드', 5000, 5, 'Y');


SELECT * FROM  hansik;


SET @menu_code = LAST_INSERT_ID();

select * from hansik where menu_code = @menu_code;

select * from tbl_menu where menu_code = @menu_code;

-- DML 문이 재현되는 VIEW
-- DISTINCT, GROUO BY (HAVING), 집계 함수, UNION, 계산식, 여러 테이블을 조인했을 경우
-- (다양한 상황. VIEW를 어떻게 정의 했느냐, VIEW에서 어떤 컬럼을 변경하려고 하느냐) 이런 상황에 따라 달라짐.



CREATE VIEW category_menu_summary AS
SELECT
    category_code,
    COUNT(*) AS menu_count,
    FLOOR(AVG(menu_price)) AS avg_price
FROM
    tbl_menu
GROUP BY
    category_code;

UPDATE  category_menu_summary SET avg_price = 10000 WHERE category_code =4;
-- 집계결과에 대해선 업데이트 할 수 없음. WHY?? -- 이런
-- VIEW는 조회하기 위해서 많이 쓰임. 정확한 용도는?


-- 재정의는 OR REPLACE로.!!

SELECT *FROM hansik;


create OR REPLACE view hansik as  -- view 이름 만들어주고 as 후에 select.
select
    A.menu_code,
    A.menu_name,
    TRUNCATE(A.menu_price/1000,1),
    B.category_code
from tbl_menu A JOIN tbl_category B
ON A.category_code = B.category_code
WHERE B.category_code=4; -- view로 입력, 수정을 한 것을  행이 view의 where 조건을 만족하도록 검사. -- 조회 목적으로 만듬.

select * from hansik;

-- 삭제

DROP VIEW IF EXISTS category_menu_summary;

# SELECT * FROM category_menu_summary;

-- view 어디있는지 조회하기.
SHOW FULL TABLES
WHERE Table_type = 'VIEW';








