-- ==================================================
-- Top-N Query Quiz
-- Oracle / DBeaver 기준
-- ==================================================

-- 실행 전 참고
-- 1. 처음 실행이면 DROP TABLE은 실행하지 않아도 됩니다.
-- 2. 이미 member, board 테이블이 있으면 아래 DROP TABLE 2줄을 먼저 실행하세요.
-- 3. 외래키 때문에 자식 테이블 board를 먼저 삭제하고, 부모 테이블 member를 나중에 삭제해야 합니다.

-- DROP TABLE board CASCADE CONSTRAINTS;
-- DROP TABLE member CASCADE CONSTRAINTS;

-- ==================================================
-- 기본 테이블 1. member
-- ==================================================

CREATE TABLE MEMBER (
    member_id VARCHAR2(30)
        CONSTRAINT member_memberid_pk PRIMARY KEY,

    user_name VARCHAR2(100)
        CONSTRAINT member_username_nn NOT NULL,

    user_pw VARCHAR2(100)
        CONSTRAINT member_userpw_nn NOT NULL,

    status VARCHAR2(20)
        DEFAULT 'ACTIVE'
        CONSTRAINT member_status_ck
        CHECK (status IN ('ACTIVE', 'SLEEP', 'LOCK', 'DELETED')),

    deleted_date DATE,
    regdate DATE DEFAULT sysdate
);
SELECT * FROM MEMBER;
DROP TABLE MEMBER;
-- ==================================================
-- 기본 테이블 2. board
-- ==================================================

CREATE TABLE board (
    board_id NUMBER
        CONSTRAINT board_boardid_pk PRIMARY KEY,

    member_id VARCHAR2(30)
        CONSTRAINT board_memberid_nn NOT NULL,

    subject VARCHAR2(200)
        CONSTRAINT board_subject_nn NOT NULL,

    content CLOB
        CONSTRAINT board_content_nn NOT NULL,

    hit NUMBER DEFAULT 0,

    status VARCHAR2(20)
        DEFAULT 'ACTIVE'
        CONSTRAINT board_status_ck
        CHECK (status IN ('ACTIVE', 'DELETED')),

    deleted_date DATE,

    regdate DATE DEFAULT sysdate,

    CONSTRAINT board_member_fk
        FOREIGN KEY (member_id)
        REFERENCES member(member_id)
);
SELECT * FROM board;
-- ==================================================
-- 문제 1. 회원 데이터 추가
-- ==================================================

-- 아래 회원 데이터를 추가하시오.
-- user01 / 홍길동 / 1234
-- user02 / 김철수 / 1111
-- user03 / 이영희 / 2222
INSERT INTO MEMBER (member_id, user_name, user_pw) VALUES ('user01', '홍길동', '1234');
INSERT INTO MEMBER (member_id, user_name, user_pw) VALUES ('user02', '김철수', '1111');
INSERT INTO MEMBER (member_id, user_name, user_pw) VALUES ('user03', '이영희', '2222');

SELECT * FROM MEMBER;

COMMIT;
-- ==================================================
-- 문제 2. 게시글 데이터 추가
-- ==================================================

-- 아래 조건에 맞게 게시글 데이터를 추가하시오.
-- user01 게시글 3개
-- user02 게시글 2개
-- user03 게시글 0개
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (1,'user01','user01 게시글 1', 'user01 작성 첫 번째',10);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (2,'user01','게시글02', '내용02',20);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (3,'user01','게시글03', '내용03',30);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (4,'user02','게시글04', '내용04',40);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (5,'user02','게시글05', '내용05',50);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (6,'user03','게시글06', '내용06',110);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (7,'user03','게시글07', '내용07',31);
INSERT INTO board (board_id, member_id, subject, content, hit) VALUES (8,'user03','게시글08', '내용08',120);


SELECT * FROM board;
SELECT * FROM member;
DELETE FROM board WHERE board_id = 1;

-- ==================================================
-- 문제 3. 회원과 게시글 INNER JOIN 조회
-- ==================================================

-- 회원명, 게시글 제목, 조회수, 작성일을 출력하시오.
-- 출력 컬럼:
-- user_name
-- subject
-- hit
-- regdate
SELECT m.user_name,b.subject,b.hit,b.regdate 
FROM MEMBER m
JOIN board b
ON m.member_id= b.member_id;

-- ==================================================
-- 문제 4. 특정 회원 게시글 조회
-- ==================================================

-- user01이 작성한 게시글만 조회하시오.
SELECT * FROM board WHERE member_id = 'user01';

-- ==================================================
-- 문제 5. 회원별 게시글 개수 조회
-- ==================================================

