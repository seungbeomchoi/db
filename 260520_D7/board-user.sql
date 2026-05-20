/*

--게시판
필요한 것들 user(사용자), board, comment, like
1:1 1:N N:N => 여기서 N:N 관계만 피하면 된다.
USER 입장에서 BOARD를 봤을 때
USER		BOARD
  1     :     N
USER		COMMENT
  1		:	  N
BOARD		COMMENT
  1		:	  N
USER		LIKE
  N		:	  M(N)

board_user
board
board_comment
board_like
*/

/*
1. 한 명의 사용자는 여러 개의 게시글을 작성할 수 있다.

2. 하나의 게시글에는 여러 개의 댓글이 작성될 수 있다.

3. 한 명의 사용자는 여러 게시글에 좋아요를 누를 수 있다.

4. 하나의 게시글도 여러 사용자에게 좋아요를 받을 수 있다.

5. 같은 사용자는 같은 게시글에 좋아요를 한 번만 누를 수 있어야 한다.

6. 댓글은 어떤 게시글에 작성되었는지와 누가 작성했는지를 저장해야 한다.
*/

-- ─────────────────────────────────────────────
--user 테이블
--
--user_id   : varchar2(30), PRIMARY KEY
--user_pw   : varchar2(100), NOT NULL
--nickname  : varchar2(50), UNIQUE + NOT NULL
--regdate   : date, 기본값 sysdate
DROP TABLE board_user;
SELECT * FROM board_user;
CREATE TABLE board_user (
	user_id		varchar2(30)  CONSTRAINT board_userid_pk PRIMARY KEY,
	user_pw		varchar2(100) CONSTRAINT board_userpw_nn NOT NULL,
	user_name 	varchar2(100) CONSTRAINT board_username_nn NOT NULL,
	regdate 	DATE 		  DEFAULT sysdate
);
-- ─────────────────────────────────────────────
--board 테이블
--
--board_id : number, PRIMARY KEY
--user_id  : varchar2(30), FOREIGN KEY
--subject  : varchar2(200), NOT NULL
--content  : clob, NOT NULL
--hit      : number, 기본값 0
--regdate  : date, 기본값 sysdate
DROP TABLE board;
SELECT * FROM board;
CREATE TABLE board (
	board_id	NUMBER 			CONSTRAINT board_boardid_pk PRIMARY KEY,
	user_id		varchar2(30)	,
	subject		varchar2(200) 	CONSTRAINT board_subject_nn NOT NULL,
	content		clob 			CONSTRAINT board_content_nn NOT NULL,
	hit			NUMBER 			DEFAULT 0,
	regdate		DATE   			DEFAULT sysdate,
	CONSTRAINT board_user_fk 	FOREIGN KEY (user_id) REFERENCES board_user(user_id)
);
COMMIT;
-- ─────────────────────────────────────────────
--comment 테이블
--
--comment_id : number, PRIMARY KEY
--board_id   : number, FOREIGN KEY
--user_id    : varchar2(30), FOREIGN KEY
--content    : varchar2(1000), NOT NULL
--regdate    : date, 기본값 sysdate
DROP TABLE board_comment;
CREATE TABLE board_comment (
	comment_id NUMBER         CONSTRAINT board_comment_commentid_pk PRIMARY KEY,
	board_id   NUMBER ,
	user_id    varchar2(30),
	content    varchar2(4000) CONSTRAINT board_comment_content_nn NOT NULL,
	regdate  DATE             DEFAULT sysdate,
	CONSTRAINT board_comment_boardid_fk  FOREIGN KEY (board_id) REFERENCES board(board_id),
	CONSTRAINT board_comment_userid_fk   FOREIGN KEY (user_id)  REFERENCES board_user(user_id)
);


INSERT INTO board_user values('jjang051','1234','장성호',sysdate);
INSERT INTO board_user values('hong','1234','홍길동',sysdate);
INSERT INTO board_user values('lee','1234','이순신',sysdate);

SELECT * FROM board WHERE user_id = 'jjang051';
INSERT INTO board values(4,'hong','제목04','내용04',1,sysdate);
SELECT * FROM board;
COMMIT;


INSERT INTO board_comment values(1,1,'jjang051','댓글01',sysdate);
INSERT INTO board_comment values(2,1,'hong','댓글02',sysdate);
SELECT * FROM board_comment;

-- top/n query => 위에서부터 몇 개까지만 끊어서 가져온다?
SELECT * FROM board;
--join을 써야 함
SELECT b.board_id,b.SUBJECT,b.CONTENT,u.user_name,b.REGDATE
FROM board b 
JOIN board_user u 
ON b.user_id = u.user_id;
-- ─────────────────────────────────────────────
--like 테이블
--
--like_id  : number, PRIMARY KEY
--board_id : number, FOREIGN KEY
--user_id  : varchar2(30), FOREIGN KEY
--regdate  : date, 기본값 sysdate
DROP TABLE board_like;
CREATE TABLE board_like (
	like_id    NUMBER         CONSTRAINT board_like_likeid_pk PRIMARY KEY,
	board_id   NUMBER ,
	user_id    varchar2(30),
	regdate    DATE             DEFAULT sysdate,
	CONSTRAINT board_like_boardid_fk  FOREIGN KEY (board_id) REFERENCES board(board_id),
	CONSTRAINT board_like_userid_fk   FOREIGN KEY (user_id)  REFERENCES board_user(user_id),
	CONSTRAINT board_like_unique   UNIQUE (board_id,user_id)	
);
SELECT * FROM board_like;
INSERT INTO board_like values(1,1,'jjang051',sysdate);
INSERT INTO board_like values(2,1,'hong',sysdate);
INSERT INTO board_like values(3,2,'hong',sysdate);
INSERT INTO board_like values(4,2,'jjang051',sysdate);
INSERT INTO board_like values(5,2,'lee',sysdate);

-- ─────────────────────────────────────────────


-- join 게시글 + 댓글 수 + 좋아야 수 출력할 수 있게 만들어 보는 게 오늘 할 숙제

