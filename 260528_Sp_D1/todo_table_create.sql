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
-- 강사님 SQL 아래부터 복붙
INSERT INTO movie VALUES (movie_seq.nextval,'범죄도시','N');
INSERT INTO movie VALUES (movie_seq.nextval,'파묘','N');
INSERT INTO movie VALUES (movie_seq.nextval,'왕과 사는 남자','N');

UPDATE movie SET reserve_yn = 'Y' WHERE NO = 1;
DELETE FROM movie WHERE NO = 1;
ROLLBACK;

COMMIT;

-- hit는 조회수 컬럼, regdate는 글쓴 날짜
-- 게시판 테이블 생성.
DROP TABLE board;
CREATE TABLE board (
	NO NUMBER CONSTRAINT board_no_pk PRIMARY KEY,
	title varchar2(300) CONSTRAINT board_title_nn NOT NULL,
	nickname varchar2(300) CONSTRAINT board_nickname_nn NOT NULL,
	content clob CONSTRAINT board_content_nn NOT NULL,
	hit NUMBER DEFAULT 0,
	regdate DATE DEFAULT sysdate
);

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999999999
nocache
nocycle;

INSERT INTO 
	board(no,title,content,nickname,regdate,hit) 
	values(board_seq.nextval,'제목','내용','홍길동',sysdate,0);


UPDATE board SET hit = hit+1 WHERE NO=3;

SELECT * FROM board;
ROLLBACK;

COMMIT;

SELECT * FROM MEMBER;
CREATE TABLE member (
    no NUMBER CONSTRAINT member_no_pk PRIMARY KEY,

    user_id VARCHAR2(50)
        CONSTRAINT member_user_id_nn NOT NULL,

    user_name VARCHAR2(50)
        CONSTRAINT member_user_name_nn NOT NULL,

    user_pw VARCHAR2(100)
        CONSTRAINT member_user_pw_nn NOT NULL,

    email VARCHAR2(100)
        CONSTRAINT member_email_nn NOT NULL,

    phone VARCHAR2(20)
        CONSTRAINT member_phone_nn NOT NULL,

    address VARCHAR2(300)
        CONSTRAINT member_address_nn NOT NULL,

    reg_date TIMESTAMP DEFAULT SYSTIMESTAMP,

    CONSTRAINT member_user_id_uk UNIQUE (user_id),

    CONSTRAINT member_email_uk UNIQUE (email)
);


CREATE SEQUENCE member_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

INSERT INTO MEMBER VALUES
(member_seq.nextval,'jjang051','장성호','1234','jjang051','010-1111-1111','고양시 장항동 11-11',sysdate);

SELECT * FROM MEMBER;
SELECT count(*) FROM MEMBER WHERE USER_ID='aaa'; -- DB에서 Error 터지면 검증하는 방법?
SELECT count(*) FROM MEMBER WHERE email='gilgildong@naver.com'; -- DB에서 Error 터지면 확인하는 방법?
ROLLBACK;
COMMIT;

SELECT count(*) FROM MEMBER WHERE user_id='aaa' AND user_pw='1234';