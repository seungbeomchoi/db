--constraints
--제약

CREATE TABLE temp (
	NO number(4),
	name varchar2(100)
);
DROP TABLE temp;-- 아래를 다 진행하고 마지막에 날렸음.
INSERT INTO temp (NO,name) VALUES (1,'장성호'); -- 10번 진행했음. => 레코드? 10개 생성?(맞는 말?)
-- insert / update / delete transaction
COMMIT;
SELECT * FROM temp;
DELETE FROM temp WHERE NO = 1;
SELECT * FROM temp WHERE NO = 1 AND name = '장성호'; -- 중복 데이터가 10개라서 다 똑같이 나온다.
--중복이 안 되게 막아주는 기법들이 존재한다.


DROP TABLE table_notnull;
-- not null (빈 값이 존재하지 않도록 막는 것)
CREATE TABLE table_notnull (
	user_id varchar2(30) CONSTRAINTS table_notnull_user_id NOT NULL, -- 원래는 한 줄에 쓰는 걸 기본으로 한다
	user_pw varchar2(30) CONSTRAINTS table_notnull_user_pw NOT NULL,
	tel varchar2(20)
);
SELECT * FROM table_notnull;
INSERT INTO TABLE_notnull (USER_id,user_pw,tel) VALUES ('jjang051','1234','010-1111-1111');
INSERT INTO TABLE_notnull (USER_id,user_pw,tel) VALUES ('jjang051','1111','010-1111-1111');

INSERT INTO TABLE_notnull (USER_id,user_pw,tel) VALUES ('jjang052','5678',null); -- 이건 들어 감. / tel엔 제약사항이 없어서.
INSERT INTO TABLE_notnull (USER_id,user_pw,tel) VALUES (NULL,NULL,'010-1111-1111'); -- 이렇게 하면 null을 집어 넣을 수 없다고 나옴.

UPDATE table_notnull SET user_pw = NULL WHERE user_id = 'jjang051'; -- 이것도 안 된다. 제약사항은 굉장히 강력함.
UPDATE table_notnull SET tel = null WHERE user_id = 'jjang052';

ALTER TABLE table_notnull MODIFY (tel CONSTRAINTS table_notnull_tel NOT NULL); -- 위에 null 값이 하나 원래 들어가 있어서 진행이 안 됐음. => 위에 tel을 바꾸고 다시 실행하니 됐음.
-- => 바꾸려면 애초에 tel 값에 null 들어 간 레코드가 없어야 함?(맞는 말인지 체크)

ALTER TABLE table_notnull DROP CONSTRAINTS table_notnull_tel; -- 이러면 제약사항이 날라간다.

DELETE FROM table_notnull WHERE user_id = 'jjang051';
ROLLBACK;

DROP TABLE table_unique;
CREATE TABLE table_unique (
	user_id varchar2(30) CONSTRAINTS table_unique_userid UNIQUE,
	user_pw varchar2(30) CONSTRAINTS table_unique_userpw NOT NULL,
	tel varchar2(20)
);

INSERT INTO table_unique (user_id,user_pw,tel) VALUES ('jjang051','1234','010-1111-1111');
INSERT INTO table_unique (user_id,user_pw,tel) VALUES ('jjang051','1111','010-1111-1111'); -- 이건 안 들어갔음. => 왜?
INSERT INTO table_unique (user_id,user_pw,tel) VALUES (null,'1111','010-1111-1111'); -- unique는 null이 들어갈 수 있다. => 조심할 것.(어떻게 들어가는 것인지?)
SELECT * FROM table_unique;
COMMIT;
----------------------------------------------------------------------

CREATE TABLE table_pk (--테이블엔 하나의 PRIMARY KEY만 사용이 가능하다. (중요한 개념이다. => index라는 게 설정이 되기 때문에.)
	user_id varchar2(30) CONSTRAINTS table_pk_userid_pk PRIMARY KEY, -- PRIMARY KEY는 unique에 not null까지 포함된 기능이다?(맞는 말?)
	user_pw varchar2(30) CONSTRAINTS table_pk_userpw NOT NULL,
	email varchar2(100) CONSTRAINTS table_pk_userid_unique UNIQUE CONSTRAINTS table_pk_userid_nn NOT NULL,
	tel varchar2(20)
);
SELECT * FROM table_pk;
INSERT INTO table_pk VALUES ('jjang051','1234','jjang051@hanmail.net','010-1111-1111');
INSERT INTO table_pk VALUES ('jjang052','1234','jjang052@hanmail.net','010-1111-1111');
DROP TABLE table_pk;
----------------------------------------------
--제약사항 조회
SELECT * FROM user_constraints;


