show databases;

use mysql;

#  계정 생성
use mysql;
-- 계정 생성은 mysql DB 에서 할 수 있다.
-- mysql 데이터베이스(시스템 데이터베이스)
-- 사용자 계정 및 권한, 타임존, 로그.... 등을 포함한 데이터베이스.

-- 계정생성문법
-- create user '사용자이름'@'접속가능한 위치' identified by '비밀번호'
-- 접속가능한 위치느느 ip 지정, 와일드카드(%) 어느 위치에서든 접속을 허용. localhost
create user 'kyc'@'%' identified by '1234';

-- database 스키마 생성.
create database menudb;

-- 데이터베이스 보기
show databases;

-- 권한 부여
-- grant  all privileges on (권한을줄데이터베이스).(권한을줄테이블) to (권한을줄계정)@'범위';
grant all privileges on menudb.* to 'kyc'@'%';
-- 해당 계정이 가지고 있는 권한 목록

-- slect 권한문 부여시
-- grant select on (권한을줄데이터베이스).(권한을줄테이블) to (권한을줄계정)@'범위';





