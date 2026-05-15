--진짜 중요 정말 중요 !!
SELECT * FROM emp;
SELECT * FROM dept;  

--카타시안의 곱
SELECT * 
FROM emp,dept;

--table의 가로 확장 join / join은 테이블 2개를 연결해서 사용하는 것.
SELECT *
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO;

SELECT e.empno, e.ename, e.job, e.mgr, e.HIREDATE, e.sal, e.comm,
e.deptno, d.dname, d.loc--join을 했을 때는 누구의 것을 들고 올 건지 표시해 주는 게 좋다?
FROM emp e, dept d -- 테이블명에서 앞글자를 따서 별칭을 짓는다 => AS는 필요 없음.
WHERE e.DEPTNO  = d.DEPTNO;

-- 등가조인(이퀄"="로 연결하는 join => 가장 많이 쓰임.)
SELECT e.*, d.DNAME, d.LOC -- d.* 이렇게 출력하면 deptno가 2개 나와서(왜?) 이렇게 2개로 나눠서 씀 => 공부 필요
FROM emp e, dept d
WHERE e.DEPTNO  = d.DEPTNO;


SELECT * FROM SALGRADE s ;


--비등가조인
SELECT *
FROM emp e,salgrade s
WHERE e.SAL >= s.LOSAL  AND e.sal <= s.HISAL;

SELECT *
FROM emp e,salgrade s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL ;


--ANSI join => 어떤 뜻이고 왜 이렇게 사용해야 하는지, 언제 사용하는지 공부 필요
SELECT * FROM EMP e, DEPT d;

SELECT e.*, d.DNAME, d.LOC
FROM emp e
JOIN dept d -- 여기는 왜 이런 식으로 써야 하는지? 4줄의 코드 모두 => 공부 필요 (default는 INNER JOIN이다. 근데 그냥 JOIN만 쓰면 됨. 아래의 CROSS와는 반대?)
ON e.DEPTNO = d.DEPTNO;--join을 하려면 ansi에선 무조건 on이 필요하다?

SELECT e.*, d.DNAME, d.LOC
FROM emp e
CROSS JOIN dept d;-- 이렇게도 사용 가능하지만, 거의 이렇게 사용하는 일은 없다고 함.

SELECT e.*,d.DNAME, d.LOC  
FROM emp e
JOIN dept d
ON 1 = 1;

SELECT * FROM emp;

SELECT *
FROM emp e,salgrade s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL ;

SELECT * 
FROM emp e
JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.HISAL;

SELECT * FROM dept;
SELECT * FROM emp;

--여기서부턴 오라클 조인 안 하고 표준 조인을 한다고 함 => 무슨 말?
SELECT
	e.ename, e.deptno, d.dname, d.loc
FROM emp e
RIGHT JOIN dept d--RIGHT를 쓰면 d에 있는 게 다 출력해야 한다? 왜 이렇게 써야 하는 건지?
ON e.DEPTNO = d.DEPTNO;

SELECT * FROM emp;

--
SELECT e1.EMPNO, e1.ename, e1.mgr, e2.EMPNO, e2.ename AS mgrName
FROM emp e1
CROSS JOIN emp e2; -- self join이라고 함. => 무슨 말?

SELECT * FROM emp;

--관리자가 있는 매니저 출력
SELECT e1.empno, e1.ename, e1.mgr, e2.ename, e2.ename AS mgrName
FROM emp e1
FULL OUTER JOIN emp e2
--LEFT JOIN emp e2-- 여기서 LEFT를 붙여서 KING이 NULL인데 나왔음 => 왜?
ON e1.mgr = e2.empno; -- 내 mgr가 누구인지 출력하는 것.

-- join > left join > right join > full join > cross join

--JOIN Quiz
-- 1. 사원 이름과 부서명을 출력하시오.
-- SELECT ename, dname
-- FROM emp, dept;
-- 출력 컬럼
-- ename, dname
-- 조건
-- ANSI JOIN 사용
SELECT e.ename, e.deptno, d.dname
FROM emp e
JOIN dept d
ON e.DEPTNO = d.DEPTNO;


-- 2. 사원 이름, 급여, 급여 등급을 출력하시오.
-- SELECT ename, sal, grade
-- FROM emp, salgrade;
-- 조건
-- 비등가 조인 사용
SELECT e.ename, e.sal, s.GRADE 
FROM EMP e
JOIN salgrade s
ON e.sal BETWEEN s.LOSAL AND s.HISAL;


-- 3. 사원 이름과 관리자 이름을 함께 출력하시오.
-- 출력 예시
-- ENAME   MGR_NAME
-- ------  --------
-- SMITH   FORD
-- 조건
-- SELF JOIN 사용
SELECT e1.ename AS ename, nvl(e2.ename,'매니저 없음') AS manager_name
FROM emp e1
LEFT JOIN emp e2
ON e1.mgr = e2.EMPNO;


-- 4. 모든 사원의 이름과 부서명을 출력하시오.
-- 조건
-- 부서가 없는 사원도 출력
SELECT nvl(e.ename,'부서원 없음'), d.dname
FROM dept d
LEFT JOIN emp e
ON e.deptno = d.deptno;

-- 5. 모든 부서의 부서명과 사원 이름을 출력하시오.
-- 조건
-- 사원이 없는 부서도 출력
SELECT nvl(e.ename,'부서원 없음'), d.dname
FROM dept d
LEFT JOIN emp e
ON e.deptno = d.deptno;


-- 6. 사원 이름, 부서명, 근무 지역(loc)을 출력하시오.
-- 출력 컬럼
-- ename, dname, loc
-- 조건
-- ANSI JOIN 사용
SELECT e.ename, d.dname, d.loc
FROM emp e
JOIN dept d
ON e.DEPTNO = d.DEPTNO;


-- 7. 급여 등급이 4 이상인 사원의 이름과 급여를 출력하시오.
-- 출력 컬럼
-- ename, sal, grade
-- 조건
-- salgrade 테이블 사용
SELECT e.ename, e.sal
FROM emp e
JOIN SALGRADE s 
ON e.SAL BETWEEN s.losal AND s.hisal
WHERE s.GRADE >= 4;


-- 8. 사원 이름과 같은 부서에 근무하는 사원 수를 출력하시오.
-- 출력 컬럼
-- ename, dept_cnt
-- 조건
-- JOIN + GROUP BY 사용
SELECT e1.ename, count(e2.deptno) AS dept_cnt
FROM emp e1
JOIN emp e2
ON e1.DEPTNO = e2.DEPTNO
GROUP BY e1.ename,e1.deptno;


-- 9. 관리자보다 급여를 많이 받는 사원의 이름과 급여를 출력하시오.
-- 출력 컬럼
-- emp_name, emp_sal, mgr_name, mgr_sal
-- 조건
-- SELF JOIN 사용
SELECT e1.ename AS ename, e1.sal AS emp_sal, 
       e2.ename AS mgr_name,e2.sal AS mgr_sal
FROM emp e1
JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.sal>e2.sal;


-- 10. 부서별 평균 급여와 부서명을 출력하시오.
-- 출력 컬럼
-- dname, avg_sal
-- 조건
-- ROUND 사용
-- 평균 급여 내림차순 정렬
SELECT d.DNAME ,nvl(round(avg(e.sal),2),0) AS avg_sal
FROM dept d
LEFT JOIN emp e
ON d.DEPTNO = e.DEPTNO
GROUP BY d.DNAME ;


