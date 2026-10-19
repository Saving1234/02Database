create table member_tbl
(
    memberId int
);

ALTER TABLE member_tbl
    ADD COLUMN name varchar(200) not null;
ALTER TABLE member_tbl
    ADD COLUMN age int not null;
ALTER TABLE member_tbl
    ADD COLUMN phone varchar(400) not null;

select *
from member_tbl;

ALTER TABLE member_tbl
    MODIFY COLUMN memberId INT NOT NULL;
ALTER TABLE member_tbl
    MODIFY COLUMN memberId INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE member_tbl RENAME COLUMN memberId to memberid;
ALTER TABLE member_tbl
    MODIFY COLUMN phone varchar(200) UNIQUE KEY;
ALTER TABLE member_tbl
    MODIFY COLUMN phone varchar(200) not null;


CREATE TABLE membership_tbl
(
    membership_id int
);

ALTER TABLE membership_tbl
    ADD COLUMN member_id int;
ALTER TABLE membership_tbl

    ADD COLUMN ott_type   varchar(230),
    ADD COLUMN plan_name  varchar(350),
    ADD COLUMN enrollDate DATE,
    ADD COLUMN expiryDate DATE,
    ADD COLUMN active     BOOLEAN;

ALTER TABLE membership_tbl
    DROP PRIMARY KEY;

DESCRIBE member_tbl;

ALTER TABLE membership_tbl
    MODIFY column member_id int not null primary key;
ALTER TABLE membership_tbl
    ADD Constraint member_id foreign key (member_id)
        REFERENCES member_tbl (memberid);

#     MODIFY column member_id int fore ;

DESCRIBE membership_tbl;
ALTER TABLE tb2
    MODIFY COLUMN change_fk INT;

DROP TABLE membership_tbl;


CREATE TABLE membership_tbl
(

    membership_id int PRIMARY KEY ,
    member_id     int,
    ott_type      varchar(350) NOT NULL ,
    plan_name     varchar(300) NOT NULL ,
    enrol_date    date not null ,
    expiry_date   date,
    active        BOOLEAN default true  NOT NULL ,
    FOREIGN KEY (member_id) REFERENCES member_tbl(memberid)
)
;


# - membershipId 는 PK이며 auto_increment
# - memberId 는 외래키로 Member 테이블의 PK를 참조한다.
# - ottType과 planName은 null 이면 안된다.
# - enrollDate 의 기본값은 데이터가 입력된 시점이고 null 이면 안된다.
# - active는 기본값이 True 이고 null 이면 안된다.


DESCRIBE member_tbl;
DESCRIBE membership_tbl;

CREATE TABLE Roll_Model ( model_id int, actor VARCHAR(40), writer VARCHAR(40), winter DATE );



ALTER TABLE member_tbl MODIFY COLUMN age INT NOT NULL;




# // OTT 멤버십 데이터
# public class Membership {
#
#     private int membershipId;
# private int memberId;
# private String ottType;
# private String planName;
# private LocalDateTime enrollDate;
# private LocalDateTime expiryDate;
# private boolean active;





#     // 회원 데이터
#     public class Member {
#
#     private int memberId;
# private String name;
# private int age;
# private String phone;
#
# }

#     ALTER TABLE tb2
#     ADD COLUMN col2 int not null default 0;