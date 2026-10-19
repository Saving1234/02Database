-- 제약조건.
-- 테이블에 잘못된 정보가 들어가지 않도록 컬럼에 규칙을 정한다.
-- 컬럼 단위(레벨) : 컬럼 선언 바로 뒤(옆)에 제약조건 작성
-- 테이블 레벨 : 모든 컬럼 선언 뒤)(에 제약조건 작성.
-- 복합키나 제약조건 이름 명시할 때는 테이블레벨 정의를 쓴다.

-- not null : null 저장 방지.
-- unique : 중복값 저장 방지.
-- primarykey : 행의 고유 식별자(컬럼) 결정 notnull, unique설정


drop table if exists user_notnull;


-- 방법 2: 테이블 레벨 (제약조건 이름을 직접 줄 때)
CREATE TABLE user_notnull (
                              user_no   INT,
                              user_id   VARCHAR(255) NOT NULL,
                              user_pwd  VARCHAR(255) NOT NULL,
                              user_name VARCHAR(255) NOT NULL,
                              gender    VARCHAR(3),
                              phone     VARCHAR(255) NOT NULL,
                              email     VARCHAR(255),
                              CONSTRAINT pk_user_no PRIMARY KEY (user_no)
);

INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name,gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');


INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name,gender, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5638', 'hong123@gmail.com');

INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '010-1234-5678', 'hong123@gmail.com');

-- 외래키
-- foreign key
-- 자식테이블의 foreging key에는 부모테이블에 존재하는 값만 저장 가능.
-- 부모테이블의 참조 대상컬럼은 primary key 또는 유니크 키이여야한다.

CREATE TABLE if not exists user_fk_tble
(user_no int, user_id varchar(50) not null, user_name varchar(50) not null, grade_code int, constraint foreign key (grade_code)
    references user_grade (grade_code)); -- 부모것이 있어야 만들 수 있음. -- 참조할 대상이 있어야 만들 수 있음.

create table user_grade  -- 부모테이블?
( grade_code int primary key, grade_name varchar(50) not null);


insert into user_grade values
                           (10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

-- 참조무결성
-- 자식 테이블의 foreign key에는 부모 테이블에 존재하는 값만 저장 가능.

insert into user_fk_tble values (1, 'user01', '홍길동', 10);
insert into user_fk_tble values (2, 'user02', '유관순', 20);

insert into user_fk_tble values (1, 'user01', '홍길동', 10);
insert into user_fk_tble values (2, 'user02', '유관순', 20);

delete from user_fk_tble where user_no =1;

-- 자식이 참조중인 부모행은 바로 삭제가 불가능.
delete from user_grade where grade_code =10;




-- RESTRICT : 자식이 참조중이면 부모의 수정 - 삭제를 거부.
-- CASCADE : 부모의 변경을 자식에도 반영   --
-- SET NULL : 부모가 수정, 삭제되면 자식의 외래키를 NULL로 변경.  -- NULL로 바꾸기 때문에 기존의 데이터를 없앤다.
-- check : 값의 조건 검사(조건이 true여야 값을 저장한다.)

create table user_fk_table
(
    user_no int primary key ,
    user_id varchar(50) not null ,
    user_name varchar(50) not null,
    grade_code int null,
    constraint foreign key (grade_code) references user_grade (grade_code)
    on update set null  -- 부모가 수정되면 외래키를 null로 변경
    on delete set null  -- 부모가 삭제되면 외래키를 null로 변경 -- null로 변경할거면
);

create table user_grade
(
    grade_code int primary key,
    grade_name varchar(50) not null
);

insert into user_grade
values
    (10, '일반회원');

-- 참조 무결성
-- 자식 테이블의 foreign key에는 부모 테이블에 존재하는 값만 저장 가능
insert into user_fk_table
values
    (1, 'user01', '홍길동', 10),
    (2, 'user02', '유관순', 20);


--

update user_grade set grade_code =11
where grade_code = 10;

delete from user_grade where grade_code = 20;

select * from user_grade;
select * from user_fk_table;


-- cashcade : 부모가 바뀌면 자식도 바껴서 들어간다.




create table user_fk_table2
(
    user_no int primary key ,
    user_id varchar(50) not null ,
    user_name varchar(50) not null,
    grade_code int null,
    constraint foreign key (grade_code)
        references user_grade2 (grade_code)
        on update cascade -- 부모의 키가 변경되면 자식의 외래키도 변경
        on delete cascade -- 부모가 삭제되면 자식의 행도 삭제
);

create table user_grade2
(
    grade_code int primary key,
    grade_name varchar(50) not null
);

insert into user_grade2 values
                            (10, '일반회원'),
                            (20, '우수회원'),
                            (30, '특별회원');

insert into user_fk_table2
values
    (1, 'user01', '홍길동', 10),
    (2, 'user02', '유관순', 20);

-- grade_code 10 -> 11 로 변경
-- 데이터를 지울건지, 수정할건지.
update user_grade2
set grade_code = 11
where grade_code = 10;

delete from user_grade2
where grade_code = 20;

select * from user_grade2;
select * from user_fk_table2;


-- 체크

-- check : 값의 조건 검사(조건이 true여야 값을 저장한다.)
-- default : 기본값 설정

drop table user_check;

create table user_check
(
    user_no int primary key ,
    user_name varchar(50) not null,
    gender varchar(3),
    age int default 19,
    constraint ck check ( gender in ('남', '여') ),
    constraint ck2 check ( age >= 19 )
);


insert into  user_check  (user_no, user_name, gender) values (1, '홍길동', '남');

select * from user_check;

