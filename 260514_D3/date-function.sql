--날짜 함수
--sysdate는 dbtimezone 기준으로 출력
SELECT sysdate FROM dual;

SELECT dbtimezone, sessiontimezone FROM dual;

SELECT current_date FROM dual;--대한민국 시간