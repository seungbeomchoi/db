-- todo table 생성하기(spring에서)
CREATE TABLE todo (
	NO NUMBER CONSTRAINT todo_no_pk PRIMARY KEY,
	content varchar2(4000) CONSTRAINT todo_content_nn NOT NULL,
	complete varchar2(1) DEFAULT 'N' -- java 21 버전에는 boolean기능?이 없다?(맞는지 체크) => 지금 버전에선 생겼다고 함.
);

CREATE SEQUENCE todo_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999
nocache
nocycle; -- 시퀀스 만들기(왜 만드는지?)

SELECT * FROM todo;

-- quiz => insert 3개 진행하기
INSERT INTO todo (NO,content,complete) VALUES (todo_seq.nextval,'점심 먹기','N');
INSERT INTO todo (NO,content,complete) VALUES (todo_seq.nextval,'산책','N');
INSERT INTO todo (NO,content,complete) VALUES (todo_seq.nextval,'스프링 공부','N');
COMMIT; -- insert 후에는 무조건 꼭 COMMIT; 필수

UPDATE todo SET complete = 'Y' WHERE NO=4;
DELETE FROM todo WHERE NO=4;

--
CREATE TABLE movie (
	NO NUMBER CONSTRAINT movie_no_pk PRIMARY KEY,
	title varchar2(100) CONSTRAINT movie_title_nn NOT NULL,
	reserve_yn varchar2(1) DEFAULT 'N'
);

CREATE SEQUENCE movie_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999999999
nocache
nocycle;

SELECT * FROM movie;

COMMIT;