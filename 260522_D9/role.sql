--role  역할 
-- sys 계정에서 진행
--c## 제거 명령어
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; 
--사용자 생성 명령어
CREATE USER kim IDENTIFIED BY 1234; 
--접속할 수 있는 권한 부여 명령어
GRANT CREATE SESSION TO kim; 
--테이블 만들 수 있는 권한 부여 명령어
GRANT CREATE TABLE TO kim; 
--시퀀스 만들 수 있는 권한 부여 명령어
GRANT CREATE SEQUENCE TO kim; 
--view 만들 수 있는 권한 부여 명령어
GRANT CREATE VIEW TO kim; 
-- users tablespace에 데이터를 저장할 권한 부여하는 명령어
ALTER USER kim quota unlimited ON users; 

--사용자 생성 하면서 table space를 할당하는 명령어
--CREATE USER jang IDENTIFIED BY 1234
--DEFAULT TABLESPACE users quota unlimited ON users;

--role 권한을 묶어서 사용
DROP USER jang;
CREATE USER jang IDENTIFIED BY 1234;

ALTER USER jang quota unlimited ON users; 

GRANT CONNECT TO jang;

GRANT CREATE SESSION TO jang;
GRANT SET CONTAINER TO jang;
GRANT RESOURCE TO jang;  --resource 안
REVOKE RESOURCE FROM jang;
REVOKE CREATE TABLE FROM jang;


SELECT * FROM ROLE_SYS_PRIVS rsp WHERE ROLE='CONNECT';
SELECT * FROM ROLE_SYS_PRIVS rsp WHERE ROLE='RESOURCE';

CREATE ROLE  myrole;
GRANT CONNECT,RESOURCE,CREATE VIEW TO myrole;

CREATE USER hong IDENTIFIED BY 1234; 
GRANT myrole TO hong;
--GRANT dba TO hong;
DROP USER hong cascade;

--연결된 사용자 세션 강제 종료
SELECT sid, serial#, username FROM v$session WHERE username = 'HONG';
ALTER SYSTEM  KILL SESSION '304,5447';
ALTER SYSTEM  KILL SESSION '299,23350';


--sys계정에서 jang에게 scott.emp에 select권한 부여
GRANT SELECT ON scott.emp TO jang;

--scott계정에서 jang에게 scott.emp에 select권한 부여
GRANT SELECT ON emp TO jang;


commit;


-- sys에서 진행
--1. developer_role이라는 ROLE을 생성하시오.
SELECT * FROM dba_roles WHERE ROLE = 



-- 3. 사용자 kim에게 developer_role을 부여하시오.
CREATE USER kim IDENTIFIED BY 1234;
GRANT developer_role TO kim;

------------------------------------------------------------------
-- ==================================================
-- Role Quiz
-- 권한 / ROLE 실습 문제
-- ==================================================
-- 실행 위치:
-- SYS, SYSTEM 또는 권한을 부여할 수 있는 관리자 계정에서 실행
--
-- 주의:
-- kim, lee 사용자가 미리 존재해야 함
-- scott.emp 테이블이 미리 존재해야 함
-- ==================================================


-- ==================================================
-- 문제 1. ROLE 생성
-- ==================================================
-- developer_role 이라는 ROLE을 생성하시오.
CREATE ROLE developer_role;
SELECT * FROM dba_roles WHERE ROLE = 'DEVELOPER_ROLE';



-- ==================================================
-- 문제 2. ROLE에 시스템 권한 부여
-- ==================================================
-- developer_role 에 아래 시스템 권한을 부여하시오.
-- 권한:
-- CREATE SESSION
-- CREATE TABLE

GRANT CREATE SESSION,CREATE TABLE TO developer_role;


-- ==================================================
-- 문제 3. 사용자에게 ROLE 부여
-- ==================================================
-- 사용자 kim 에게 developer_role 을 부여하시오.

--CREATE USER kim IDENTIFIED BY 1234;  
GRANT developer_role TO kim;


-- ==================================================
-- 문제 4. 사용자에게 시스템 권한 직접 부여
-- ==================================================
-- 사용자 kim 에게 CREATE VIEW 권한을 직접 부여하시오.

GRANT CREATE VIEW TO kim;


-- ==================================================
-- 문제 5. 테이블 SELECT 권한 부여
-- ==================================================
-- 사용자 kim 에게 scott.emp 테이블의 SELECT 권한을 부여하시오.

GRANT SELECT ON scott.emp TO kim;


-- ==================================================
-- 문제 6. 테이블 INSERT 권한 부여
-- ==================================================
-- 사용자 kim 에게 scott.emp 테이블의 INSERT 권한을 부여하시오.

GRANT SELECT,INSERT,UPDATE,DELETE ON scott.emp TO kim;


-- ==================================================
-- 문제 7. ROLE 생성 후 여러 시스템 권한 부여
-- ==================================================
-- manager_role 이라는 ROLE을 생성하고 아래 권한을 부여하시오.
-- 권한:
-- CREATE SESSION
-- CREATE VIEW
-- CREATE SEQUENCE

CREATE ROLE "manager_role";
GRANT CREATE SESSION,CREATE VIEW,CREATE SEQUENCE TO "manager_role";



-- ==================================================
-- 문제 8. ROLE 부여 + 재부여 권한 설정
-- ==================================================
-- 사용자 lee 에게 manager_role 을 부여하되,
-- lee가 다른 사용자에게도 해당 ROLE을 줄 수 있도록 설정하시오.

CREATE USER lee IDENTIFIED BY 1234;
GRANT "manager_role" TO lee WITH ADMIN OPTION;


-- ==================================================
-- 문제 9. 사용자에게서 ROLE 회수
-- ==================================================
-- 사용자 kim 에게서 developer_role 을 회수하시오.

REVOKE developer_role FROM kim;


-- ==================================================
-- 문제 10. ROLE에 포함된 시스템 권한 조회
-- ==================================================
-- ROLE developer_role 에 포함된 시스템 권한 목록을 조회하시오.

SELECT * FROM ROLE_SYS_PRIVS rsp WHERE ROLE = 'DEVELOPER_ROLE';
SELECT * FROM ROLE_SYS_PRIVS rsp WHERE ROLE = 'manager_role';

COMMIT;