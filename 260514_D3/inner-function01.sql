--inner-function01
-- 내장 함수
--1. 문자 관련 함수
SELECT 
	ename, 
	lower(ename) AS lower, -- 소문자로 변환
	upper(ENAME) AS upper, -- 대문자로 변환
	initCap(ename) AS capitalize -- 첫 글자만 대문자로
FROM emp;

SELECT * FROM emp WHERE lower(ename) = lower('smith'); 

SELECT * FROM emp WHERE ename LIKE '____%';

SELECT ename, length(ename) FROM emp;

--dual은 dummy table
SELECT length('hello'), length('안녕'), --문자 길이는 그냥 length 쓰면 된다. (한글은 3byte 문자)
	   lengthb('hello'), lengthb('안녕') --lengthb는 거의 쓰지 않음. 글자의 byte를 보여주는 것?
FROM dual;

SELECT * FROM emp
WHERE LENGTH(ename) >= 5;--함수는 항상 괄호 열고, 닫고

SELECT ename, length(ename) AS nameLength FROM emp
WHERE length(ename) >= 5
ORDER BY nameLength;--이미 select 지나와서 여기선 별칭 사용 가능.
--순서 => 1. from emp(테이블을 먼저 찾음) 2. where 조건절을 2순위 
--3. group by
--4. group에 대한 having
--5. select
--6. order by
--별칭은 where 조건절에 사용할 수 없다.

SELECT ename, substr(ename, 1, 3), substr(ename, 2), substr(-3, 2)
FROM emp;-- substr(컬럼명, 시작 글자 인덱스, 인덱스 갯수?) => 맞는지 공부 / '-'쓰면 뒤에서부터 찾는 것

SELECT ename || '**' 
FROM emp; -- 파이프는 문자열을 붙여 쓰는 문자열 연결 연산자

--S***H
SELECT ename, substr(ename,1,1) || '***' || substr(ename,-1) AS markingName --oracle에서 문자 연결할 때 쓰는 게 || 이고 MySQL에선 concat?이란 걸로 문자열을 연결한다.
FROM emp;

SELECT ename, concat(ename, '**') FROM emp;--concat은 매개변수 2개만 사용 가능.
SELECT ename, ename || '**' FROM emp;-- ||는 문자열 연결 시 사용하지만, 오라클에서만 사용 가능.
-- 표준은 concat(문자열, 문자열)을 사용.

SELECT ename, concat(concat(substr(ename,1,1), '***'),substr(ename,-1)) AS markingName
FROM emp;

SELECT substr('012203-1234567',1,6) FROM dual;
SELECT substr('012203-1234567',8,1) FROM dual;--성별을 찾는다면 이런 식으로 사용할 수 있음.(요즘은 남자 3, 여자 4)
SELECT substr('01025822242', -4) FROM dual;--전화번호 마지막 네 자리 찾기

SELECT instr('HELLO ORACLE!', 'L'),
	   instr('HELLO ORACLE!', 'L',5),--다섯 글자 건너 뛰고 L을 찾아봐라 => 열 한 번째
	   instr('HELLO ORACLE!', 'L',4,2),
	   instr('HELLO ORACLE!', 'L',-1),
	   instr('HELLO ORACLE!', 'LX')
FROM dual;

-- 이름 중에 S가 포함되어 있는 emp 출력
SELECT * FROM emp WHERE ename LIKE '%S%';
SELECT * FROM emp WHERE instr(ename, 'S') > 0;--0보다 크면 포함하고 있다는 것 => 이게 무슨 말?

--공백 제거
SELECT trim('  HELLO  '), 
	   ltrim('  HELLO  '),
	   rtrim('  HELLO  ')
FROM dual;

--대치 replace
SELECT REPLACE (' H E LL O',' ','') FROM dual;-- 특정 문자열에서 공백 하나를 없애라. => 그래서 중간에 공백 1개가 있고 그 다음엔 공백 자리가 없는 것.
SELECT REPLACE ('010-1234-5678','-','') FROM dual;

--영어만 남기고 다 지우고싶다 => replace로는 안 된다. 정규 표현식을 사용해야 함.
SELECT 'A1B2C3' FROM dual;
SELECT REGEXP_REPLACE('A1B2C3','[^A-Za-z]','') FROM dual;--REGEXP가 정규 표현식을 뜻한다.

--채우기
SELECT LPAD('77', 3, '0') FROM dual;
SELECT RPAD('A', 5, '*') FROM dual;

SELECT ename,
	   substr(ename,1,1) || rpad('*',LENGTH(ename)-2,'*') || substr(ename,-1)
FROM emp;

SELECT '장성호',
substr('장성호',1,1)||rpad('*',LENGTH('장성호')-2,'*')||substr('장성호', -1)
FROM dual;


