DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE member (
    member_id VARCHAR2(30)  CONSTRAINT member_memberid_pk PRIMARY KEY,
    user_name VARCHAR2(100) CONSTRAINT member_username_nn NOT NULL,
    user_pw   VARCHAR2(100) CONSTRAINT member_userpw_nn NOT NULL,
    status    VARCHAR2(20) 	DEFAULT 'ACTIVE' ,
    deleted_date DATE,
    regdate DATE DEFAULT sysdate,
    CONSTRAINT member_status_ck CHECK (status IN ('ACTIVE','SLEEP','LOCK','DELETED'))
);
DROP TABLE board  CASCADE CONSTRAINTS;
CREATE TABLE board (
    board_id NUMBER CONSTRAINT board_boardid_pk PRIMARY KEY,
    member_id VARCHAR2(30) CONSTRAINT board_memberid_nn NOT NULL,
    subject VARCHAR2(200) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    hit NUMBER DEFAULT 0,
    status VARCHAR2(20) DEFAULT'ACTIVE' CONSTRAINT board_status_ck CHECK (status IN ('ACTIVE','DELETED')),
    deleted_date DATE,
    regdate DATE DEFAULT sysdate,
	CONSTRAINT board_member_fk FOREIGN KEY (member_id) REFERENCES member(member_id)
);
--1. 회원 3명 입력
INSERT INTO MEMBER (member_id,user_name, user_pw) VALUES ('user01','홍길동','1234');
INSERT INTO MEMBER (member_id,user_name, user_pw) VALUES ('user02','고길동','1234');
INSERT INTO MEMBER (member_id,user_name, user_pw) VALUES ('user03','장동건','1234');
COMMIT;

--2. board 5개 입력
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (1,'user01','제목01','내용01',10);
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (2,'user01','제목02','내용02',30);
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (3,'user01','제목03','내용03',20);
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (4,'user02','제목04','내용04',50);
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (5,'user02','제목05','내용05',40);
COMMIT;

SELECT * FROM board;
SELECT * FROM member;

--문제 3. 회원과 게시글 INNER JOIN 조회
SELECT m.user_name,b.subject,b.hit,b.regdate 
FROM MEMBER m
JOIN board b
ON m.member_id= b.member_id;

--문제 4. 특정 회원 게시글 조회

SELECT * FROM board WHERE member_id = 'user01';

--문제 5. 회원별 게시글 개수 조회
SELECT m.member_id,m.user_name,count(b.board_id) AS board_count 
FROM MEMBER m
JOIN board b
ON m.member_id= b.member_id
GROUP BY m.member_id,m.user_name;

COMMIT;


--문제 6. 게시글이 없는 회원도 포함하여 게시글 개수 조회
SELECT m.member_id,m.user_name,count(b.board_id) AS board_count 
FROM MEMBER m
LEFT JOIN board b
ON m.member_id= b.member_id
GROUP BY m.member_id,m.user_name;

--문제 7. 회원 soft delete 처리 (user01 회원을 탈퇴 처리하시오).
--DELETE FROM MEMBER WHERE member_id = 'user01';
UPDATE MEMBER SET status = 'DELETED', deleted_date = sysdate WHERE member_id = 'user01';
COMMIT;
SELECT * FROM MEMBER;
ROLLBACK;

--문제 8. 게시글 soft delete 처리 (board_id = 1 게시글을 삭제 처리하시오.)
UPDATE board  SET status = 'DELETED', deleted_date = sysdate WHERE board_id = 1;
SELECT * FROM board;

--문제 9. 정상 회원만 조회
SELECT * FROM MEMBER WHERE status = 'ACTIVE';

--문제 10. 정상 게시글만 조회
SELECT * FROM board WHERE status = 'ACTIVE';

--문제 11. 정상 회원의 정상 게시글 조회
SELECT m.member_id,m.user_name,b.board_id, b.subject,b.hit 
FROM MEMBER m
JOIN board b
ON m.member_id= b.member_id
WHERE m.status = 'ACTIVE' AND b.status = 'ACTIVE';

--문제 12. 게시글 hard delete board_id = 2 게시글을 실제 삭제하시오.
DELETE FROM board WHERE board_id = 2;
SELECT * FROM board;

--문제 13. 회원 hard delete  user02 회원이 작성한 게시글을 먼저 삭제한 뒤, user02 회원을 실제 삭제하시오.
DELETE FROM board WHERE member_id = 'user02';
DELETE FROM MEMBER WHERE member_id = 'user02';
COMMIT;

--문제 14. 조회수 높은 게시글 TOP 3 조회
SELECT * FROM board
ORDER BY hit DESC
FETCH FIRST 3 ROWS ONLY;

SELECT * FROM 
	(SELECT rownum,b.* FROM board b
	ORDER BY hit DESC)
WHERE rownum <=3;


INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (5,'user03','제목05','내용01',110);
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (6,'user03','제목06','내용02',30);
INSERT INTO board (board_id,member_id, subject, content,hit) VALUES (7,'user03','제목07','내용03',120);

COMMIT;

--문제 15. 조회수 기준 4~6번째 게시글 조회
SELECT * FROM board
ORDER BY hit DESC
offset 3 rows
FETCH FIRST 3 ROWS ONLY;

SELECT * FROM (
	SELECT  b.*, rownum AS rnum FROM 
		(SELECT * FROM board ORDER BY hit DESC) b
	) WHERE rnum >3 AND rnum < 6;
	

--문제 16. 삭제 게시글 제외 TOP 5 조회
SELECT * FROM board WHERE status = 'ACTIVE'
ORDER BY hit DESC
FETCH FIRST 5 ROWS ONLY;

--문제 17. 탈퇴 회원 제외 TOP 5 조회 (탈퇴하지 않은 회원이 작성한 게시글 중 조회수가 높은 게시글 5개를 조회하시오.)
SELECT m.member_id,m.user_name,b.board_id,b.subject,b.hit,b.regdate
FROM MEMBER m
JOIN board b
ON m.member_id  = b.member_id
WHERE m.status = 'ACTIVE' 
ORDER BY b.hit DESC
FETCH FIRST 5 ROWS ONLY;

--# 문제 18. 종합 조회 정상 회원이 작성한 정상 게시글만 조회하시오. 
--회원 status = ACTIVE
--게시글 status = ACTIVE
--조회수 높은 순서
--상위 10개
SELECT m.member_id,m.user_name,b.board_id,b.subject,b.hit,b.regdate
FROM MEMBER m
JOIN board b
ON m.member_id  = b.member_id
WHERE m.status = 'ACTIVE' AND b.status = 'ACTIVE' 
ORDER BY b.hit DESC
FETCH FIRST 10 ROWS ONLY;
commit;