-- 회원별 게시글 개수를 조회하시오.
-- 출력 컬럼:
-- member_id
-- user_name
-- board_count
SELECT m.member_id,m.user_name,count(b.board_id) AS board_count 
FROM MEMBER m
JOIN board b
ON m.member_id= b.member_id
GROUP BY m.member_id,m.user_name;
COMMIT;
-- ==================================================
-- 문제 6. 게시글이 없는 회원도 포함하여 게시글 개수 조회
-- ==================================================

-- 회원별 게시글 개수를 조회하되, 게시글이 없는 회원도 출력하시오.
SELECT m.member_id, m.user_name,COUNT(b.board_id) AS board_count
FROM MEMBER m
LEFT JOIN board b
ON m.member_id = b.member_id
GROUP BY m.member_id, m.user_name
ORDER BY m.member_id;

-- ==================================================
-- 문제 7. 회원 soft delete 처리
-- ==================================================

-- user01 회원을 탈퇴 처리하시오.
-- 조건:
-- status = DELETED
-- deleted_date = 현재 날짜

UPDATE MEMBER
SET status = 'DELETED',
	deleted_date = sysdate
WHERE member_id = 'user01';

SELECT * FROM MEMBER WHERE member_id = 'user01';

COMMIT;

-- ==================================================
-- 문제 8. 게시글 soft delete 처리
-- ==================================================

-- board_id = 1 게시글을 삭제 처리하시오.
-- 조건:
-- status = DELETED
-- deleted_date = 현재 날짜

UPDATE board SET status = 'DELETED', deleted_date = sysdate WHERE board_id = 1;

SELECT * FROM board WHERE board_id = 1;

COMMIT;
-- ==================================================
-- 문제 9. 정상 회원만 조회
-- ==================================================

-- status가 ACTIVE인 회원만 조회하시오.

SELECT * FROM MEMBER WHERE status = 'ACTIVE';

-- ==================================================
-- 문제 10. 정상 게시글만 조회
-- ==================================================

-- status가 ACTIVE인 게시글만 조회하시오.

SELECT * FROM board WHERE status = 'ACTIVE';

-- ==================================================
-- 문제 11. 정상 회원의 정상 게시글 조회
-- ==================================================

-- 회원 상태가 ACTIVE이고 게시글 상태도 ACTIVE인 게시글만 조회하시오.
-- 출력 컬럼:
-- member_id
-- user_name
-- board_id
-- subject
-- hit

SELECT m.member_id, m.user_name, b.board_id, b.subject, b.hit FROM MEMBER m JOIN board b ON m.member_id = b.member_id WHERE m.status = 'ACTIVE' AND b.status = 'ACTIVE' ORDER BY b.board_id;


-- ==================================================
-- 문제 12. 게시글 hard delete
-- ==================================================

-- board_id = 2 게시글을 실제 삭제하시오.


-- ==================================================
-- 문제 13. 회원 hard delete
-- ==================================================

-- user02 회원이 작성한 게시글을 먼저 삭제한 뒤,
-- user02 회원을 실제 삭제하시오.
DELETE FROM board WHERE MEMBER_id = 'user02'; -- 이게 먼저 선행되어야 함.
DELETE FROM MEMBER WHERE member_id = 'user02';
-- ==================================================
-- 문제 14. 조회수 높은 게시글 TOP 3 조회
-- ==================================================

-- 조회수가 높은 게시글 3개만 조회하시오.
-- 조건:
-- ORDER BY
-- FETCH FIRST
COMMIT;


-- ==================================================
-- 문제 15. 조회수 기준 4~6번째 게시글 조회
-- ==================================================

-- 조회수가 높은 순서로 정렬했을 때
-- 4번째부터 6번째 게시글을 조회하시오.
-- 조건:
-- OFFSET
-- FETCH

-- 주의:
-- 문제 2 조건대로 게시글을 user01 3개 + user02 2개만 넣으면
-- 전체 게시글은 총 5개입니다.
-- 따라서 6번째 게시글은 존재하지 않을 수 있습니다.


-- ==================================================
-- 문제 16. 삭제 게시글 제외 TOP 5 조회
-- ==================================================

-- 삭제되지 않은 게시글 중 조회수가 높은 게시글 5개를 조회하시오.
-- 조건:
-- board.status = ACTIVE


-- ==================================================
-- 문제 17. 탈퇴 회원 제외 TOP 5 조회
-- ==================================================

-- 탈퇴하지 않은 회원이 작성한 게시글 중
-- 조회수가 높은 게시글 5개를 조회하시오.
-- 조건:
-- member.status = ACTIVE


-- ==================================================
-- 문제 18. 종합 조회
-- ==================================================

-- 정상 회원이 작성한 정상 게시글만 조회하시오.
-- 조건:
-- 회원 status = ACTIVE
-- 게시글 status = ACTIVE
-- 조회수 높은 순서
-- 상위 10개