CREATE TABLE table_pk (--테이블엔 하나의 PRIMARY KEY만 사용이 가능하다. (중요한 개념이다. => index라는 게 설정이 되기 때문에.)
	user_id varchar2(30),
	user_pw varchar2(30) CONSTRAINTS table_pk_userpw NOT NULL,
	email varchar2(100) CONSTRAINTS table_pk_userid_nn NOT NULL,
	tel varchar2(20),
	 CONSTRAINTs table_pk_userid_pk PRIMARY KEY (user_id), -- PRIMARY KEY는 unique에 not null까지 포함된 기능이다?(맞는 말?)
	 CONSTRAINTs table_pk_userid_unique UNIQUE  (email)
); -- 이런 식으로 만들 수도 있기는 하다. 



-- not null은 컬럼 단위에 쓰는 제약 사항 => 만약 아래 쪽에 사용하려면 check를 통해서 사용한다.
CREATE TABLE table_pk (--테이블엔 하나의 PRIMARY KEY만 사용이 가능하다. (중요한 개념이다. => index라는 게 설정이 되기 때문에.)
	user_id varchar2(30),
	user_pw varchar2(30),
	email varchar2(100),
	tel varchar2(20),
	 CONSTRAINT table_pk_userid_pk PRIMARY KEY (user_id), -- PRIMARY KEY는 unique에 not null까지 포함된 기능이다?(맞는 말?)
	 CONSTRAINT table_pk_userpw_check CHECK (user_pw IS NOT NULL),-- check는 괄호 안에 있는 조건을 확인하는 기능?
     CONSTRAINT table_pk_useremail_nn CHECK (email IS NOT NULL),
	 CONSTRAINT table_pk_useremail_unique UNIQUE (email)
); -- 이런 식으로 만들 수도 있기는 하다. 


ROLLBACK;
COMMIT;

SELECT * FROM table_pk;

-- foreign key
DROP TABLE dept_fk;

SELECT * FROM dept_fk;
CREATE TABLE dept_fk (
	deptno number(2) CONSTRAINT dept_fk_deptno_pk PRIMARY KEY,
	dname varchar2(100),
	loc varchar2(100)
);
INSERT INTO dept_fk VALUES(10,'IT','ILSAN');
INSERT INTO dept_fk VALUES(20,'DB','BUSAN');

CREATE TABLE emp_fk (
	empno number(4) CONSTRAINT emp_fk_empno_pk PRIMARY KEY,
	ename varchar2(100) CONSTRAINT emp_fk_ename_nn NOT NULL,
	deptno number(2) CONSTRAINT emp_fk_deptno_fk REFERENCES dept_fk(deptno)
);
SELECT * FROM emp_fk;
INSERT INTO emp_fk VALUES (10,'aaa',10);
INSERT INTO emp_fk VALUES (2001,'aaa',20);


DROP TABLE table_etc;
CREATE TABLE table_etc (
	user_id varchar(20) CONSTRAINT table_etc_userid_pk PRIMARY KEY,
	user_pw varchar(20) CONSTRAINT table_etc_userpw_nn NOT NULL,
	user_name varchar2(100) CONSTRAINT table_etc_username_ck CHECK(LENGTH(USER_NAME) > 2),
	user_gender char(1) CONSTRAINT table_etc_usergender_ck CHECK(user_gender IN ('M','F')),
	-- oracle엔 boolean이 없어서 char()로 대체한다.
	regdate DATE DEFAULT sysdate -- default를 설정할 수 있다(제약 조건은 아님?)
); -- 프론트는 믿지 말라는 업계에서 유명한 말이 있다. => 들어오는 것들을 자바 스크립트 등에서는 우회해서 들어오는 방법이 많으니
-- 백엔드에서 확실하게 제약을 걸고 체크를 해서 진행하는 게 가장 좋다.
SELECT * FROM table_etc;
INSERT INTO table_etc(user_id,user_pw,user_name) values('jjang051','1234','장성호');
INSERT INTO table_etc(user_id,user_pw,user_name,user_gender) values('jjang052','1234','장성호','F');

COMMIT;

