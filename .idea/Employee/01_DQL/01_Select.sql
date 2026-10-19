-- 회사에 따라서 sql 대/소문자로 쓰는게 갈림.

-- SELECT menu_name FROM tbl_menu;
-- 테이블에서 한줄씩 데이터로 읽음.

-- SELECT (조회할 컬럼) FROM 테이블명
SELECT * FROM tbl_menu;
SELECT menu_name FROM tbl_menu;
SELECT * FROM tbl_menu; -- 테이블 메뉴의 모든 컬럼을 조회하겠다.

SELECT
    menu_code as 코드,
    menu_name as 이름,
    menu_price
FROM tbl_menu;

SELECT 5+5; -- 연산도 가능. -- 출력이라.

    -- as 별칭만들기.

-- 내장함수. 시간.
SELECT now() as time; -- 결과 컬럼명을 설정. 타임으로. 별칭만들기.

-- 내장함수. 합쳐서 넣으라는.
SELECT concat('8', 'ear') as name;

-- 정렬


select * columns from

