--subquery query에 또 다른 query를 사용
--jones보다 높은 급여를 받는 사람
SELECT sal FROM emp WHERE ename = 'JONES';
SELECT ename, sal FROM emp WHERE sal >= 2975;

-- server -> db 서버가 db로 보낼 때 비용이 든다.
SELECT ename, sal
FROM EMP
WHERE sal >= (SELECT sal FROM emp WHERE ename = 'JONES');
--하나의 값으로 쓰이는 subquery를 scalar subquery라고 한다.

--allen과 크거나 같은 comm을 받는 사람의 정보를 출력
SELECT comm FROM emp WHERE ename = 'ALLEN';
SELECT ename, comm
FROM emp
WHERE comm >= (SELECT comm FROM emp WHERE ename = 'ALLEN'); 

--scott보다 입사일이 빠른 사람
SELECT hiredate FROM EMP e  WHERE ename = 'SCOTT';
SELECT ename, hiredate
FROM emp
WHERE hiredate < (SELECT hiredate FROM emp WHERE ename = 'SCOTT');

--20번 부서 사원 중에서 전체 사원의 평균 급여보다 많이 받는 사원의 사번, 이름, 직업, 급여, 부서 정보
SELECT * FROM emp; -- deptno(부서 번호), empno(사번), ename, job, sal, deptno
SELECT ename, sal, deptno FROM emp WHERE deptno='20';

--강사님 답(더 정확.)
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
FROM EMP e 
JOIN dept d
ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 20 AND e.sal > (SELECT avg(sal) FROM emp);

--Gemini 답
SELECT empno, ename, job, sal, deptno
FROM EMP 
WHERE deptno = 20
	AND sal > (
	SELECT AVG(sal)
	FROM emp
);



--각 부서의 최고 급여와 같은 급여를 받는 사원 조회 => 부서별 최고 연봉자 찾기
SELECT * FROM EMP e
WHERE sal in(SELECT max(sal) AS maxSal -- in()은 일치 구문? => "같은"이라는 말? 그래서 in을 쓰면 OR 조건과 같다? 맞는 말인지 체크
FROM emp
GROUP BY deptno);


 -- sal은 1개의 값만 받을 수 있는데? maxSal 안에는 값이 많으니 에러가 나온다. => 그래서 ANY / SOME를 사용. "ANY는 하나라도 만족하면 TRUE"
SELECT * FROM EMP e--ANY / SOME는 하나라도 만족하면 TRUE, 보통 ANY를 더 많이 사용한다.
WHERE sal > ANY (SELECT max(sal) AS maxSal
FROM emp
GROUP BY deptno);


-- ALL은 여기선 셋 다 만족해야 함. => maxSal 안에 2975, 3000, 5000이 있는데 5000보다 커야 하는 값이 나와야 한다.
-- ALL은 모두 만족하면 TURE
-- **ANY / ALL은 서브 쿼리가 다중행을 반환할 때 사용한다.**
SELECT * FROM EMP e
WHERE sal >= ALL (SELECT max(sal) AS maxSal
FROM emp
GROUP BY deptno);


--EXISTS는 하나라도 행이 있으면 TRUE 반환? => 맞는지 체크
SELECT * FROM EMP e
WHERE NOT EXISTS (SELECT dname FROM dept WHERE deptno = 50);


-- SubQuery Quiz

-- 1. 전체 평균 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal
FROM emp
WHERE sal > (SELECT avg(sal) FROM emp);
--강사님 답
SELECT ename, sal FROM EMP
WHERE sal >= (SELECT avg(sal) FROM emp);


-- 2. SMITH보다 급여를 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename='SMITH');
--강사님 답
SELECT ename, sal FROM emp
WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SMITH');

-- 3. 가장 높은 급여를 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal FROM emp
WHERE sal >= (SELECT MAX(SAL) FROM emp);

-- 4. 가장 낮은 급여를 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal FROM emp
WHERE sal <= (SELECT MIN(SAL) FROM emp);


-- 5. 평균 급여 이하를 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal FROM emp
WHERE sal <= (SELECT avg(sal) FROM emp);


-- 6. 30번 부서의 최고 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal FROM emp
WHERE sal >= (SELECT max(sal) FROM emp WHERE deptno = 30);

-- 7. 20번 부서의 최저 급여보다 적게 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal FROM emp
WHERE sal <= (SELECT min(sal) FROM emp WHERE deptno = 20);

-- 8. 부서별 최고 급여자를 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
-- 조건
-- 다중컬럼 서브쿼리 사용
SELECT ename, sal, deptno
FROM emp
WHERE (deptno, sal) IN (
SELECT deptno, max(sal) FROM emp
GROUP BY deptno);

-- 9. 부서별 최저 급여자를 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
SELECT ename, sal, deptno
FROM emp
WHERE (deptno, sal) IN (
SELECT deptno, min(sal) FROM emp
GROUP BY DEPTNO);

-- 10. KING과 같은 부서에 근무하는 사원을 조회하시오.
-- 출력 컬럼
-- ename, deptno
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'KING');

-- 11. ALLEN과 같은 직무(job)를 가진 사원을 조회하시오.
-- 출력 컬럼
-- ename, job
SELECT ename, job
FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN');

-- 12. 평균 급여보다 많이 받는 사원 중 30번 부서 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
SELECT  ename ,sal, deptno
FROM emp
WHERE sal >= (SELECT avg(sal) FROM emp) AND deptno = 30; -- 여기선 avg(sal)을 사용했는데 왜 group by를 안 한 거야?

