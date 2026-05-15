-- cast-function
--cast "11"
-- 프론트에서 백단으로 넘어오면 싹 다 String이다.
SELECT empno + '500' AS plus500 FROM emp; -- 묵시적 변환(무슨 뜻인지 공부하기)
SELECT empno + TO_NUMBER('500') AS plus500 FROM emp; -- 명시적 변환(무스 뜻?)

-- Numer, char, date(숫자, 문자, 날짜) 이렇게 되어 있다? sql이? 아니면 java가? => 무슨 뜻?
SELECT 
	sysdate, 
	TO_CHAR(sysdate, 'YYYY/MM/DD DAY HH24:MI:SS') AS formatDate,
	TO_CHAR(sysdate, 'YYYY/MM/DD DAY AM HH:MI:SS') AS formatDateAPM,-- AM, PM 둘 중 뭘 써도 상관없다.
	TO_CHAR(sysdate, 'YYYY/MM/DD DAY DY AM HH:MI:SS') AS formatDateDay,-- AM, PM 둘 중 뭘 써도 상관없다.
	TO_CHAR(sysdate, 'YYYY/MONTH/DD DY AM HH:MI:SS') AS formatDateMonth,
	TO_CHAR(sysdate+30, 'YYYY/MON/DD DY AM HH:MI:SS') AS formatDateMonth,
	TO_CHAR(sysdate+30, 'YYYY/MON/DD DY AM HH:MI:SS',
						'NLS_DATE_LANGUAGE=KOREAN') AS formatDateMonthNLS
FROM dual;

SELECT * FROM NLS_SESSION_PARAMETERS; -- 설정 보기?
ALTER SESSION SET NLS_DATE_LANGUAGE=AMERICAN; -- 설정 변경?


SELECT
	sysdate,
	'2026-05-14',
	TO_DATE('2026-05-14', 'YYYY-MM-DD') AS formatDate,
	TO_DATE('2026/05/14', 'YYYY-MM-DD') AS formatDate02,
	TO_DATE('2026/05/14 13:25:15', 'YYYY/MM/DD HH24:MI:SS') AS formatDate03
FROM dual;


--문자를 숫자로
SELECT
	'100' + '100' AS implicit,
	TO_NUMBER('100')+TO_NUMBER('100') AS explicit
FROM dual;


SELECT
	TO_NUMBER('1,000', '9,999') AS format01,
	TO_NUMBER('  100  ') AS format02,
	TO_NUMBER('  -100  ') AS format03
FROM dual;

SELECT
	999,
	TO_CHAR(999,'99999') AS format01,
	TO_CHAR(999,'00000') AS format02,
	TO_CHAR(999, 'fm99999') AS format03 --fm을 붙이면 공백을 없앤다.
FROM dual;

SELECT
	empno,
	TO_CHAR(empno, 'fm99999999'),
	TO_CHAR(empno, '00000000')
FROM emp;

-- 9는 없으면 공백, 0은 채우기 (공백은 없애고 싶으면 앞에 fm 붙여주면 된다.)
SELECT
	sal,
	TO_CHAR(989898989, 'fm999,999,999,999.000')
FROM emp;


-- 강사님 DB quiz

-- 1. 급여를 천 단위 콤마 형식으로 출력하시오. SELECT ename, sal FROM emp;
SELECT ename,sal,TO_CHAR(sal,'fm999,999') FROM EMP;

