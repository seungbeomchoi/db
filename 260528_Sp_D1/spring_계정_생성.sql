ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; --sys에서
--사용자 생성 명령어
CREATE USER spring IDENTIFIED BY 1234; 
--접속할 수 있는 권한 부여 명령어
GRANT CREATE SESSION TO spring; 
--테이블 만들 수 있는 권한 부여 명령어
GRANT CREATE TABLE TO spring; 
--시퀀스 만들 수 있는 권한 부여 명령어
GRANT CREATE SEQUENCE TO spring; 
--view 만들 수 있는 권한 부여 명령어
GRANT CREATE VIEW TO spring; 
-- users tablespace에 데이터를 저장할 권한 부여하는 명령어
ALTER USER spring quota unlimited ON users; 
COMMIT;