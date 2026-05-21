--altco 계정 생성
SELECT * FROM dual;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER altco IDENTIFIED BY cocoin;
GRANT CONNECT,resource TO altco; -- 여기 안에 create table이라는 권한이 들어가 있음.
GRANT CREATE VIEW TO altco;
GRANT unlimited TABLESPACE TO altco;
COMMIT;