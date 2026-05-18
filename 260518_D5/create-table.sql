-- select / insert / update / delete => DML (데이터 조작 언어)
SELECT * FROM emp;

-- DDL (Data Definition)
CREATE TABLE dept_temp AS SELECT * FROM dept; -- 이렇게하면 테이블이 복사가 된다.
-- table 만들었는지 확인하고 싶으면 scott에 스키마에 - SCOTT - Tables 들어가면 3개 였던 게 4개가 됐다.
SELECT * FROM DEPT_TEMP;
DROP TABLE dept_temp; -- drop 쓰면 테이블 삭제(안에 있는 데이터가 전부 다 날라감)
-- DROP는 ROLLBACK이 없다.

INSERT INTO dept_temp (deptno,dname,loc) 
VALUES (70,'UI/UX','ILSAN');-- 값이 하나 추가, 이걸 여러 번 엔터치면 중복 데이터가 생김 => 중복 데이터를 막아야 함(그걸 제약사항이라고 한다)
SELECT * FROM DEPT_TEMP;-- 추가 확인

INSERT INTO dept_temp (deptno,dname,loc) 
VALUES (70,'UI/UX',NULL);

DELETE FROM dept_temp WHERE deptno = 70;-- (테이블 안에 있는 데이터를 전부 다 날림? => 조건 없이 delete하면 drop와 거의 같다?)
-- delete도 이렇게 조건을 달아주면 좋다.
SELECT * FROM DEPT_TEMP;-- 추가 확인
-- transaction
-- select를 제외한 3개는 ROLLBACK 또는 COMMIT을 무조건 해야 한다?
-- 상단 데이터베이스에 - 트랜젝션 모드에서 - 매뉴얼 커밋으로 바꿔라
ROLLBACK;
COMMIT;



CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1=0;-- 이렇게 되면 껍데기만 들고 오고 내용은 없다.
--조건을 만족하지 못 하는 걸 넣어주면 껍데기만 들고 올 수 있다. 마지막에 WHERE 1=0;처럼
SELECT * FROM emp_temp;
INSERT INTO emp_temp VALUES --컬럼을 전부 다 입력할 때는 emp_temp() 여기 괄호 없어도 된다
	(9999,'JJANG','CEO',NULL,to_date('2026-05-18','YYYY-MM-DD'),
	9000,7700,40);
INSERT INTO emp_temp VALUES
	(9998,'LEEJAEYONG','CFO',NULL,to_date('2026-05-18','YYYY-MM-DD'),
	8000,9000,30);

INSERT INTO emp_temp (empno,ename,job,sal,deptno) VALUES
	(9997,'KIM','CLERK',5000,30);


UPDATE emp_temp SET sal = 7000, ename = 'LEE' WHERE empno = 9998;

SELECT * FROM emp_temp;

ROLLBACK;
COMMIT; -- 영속화


--------------------------------------------------
-- INSERT / UPDATE / DELETE Quiz
--------------------------------------------------

CREATE TABLE emp_copy AS SELECT * FROM emp;
CREATE TABLE dept_copy AS SELECT * FROM dept;
CREATE TABLE salgrade_copy AS SELECT * FROM salgrade;

--------------------------------------------------
-- INSERT 문제
--------------------------------------------------

-- 1. dept_copy에 50번 부서를 추가하시오.
-- DEPTNO : 50
-- DNAME  : IT
-- LOC    : SEOUL
INSERT INTO dept_copy(deptno, dname, loc) values(50,'IT','SEOUL');
SELECT * FROM dept_copy;


-- 2. dept_copy에 60번 부서를 추가하시오.
-- DEPTNO : 60
-- DNAME  : MARKETING
-- LOC    : BUSAN
INSERT INTO dept_copy(deptno, dname, loc) values(60,'MARKETING','BUSAN');