-- 13. 부서명이 SALES인 부서의 사원을 조회하시오.
-- 출력 컬럼
-- ename, deptno
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES');-- 여기서 dname은 갑자기 뭐야? 어느 테이블이 존재해?

-- 14. 사원이 존재(1명이라도 있는)하는 부서만 조회하시오.
-- 출력 컬럼
-- dname
-- 조건
-- EXISTS 사용
SELECT dname FROM dept d
WHERE EXISTS (SELECT * FROM EMP e WHERE e.DEPTNO = d.DEPTNO);


-- 15. 사원이 존재하지 않는 부서를 조회하시오.
-- 출력 컬럼
-- dname
-- 조건
-- NOTEXISTS 사용
SELECT dname FROM dept d
WHERE NOT EXISTS (SELECT * FROM EMP e WHERE e.DEPTNO = d.DEPTNO);


-- 16. 자신의 부서 평균 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
-- 조건
-- 상호연관 서브쿼리 사용
SELECT ename, sal, deptno
FROM EMP e 
WHERE sal > (SELECT avg(sal) FROM emp WHERE deptno = e.DEPTNO);


-- 17. 자신의 부서 평균 급여보다 적게 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
SELECT ename, sal, deptno
FROM EMP e 
WHERE sal < (SELECT avg(sal) FROM emp WHERE deptno = e.DEPTNO);


-- 18. 각 부서의 평균 급여를 조회하시오.
-- 출력 컬럼
-- deptno, avg_sal
-- 조건
-- 인라인뷰 사용
SELECT deptno, avg(sal) AS avgSal FROM emp
GROUP BY deptno;

SELECT deptno, avgsal
FROM (SELECT deptno, avg(sal) AS avgSal FROM emp
GROUP BY deptno);
--FROM 절에 쓰는 subquery를 보통 inline-view라고 한다.


-- 19. 평균 급여가 가장 높은 부서를 조회하시오.
-- 출력 컬럼
-- deptno
SELECT deptno FROM emp
GROUP BY deptno
HAVING avg(sal) = (SELECT max(avg(sal)) FROM emp -- 여기서 HAVING는 왜 나오는 것인지?
GROUP BY deptno);

-- 20. 최고 급여를 받는 사원의 이름과 부서명을 조회하시오.
-- 출력 컬럼
-- ename, dname
SELECT e.ename, d.dname -- 1. 여긴 왜 나왔고
FROM EMP e
JOIN dept d -- 2. JOIM은 왜 쓰이고
ON e.DEPTNO = d.DEPTNO -- 3. ON은 왜 여기서 쓰인 것인지?
WHERE e.sal >= (SELECT max(sal) FROM emp); -- WHERE e.sal은 무슨 뜻인지

-- 21. 부서별 평균 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
SELECT ename, sal, deptno
FROM emp e
WHERE sal >= (SELECT avg(sal) FROM emp WHERE deptno = e.DEPTNO);


-- 22. 가장 최근에 입사한 사원을 조회하시오.
-- 출력 컬럼
-- ename, hiredate
SELECT ename, hiredate
FROM emp
WHERE hiredate = (SELECT max(hiredate) FROM emp);

-- 23. 가장 오래전에 입사한 사원을 조회하시오.
-- 출력 컬럼
-- ename, hiredate
SELECT ename, hiredate
FROM emp
WHERE hiredate = (SELECT min(hiredate) FROM emp);


-- 24. 10번 부서 사원들의 평균 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
SELECT ename, sal FROM emp
WHERE sal > (SELECT avg(sal) FROM emp WHERE deptno = 10);


-- 25. 직무별 최고 급여자를 조회하시오.
-- 출력 컬럼
-- ename, job, sal
SELECT ename, job, sal FROM emp
WHERE (job,sal) IN (SELECT job, max(sal) FROM emp
GROUP BY job);


-- 26. 직무별 최저 급여자를 조회하시오.
-- 출력 컬럼
-- ename, job, sal
SELECT ename, job, sal FROM emp
where(job, sal) IN (SELECT job, min(sal) FROM emp
GROUP BY job);


-- 27. 모든 부서의 최고 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
-- 조건
-- ALL 사용
SELECT ename, sal FROM emp
WHERE sal >= ALL (SELECT max(sal) FROM emp
GROUP BY deptno);


-- 28. 어떤 부서의 최고 급여보다 많이 받는 사원을 조회하시오.
-- 출력 컬럼
-- ename, sal
-- 조건
-- ANY 또는SOME 사용
SELECT ename, sal FROM emp
WHERE sal >= ANY (SELECT MAX()ax(sal) FROM emp
GROUP BY deptno);


-- 29. 부서별 최고 급여자와 최저 급여자를 함께 조회하시오.
-- 출력 컬럼
-- ename, sal, deptno
SELECT ename,sal,deptno
FROM emp 
WHERE (deptno,sal) IN (
SELECT deptno,max(sal) FROM emp 
GROUP BY deptno) 
OR (deptno,sal) IN (
SELECT deptno,min(sal) FROM emp 
GROUP BY deptno)
order BY deptno;


-- 30. 평균 급여가 전체 평균 급여보다 높은 부서를 조회하시오.
-- 출력 컬럼
-- deptno, avg_sal
-- 조건
-- GROUPBY+HAVING+ 서브쿼리 사용
SELECT deptno,avg(sal) AS avgSal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT avg(sal) FROM emp);