-- 2. 급여를 `￦1,250` 형식으로 출력하시오. SELECT ename, sal FROM emp;
SELECT ename, sal, TO_CHAR(sal,'L999,999') FROM emp;
SELECT ename, sal, TO_CHAR(sal,'L999,999', 'NLS_CURRENCY = \') FROM emp;

-- 3. 급여를 소수 둘째 자리까지 표시하시오. 예: `1250.00` SELECT ename, sal FROM emp;
SELECT ename,sal, TO_CHAR(sal,'fm99,999.00') FROM emp;

-- 4. 사원번호를 6자리로 맞추고 앞자리는 0으로 채우시오. 예: `007369` SELECT empno, ename FROM emp;
SELECT empno, ename, TO_CHAR(empno,'000000') FROM emp;

-- 5. 커미션이 NULL이면 0으로 처리한 뒤 천 단위 콤마로 출력하시오. SELECT ename, comm FROM emp;
SELECT ename,comm,TO_CHAR(NVL(comm,0),'fm999,999') FROM emp;

-- 6. 급여와 커미션의 합계를 구하고 천 단위 콤마로 출력하시오. SELECT ename, sal, comm FROM emp;
SELECT ename, sal, comm, TO_CHAR(sal+NVL(comm,0),'fm999,999') AS total FROM emp;

-- 7. 문자열 `'1,250'`을 숫자로 변환한 뒤 10을 곱하시오. SELECT'1,250' FROM dual;
SELECT TO_NUMBER('1,250','9,999')*10 FROM dual;

-- 8. 문자열 `'000123'`을 숫자로 변환한 뒤 100을 더하시오. SELECT'000123' FROM dual;
SELECT TO_NUMBER('000123')+100 FROM dual;

-- 9. 문자열 `'12,345.67'`을 숫자로 변환하시오. SELECT'12,345.67' FROM dual;
SELECT to_number('12,345.67','99,999.99') FROM dual;

-- 10. 문자열 `'2026-05-14'`를 날짜로 변환한 뒤 7일 후 날짜를 출력하시오. SELECT'2026-05-14' FROM dual;
SELECT TO_DATE('2026-05-14', 'YYYY-MM-DD')+7 FROM dual;

-- 11. 문자열 `'2026/05/14 15:30:20'`를 날짜로 변환하시오. SELECT'2026/05/14 15:30:20' FROM dual;
SELECT TO_DATE('2026/05/14 15:30:20', 'YYYY/MM/DD HH24:MI:SS') FROM dual;

-- 12. 문자열 `'20260514'`를 날짜로 변환한 뒤 `YYYY/MM/DD` 형식으로 출력하시오. SELECT'20260514' FROM dual;
SELECT TO_CHAR(TO_DATE('20260514','YYYYMMDD'),'YYYY/MM/DD') FROM dual;

-- 13. 현재 날짜를 `YYYY년 MM월 DD일 AM HH시 MI분 SS초` 형식으로 출력하시오. SELECT sysdate FROM dual;
SELECT TO_CHAR(sysdate,'YYYY"년" MM"월" DD"일" AM HH"시" MI"분" SS"초"') FROM dual;

-- 14. 현재 날짜의 요일을 한글 또는 영어 요일로 출력하시오. SELECT sysdate FROM dual;
SELECT TO_CHAR(sysdate,'DAY'),
	   TO_CHAR(sysdate, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN')
FROM dual;

-- 15. 현재 날짜 기준 이번 달 1일과 이번 달 마지막 날을 함께 출력하시오. SELECT sysdate FROM dual;
SELECT TRUNC(sysdate,'MM'), LAST_DAY(sysdate) FROM dual;

-- 16. 현재 날짜 기준 다음 달 1일을 출력하시오. SELECT sysdate FROM dual;
SELECT ADD_MONTHS(TRUNC(sysdate,'MM'),1) FROM dual;
SELECT LAST_DAY(sysdate)+1 FROM dual;

-- 17. 현재 날짜 기준 이번 분기의 시작일을 출력하시오. SELECT sysdate FROM dual;
SELECT TRUNC(sysdate,'Q') FROM dual;

-- 18. 현재 날짜 기준 연도 시작일을 출력하시오. SELECT sysdate FROM dual;
SELECT TRUNC(sysdate,'YYYY') FROM dual;

-- 19. 입사일 기준 근무 일수를 정수로 출력하시오. SELECT ename, hiredate FROM emp;
SELECT ename,hiredate,TRUNC(sysdate-HIREDATE) FROM emp;

-- 20. 입사일 기준 근무 개월 수를 정수로 출력하시오. SELECT ename, hiredate FROM emp;
SELECT ename,hiredate,TRUNC(MONTHS_BETWEEN(sysdate,hiredate)) FROM emp;

-- 21. 급여를 백의 자리에서 반올림하시오. SELECT ename, sal FROM emp;
SELECT ename, sal, ROUND(sal,-3) FROM emp; -- 아래 trunc와 반대 기능?

-- 22. 급여를 백의 자리에서 버림 처리하시오. SELECT ename, sal FROM emp;
SELECT ename,sal,TRUNC(sal,-3) FROM emp; -- trunc가 버림 기능? 뒤에 -3은 일, 십, 백 해서 백의 자리?

-- 23. 급여를 12개월 기준 연봉으로 계산하고 천 단위 콤마로 출력하시오. SELECT ename, sal FROM emp;
SELECT ename,TO_CHAR(sal*12,'999,999') FROM emp; -- 이게 왜 천 단위 콤마로 되는 건지?

-- 24. 급여의 3.3%를 세금으로 계산하고 원 단위 절사하시오. SELECT ename, sal FROM emp;
SELECT ename, sal AS 세전, sal-TRUNC(sal*0.033) AS 세후 FROM emp; --3.3이 왜 sal*0.033을 해야 하는지?

-- 25. 급여를 3으로 나눈 나머지를 출력하시오. SELECT ename, sal FROM emp;
SELECT ename, MOD(sal,3) FROM emp; -- 왜 이렇게 되는지? mod는 뭐고 두 번째 인덱스의 3은 뭘 뜻하는지?

-- 26. 사원번호가 홀수인 사원만 출력하시오. SELECT empno, ename FROM emp;
SELECT ename, empno FROM emp WHERE mod(empno,2) = 1; -- 홀수 사원을 왜 이렇게 계산하는지?

-- 27. 숫자 `1234.56`을 절댓값으로 바꾼 뒤 소수 첫째 자리까지 반올림하시오. SELECT-1234.56 FROM dual;
SELECT ROUND(ABS(-1234.56),1) FROM dual; -- 왜 이렇게 계산하는 건지 철저히 설명 필요

-- 28. 숫자 `2`의 `10`제곱과 `1024`의 제곱근을 함께 출력하시오. SELECT2,1024 FROM dual;
SELECT power(2,10), sqrt(1024) FROM dual;

-- 29. 급여를 기준으로 1000 단위 구간을 출력하시오. 예: `1250` → `1000`, `2850` → `2000` SELECT ename, sal FROM emp;
SELECT trunc(sal,-3) FROM emp;

-- 30. 입사일을 `YYYY-MM` 형식으로 변환하여 월별로 그룹화하고 사원 수를 출력하시오. SELECT hiredate FROM emp;
SELECT TO_CHAR(hiredate, 'YYYY-MM') AS hire_month, COUNT(*) FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY-MM')
ORDER BY hire_month;
