-- 1. [치트키] 오라클 최신 버전 룰 무시 (이거 없으면 에러남)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- 2. [삭제] 기존에 꼬여버린 etftest 계정과 모든 데이터를 강제 삭제
-- (만약 계정이 없다는 에러가 나면 무시하고 다음 줄 진행하면 됩니다)
DROP USER etftest CASCADE;

-- 3. [생성] 계정 다시 만들기 (비밀번호: 1234)
CREATE USER etftest IDENTIFIED BY "1234"; 

-- 4. [권한] 접속 및 테이블 생성 권한 부여
GRANT CONNECT, RESOURCE TO etftest;

-- 5. [공간] 데이터 저장 공간 무제한 허용 (이거 안 하면 나중에 용량 에러남)
ALTER USER etftest DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;