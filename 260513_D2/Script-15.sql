--260513_Script-14까지 진도 나간 후 quiz / 복습 필수
--answer
--1. 급여가 3000 이상인 사원을 조회하세요.
SELECT * FROM emp
WHERE sal >= 3000;

--2. 급여가 1500보다 작은 사원을 조회하세요.
SELECT * FROM EMP
WHERE sal < 1500; --처음에 <= 부호를 사용함.

--3. 부서번호가 10번인 사원을 조회하세요.
SELECT * FROM emp
WHERE deptno = 10;

--4. 직업이 MANAGER가 아닌 사원을 조회하세요.
SELECT * FROM EMP
WHERE job != 'MANAGER';--원래 WHERE not job = 'MANAGER'; 이렇게 써서 틀림

--5. 급여가 1000 이상 3000 이하인 사원을 조회하세요.
SELECT * FROM EMP WHERE sal>=1000 AND sal <=3000;
SELECT * FROM EMP
WHERE sal BETWEEN 1000 AND 3000;

--6. 급여가 1000 이상 3000 이하가 아닌 사원을 조회하세요.
SELECT * FROM EMP e WHERE NOT (sal >= 1000 AND sal <= 3000);
SELECT * FROM emp
WHERE sal NOT BETWEEN 1000 AND 3000;

--7. 부서번호가 10, 20, 30 중 하나인 사원을 조회하세요.
SELECT * FROM EMP 
WHERE deptno IN (10, 20, 30);

--8. 직업이 CLERK, SALESMAN, MANAGER 중 하나인 사원을 조회하세요.
SELECT * FROM EMP WHERE job IN ('CLERK', 'SALESMAN', 'MANAGER');

--9. 직업이 PRESIDENT, ANALYST가 아닌 사원을 조회하세요.
SELECT * FROM EMP WHERE job NOT IN ('PRESIDENT', 'ANALYST');

--10. 사원 이름이 S로 시작하는 사원을 조회하세요.
SELECT * FROM EMP WHERE ename LIKE 'S%';

--11. 사원 이름에 A가 포함된 사원을 조회하세요.
SELECT * FROM EMP WHERE ename LIKE '%A%';

--12. 사원 이름이 N으로 끝나는 사원을 조회하세요.
SELECT * FROM EMP WHERE ename LIKE '%N';

--13. 사원 이름의 두 번째 글자가 A인 사원을 조회하세요.
SELECT * FROM EMP WHERE ename LIKE '_A%';

--14. 사원 이름에 M이 먼저 나오고, 그 뒤에 I가 나오는 사원을 조회하세요.
SELECT * FROM emp WHERE ename LIKE '%M%I%';

--15. 급여에 500을 더한 결과를 출력하세요.
SELECT ename, sal, sal+500 AS salplus500 FROM emp;

--16. 급여에서 100을 뺀 결과를 출력하세요.
SELECT ename, sal, sal-100 AS salminus100 FROM emp;

--17. 급여의 12개월 연봉을 출력하세요.
SELECT ename, sal, sal*12 AS annsal FROM emp;

--18. 급여를 30으로 나눈 하루 급여를 출력하세요.
SELECT ename, sal, sal/30 AS ildang FROM emp;

--19. 급여가 2000 이상이고 부서번호가 20번인 사원을 조회하세요.
SELECT * FROM emp WHERE sal>=2000 AND deptno=20;

--20. 급여가 1500 이상이거나 직업이 SALESMAN인 사원을 조회하세요.
SELECT * FROM EMP where sal >=1500 OR job='SALESMAN';

--21. 부서번호가 30번이고 직업이 SALESMAN인 사원을 조회하세요.
SELECT * FROM EMP WHERE deptno=30 AND job='SALESMAN';

--22. 직업이 CLERK 또는 MANAGER이고 급여가 1000 이상인 사원을 조회하세요.
SELECT * FROM EMP WHERE job IN ('CLERK', 'MANAGER') AND sal >= 1000;

--23. 급여가 1200 이상 2500 이하이고 부서번호가 30번인 사원을 조회하세요.
SELECT * FROM EMP WHERE sal BETWEEN 1200 AND 2500 AND deptno=30;