-- 3. emp_copy에 신입 사원을 추가하시오.
-- EMPNO    : 9001
-- ENAME    : KIM
-- JOB      : CLERK
-- MGR      : 7782
-- HIREDATE : 오늘 날짜
-- SAL      : 1200
-- COMM     : NULL
-- DEPTNO   : 10
INSERT INTO emp_copy(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) 
values(9001,'KIM','CLERK',7782,TO_DATE('2026-05-18','YYYY-MM-DD'),1200,NULL,10);

SELECT * FROM emp_copy;

-- 4. emp_copy에 사원을 추가하시오.
-- EMPNO    : 9002
-- ENAME    : LEE
-- JOB      : SALESMAN
-- MGR      : 7698
-- HIREDATE : 오늘 날짜
-- SAL      : 1500
-- COMM     : 300
-- DEPTNO   : 30
INSERT INTO emp_copy(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(9002,'LEE','SALESMAN',7698,TO_DATE('2026-05-18','YYYY-MM-DD'),1500,300,30);


-- 5. 컬럼명을 명시하여 emp_copy에 사원을 추가하시오.
-- EMPNO : 9003
-- ENAME : PARK
-- JOB   : ANALYST
-- SAL   : 3000
-- DEPTNO: 20
-- 나머지 컬럼은 NULL
INSERT INTO emp_copy (empno,ename,job,sal,deptno) values(9003,'PARK','ANALYST',3000,20);
SELECT * FROM emp_copy;
COMMIT;

-- 6. dept_copy에 기존 40번 부서를 복사하여 70번 부서로 추가하시오.
-- DNAME, LOC는 40번 부서와 동일
-- DEPTNO만 70
INSERT INTO dept_copy(deptno, dname, loc)
	SELECT 70, dname, loc FROM dept_copy WHERE deptno = 40;

SELECT * FROM dept_copy;

COMMIT;


-- 7. emp_copy에 30번 부서 사원들을 복사하여 추가하시오.
-- EMPNO는 기존 사번 + 10000
-- ENAME은 기존 이름 뒤에 '_COPY'
-- 나머지 정보는 동일
--내가 추가 : 숫자랑 글자가 많이 안 들어가서 +100하고 '_C'로 줄여서 INSERT 했음.
INSERT INTO emp_copy (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	SELECT empno+100, ename||'_C',job,mgr,hiredate,sal,comm,deptno
	FROM emp_copy WHERE deptno = 30;

SELECT * FROM emp_copy;
COMMIT;

-- 8. emp_copy에 평균 급여보다 많이 받는 사원들을 복사하여 추가하시오.
-- EMPNO는 기존 사번 + 20000
-- ENAME은 기존 이름 뒤에 '_HIGH'
-- 나머지 정보는 동일
INSERT INTO emp_copy (empno,ename,job,mgr,hiredate,sal,comm,deptno)
	SELECT empno+200, ename||'_C',job,mgr,hiredate,sal,comm,deptno
	FROM emp_copy WHERE sal > (SELECT avg(sal) FROM emp_copy);
SELECT * FROM emp_copy;
COMMIT;


-- 9. dept_copy에 emp_copy에 존재하는 부서번호만 신규 부서로 추가하시오.
-- DEPTNO는 기존 부서번호 + 100
-- DNAME은 'COPY_DEPT'
-- LOC은 'UNKNOWN'
-- 중복 없이 추가
INSERT INTO dept_copy(deptno,dname,loc)
	SELECT DISTINCT deptno+5, 'COPY_DEPT','UNKNOWN' FROM dept_copy;


-- 10. salgrade_copy에 새로운 급여 등급을 추가하시오.
-- GRADE : 6
-- LOSAL : 5001
-- HISAL : 9999
INSERT INTO salgrade_copy(grade,losal,hisal) values(6,5001,9999);
COMMIT;
SELECT * FROM salgrade_copy;

--------------------------------------------------
-- UPDATE 문제
--------------------------------------------------

-- 11. emp_copy에서 10번 부서 사원의 급여를 10% 인상하시오.
-- 변경 컬럼 : SAL
UPDATE emp_copy SET sal = sal*1.1 WHERE deptno = 10;

-- 12. emp_copy에서 직무가 SALESMAN인 사원의 커미션을 100 증가시키시오.
-- 변경 컬럼 : COMM
UPDATE emp_copy 
	SET comm = nvl(comm,0) + 100 WHERE job = 'SALESMAN';
-- 13. emp_copy에서 커미션이 NULL인 사원의 커미션을 0으로 변경하시오.
-- 변경 컬럼 : COMM
UPDATE emp_copy 
	SET comm = 0 WHERE comm IS NULL;
-- 14. dept_copy에서 50번 부서의 위치를 INCHEON으로 변경하시오.
-- 변경 컬럼 : LOC
UPDATE dept_copy SET loc = 'INCHEON' WHERE deptno = 50;
-- 15. emp_copy에서 SMITH의 급여를 전체 평균 급여로 변경하시오.
-- 서브쿼리 사용
UPDATE emp_copy 
	SET sal = (SELECT avg(sal) FROM emp_copy) 
WHERE ename = 'SMITH';
-- 16. emp_copy에서 20번 부서 사원의 급여를 30번 부서 평균 급여만큼 증가시키시오.
-- 서브쿼리 사용
UPDATE emp_copy 
	SET sal = (SELECT avg(sal) FROM emp_copy WHERE deptno = 30) 
WHERE deptno = 20;
-- 17. emp_copy에서 부서명이 SALES인 사원의 급여를 5% 인상하시오.
-- dept_copy 서브쿼리 사용
UPDATE emp_copy 
	SET sal = sal*1.05 
WHERE deptno = (SELECT deptno FROM dept_copy WHERE dname = 'SALES');
-- 18. emp_copy에서 최고 급여자의 직무를 TOP으로 변경하시오.
-- 서브쿼리 사용
UPDATE emp_copy SET job = 'TOP' 
WHERE sal = (SELECT max(sal) FROM emp_copy);

-- 19. dept_copy에서 사원이 없는 부서의 지역을 EMPTY로 변경하시오.
-- NOT EXISTS 사용
UPDATE dept_copy d SET loc = 'EMPTY'
WHERE NOT EXISTS (SELECT * FROM emp_copy e WHERE e.deptno = d.deptno);

-- 20. emp_copy에서 자신의 부서 평균 급여보다 적게 받는 사원의 급여를 300 증가시키시오.
-- 상호연관 서브쿼리 사용
UPDATE emp_copy e SET sal=sal+300
WHERE sal < (SELECT avg(sal) FROM emp_copy WHERE deptno = e.deptno);

COMMIT;
--------------------------------------------------
-- DELETE 문제
--------------------------------------------------

-- 21. emp_copy에서 급여가 1000 미만인 사원을 삭제하시오.

-- 22. emp_copy에서 커미션이 0인 사원을 삭제하시오.

-- 23. dept_copy에서 60번 부서를 삭제하시오.

-- 24. emp_copy에서 부서번호가 40번인 사원을 삭제하시오.

-- 25. emp_copy에서 평균 급여보다 적게 받는 사원을 삭제하시오.
-- 서브쿼리 사용

-- 26. emp_copy에서 부서명이 RESEARCH인 부서의 사원을 삭제하시오.
-- dept_copy 서브쿼리 사용

-- 27. dept_copy에서 사원이 존재하지 않는 부서를 삭제하시오.
-- NOT EXISTS 사용

-- 28. emp_copy에서 각 부서의 최저 급여자를 삭제하시오.
-- 다중컬럼 서브쿼리 사용

-- 29. emp_copy에서 관리자 역할을 하고 있는 사원은 제외하고 나머지 MANAGER 직무 사원을 삭제하시오.
-- NOT IN 또는 NOT EXISTS 사용

-- 30. emp_copy에서 가장 오래전에 입사한 사원을 삭제하시오.
-- 서브쿼리 사용






