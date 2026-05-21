--1:1 OneToOne OneToMany  ManyToOne
--회원 - 상세페이지
DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE MEMBER (
	no  NUMBER 
		CONSTRAINT member_no_nn NOT NULL
		CONSTRAINT member_no_uk UNIQUE,
	member_id    varchar2(30) 
		CONSTRAINT member_memberid_pk PRIMARY KEY,
	member_name  varchar2(100) 
		CONSTRAINT member_membername_nn NOT NULL,
	member_pw varchar2(100)
			CONSTRAINT member_memberpw_nn NOT NULL,
	status varchar2(20) DEFAULT 'ACTIVE' 
	CONSTRAINT member_status_ck CHECK (status IN ('ACTIVE','SLEEP','LOCK','DELETED')),
	deleted_date DATE,
	deleted_by varchar2(20),
	deleted_reason varchar2(1000),
	regdate DATE DEFAULT sysdate
);
DROP TABLE member_detail CASCADE CONSTRAINTS;
CREATE TABLE member_detail(
	no  NUMBER 
		CONSTRAINT member_detail_no_nn NOT NULL
		CONSTRAINT member_detail_no_uk UNIQUE,
	member_id    varchar2(30) 
		CONSTRAINT member_detail_memberid_pk PRIMARY KEY
		CONSTRAINT member_detail_memberid_fk REFERENCES member(member_id) ON DELETE CASCADE,
	phone varchar2(20)
		CONSTRAINT member_detail_phone_nn NOT NULL
		CONSTRAINT member_detail_phone_uk UNIQUE,
	address varchar2(200),
	birth DATE 
);

--no를 SEQUENCE 로 만들어서 입력
CREATE SEQUENCE seq_member
START WITH 1
INCREMENT  BY 1
MAXVALUE 9999999999999999999
CACHE 10
NOCYCLE ;

CREATE SEQUENCE seq_member_detail
START WITH 1
INCREMENT  BY 1
MAXVALUE 9999999999999999999
CACHE 10
NOCYCLE ;

SELECT seq_member.nextval FROM dual;
SELECT seq_member.currval FROM dual;

COMMIT;

INSERT INTO MEMBER (NO,member_id,member_name,member_pw)  VALUES (seq_member.nextval,'aaaa','장성호','1234');
INSERT INTO MEMBER (NO,member_id,member_name,member_pw) VALUES (seq_member.nextval,'bbbb','장동건','1234');

DELETE FROM MEMBER WHERE member_id = 'aaaa';

UPDATE MEMBER SET status = 'DELETED', 
                  deleted_date = sysdate, 
                  deleted_by ='self',
                  deleted_reason = '자진탈퇴'
WHERE member_id = 'aaaa';
COMMIT;
ROLLBACK;
SELECT * FROM MEMBER;

INSERT INTO MEMBER_detail  VALUES 
	(seq_member_detail.nextval,'aaaa','010-2222-2222','경기도 일산시 백석동',
		to_date('1999-09-05','YYYY-MM-DD'));
INSERT INTO MEMBER_detail  VALUES 
	(seq_member_detail.nextval,'bbbb','010-1111-1111','경기도 일산시 백석동',
		to_date('1999-09-04','YYYY-MM-DD'));


COMMIT;

SELECT * FROM MEMBER;
SELECT * FROM MEMBER_detail;
SELECT m.*,md.ADDRESS ,md.BIRTH ,md.PHONE 
FROM MEMBER m
JOIN MEMBER_DETAIL md 
ON m.MEMBER_ID = md.MEMBER_ID;

DELETE FROM MEMBER WHERE member_id = 'aaaa';

COMMIT;


-- 영화(movie)와 영화상세정보(movie_detail)
--no,movie_id,title,running_time,open_date
--no,movie_id,story,director,star_rating(1~5)
CREATE TABLE movie (
	no  NUMBER 
		CONSTRAINT movie_no_nn NOT NULL
		CONSTRAINT movie_no_uk UNIQUE,
	movie_id    varchar2(30) 
		CONSTRAINT movie_movieid_pk PRIMARY KEY,
	title  varchar2(100) 
		CONSTRAINT movie_title_nn NOT NULL,
	running_time NUMBER 
			CONSTRAINT movie_runningtime_nn NOT NULL,
	open_date DATE 
);
CREATE TABLE movie_detail (
	no  NUMBER 
		CONSTRAINT movie_detail_no_nn NOT NULL
		CONSTRAINT movie_detail_no_uk UNIQUE,
	movie_id    varchar2(30) 
		CONSTRAINT movie_detail_movieid_pk PRIMARY KEY,
	story  clob 
		CONSTRAINT movie_detail_story_nn NOT NULL,
	director varchar2(100) 
			CONSTRAINT movie_detail_director_nn NOT NULL,
	star_rating NUMBER (1) 
			CONSTRAINT movie_detail_starrating_nn NOT NULL
			CONSTRAINT movie_detail_starrating_ck CHECK (star_rating BETWEEN 1 AND 5)
);

INSERT INTO movie VALUES
	(seq_movie.nextval,1002,'왕과 사는 남자',1000000,to_date('2025-02-10','YYYY-MM-DD'));
INSERT INTO movie_detail VALUES
	(seq_movie_detail.nextval,1002,'단종과 엄홍도의 이야기','장항준',3);

SELECT * FROM movie;
SELECT * FROM movie_detail;

COMMIT;

SELECT m.*,md.story,md.director,md.star_rating
FROM movie m
JOIN movie_detail md
ON m.movie_id =  md.movie_id;

SELECT * FROM MEMBER;

DELETE FROM member WHERE member_id = 'aaaa';

COMMIT;

CREATE SEQUENCE seq_movie
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999
CACHE 10
NOCYCLE;

CREATE SEQUENCE seq_movie_detail
START WITH 1
INCREMENT BY 1
MAXVALUE 999999999999
CACHE 10
NOCYCLE;


 