DROP TABLE board;
CREATE TABLE board (
	NO NUMBER CONSTRAINT board_no_pk PRIMARY KEY,
	subject varchar2(200) CONSTRAINT board_subject_nn NOT NULL,
	content clob CONSTRAINT board_content_ck check(LENGTH(content) > 30),
	regdate DATE DEFAULT sysdate
);
SELECT * FROM board; -- oracle은 MySQL처럼 번호가 자동 증가하는 기능이 없다. => 그래서 아래처럼 사용했었음(예전에?)
INSERT INTO board VALUES (1,'aaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',sysdate);
INSERT INTO board VALUES (2,'aaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',sysdate);
INSERT INTO board VALUES (2,'aaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',sysdate);
INSERT INTO board VALUES ((SELECT nvl(max(no),0)+1 FROM board),'aaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',sysdate);


--sequence(자동 증가 기능)
CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1
cache 20-- 미리 번호 저장 안 하겠다.
nocycle; -- 끝나도 다시 돌아가지 않겠다.
INSERT INTO board VALUES (board_seq.nextval,'aaaa','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',sysdate);
--시퀀스 만들면 절대 겹치지 않음. 그럴 일이 없음.
DELETE FROM board WHERE NO = 4;

SELECT * FROM board;

COMMIT;


-- ─────────────────────────────────────────────
-- Constraints Quiz
-- Oracle / DBeaver 기준
-- 각 문제 아래에 직접 CREATE TABLE 문을 작성하면 됩니다.
-- 주의: FOREIGN KEY가 있는 테이블은 참조 대상 테이블이 먼저 생성되어 있어야 합니다.

-- ─────────────────────────────────────────────
-- 1. shop_member 테이블을 생성하시오.
-- member_id : varchar2(30), PRIMARY KEY
-- member_pw : varchar2(100), NOT NULL
-- email     : varchar2(100), UNIQUE + NOT NULL

-- 풀이 작성 위치:
DROP TABLE shop_member;
CREATE TABLE shop_member (
	member_id varchar2(30) CONSTRAINT shop_member_memberid_pk PRIMARY KEY,
	member_pw varchar2(100) CONSTRAINT shop_member_memberpw_nn NOT NULL,
	email varchar2(100) CONSTRAINT shop_member_email_uq UNIQUE
);
INSERT INTO shop_member values('ccc','1234','jjang053@gmail.com');
SELECT * FROM shop_member;
COMMIT;
-- ─────────────────────────────────────────────
-- 2. shop_order 테이블을 생성하시오.
-- order_id   : number, PRIMARY KEY
-- member_id  : varchar2(30), FOREIGN KEY → shop_member(member_id)
-- order_date : date, 기본값 sysdate

-- 풀이 작성 위치:
DROP TABLE shop_order;
CREATE TABLE shop_order (
	order_id NUMBER CONSTRAINT shop_order_order_id_pk PRIMARY KEY,
	member_id varchar2(30) CONSTRAINT shop_order_memberid_fk REFERENCES shop_member(member_id),
	order_date DATE DEFAULT sysdate
);
INSERT INTO shop_order values(113,'ccc',sysdate);
SELECT * FROM shop_order;

-- ─────────────────────────────────────────────
-- 3. blog_user 테이블을 생성하시오.
-- user_id : varchar2(30), PRIMARY KEY
-- name    : varchar2(50), NOT NULL
-- email   : varchar2(100), UNIQUE

-- 풀이 작성 위치:
CREATE TABLE blog_user (
	user_id varchar2(30) CONSTRAINT blog_user_userid_pk PRIMARY KEY,
	name varchar2(50) CONSTRAINT blog_user_name_nn NOT NULL,
	email varchar2(100) CONSTRAINT blog_user_email_uq UNIQUE
);
INSERT INTO blog_user values('aaa','홍길동','jjang051@gmail.com');
SELECT * FROM blog_user;
COMMIT;
-- ─────────────────────────────────────────────
DROP TABLE blog_post;
-- 4. blog_post 테이블을 생성하시오.
-- post_id : number, PRIMARY KEY
-- title   : varchar2(200), NOT NULL
-- user_id : varchar2(30), FOREIGN KEY → blog_user(user_id)

-- 풀이 작성 위치:
CREATE TABLE blog_post (
	post_id NUMBER CONSTRAINT blog_post_postid_pk PRIMARY KEY,
	title varchar2(200) CONSTRAINT blog_post_title_nn NOT NULL,
	user_id varchar2(30) CONSTRAINT blog_post_userid_fk REFERENCES blog_user(user_id)
);
INSERT INTO blog_post VALUES (1,'비옵니다','aaa');
COMMIT;
SELECT * FROM blog_post;

-- ─────────────────────────────────────────────
-- 5. school_student 테이블을 생성하시오.
-- student_id : varchar2(20), PRIMARY KEY
-- name       : varchar2(50), NOT NULL
-- grade      : number(1), 1~6 사이