--24. 사원 이름이 A로 시작하지 않는 사원을 조회하세요.
SELECT * FROM emp WHERE ename NOT LIKE 'A%';

--25. 사원 이름에 L이 포함되지 않는 사원을 조회하세요.
SELECT * FROM EMP WHERE ename NOT LIKE '%L%';

--26. 직업이 MANAGER, CLERK 중 하나이고 부서번호가 10 또는 20인 사원을 조회하세요.
SELECT * FROM EMP WHERE job IN ('CLERK', 'MANAGER') AND deptno IN (10, 20);

--27. 급여에 10% 인상한 금액을 출력하세요. => 이 문제는 공부 좀 더 하기
SELECT ename, sal, sal*1.1 FROM emp;

--28. 급여에 커미션(COMM)을 더한 총액을 출력하세요. 단, COMM이 NULL인 경우는 제외하세요. => 공부 더 필요.
SELECT ename, sal, comm, sal+comm FROM emp WHERE comm IS NOT NULL;

--29. 급여가 2000보다 크고 4000보다 작거나, 직업이 PRESIDENT인 사원을 조회하세요.
SELECT * FROM EMP WHERE (sal>2000 AND sal<4000) OR job = 'PRESIDENT';

--30. 사원 이름이 5글자인 사원을 LIKE를 이용해서 조회하세요.
SELECT * FROM EMP WHERE ename LIKE '_____';


--집합연산자 합집합 / 교집합 / 차집합
--1. union 중복 제거(합집합)
SELECT job FROM EMP
UNION
SELECT job FROM emp;

--2. union all은 중복 제거 안 함.
SELECT job FROM EMP
UNION ALL--union은 중복 제거 / union all은 전체 다 모아서 보여주는 것
SELECT job FROM emp;

--3. intersect(교집합)
SELECT deptno FROM emp--타입 갯수가 같아야 함.
INTERSECT
SELECT deptno FROM dept;

--4. minus
SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

SELECT empno, ename FROM emp -- 여긴 어떤 이유로 알려주신 건지 공부 필요.
UNION SELECT deptno, dname FROM dept dept;


--String function Quiz
--1. 사원 이름을 대문자로 출력하시오. SELECT ename FROM emp;
SELECT ename, upper(ename) AS upper FROM emp;

--2. 사원 이름을 소문자로 출력하시오. SELECT ename FROM emp;
SELECT ename, lower(ename) AS lower FROM emp;

-- 3. 사원 이름의 첫 글자만 대문자로 출력하시오. SELECT ename FROM emp;
SELECT ename, initCap(ename) AS capitalize FROM emp;

-- 4. 사원 이름의 글자 수를 출력하시오. SELECT ename FROM emp;
SELECT ename, length(ename) FROM emp;

-- 5. 사원 이름의 앞 3글자만 출력하시오. SELECT ename FROM emp;
SELECT ename, substr(ename,1,3) FROM emp;

-- 6. 사원 이름의 마지막 2글자만 출력하시오. SELECT ename FROM emp;
SELECT ename, substr(ename, -2) FROM emp;

-- 7. 사원 이름의 두 번째 글자부터 끝까지 출력하시오. SELECT ename FROM emp;
SELECT ename, substr(ename, 2) FROM emp;

-- 8. 사원 이름에 A가 포함된 사원만 출력하시오. SELECT ename FROM emp;
SELECT ename FROM emp WHERE instr(ename, 'A') > 0;

-- 9. 사원 이름에서 A를 *로 바꿔서 출력하시오. SELECT ename FROM emp;


-- 10. 사원 이름 앞에 EMP_를 붙여 출력하시오. 예시: SMITH → EMP_SMITH
SELECT ename, 'EMP_' || ename FROM emp;
SELECT CONCAT('EMP_', ename) FROM emp;

-- 11. 사원 이름 뒤에 _USER를 붙여 출력하시오. 예시: SMITH → SMITH_USER
SELECT ename, ename || '_USER' FROM emp;
SELECT CONCAT(ename, '_USER') FROM emp;

