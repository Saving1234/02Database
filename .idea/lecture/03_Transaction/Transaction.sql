select @@autocommit;

-- 비활성화
set autocommit =0;
set autocommit = off;

-- 활성화
set autocommit =1;
set autocommit = on;

-- 트렌젝션 범위 시작
start transaction;

insert into tbl_menu values (null, '바나나해장국', 8500, 4, 'Y');
update tbl_menu set menu_name = '수정된 메뉴' where menu_code =5;
delete from tbl_menu where menu_code = 1;

select * from tbl_menu where menu_code=5;

-- 하나의 트렌젝션으로 잡혀있어서 바뀌지 않음.
    -- 트렌젝션 범위에 잡혀있으면 커밋전까지 반영이 안됨.

commit; -- 변경사항 확정.
rollback; -- 아직 커밋되지 않은 내용을 취소할 때. 전으로 돌릴 때.

-- insert() , update, delete 이런 작업들을 트렌젝션으로 묶을 수 있다. -- 스프링부트에서.


