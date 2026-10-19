-- DDL (DATA DEFI)
-- 데이터베이스의 구조를 생성, 변경, 초기화, 삭제 할 때 사용
-- CREATE : 새로운 객체 생성. 테이블, 데이터베이스 등
-- ALTER : 기존 객체 변경
-- TRUNCATE : 테이블 구조 유지, 모든 행 삭제
-- DROP : 객체의 구조와 데이터 모두 삭제.

-- IF NOT EXISTS 이것은 기존 테이블이 있는지 확인한 후에 없으면 만들어줌.

create table IF NOT EXISTS tb1
(
    pk   int,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
);

describe tb1; -- 테이블 조회? 테이블 컬럼 속성이 무엇인지.

insert into tb1
values (1, 10, 'Y');

SELECT *
from tb1;

-- tb2

-- auto_increament : 행을 추가할 떄 자동으로 번호를 생성해주는 기능 -- 값이 계속 추가됨.
-- PRIMARY KEY 또는 UNIQUE KEY가 설정된 컬럼에 사용 -- 데이터 고유의 번호.

create table IF NOT EXISTS tb2
(
    pk   INT auto_increament primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
);


describe tb2;

insert into tb2(fk, col1)
values (10, 'Y'),
       (10, 'N'); -- 테이블에 ()치고 그 안에 컬럼 넣으면, 이것만 넣겠다는 뜻?

SELECT *
FROM tb2;

-- 수정

-- 컬럼추가
ALTER TABLE tb2
    ADD COLUMN col2 int not null default 0; -- 이 컬럼 추가,

describe tb2;

-- 삭제

ALTER TABLE tb2
    DROP COLUMN col2;

describe tb2;

-- 컬럼 수정
-- 이름, 컬럼정의(타입, 제약조건)
-- CHANGE COLUMN : 다 수정.

-- 이름바꾸면서 타입도 변경.

ALTER TABLE tb2
    CHANGE COLUMN fk change_fk BIGINT NOT NULL;

DESCRIBE tb2;

-- 타입만 변경

ALTER TABLE tb2
    MODIFY COLUMN change_fk INT;

DESCRIBE tb2;


-- 이르만 변경


ALTER TABLE tb2 RENAME COLUMN FK TO change_fk;

DESCRIBE tb2;

-- PRIMARY KEY 제약조건 삭제 및 추가

-- AUTOINCREAMENT 컬럼 : KEY 추가가 되어있어야함.

ALTER TABLE tb2
    MODIFY COLUMN pk INT NOT NULL;

ALTER TABLE tb2
    DROP PRIMARY KEY; -- 삭제하려면 본래 가지고 있던 속성들과 같아야 삭제가 가능?

DESCRIBE tb2;

ALTER TABLE tb2
    ADD PRIMARY KEY (pk);
DESCRIBE tb2;

ALTER TABLE tb2
    MODIFY COLUMN pk INT NOT NULL auto_increment; -- modify로 수정한다고 선언. auto_increament도 넣는다고 수정이 됨.

DESCRIBE tb2;

-- 삭제할 테이블 추가.

create table IF NOT EXISTS tb2
(
    pk   INT auto_increment primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
)
    COMMENT '좋은 DB';

create table IF NOT EXISTS tb3
(
    pk   INT auto_increment primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
)
    COMMENT '삭제할 DB입니다';


-- 테이블 만들 때 엔진. 엔진 (INNODB) , INNODB : 트렌젝션, 장애복구, 외래 키 이런 기능을 제공하는 엔진.  개발할 땐 필수. CSV를 엔진에 넣어서 사용하기도 한다.
--  MyISAM 도 예전에 있었음.

drop table if exists tb3; -- 계속 반복되서 실행할 때 문제가 생길 수도 있어서. 많은 양의 데이터를 실행할 때 이미 되어있는 것을 또 한 번하면 컴파일 에러가 뜨니, 문제된 것을 찾아 수정하는것이 더 어려워짐.

DESCRIBE tb2;

-- 더미데이터 미리 만들어 스크립트 작성하기도 함.


create table IF NOT EXISTS tb3
(
    pk   INT auto_increment primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
)
    COMMENT '좋은 DB';

create table IF NOT EXISTS tb4
(
    pk   INT auto_increment primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
)
    COMMENT '삭제할 DB입니다';

create table IF NOT EXISTS tb5
(
    pk   INT auto_increment primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
)
    COMMENT '좋은 DB';

drop table if exists tb3, tb4, tb5;
-- if exist 하면 세개 다 삭제

-- truncate
-- 테이블 구조는 유지하면서 모든 행(데이터)은 전부 삭제.
-- Auto_increament 넣고 3 삭제하면 그 자리에 4가 올라옴.
-- Auto_increament 값도 초기화 됨.


create table IF NOT EXISTS tb3
(
    pk   INT auto_increment primary key,
    fk   int,
    coll varchar(255),
    check ( coll in ('Y', 'N') )
)
    COMMENT '좋은 DB';

insert into tb3 (fk, coll) values (10, 'Y'), (20, 'Y'),(30, 'Y'),(40, 'Y');

SELECT * FROM tb3;

DELETE FROM tb3 WHERE PK = 5;

insert into tb3 (fk, coll) values (10, 'Y');

SELECT * FROM tb3;

TRUNCATE  TABLE tb3;

SELECT * FROM tb3;

DESCRIBE tb3;

-- DELETE : 선택한 행 삭제하기 위해
-- TRUNCATE : 테이블 구조 초기화하여 행 삭제하기 위해 사용
-- DROP : 모든 행과 모든 구조 삭제.