-- 12. 사원 이름의 앞뒤에 [ ]를 붙여 출력하시오. 예시: SMITH → [SMITH]
SELECT '[' || ename || ']' FROM emp;
SELECT CONCAT(CONCAT('[', ename), ']') FROM emp;

-- 13. 사원 이름을 전체 길이 10자리로 만들고, 왼쪽 빈 공간을 *로 채우시오. 예시: SMITH → *****SMITH
SELECT LPAD(ename, 10, '*') FROM emp;

-- 14. 사원 이름을 전체 길이 10자리로 만들고, 오른쪽 빈 공간을 *로 채우시오. 예시: SMITH → SMITH*****
SELECT RPAD(ename, 10, '*') FROM emp;

-- 15. 사원 이름의 첫 글자만 출력하시오. SELECT ename FROM emp;
SELECT SUBSTR(ename,1,1) FROM emp;

-- 16. 사원 이름의 마지막 글자만 출력하시오. SELECT ename FROM emp;
SELECT SUBSTR(ename,-1) FROM emp;

-- 17. 사원 이름의 첫 글자와 마지막 글자만 이어서 출력하시오. 예시: SMITH → SH
SELECT  SUBSTR(ename,1,1)||SUBSTR(ename,-1) FROM emp;
SELECT CONCAT(SUBSTR(ename,1,1),SUBSTR(ename,-1)) FROM emp;

-- 18. 사원 이름의 첫 글자만 남기고 나머지는 **로 출력하시오. 예시: SMITH → S***
SELECT CONCAT(SUBSTR(ename,1,1),'***') FROM emp;

-- 19. 사원 이름의 마지막 글자만 남기고 앞에는 **를 붙여 출력하시오. 예시: SMITH → ***H
SELECT CONCAT('***',SUBSTR(ename,-1)) FROM emp;

-- 20. 사원 이름이 5글자 이상인 사원만 출력하시오. SELECT ename FROM emp;
SELECT ename FROM emp WHERE LENGTH(ename)>=5;

-- 21. 사원 이름이 4글자인 사원만 출력하시오. SELECT ename FROM emp;
SELECT ename FROM emp WHERE LENGTH(ename)=4;
SELECT ename FROM emp WHERE ename LIKE '____';

-- 22. 사원 이름에서 L의 위치를 출력하시오. SELECT ename FROM emp;
SELECT ename, INSTR(ename,'L') FROM emp;

-- 23. 사원 이름에 T가 포함된 사원만 출력하시오. SELECT ename FROM emp;
SELECT ename FROM emp WHERE ename LIKE '%T%';

-- 24. 사원 이름에서 S를 $로 바꿔 출력하시오. SELECT ename FROM emp;
SELECT REPLACE(ename,'S','$') FROM emp;

-- 25. 사원 이름의 앞 2글자만 출력하시오. SELECT ename FROM emp;
SELECT SUBSTR(ename,1,2) FROM emp;

-- 26. 사원 이름의 뒤 3글자만 출력하시오. SELECT ename FROM emp;
SELECT SUBSTR(ename,-3) FROM emp;

-- 27. 사원 이름의 앞 2글자와 뒤 2글자를 이어서 출력하시오. 예시: SMITH → SMTH
SELECT CONCAT(SUBSTR(ename,1,2),SUBSTR(ename,-2)) FROM emp;

-- 28. 사원 이름을 소문자로 바꾼 뒤 _emp를 붙여 출력하시오. 예시: SMITH → smith_emp
SELECT CONCAT(LOWER(ename),'_emp') FROM emp;

-- 29. 사원 이름의 앞 2글자만 남기고 뒤에는 **를 붙여 출력하시오. 예시: SMITH → SM***
SELECT CONCAT(SUBSTR(ename,1,2),'***') FROM emp;

-- 30. 사원 이름의 앞 1글자와 뒤 1글자 사이에 **를 넣어 출력하시오. 예시: SMITH → S***H
SELECT CONCAT(CONCAT(SUBSTR(ename,1,1),'***'),SUBSTR(ename,-1)) FROM emp;
