SELECT * FROM dual;  --query sql / sys에서 진행
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
DROP USER scott CASCADE; -- 연결이 안 돼서 sys , sysdba? 설정해서 사용자를 지웠다.
CREATE USER scott IDENTIFIED BY tiger;
GRANT CONNECT,resource TO scott; -- 사용자에게 권한을 할당하고 데이터 베이스 공간도 할당한 것?
GRANT CREATE VIEW TO scott;
GRANT unlimited TABLESPACE TO scott;