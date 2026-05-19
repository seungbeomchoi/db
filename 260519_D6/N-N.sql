--member
--id, name, password, phone, address, birth

--	NO number, --number만 쓰면 굉장히 큰 숫자도 들어갈 수 있다. 괄호를 쓰면 숫자를 정할 수 있다?
CREATE TABLE MEMBER (
	member_id varchar2(100),
	name varchar2(100),
	password varchar2(100)
);
DROP TABLE member_detail;
CREATE TABLE member_detail (
--	member_id varchar2(100), 
--	=> 이게 들어갔어야 함 => 이걸 "외래키"라고 함 / 그리고 값이 중복도 되면 안 되고, null값도 들어가면 안 되는 걸 primary key라고도 함.
	member_id varchar2(100),
	phone varchar2(100),
	address varchar2(300),
	birth DATE
);
-- 요즘 방식?으로 2개로 나눠서 테이블 만들었음.

-- 요즘 비밀번호는 암호화를 하고 복호화하는 걸 아예 만들지 않아서 복호화 자체를 못 하게 한다.(알고리즘 사용)
INSERT INTO MEMBER values('jjang051','장성호','1234');
INSERT INTO MEMBER values('jjang052','장동건','1234');
SELECT * FROM MEMBER;
INSERT INTO member_detail values('jjang051','010-1111-1111','경기도 일산 장항동',to_date('1999/01/10','YYYY/MM/DD'));
INSERT INTO member_detail values('jjang052','010-2222-2222','서울 청담동',to_date('1980/01/10','YYYY/MM/DD'));
SELECT * FROM member_detail;
-- 이렇게 하면 JOIN이 안 된다. 반드시 ON 조건절에 같은 게 있어야 하는데 중복되는 게 없다. => member_id가 있어야 함.


--TRUNCATE TABLE member_detail;


-- 이렇게 아래처럼 되면 이건 1:1 관계라고 한다. => 한 행이(row) 다른 테이블에 한 행(row)과 연결되는 관계
SELECT m.*, md.* -- m과 md의 모든 것
FROM MEMBER m
JOIN member_detail md
ON m.member_id = md.member_id;



CREATE TABLE board (
	member_id varchar2(100),
	subject varchar2(4000), -- 제목
	contents clob,
	regdate date
);
INSERT INTO board VALUES ('jjang051','화요일입니다. 아직 많이 남았습니다.','내용무',sysdate);
INSERT INTO board VALUES ('jjang051','수요일입니다. 아직 이틀 남았습니다.','내용무',sysdate);
SELECT * FROM board;

SELECT m.member_id,m.name,b.* -- m과 md의 모든 것
FROM board b
JOIN member m
ON b.member_id = m.member_id;

COMMIT;

-- 다 대 다 관계는 만들면 안 된다. N:N 다:다
-- 학생 - 과목 => 1:N
-- 과목 - 학생 => 1:N
-- 2개가 맞물리면 N:N 관계가 되는데 이러면 중복 데이터가 계속 생긴다. => 반드시 주의 필요

-- 관객 - 영화


CREATE TABLE student (
	student_id NUMBER,
	student_name varchar2(100)
);
CREATE TABLE subject (
	subject_id NUMBER,
	subject_name varchar2(100)
);
INSERT INTO student values(1,'장성호',101);
INSERT INTO student values(1,'장성호',102);
SELECT * FROM student;

INSERT INTO subject values(101,'db',1);
INSERT INTO subject values(102,'java',2);

UPDATE student SET student_name = '장동건' WHERE student_id = 1;

DELETE FROM student WHERE student_id = 1 AND subject_id = 102;

SELECT * FROM student;

--  N:N
-- 수강신청 

DROP TABLE student;
DROP TABLE subject;
CREATE TABLE enroll (
	student_id NUMBER,
	subject_id NUMBER,
	enroll_date date
);

INSERT INTO student values(1,'장성호');
INSERT INTO student values(2,'장동건');

INSERT INTO subject values(101,'db');
INSERT INTO subject values(102,'java');

SELECT * FROM student;
SELECT * FROM subject;


INSERT INTO enroll values(1,101,sysdate);
INSERT INTO enroll values(1,102,sysdate);
INSERT INTO enroll values(2,102,sysdate);
INSERT INTO enroll values(2,102,sysdate);

SELECT * FROM enroll;

SELECT * FROM enroll WHERE student_id = 1;


UPDATE student SET student_name = '현빈' WHERE student_id = 1;
DELETE FROM enroll WHERE student_id = 1 AND subject_id = 101;



COMMIT;



/** 기존에 64번 줄 --관객 - 영화 바로 아래 내가 강사님 따라 입력했던 코드들. 그 후에 N:N 방식이 이런 식으로 꼬인다고 설명하시면서 코드 바꾸셨음.
CREATE TABLE student (
	student_id NUMBER,
	student_name varchar2(100),
	subject_id NUMBER
);
CREATE TABLE subject (
	subject_id NUMBER,
	subject_name varchar2(100),
	student_id NUMBER
);
INSERT INTO student VALUES(1,'장성호',101);
INSERT INTO student VALUES(1,'장성호',102);
SELECT * FROM student;

INSERT INTO subject VALUES(101,'db',1);
INSERT INTO subject VALUES(102,'java',2);
SELECT * FROM subject;


DROP TABLE student;
DROP TABLE subject;

**/
