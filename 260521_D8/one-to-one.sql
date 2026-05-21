-- 1:1
--JK?배울 때 @OneToOne OneToMany ManyToOne이렇게 사용한다?
-- 1:N => OneToMany / ManyToMany
-- 회원간 상세 페이지
DROP TABLE MEMBER;
DROP TABLE MEMBER_DETAIL;
CREATE TABLE MEMBER (
	NO 				NUMBER 		  CONSTRAINT member_no_nn NOT NULL CONSTRAINT member_no_uq UNIQUE,
	member_id		varchar2(30)  CONSTRAINT member_memberid_pk PRIMARY KEY,
	member_name		varchar2(100) CONSTRAINT member_membername_nn NOT NULL,
	member_pw		varchar2(100) CONSTRAINT member_memberpw_nn NOT NULL,
	status			varchar(20)   DEFAULT 'ACTIVE'
								  CONSTRAINT member_status_ck CHECK (status IN ('ACTIVE','SLEEP','LOCK','DELETED')),
	deleted_date	DATE,
	deleted_by		varchar2
	regdate			DATE 		  DEFAULT sysdate
);
SELECT * FROM MEMBER;
-- OneToOne에는 foreign key가 반드시 있어야 한다. => 왜?
DROP TABLE member_detail;
CREATE TABLE member_detail (
	NO 				NUMBER 		 CONSTRAINT member_detail_no_nn NOT NULL 
								 CONSTRAINT member_detail_no_uq UNIQUE,
	member_id		varchar2(30) CONSTRAINT member_detail_memberid_pk PRIMARY KEY-- 이게 없으면 중복되도 상관 없다는 얘기가 된다.
								 CONSTRAINT member_detail_memberid_fk REFERENCES member(member_id) ON DELETE CASCADE,
	phont			varchar2(20) CONSTRAINT member_detail_phone_no_nn NOT NULL 
								 CONSTRAINT member_detail_phone_no_uq UNIQUE,
	address 		varchar2(200),
	birth			DATE
);

ALTER TABLE member_detail
RENAME COLUMN phont TO phone;

SELECT * FROM member_detail;
COMMIT;

-- NO를 sequence로 만들어서 입력해서 member_detail에 INSERT로 값을 넣어놔라
CREATE SEQUENCE seq_member
START WITH 1
INCREMENT BY 1
MAXVALUE 99999999999999999999
CACHE 10 -- 캐시를 10개 정도 확보해주겠다 => 왜? 무슨 말?
NOCYCLE; -- MAXVALUE의 값이 끝나도 순환을 안 하겠다? 무슨 말?

CREATE SEQUENCE seq_member_detail
START WITH 1
INCREMENT BY 1
MAXVALUE 99999999999999999999
CACHE 10
NOCYCLE;

SELECT seq_member.nextval FROM dual;
SELECT seq_member.currval FROM dual;

INSERT INTO MEMBER VALUES (seq_member.nextval, 'aaaa', '장성호', '1234', sysdate);
INSERT INTO MEMBER VALUES (seq_member.nextval, 'bbbb', '장동건', '1234', sysdate);
INSERT INTO MEMBER_detail VALUES (seq_member_detail.nextval, 'aaaa', '010-1111-1111','경기도 고양시 장항동',
								  to_date('1999-09-02','YYYY-MM-DD'));
INSERT INTO MEMBER_detail VALUES (seq_member_detail.nextval, 'bbbb', '010-2222-2222','경기도 고양시 백석동',
								  to_date('1999-09-05','YYYY-MM-DD'));
-- 이름은 위에 있으니 다시 입력 안 함.
SELECT * FROM MEMBER;
SELECT * FROM MEMBER_detail;
--아래는 조인해서 쓸 때
SELECT m.*,md.ADDRESS, md.BIRTH, md.PHONE FROM MEMBER m JOIN member_detail md ON m.member_id = md.member_id;

DELETE FROM MEMBER WHERE member_id = 'aaaa';
COMMIT;

--영화(movie)와 영화 상세 정보(movie_detail) / type은 알아서 사용
--no, movie_id, title, running_time, open_date(상영일)
--no, movie_id, story, director(감독), star_rationg(별점, 1~5점까지만 사용할 수 있게)
CREATE TABLE movie (
	NO			 NUMBER    	   CONSTRAINT movie_no_nn NOT NULL 
						  	   CONSTRAINT movie_no_uq UNIQUE,
	movie_id	 varchar2(30)  CONSTRAINT movie_movieid_pk PRIMARY KEY,
	title	 	 varchar2(100) CONSTRAINT movie_title_nn NOT NULL,
	running_time NUMBER
							   CONSTRAINT movie_runningtime_nn NOT NULL,
	open_date	 DATE		   
);
SELECT * FROM movie;
DROP TABLE movie;
DROP TABLE movie_detail;

CREATE TABLE movie_detail (
	NO			 NUMBER		   CONSTRAINT movie_detail_no_nn NOT NULL 
							   CONSTRAINT movie_detail_no_uq UNIQUE,
	movie_id     varchar2(30) 
							   CONSTRAINT movie_detail_movieid_pk PRIMARY KEY,
	story  		 clob   
							   CONSTRAINT movie_detail_story_nn NOT NULL,
	director 	 varchar2(100) 
							   CONSTRAINT movie_detail_director_nn NOT NULL,
	star_rating  NUMBER (1) 
							   CONSTRAINT movie_detail_starrating_nn NOT NULL
							   CONSTRAINT movie_detail_starrating_ck CHECK (star_rating BETWEEN 1 AND 5)
); 						  	   

INSERT INTO movie VALUES (seq_movie.nextval,1002,'왕과 사는 남자',1000000,to_date('2025-02-10','YYYY-MM-DD'));
INSERT INTO movie_detail VALUES (seq_movie_detail.nextval,1002,'단종과 엄홍도의 이야기','장항준',3);


SELECT * FROM movie;
SELECT * FROM movie_detail;

DROP TABLE MEMBER CASCADE CONSTRAINTS; --cascade를 같이 쓰면 하위에 있는 constraints도 함께 삭제하라고 하는 것? => 무슨 말?

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


--delete에는 soft / hard delete가 있다. => 확인할 것.
--status를 1/0으로 해서? 