-- 풀이 작성 위치:
CREATE TABLE school_student (
	student_id varchar2(20) CONSTRAINT school_student_studentid_pk PRIMARY KEY,
	name varchar2(50) CONSTRAINT school_student_name_nn NOT NULL,
	grade number(1) CONSTRAINT school_student_grade_ck CHECK (grade BETWEEN 1 AND 6)
);
INSERT INTO school_student VALUES (111,'장동건',4);
COMMIT;
SELECT * FROM school_student;


-- ─────────────────────────────────────────────
-- 6. school_score 테이블을 생성하시오.
-- score_id   : number, PRIMARY KEY
-- student_id : varchar2(20), FOREIGN KEY → school_student(student_id)
-- subject    : varchar2(50), NOT NULL
-- score      : number(3), 0~100 사이

-- 풀이 작성 위치:
CREATE TABLE school_score (
	score_id number CONSTRAINT school_score_scoreid_pk PRIMARY KEY,
	student_id varchar2(20) CONSTRAINT school_score_studentid_fk REFERENCES school_student(student_id),
	subject varchar2(50) CONSTRAINT school_score_subject_nn NOT NULL,
	score number(3) CONSTRAINT school_score_score_ck CHECK(score BETWEEN 0 AND 100)
);
INSERT INTO school_score VALUES (2,'111','영어',89);
COMMIT;
SELECT * FROM school_score;

-- ─────────────────────────────────────────────
-- 7. library_book 테이블을 생성하시오.
-- book_id : number, PRIMARY KEY
-- title   : varchar2(200), NOT NULL
-- isbn    : varchar2(30), UNIQUE

-- 풀이 작성 위치:
CREATE TABLE library_book (
	book_id NUMBER CONSTRAINT library_book_bookid_pk PRIMARY KEY,
	title varchar2(200) CONSTRAINT library_book_title_nn NOT NULL,
	isbn varchar(30) CONSTRAINT library_book_isbn_uk UNIQUE 
);
INSERT INTO library_book VALUES (2312,'춘향전','33443243243');
COMMIT;
SELECT * FROM library_book;
-- ─────────────────────────────────────────────
-- 8. library_loan 테이블을 생성하시오.
-- loan_id   : number, PRIMARY KEY
-- book_id   : number, FOREIGN KEY → library_book(book_id)
-- loan_date : date, 기본값 sysdate

-- 풀이 작성 위치:
CREATE TABLE library_loan (
	load_id   number         CONSTRAINT library_loan_loadid_pk PRIMARY KEY,
	book_id   number         CONSTRAINT library_loan_bookid_fk REFERENCES library_book(book_id),
	loan_date DATE           DEFAULT sysdate 
);

INSERT INTO library_loan VALUES (12212,2312,sysdate);
COMMIT;
SELECT * FROM library_loan;

-- ─────────────────────────────────────────────
-- 9. hospital_patient 테이블을 생성하시오.
-- patient_id : number, PRIMARY KEY
-- name       : varchar2(50), NOT NULL
-- gender     : char(1), M 또는 F만 가능

-- 풀이 작성 위치:
CREATE TABLE hospital_patient (
	patient_id   number         CONSTRAINT hospital_patient_patientid_pk PRIMARY KEY,
	name         varchar2(50)   CONSTRAINT hospital_patient_name_nn NOT NULL,
	gender       char(1)        CONSTRAINT hospital_patient_gender_ck check(gender IN ('M','F')) 
);
INSERT INTO hospital_patient VALUES (12212,'현빈','M');
INSERT INTO hospital_patient VALUES (12213,'전지현','F');
COMMIT;
SELECT * FROM hospital_patient;


-- ─────────────────────────────────────────────
-- 10. hospital_reservation 테이블을 생성하시오.
-- reservation_id : number, PRIMARY KEY
-- patient_id     : number, FOREIGN KEY → hospital_patient(patient_id)
-- reserve_date   : date, NOT NULL

-- 풀이 작성 위치:
CREATE TABLE hospital_reservation (
	reservation_id		NUMBER CONSTRAINT hospital_reservation_reservationid_pk PRIMARY KEY,
	patient_id			NUMBER CONSTRAINT hospital_reservation_patientid_fk REFERENCES hospital_patient(patient_id),
	reserve_date		DATE   DEFAULT sysdate
);
INSERT INTO hospital_reservation VALUES (122312212,12212,sysdate);
SELECT * FROM hospital_reservation;
COMMIT;

