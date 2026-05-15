--group function
--지금까지 한 건 single function
--SELECT comm, nvl(comm,0) FROM emp;--row데이터 하나마다 nvl을 적용해서 진행한다 => 이게 single function? 무슨 뜻?
SELECT sum(sal) FROM  emp;

--일반 컬럼을 다중행 함수랑 같이 사용하려면 group by를 사용해야 한다.
SELECT deptno, sum(sal) 
FROM emp
GROUP BY deptno--부서별 총 합을 구하고싶다. 반드시 group by가 있어야 같이 출력할 수 있음. => 무슨 말?
ORDER BY deptno;


SELECT deptno, round(avg(sal),2)
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT count(*) FROM emp;--전체 갯수 체크할 때는 * 쓰는 경우가 많음.
SELECT count(comm) FROM emp;--null은 안 된다? 무슨 말?
SELECT count(comm),count(*) FROM emp;--이건 둘 다 다중행이라 되는 거다? => 무슨 말?

--급여 가장 많이 받는 사람
SELECT ename, max(sal) FROM emp;--이렇게만 하면 ename은 14개가 나오고 max는 1개가 나오는 거라 안 된다? => 무슨 말?

SELECT ename, sal FROM emp --sub query
WHERE sal >= (SELECT max(sal) FROM emp);--이렇게 쿼리 안에 쿼리를 써서 구할 수 있음 => 이걸 서브 쿼리라고 함?

SELECT max(hiredate) FROM emp;--가장 최근에 입사한 사람?
SELECT min(hiredate) FROM emp;--가장 오래 전에 입사한 사람? => 어떻게 구하는지?


--급여 가장 적게 받는 사람
SELECT ename, sal FROM emp
WHERE sal <= (SELECT min(sal) FROM emp);--위의 sub query랑 부호가 바뀌는 이유를 생각해보기

--중복은 제외 => 한 번만 하는 거라고 하셨는데 무슨 말인지?
SELECT sum(sal),SUM(DISTINCT sal) FROM emp;


--quiz
--제일 급여 많이 받는 사람과 적게 받는 사람의 차이

SELECT max(sal),
	   min(sal),
	   max(sal)-min(sal) AS diff
FROM emp;-- 강사님 답

SELECT MAX(sal) - MIN(sal) AS sal_diff FROM emp;--내가 본 GPT 답

--group함수의 조건은 having을 사용한다.
SELECT deptno, avg(sal) AS avgSal	--5
FROM EMP					--1
WHERE sal >= 1000			--2
GROUP BY DEPTNO				--3
HAVING avg(sal) >= 2000		--4
ORDER BY DEPTNO;			--6

-- 부서별 인원수
-- 직급별(job)의 최고 급여
-- 부서별 급여 총 합
SELECT deptno,
	   COUNT(*) AS p_count,
	   sum(sal) AS total_sal
FROM EMP
GROUP BY deptno
ORDER BY deptno;

-- 직급별(job)의 최고 급여
SELECT job,
	   MAX(sal) AS maxSal
FROM emp
GROUP BY job
ORDER BY maxSal;

-- 부서별 급여 총합
SELECT deptno, sum(sal) AS total
FROM emp
GROUP BY deptno
ORDER BY total DESC;


-- # 그룹 함수 Quiz

-- 1. 부서별 평균 급여를 구하고 평균 급여가 2000 이상인 부서만 출력하시오.
-- SELECT deptno, sal
-- FROM emp;
-- 출력 컬럼
-- deptno, avg_sal
SELECT deptno, avg(sal) AS avgSal
FROM EMP
GROUP BY deptno
HAVING avg(sal) >= 2000
ORDER BY deptno;

-- 2. 직급별 사원 수를 구하고 사원 수가 3명 이상인 직급만 출력하시오.
-- SELECT job
-- FROM emp;
-- 출력 컬럼
-- job, cnt
SELECT job,count(*) AS cnt
FROM emp
GROUP BY job
HAVING COUNT(*) >= 3
ORDER BY cnt;

-- 3. 부서별 최고 급여와 최저 급여의 차이를 출력하시오.
-- SELECT deptno, sal
-- FROM emp;
-- 출력 컬럼
-- deptno, salary_gap
SELECT deptno, MAX(sal) AS maxSal, min(sal) AS minSal,
	   MAX(sal) - min(sal) AS diff
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- 4. 커미션을 받는 사원 수와 받지 않는 사원 수를 각각 출력하시오.
-- SELECT comm
-- FROM emp;
-- 출력 예시
-- BONUS_O  BONUS_X
-- -------- --------
-- 410
SELECT count(comm) AS bonus_on,-- count는 어떤 기능인지?
	   count(*) - count(comm) AS bonus_off
FROM emp;

	   
-- 5. 입사 연도별 사원 수를 출력하시오.
-- SELECT hiredate
-- FROM emp;
-- 출력 컬럼
-- hire_year, cnt
-- 정렬 조건
-- 입사 연도 오름차순
SELECT TO_CHAR(hiredate, 'YYYY') AS hire_year, -- TO_CHAR은 어떤 기능이고 HIREDATE는 뭔지?
	   count(*) AS cnt -- count는 어떤 의미이고 GROUP BY는 왜 써야하는 것인지?
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY HIRE_YEAR; -- 여기서 정렬?을 의미하는 ORDER BY는 왜 쓰는지?


-- 6. 부서별 평균 급여를 구하고 전체 평균 급여보다 높은 부서만 출력하시오.
-- SELECT deptno, sal
-- FROM emp;
-- 출력 컬럼
-- deptno, avg_sal
SELECT deptno, AVG(sal) AS avgSal
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (SELECT AVG(sal) FROM emp);

-- 7. 직급별 급여 총합을 구하고 급여 총합이 가장 높은 직급부터 출력하시오.
-- SELECT job, sal
-- FROM emp;
-- 출력 컬럼
-- job, total_sal
-- 정렬 조건
-- 급여 총합 내림차순
SELECT job, sum(sal) AS sumSal
FROM emp
GROUP BY JOB
ORDER BY sumSal;

-- 8. 부서별 사원 수와 평균 근속 개월 수를 출력하시오.
-- SELECT deptno, hiredate
-- FROM emp;
-- 출력 컬럼
-- deptno, cnt, avg_months
-- 조건
-- MONTHS_BETWEEN() 사용
-- 소수 둘째 자리까지 출력
SELECT deptno, count(*) AS cnt,
	   ROUND(AVG(MONTHS_BETWEEN(sysdate,hiredate))) AS avg_month 
	   -- 왜 이렇게 괄호 괄호가 생기는지? 그리고 round, avg, month_between순으로 사용한 이유가 뭐고 sysdate와 hiredate는 여기서 어떤 뜻으로 사용된 것인지?
FROM emp
GROUP BY deptno;


-- 9. 직급별 최고 급여를 받는 사원의 급여를 출력하시오.
-- SELECT job, sal
-- FROM emp;
-- 출력 컬럼
-- job, max_sal
-- 조건
-- 최고 급여가3000 이상인 직급만 출력
SELECT job, max(sal) AS maxSal
FROM emp
GROUP BY job
HAVING max(sal) >= 3000;

-- 10. 부서별 평균 급여를 구한 뒤 평균 급여 순위가 높은 순으로 출력하시오.
-- SELECT deptno, sal
-- FROM emp;
-- 출력 컬럼
-- deptno, avg_sal
-- 조건
-- ROUND 사용
-- 평균 급여 내림차순 정렬
SELECT deptno, ROUND(avg(sal)) AS avgSal
FROM emp
GROUP BY deptno
ORDER BY avgSal DESC;



