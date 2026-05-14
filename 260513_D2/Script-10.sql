SELECT * FROM dual;  --query sql / bitco02 만드는 것 시작 / sys에서 진행
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
DROP USER bitco02 CASCADE;

CREATE USER bitco02 IDENTIFIED BY 1234;
GRANT CONNECT,resource TO bitco02; -- 사용자에게 권한을 할당하고 데이터 베이스 공간도 할당한 것?
GRANT CREATE VIEW TO bitco02;
GRANT unlimited TABLESPACE TO bitco02;--bitco가 연결이 있어서 bitco02로 바꿈