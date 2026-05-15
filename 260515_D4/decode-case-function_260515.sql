--null을 다루는 함수
SELECT ename,
	   nvl(comm,0),
	   nvl2(comm,TO_CHAR(comm,'fm999,999'),'x'),
	   nvl2(comm,comm,0)
FROM EMP;

--decode 조건문(오라클 전용) / decode가 아닌 ANSI전용으로 처리하는 것도 배운다
SELECT DECODE(
	job,--job이 MANAGER라면 관리라고 부르겠다.
	'MANAGER','관리',
	'SALESMAN', '영업',
	'CLERK', '사원',
	'기타'--다른 거 안 쓰면 이렇게 마무리한다? => 나머지는 다 기타로 나옴.(if문에서 else같은 것?)
) FROM emp;

--ANSI 문법(어디에서나 사용할 수 있음.)
SELECT CASE 
		WHEN job = 'MANAGER' THEN '관리'	
		WHEN job = 'SALESMAN' THEN '영업'	
		WHEN job = 'CLERK' THEN '사원'
		ELSE '기타'
		END 
FROM emp;

SELECT DECODE(
	comm,
	NULL,'N',
	'Y'
) FROM emp;

SELECT CASE
		WHEN comm IS NULL THEN 'N'
		ELSE 'Y'
	   END
FROM emp;

--quiz
--manager의 월급을 10% 인상 salesman은 5% 인상 analyst는 그대로 / 나머지는 30% 인상
SELECT
	empno, ename, job, sal,
	decode (
		job,
		'MANAGERCASE', sal*1.1,
		'SALESMAN',sal*1.05,
		'ANALYST',sal,
		sal*1.3
		) AS up_sal
FROM emp;

SELECT 
	empno,	ename,	job,	sal,
	CASE job
		WHEN 'MANAGER' THEN sal*1.1
		WHEN 'SALESMAN' THEN sal*1.05
		WHEN 'ANALYST' THEN sal
		ELSE sal*1.3
	END AS up_sal
FROM emp;