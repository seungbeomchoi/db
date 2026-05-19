-- inser / update / delete / selete => DML(data manupulation language)
-- create / drop / alter => DDL(data definition language) 테이블 삭제 및 변경
-- commit / rollback => TCL(transaction control language)

CREATE TABLE emp_ddl (
	empno    number(4),
	ename    varchar2(100), -- varchar (가변 길이 100byte / 영어는 1byte, 한글은 3byte)
	job      varchar2(100),
	mgr      number(4),
	hiredate DATE,
	sal      number(7,2), 
	-- 전체 자릿수는 7개 => ex. 99999.99까지는 가능 / 100000.00(불가) / 12345.678(가능, 마지막 소수는 반올림해서 .68로 들어감), 99999.999(불가)
	comm	 number(7,2),
	deptno   number(2)
);
SELECT * FROM emp_ddl;

INSERT INTO emp_ddl (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (1234, '장성호', 'CEO', NULL, sysdate, 99999, 1000, 10);

INSERT INTO emp_ddl (empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (1235,'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijkl','ceo',NULL,sysdate,99999,1000,10);

INSERT INTO emp_ddl (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (1236, '장성호', 'CEO', NULL, sysdate, 99998.999, 1000, 10);


-- 게시판
CREATE TABLE board(
	NO NUMBER(20),
	subject varchar2(4000),
	contents clob, -- 32TB까지 쓸 수 있음. 캐릭터 라지 오브젝트(긴 문자를 쓸 때 사용)
	contents_blob blob, -- 바이너리 라지 오브젝트 => 이미지를 path 경로만 가지고 저장하는 게 아닌 이미지 그 자체를 byte로 분해해서 저장할 때 사용한다.
	-- 이미지는 너무 파일이 커져서 blob는 잘 안 쓴다. => 데이터베이스가 비싸기 때문에 경로를 저장하는 방식으로 씀. 그 때 varchar2를 많이 씀.
	filename varchar2(1000)
);

INSERT INTO board (NO,subject,contents,contents_blob,filename)
VALUES (1,'제목입니다.','테스트 중입니다.',NULL,NULL);

SELECT * FROM board;

-- drop은 테이블 삭제
DROP TABLE board;

-- ALTER는 수정
-- add는 컬럼 추가
ALTER TABLE board ADD bigo varchar2(20);  
COMMIT;

-- 컬럼의 이름 바꾸기
ALTER TABLE board RENAME COLUMN bigo TO etc;

SELECT * FROM guest_board;
-- table 이름 바꾸기
RENAME board TO guest_board;

--column 삭제
ALTER TABLE guest_board DROP COLUMN etc;

SELECT * FROM guest_board;

--테이블의 이름 바꾸기
RENAME emp_copy TO emp_rename;

SELECT * FROM emp_rename;

INSERT INTO emp_rename (empno) VALUES (10000);
--만약 empno의 타입을 바꾸고 싶을 때
ALTER TABLE emp_rename MODIFY empno NUMBER(5);


INSERT INTO guest_board (NO,subject,contents) VALUES (3,'제목을 씁니다.','내용을 씁니다.');
ROLLBACK;
ALTER TABLE guets_board MODIFY subject varchar2(1000);

UPDATE guets_board SET SUBJECT = '안녕';

DELETE FROM guest_board
WHERE no = 1
  AND subject = '제목입니다.';

SELECT * FROM guest_board;
COMMIT;

--table 삭제
DROP TABLE temp; -- 테이블 자체를 날림.

--내용만 삭제
DELETE FROM guest_board; -- 테이블은 살리고 게스트 보드의 내용만 다 삭제 commit/rollback 가능
TRUNCATE TABLE guest_board; -- 테이블은 살리고 내용만 삭제 but, auto commit. => rollback 불가능 (DELETE보다 삭제 속도가 빠르다?)


--ddl은 쓰는 순간 auto commit이다. => 조심해야 함.


------------------------------------------------------
-- # DDL Quiz

-- ## 1. 회원 테이블 `shop_member`를 생성하시오.
--
-- member_no   NUMBER(10)
-- member_id   VARCHAR2(100)
-- member_name VARCHAR2(100)
-- email       VARCHAR2(200)
-- phone       VARCHAR2(30)
-- regdate     DATE

CREATE TABLE shop_member (
	member_no number(10),
	member_id varchar2(100),
	member_name varchar2(100),
	email varchar2(200),
	phone varchar2(30),
	regdate DATE
);
SELECT * FROM shop_member;

-- ---

-- ## 2. 상품 카테고리 테이블 `category`를 생성하시오.
--
-- category_no   NUMBER(10)
-- category_name VARCHAR2(100)
CREATE TABLE category(
	category_no number(10),
	category_name varchar2(100)
);
SELECT * FROM category;
-- ---

-- ## 3. 상품 테이블 `product`를 생성하시오.
--
-- product_no   NUMBER(10)
-- category_no  NUMBER(10)
-- product_name VARCHAR2(200)
-- price        NUMBER(10,2)
-- stock        NUMBER(10)
-- regdate      DATE

CREATE TABLE product (
	product_no NUMBER(10),
	category_no NUMBER(10),
	product_name varchar2(200),
	price number(10,2),
	stock number(10),
	regdate DATE
);
SELECT * FROM product;
-- ---

-- ## 4. 주문 테이블 `orders`를 생성하시오.
--
-- order_no   NUMBER(10)
-- member_no  NUMBER(10)
-- order_date DATE
-- status     VARCHAR2(50)

CREATE TABLE orders (
	order_no number(10),
	member_no number(10),
	order_date DATE,
	status varchar2(50)
);
SELECT * FROM orders;
-- ---

-- ## 5. 주문 상세 테이블 `order_item`을 생성하시오.
--
-- order_item_no NUMBER(10)
-- order_no      NUMBER(10)
-- product_no    NUMBER(10)
-- quantity      NUMBER(5)
-- order_price   NUMBER(10,2)
CREATE TABLE order_item (
	order_item_no number(10),
	order_no number(10),
	product_no number(10),
	quantity number(5),
	order_price number(10,2)
);
SELECT * FROM ORDER_item;
-- ---

-- ## 6. 장바구니 테이블 `cart`를 생성하시오.
--
-- cart_no    NUMBER(10)
-- member_no  NUMBER(10)
-- product_no NUMBER(10)
-- quantity   NUMBER(5)
-- regdate    DATE
CREATE TABLE cart (
	cart_no number(10),
	member_no  number(10),
	product_no number(10),
	quantity number(5),
	regdate DATE
);
SELECT * FROM cart;
-- ---

-- ## 7. 리뷰 테이블 `review`를 생성하시오.
--
-- review_no  NUMBER(10)
-- member_no  NUMBER(10)
-- product_no NUMBER(10)
-- content    CLOB
-- score      NUMBER(2)
-- regdate    DATE
CREATE TABLE review (
	review_no number(10),
	member_no number(10),
	product_no number(10),
	content clob,
	score number(2),
	regdate DATE
);
SELECT * FROM review;
-- ---

-- ## 8. 배송 테이블 `delivery`를 생성하시오.
--
-- delivery_no NUMBER(10)
-- order_no    NUMBER(10)
-- address     VARCHAR2(500)
-- receiver    VARCHAR2(100)
-- phone       VARCHAR2(30)
-- status      VARCHAR2(50)
CREATE TABLE delivery (
	delivery_no number(10),
	order_no number(10),
	address varchar2(500),
	receiver varchar2(100),
	phone varchar2(30),
	status varchar2(50)
);
SELECT * FROM delivery;
-- ---

-- ## 9. 결제 테이블 `payment`를 생성하시오.
--
-- payment_no   NUMBER(10)
-- order_no     NUMBER(10)
-- pay_method   VARCHAR2(50)
-- pay_amount   NUMBER(10,2)
-- pay_date     DATE
CREATE TABLE payment (
    payment_no NUMBER(10),
    order_no NUMBER(10),
    pay_method VARCHAR2(50),
    pay_amount NUMBER(10,2),
    pay_date DATE
);
SELECT * FROM payment;
-- ---

-- ## 10. 상품 테이블 `product`에 `description` 컬럼을 추가하시오.
--
-- description CLOB
ALTER TABLE product ADD description clob; -- 글자
SELECT * FROM product;
-- ALTER TABLE product DROP COLUMN description;
-- ---

-- ## 11. 상품 테이블 `product`에 `image_data` 컬럼을 추가하시오.
--
-- image_data BLOB
ALTER TABLE product ADD image_date blob; --blob는 잘 안 쓴다.
SELECT * FROM product;

-- ---

-- ## 12. 회원 테이블 `shop_member`에 `address` 컬럼을 추가하시오.
--
-- address VARCHAR2(500)
ALTER TABLE shop_member ADD address varchar2(500);
SELECT * FROM shop_member;
-- ---

-- ## 13. 주문 테이블 `orders`에 `total_price` 컬럼을 추가하시오.
--
-- total_price NUMBER(12,2)
ALTER TABLE orders ADD total_price NUMBER(12,2);
SELECT * FROM orders;
-- ---

-- ## 14. 리뷰 테이블 `review`의 `score` 컬럼 타입을 변경하시오.
--
-- NUMBER(3)
ALTER TABLE review MODIFY score number(3);
COMMIT;
-- ---

-- ## 15. 상품 테이블 `product`의 `product_name` 컬럼 크기를 변경하시오.
--
-- VARCHAR2(500)
ALTER TABLE product MODIFY product_name varchar2(500);
-- ---

-- ## 16. 배송 테이블 `delivery`의 `address` 컬럼 크기를 변경하시오.
--
-- VARCHAR2(1000)
ALTER TABLE delivery MODIFY address varchar2(1000);
-- ---

-- ## 17. 결제 테이블 `payment`의 `pay_amount` 컬럼 타입을 변경하시오.
--
-- NUMBER(12,2)
ALTER TABLE payment MODIFY pay_amount number(12,2);
-- ---
COMMIT;
-- ## 18. 장바구니 테이블 `cart`에서 `regdate` 컬럼을 삭제하시오.
ALTER TABLE cart DROP COLUMN regdate;
SELECT * FROM cart;
-- ---

-- ## 19. 회원 테이블 `shop_member`에서 `phone` 컬럼을 삭제하시오.
ALTER TABLE shop_member DROP COLUMN phone;
SELECT * FROM shop_member;
-- ---

-- ## 20. 상품 테이블 `product`의 `stock` 컬럼 이름을 `stock_qty`로 변경하시오.
ALTER TABLE product RENAME COLUMN stock TO stock_qty;
SELECT * FROM product;
COMMIT;
-- ---

-- ## 21. 회원 테이블 `shop_member`의 `member_name` 컬럼 이름을 `username`으로 변경하시오.
ALTER TABLE shop_member
RENAME COLUMN member_name TO username;
SELECT * FROM shop_member;
-- ---

-- ## 22. 주문 테이블 `orders`의 이름을 `shop_order`로 변경하시오.
RENAME orders TO shop_order;
SELECT * FROM shop_order;
-- ---

-- ## 23. 주문 상세 테이블 `order_item`의 이름을 `shop_order_item`으로 변경하시오.
RENAME order_item TO shop_order_item;
SELECT * FROM shop_order_item;
-- ---
COMMIT;

-- ## 24. 리뷰 테이블 `review`의 모든 데이터를 삭제하시오.
--
-- 조건:
--
-- 테이블 구조는 유지
TRUNCATE TABLE review; --rollback 불가능
DELETE FROM review; --rollback 가능
SELECT * FROM review;
-- ---

-- ## 25. 장바구니 테이블 `cart`의 모든 데이터를 삭제하시오.
--
-- 조건:
--
-- 테이블 구조는 유지
TRUNCATE TABLE cart;
SELECT * FROM cart;
-- ---

-- ## 26. 임시 상품 테이블 `temp_product`를 삭제하시오.
--
-- 조건:
--
-- 테이블 자체 삭제
CREATE TABLE temp_product AS SELECT * FROM product;
SELECT * FROM temp_product;
DROP TABLE temp_product;
COMMIT;
-- ---

-- ## 27. 상품 테이블 `product`를 복사하여 `product_backup` 테이블을 생성하시오.
--
-- 조건:
--
-- 구조와 데이터 모두 복사
CREATE TABLE product_backup AS SELECT * FROM product; --ctas => 무슨 뜻?
SELECT * FROM product_backup;
-- ---

-- ## 28. 회원 테이블 `shop_member`를 복사하여 `member_empty` 테이블을 생성하시오.
--
-- 조건:
--
-- 구조만 복사
-- 데이터 제외
CREATE TABLE member_empty AS SELECT * FROM shop_member WHERE 1 = 0; -- ctas (무슨 뜻?)
SELECT * FROM member_empty;
-- ---

-- ## 29. 결제 테이블 `payment`에 테이블 설명을 추가하시오.
--
-- 주문 결제 정보 테이블
COMMENT ON TABLE payment IS '주문 결제 정보 테이블';

SELECT table_name, comments FROM user_tab_comments
WHERE table_name = 'PAYMENT'; -- 여긴 어떤 기능이길래? 오늘 날짜 기준(26.05.19) 배우지 않아서 내일 배우는 진도라고 함.
COMMIT;
-- ---

-- ## 30. 상품 테이블 `product`의 `image_data` 컬럼에 설명을 추가하시오.
--
-- 상품 이미지 데이터
ALTER TABLE product ADD image_date blob;
SELECT * FROM product;
COMMENT ON COLUMN product.image_data IS '상품 이미지 데이터';
COMMIT;