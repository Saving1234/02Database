-- DML DATA Mainpulation Language
-- 테이블의 데이터를 추가, 수정, 삭제, 조회(DQL) 할 때 사용

-- INSERT : 데이터추가
INSERT INTO tbl_menu
VALUES (null, '바나나해장국', 8500, 4, 'Y');

-- NULL 값이 가능하거나 AUTO_INCREAMENT가 있는 컬럼을 제외하고, INSERT 하고 싶은 데이터칼럼을 지정해서 INSERT할 수 있다.

# INSERT INTO tbl_menu
# VALUES (8500, '바나나해장국', 4, 'Y'),
#        (8500, '바나나해장국', 4, 'Y'),
#               (8500, '바나나해장국', 4, 'Y');

-- UPDATE : 데이터 수정
-- 안에 있는 값을 써서 수정.
-- UPDATE, 테이블명, SET, 바꿀 대상, WHERE 조건. 어디쪽을.

    UPDATE tbl_menu SET
                        orderable_status = 'Y',
                        menu_name = '아이스 아메리카노'
    WHERE menu_code = 35;

-- DELETE : 데이터 삭제

DELETE FROM tbl_menu WHERE menu_code = 37;

# INSERT INTO tbl_menu
# VALUES (37, '돼지고기', )

-- 가격이 가장 저렴한 ㅔ뉴 2가지 삭제.

-- 가격 기준 정렬. 오름차순으로 하면 가장 싼게 위에 있으니까.
-- WHERE조건이 명확해야함. 명확하지 않으면 SAFE MODE로 안사라짐.

DELETE FROM tbl_menu ORDER BY menu_price
LIMIT 2;

DELETE  FROM tbl_menu WHERE  menu_code IN (SELECT menu_code FROM(SELECT menu_code
                                                                 FROM tbl_menu
                                                                 ORDER BY  menu_price
                                                                 LIMIT 2)
                                                            AS taget_menu);

-- DELETE  FROM tbl_menu; 다 지우는 것.

-- REPLACE
-- 데이터를 입력할 때 중복된 데이터는 덮어 쓸 수 있도록 하는 것.
-- INTO 지우고 써도 무방함.

REPLACE INTO tbl_menu
VALUES (1, '스페셜 쥐 꼬리 감자 그라탕', 11500, 4, 'Y');