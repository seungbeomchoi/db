SELECT * FROM emp; -- 테이블을 조회하는 명령어. / 우린 이제 CRUD를 한다. / 책에는 DESC emp; 하라고 되어 있는데 디비버에선 이게 안 된다.
-- SELECT, INSERT, DELETE, update 이 네 가지를 DML이라고 부른다.(셀렉트 빼고 나머지를)
SELECT empno, ename, job FROM EMP; -- 셀렉트 컬럼명 프롬 테이블명 이런 식으로.
SELECT * FROM dept; -- 총 3개의 컬럼이 있고 4개의 데이터가 있다.
SELECT * FROM salgrade;

SELECT DISTINCT job, deptno FROM emp; -- 중복 제거하려면 컬럼명 앞에 DISTINCT 붙이면 된다.(java Stream에서도 나왔음. 어제 260511)
SELECT ALL job, deptno FROM emp; -- 거의 사용하지 않음.

-- 별칭(alias)를 정할 때는 AS를 쓴다. / 테이블 별칭은 emp 뒤에 쓰면 된다.
SELECT ename AS name, sal*12 AS annsal FROM EMP;
-- 중요함 => annsal 이렇게 하면 컬럼명 바뀜. 별명은 띄어쓰기 X OR 띄어쓸 거면 " "이렇게 문자열로 묶어야 함. / 연봉(sal이 월급)

--디센딩 어센딩(오름차순, 내림차순) 여기서 처리하면 굳이 java에서 Stream할 필요가 없음.
--order by를 사용하면 정렬할 수 있음. => 순서 정하기 오름차순, 내림차순
SELECT * FROM emp ORDER BY sal desc;--SELECT * FROM emp ORDER BY sal; 오름차순
--1 empno 기준으로 내림차순 정렬
SELECT * FROM emp ORDER BY empno DESC;
SELECT ename, sal, deptno FROM emp ORDER BY deptno, sal desc;
-- 테이블엔 절대로 중복 데이터가 들어가면 안 된다.

--P.97
--answer 01
SELECT empno AS 사원번호, ename AS 사원이름 FROM emp;

--answer 02
SELECT DISTINCT job FROM emp;

--answer 03
SELECT 
	empno AS employee_no, 
	ename AS employee_name, 
	mgr AS manager, 
	sal AS salary, 
	comm AS commission, 
	deptno AS department_no 
FROM EMP ORDER BY department_no;

-- P.99
SELECT * FROM emp
WHERE deptno = 30;

SELECT * FROM emp
WHERE empno = 7369;

--값의 경우는 대소문자 구분 / 문자열은 작은따옴표로 쓰고 여기선 대, 소문자 구분한다.
SELECT * FROM EMP 
WHERE deptno = 30 AND job='SALESMAN';

-- 사원번호가 7499이고 부서번호가 30인 사람 출력
SELECT * FROM EMP
WHERE empno = 7499 AND deptno = 30;

SELECT * FROM emp
WHERE deptno = 30 OR job = 'CLERK';

SELECT * FROM emp
WHERE NOT deptno = 20;--oracle query에서는 같다를 == 아니고 = 하나만 사용하면 된다.

--산술연산자
SELECT * FROM emp
WHERE sal*12 = 36000;

SELECT * FROM emp
WHERE sal+sal+sal+sal = 12000;

SELECT sal, sal+1000 AS plus_sal, sal*12 AS annsal FROM  EMP;

--null은 연산이 불가.
SELECT ename, comm+1000 AS plus_comm FROM EMP;

--null은 연산이 불가. / nvl은 함수다. (oracle에 함수가 엄청 많음.)
SELECT ename, nvl(comm, 0)+1000 AS plus_comm FROM EMP;