-- INDEX
-- 테이블에서 원하는 행을 빠르게 찾기 위해 사용하는 데이터베이스 객체
-- UNIQUE 값이기 때문에 빨리 찾아진다???
DROP TABLE IF EXISTS phone;

CREATE TABLE phone
(
    phone_code  INT,
    phone_name  VARCHAR(100)   NOT NULL,
    phone_price DECIMAL(10, 2) NOT NULL,
    company     VARCHAR(30)    NOT NULL,
    CONSTRAINT pk PRIMARY KEY (phone_code)
);


INSERT INTO phone (phone_code, phone_name, phone_price, company)
VALUES (1, 'GalaxyS26', 1250000, 'Samsung'),
       (2, 'iPhone17', 1580000, 'Apple'),
       (3, 'GalaxyFold8', 2300000, 'Samsung'),
       (4, 'GalaxyS26Ultra', 1850000, 'Samsung'),
       (5, 'iPhone17Ultra', 1980000, 'Apple'),
       (6, 'GalaxyZFold8Ultra', 1800000, 'Samsung'),
       (7, 'Pixel11', 1350000, 'Google'),
       (8, 'Pixel11Pro', 1650000, 'Google');

select *
from phone;

-- 폰의 인덱스를 보여달라.

show index from phone;

-- EXPLAIN
-- SELECT가 어떻게 실행될지 옵티마이저가 세운 게획을 보여줌.
-- 옵티마이저란???
-- SQL문을 가장 효율적으로 실행할 방법을 선택하는 MYSQL 내부 기능.

EXPLAIN
SELECT *
FROM phone
WHERE phone_name = 'Galaxy';
-- TYPE.. 데이터를 어떻게 스캔할지 본다. ALL == 전체 데이터를 스캔하는 것이 됨.
-- POSSIBLE KEY ㅏ용할 수 있는 인덱스 후보.
-- KEY 선택할 수 있는 후보.
-- ROWS : 읽을 것으로 예상되는 행의 수.
-- FILTERED : 조건을 통과할 것 같은 행의 수.


-- 단일컬럼 인덱스
-- 하나의 컬럼으로 구성한 인덱스.

CREATE INDEX idx_phone_name -- keyname
    on phone (phone_name); -- 관련있는 컬럼은 폰 네임으로 만들겠다.

show index from phone;

-- 인덱스 고려할만한 컬럼 (PK, ) ?? 질문 또는 찾아보기
-- WHERE 조건에 자주 사용하는 컬럼
-- JOIN 조건에 자주 사용하는 컬럼
-- ORDER BY, GROUP BY에 자주 사용하는 컬럼
-- 값의 종류가 충분히 다양해 많은 행을 거를 수 있는 컬럼

-- 데이터가 많아질 수록 인덱스로 받을 데이터 양이 많아짐.
-- 옵티마이저가 판단하는 것에 따라 달라짐.
-- 그래서 강제로 시키는 방법도 있음.

EXPLAIN
SELECT *
FROM phone FORCE INDEX (idx_phone_name)
WHERE phone_name = 'Galaxy';

-- 복합 인덱스
-- 두개 이상의 컬럼을 순서대로 묶어 만든 인덱스
-- PHONE NAME, PHONE PRICE를 먹는다고 했을 때 앞은 인덱스로서 활용. 뒤는 똑같이 연산되어 나오기 때문에 효율이 좋지 않다???
-- 1. PHONE_NAME만 사용하는 조건
-- 2. PONE_NAME, PHONE_PRICE를 함께 사용하는 조건일 경우 사용하기 좋다.

DROP  INDEX idx_phone_name on phone;

show index from phone;

create index idx_phone_name on phone (phone_name, phone_price);



show index from phone;

explain
select * from phone where phone_name = 'iPhone17';

explain
select * from phone where phone_price = 185000;  -- 뒤에 있는 것은 타입을 효율적으로 실행?시키지 못하기 때문에 all로?
-- extra = using where 위치를 찾는다


explain
select  phone_name, phone_price

from phone where phone_name = 'iPhone17';
-- extra가 바뀜. using index -- 커버링 인덱스. 필요한 인덱스가 모두 있으면 테이블 행을 추가로 읽지 않는다.

-- 안에 있는 데이터가 많이 수정되다보면 통계를 갱신할 필요가 있다.
analyze table phone;
-- 테이블공간을 재구성. 정렬?
optimize table phone;