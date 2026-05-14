-- 숫자 관련 함수	정수 / 실수  number
SELECT--(숫자를 특정 위치에서 반올림하는 ROUND 함수)
	round(123.456789,1) ,--지정한 위치까지 표시하되, 그 아래 숫자에서 반올림.
	round(123.456789,2) ,--round 많이 사용하니 꼭 기억할 것.
	round(123.456489,3) ,
	round(123.456489,-1) ,
	round(123.456489,-2) ,
	round(152.456489,-2) ,
	round(2652.456489,-2)
FROM dual;
--round는 국제 표준 함수이지만, trunc는 oracle에서만 사용할 수 있다
-- 무조건 버리기(단, oracle 전용) mysql/oracle/postgre(요즘 유행?) => RDBMS => 이것들을 다루는 국제적 기준이 SQL
SELECT--()
	trunc(123.456789,1) ,--지정한 위치까지 표시하고, 그 아래 숫자는 크기에 상관없이 무조건 버림
	trunc(123.456789,2) ,
	trunc(123.456789,3) ,
	trunc(123.456789,-1) ,
	trunc(123.456789,-2)
FROM dual;

SELECT
	ceil(123.456789) ,--(ceil은 자릿수가 없음. / 무조건 정수만 반환(출력))
	floor(123.756789) ,--(내림)
	ceil(-123.156489) , -- 무조건 큰 정수로 올림
	floor(-123.456489) -- 무조건 작은 정수로 내림
FROM dual;

SELECT
	mod(10,3) -- 나머지 연산
FROM dual;

SELECT empno, ename
FROM emp
WHERE mod(empno,2)=0;

SELECT
	power(10,2), -- 제곱
	power(3,3), 
	sqrt(25), -- 루트?(공부 필요)
	sqrt(9)
FROM dual;


