--C INSERT into
--R SELECT (가장 많이 쓰임.)
--U update
--D delete

SELECT ename, empno, job, mgr FROM emp;
SELECT * FROM emp; -- 모든 데이터를 다 뽑아서 사용하는 경우는 거의 없다.
SELECT * FROM emp
WHERE empno = 7369 AND ename = 'SMITH';-- 세미콜론 찍기 전까지는 한 문장으로 본다. / WHERE 조건절이 굉장히 중요
--오늘은(260513) 연산자 수업으로 시작
--1. 비교연산자
SELECT * FROM emp
WHERE sal >= 3000
ORDER BY sal DESC, empno ASC;--원래는 asc를 붙여야 하지만 디폴트가 asc라서 쓰지 않음.

SELECT * FROM emp
WHERE sal <= 3000
ORDER BY sal;

SELECT * FROM emp
WHERE ename >= 'F';

SELECT * FROM emp
WHERE ename = 'SMITH';

--다르다(아래 3개가 전부 "다르다"라는 뜻)
SELECT * FROM emp
WHERE sal != 3000;

SELECT * FROM emp
WHERE sal <> 3000; --옛날 스타일.

SELECT * FROM emp
WHERE sal ^= 3000;
--quiz => job이 MANAGER 또는 SALESMAN 또는 CLERK인 사람을 출력
SELECT * FROM emp
WHERE job = 'MANAGER' OR job = 'SALESMAN' OR job = 'CLERK'
ORDER BY job;

SELECT * FROM emp--이 방식이 더 편하고 가독성 좋음.
WHERE job IN ('MANAGER', 'SALESMAN', 'CLERK')
ORDER BY job;

SELECT * FROM emp
WHERE deptno = 20 OR deptno = 30
ORDER BY deptno;

SELECT * FROM EMP 
WHERE deptno IN (20,30)
ORDER BY deptno;

SELECT * FROM EMP 
WHERE (deptno, job) IN ((20,'MANAGER'),(30,'CLERK'));

SELECT * FROM emp--어떤 형식인지 비교해보기
WHERE 
(DEPTNO = 20 AND job = 'MANAGER') OR
(DEPTNO =30 AND job = 'CLERK');

SELECT * FROM emp
WHERE job NOT IN ('MANAGER', 'SALESMAN', 'CLERK')--manager, salesman, clerk 전부 아닌 사람을 찾는 것.(NOT이 붙었음)
ORDER BY job;

--quiz : 급여가 2000이상 3000이하인 사람 출력
SELECT * FROM EMP
WHERE sal >= 2000 AND sal <= 3000
ORDER BY sal;

SELECT * FROM EMP
WHERE sal BETWEEN 2000 AND 3000--꺽쇠가 없어서 between을 많이 사용한다. => java에서 mybatis가 잘못 해석하지 않도록?
ORDER BY sal;

--java mybatis가 <xml>을 사용해서? db에 값을 읽는다? <xml>은 <html>과 비슷하다?

SELECT * FROM EMP
WHERE sal NOT BETWEEN 2000 AND 3000
ORDER BY sal;

SELECT * FROM EMP e --이 "e"도 alias임(별칭) / 테이블명도 컬럼명처럼 길어지면 별칭으로 짧게 바꿔야 해서.
WHERE ename = 'SMITH';

-- _와 %(아무거나)를 사용할 수 있음.
SELECT * FROM emp
WHERE ename LIKE 'S%';--ename에서 S로 시작하고 뒤에는 뭐가 와도 상관없다. 그걸 "%"로 표현

SELECT * FROM emp
WHERE ename LIKE '%ER';--ER로 끝나면 앞은 뭐가 와도 상관 없다.

SELECT * FROM emp
WHERE ename LIKE '%AR%';--중간에 AR만 나오면 앞, 뒤로 이름에 뭐가 나와도 상관없다.

SELECT * FROM emp
WHERE ename LIKE '%M%I%';--M이 먼저 나오고 I가 나중에 나오는 모든 사람

SELECT * FROM emp
WHERE ename LIKE '_____';--이름이 다섯 글자인 사람을 모두 뽑아라. => "_"는 자릿수

--quiz : 이름이 5글자이면서 S로 끝나는 사람
SELECT * FROM emp
WHERE ename LIKE '____S';

--quiz : 이름의 두 번째 글자가 L인 사람
SELECT * FROM emp
WHERE ename LIKE '_L%';--LIKE 정말 많으 쓰임.

--null은 =(이퀄) 검색이 안 된다 => is를 사용해야 함. is null
SELECT * FROM emp
WHERE comm IS NULL;


SELECT * FROM EMP
WHERE comm IS NOT NULL;