-- ─────────────────────────────────────────────
-- 11. product_category 테이블을 생성하시오.
-- category_id   : number, PRIMARY KEY
-- category_name : varchar2(100), UNIQUE + NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 12. store_product 테이블을 생성하시오.
-- product_id   : number, PRIMARY KEY
-- category_id  : number, FOREIGN KEY → product_category(category_id)
-- product_name : varchar2(100), NOT NULL
-- price        : number(10), 0보다 커야 함

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 13. company_department 테이블을 생성하시오.
-- dept_id   : number, PRIMARY KEY
-- dept_name : varchar2(100), UNIQUE + NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 14. company_employee 테이블을 생성하시오.
-- emp_id  : number, PRIMARY KEY
-- dept_id : number, FOREIGN KEY → company_department(dept_id)
-- ename   : varchar2(50), NOT NULL
-- sal     : number(10), 1000 이상

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 15. movie_theater 테이블을 생성하시오.
-- theater_id   : number, PRIMARY KEY
-- theater_name : varchar2(100), UNIQUE + NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 16. movie_screening 테이블을 생성하시오.
-- screening_id : number, PRIMARY KEY
-- theater_id   : number, FOREIGN KEY → movie_theater(theater_id)
-- movie_title  : varchar2(200), NOT NULL
-- screen_date  : date, NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 17. restaurant_customer 테이블을 생성하시오.
-- customer_id : number, PRIMARY KEY
-- phone       : varchar2(20), UNIQUE + NOT NULL
-- name        : varchar2(50), NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 18. restaurant_booking 테이블을 생성하시오.
-- booking_id   : number, PRIMARY KEY
-- customer_id  : number, FOREIGN KEY → restaurant_customer(customer_id)
-- booking_date : date, NOT NULL
-- seat_count   : number(2), 1 이상

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 19. travel_member 테이블을 생성하시오.
-- travel_id   : number, PRIMARY KEY
-- passport_no : varchar2(50), UNIQUE + NOT NULL
-- name        : varchar2(50), NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 20. travel_ticket 테이블을 생성하시오.
-- ticket_id  : number, PRIMARY KEY
-- travel_id  : number, FOREIGN KEY → travel_member(travel_id)
-- start_date : date, NOT NULL
-- end_date   : date, start_date보다 커야 함

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 21. game_player 테이블을 생성하시오.
-- player_id : varchar2(30), PRIMARY KEY
-- nickname  : varchar2(50), UNIQUE + NOT NULL
-- level_no  : number(3), 1 이상

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 22. game_item 테이블을 생성하시오.
-- item_id   : number, PRIMARY KEY
-- player_id : varchar2(30), FOREIGN KEY → game_player(player_id)
-- item_name : varchar2(100), NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 23. bank_customer 테이블을 생성하시오.
-- customer_id : number, PRIMARY KEY
-- name        : varchar2(50), NOT NULL
-- phone       : varchar2(20), UNIQUE

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 24. bank_account 테이블을 생성하시오.
-- account_no  : varchar2(30), PRIMARY KEY
-- customer_id : number, FOREIGN KEY → bank_customer(customer_id)
-- balance     : number(12), 0 이상

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 25. academy_teacher 테이블을 생성하시오.
-- teacher_id : number, PRIMARY KEY
-- name       : varchar2(50), NOT NULL
-- email      : varchar2(100), UNIQUE

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 26. academy_class 테이블을 생성하시오.
-- class_id   : number, PRIMARY KEY
-- teacher_id : number, FOREIGN KEY → academy_teacher(teacher_id)
-- class_name : varchar2(100), NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 27. warehouse_owner 테이블을 생성하시오.
-- owner_id : number, PRIMARY KEY
-- name     : varchar2(50), NOT NULL
-- tel      : varchar2(20), UNIQUE

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 28. warehouse_info 테이블을 생성하시오.
-- warehouse_id : number, PRIMARY KEY
-- owner_id     : number, FOREIGN KEY → warehouse_owner(owner_id)
-- location     : varchar2(200), NOT NULL
-- capacity     : number(10), 1 이상

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 29. board_writer 테이블을 생성하시오.
-- writer_id : varchar2(30), PRIMARY KEY
-- name      : varchar2(50), NOT NULL
-- email     : varchar2(100), UNIQUE + NOT NULL

-- 풀이 작성 위치:


-- ─────────────────────────────────────────────
-- 30. board_comment 테이블을 생성하시오.
-- comment_id : number, PRIMARY KEY
-- writer_id  : varchar2(30), FOREIGN KEY → board_writer(writer_id)
-- content    : varchar2(1000), NOT NULL
-- regdate    : date, 기본값 sysdate

-- 풀이 작성 위치:



