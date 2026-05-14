--날짜 함수
--sysdate는 dbtimezone 기준으로 출력
SELECT sysdate FROM dual;

SELECT dbtimezone, sessiontimezone FROM dual;

SELECT current_date FROM dual;--대한민국 시간

SELECT systimestamp FROM dual;

-- 미지의 서울 sysdate - 1(어제)는 지나갔고 sysdate + 1(내일)은 오지 않았고, 
--
SELECT sysdate, 
	   sysdate + 1 AS tomorrow, 
	   sysdate - 1 AS yesterday
FROM dual;

SELECT sysdate, 
	   sysdate + 1/24 AS --1 hour later
FROM dual;

-- 월 더하기(개월 수 더하기)
SELECT add_months(sysdate, 1),   --1 month later / 날짜는 어떻게 될 지 모르니 함부로 +30, +31하는 게 아니고 함수로 사용한다.
	   ADD_MONTHS(sysdate, 12),
	   ADD_MONTHS(sysdate, 12*10)
	   ADD_MONTHS(sysdate, -2) -- 2개월 전
FROM dual;

-- 개월 수 더하기
SELECT ADD_MONTHS(hiredate,120) AS ten_annuary
FROM emp;

-- 개월 수 차이
SELECT hiredate, 
	   MONTHS_BETWEEN(sysdate, hiredate) AS work_month, 
	   trunc(MONTHS_BETWEEN(sysdate, hiredate)/12) AS work_month02
FROM emp;

--년, 월, 일 추출
SELECT-- 추출하는 것? => 뭘 추출하는지?
	EXTRACT(YEAR FROM sysdate) AS YEAR, 
	EXTRACT(MONTH FROM sysdate) AS MONTH, 
	EXTRACT(DAY FROM sysdate) AS DAY 
FROM dual; 

--마지막 날짜 (해당 날짜가 속한 마지막 날)
SELECT LAST_DAY(sysdate) FROM dual;

--해당 날짜 기준으로 다음 월요일 찾기
SELECT NEXT_DAY(sysdate, 'MONDAY') FROM dual;

--quiz : 다음 달 첫 번째 금요일 찾기
SELECT NEXT_DAY(LAST_DAY(sysdate), 'FRIDAY') FROM dual;

-- 이번 달 마지막 금요일 찾기
SELECT NEXT_DAY(LAST_DAY(sysdate)-7, 'FRIDAY') FROM dual;

SELECT 
	sysdate, 
	round(sysdate) AS formatTime, -- 12시(정오) 기준으로 다음 날짜
	round(sysdate, 'CC') AS formatCC, -- 세기 기준으로 다음 세기 2001
	round(sysdate, 'YYYY') AS formatYear, -- 6월 30일 기준 다음 년도
	round(sysdate, 'MM') AS formatMonth, -- 15일 기준으로 이번 달 / 다음 달
	round(sysdate, 'Q') AS formatQuater, -- 분기 기준 => 26.05.14 기준으로 26-04-01(2분기 첫 째날로 나옴)
	round(sysdate, 'DDD') AS formatDay, -- 하루 기준 12시 기준으로 오늘 또는 내일 => 12시인지 00시인지 체크하기
	round(sysdate, 'HH') AS formatHour -- 30분 기준으로 다음 시간 / 현재 시간
FROM dual
UNION
SELECT 
	sysdate, 
	trunc(sysdate) AS formatTime, -- 12시(정오) 기준으로 다음 날짜
	trunc(sysdate, 'CC') AS formatCC, -- 세기 기준으로 다음 세기 2001
	trunc(sysdate, 'YYYY') AS formatYear, -- 6월 30일 기준 다음 년도
	trunc(sysdate, 'MM') AS formatMonth, -- 15일 기준으로 이번 달 / 다음 달
	trunc(sysdate, 'Q') AS formatQuater, -- 분기 기준 => 26.05.14 기준으로 26-04-01(2분기 첫 째날로 나옴)
	trunc(sysdate, 'DDD') AS formatDay, -- 하루 기준 12시 기준으로 오늘 또는 내일 => 12시인지 00시인지 체크하기
	trunc(sysdate, 'HH') AS formatHour -- 30분 기준으로 다음 시간 / 현재 시간
FROM dual;


