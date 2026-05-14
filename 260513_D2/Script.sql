-- 1. [핵심] 오라클 스크립트 모드 켜기 (이거 실행하면 에러 안 남)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- 2. 이제 계정 생성 (아까 실패했던 거 다시 실행)
CREATE USER etftest IDENTIFIED BY "1234"; 

-- 3. 권한 부여
GRANT CONNECT, RESOURCE TO etftest;

-- 4. 저장 공간 허용
ALTER USER etftest DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

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


SELECT count(*) 
FROM etf_price 
WHERE isin_cd = 'KR7471460006';


