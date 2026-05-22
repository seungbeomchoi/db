--altco 계정에서 진행

-- 정규화 normalization 1nf 2nf 3nf
-- order
CREATE TABLE ORDER_all (
	order_id		NUMBER,
	user_name		varchar2(100),
	user_phon		varchar2(20),
	product_name	varchar2(100),
	product_price	NUMBER,
	company_name	varchar2(100),
	company_tel		varchar2(20),
	order_count		NUMBER
);

ALTER  TABLE order_all RENAME COLUMN user_phon TO user_phone;
INSERT INTO order_all VALUES (1,'장성호','010-1111-1111','키보드',50000,'로지텍','02-1111-1111',1);
INSERT INTO order_all VALUES (1,'장성호','010-1111-1111','마우스',30000,'로지텍','02-1111-1111',2);
INSERT INTO order_all VALUES (2,'장동건','010-2222-2222','모니터',300000,'삼성','02-2222-2222',1);
SELECT * FROM ORDER_all;

COMMIT;

SELECT user_name, user_phone, count(*)
FROM order_all
GROUP BY user_name, user_phone;


-- 1nf는 중복 제거(첫 번째 정규화)
DROP TABLE MEMBER CASCADE CONSTRAINTS;

CREATE TABLE MEMBER (
	user_id			varchar2(30),
	user_name		varchar2(100),
	user_phone		varchar2(20),
	CONSTRAINT member_pk PRIMARY KEY (user_id));

INSERT INTO MEMBER VALUES ('user01','장성호','010-1111-1111');
INSERT INTO MEMBER VALUES ('user02','장동건','010-2222-2222');

SELECT * FROM MEMBER;


CREATE TABLE company (
	company_id		NUMBER,
	company_name	varchar2(100) CONSTRAINT company_name_nn NOT NULL,
	company_tel		varchar2(20),
	CONSTRAINT company_id_pk PRIMARY KEY (company_id));
INSERT INTO company VALUES (1,'로지텍','010-1111-1111');
INSERT INTO company VALUES (2,'삼성','010-2222-2222');

SELECT * FROM company;
DELETE FROM MEMBER WHERE user_name IN('로지텍', '삼성');

COMMIT;

-- 상품 테이블 만들기
DROP TABLE product CASCADE CONSTRAINT;
CREATE TABLE product (
	product_id		NUMBER		  CONSTRAINT product_productid_pk PRIMARY KEY,
	product_name	varchar2(100) CONSTRAINT product_name_nn NOT NULL,
	product_price	NUMBER		  CONSTRAINT product_price_nn NOT NULL,
	company_id		NUMBER		  CONSTRAINT product_companyid_nn NOT NULL,
	CONSTRAINT product_companyid_fk FOREIGN KEY(company_id)
	REFERENCES company(company_id)
);

INSERT INTO product VALUES (10,'키보드',50000,1);
INSERT INTO product VALUES (20,'마우스',30000,1);
INSERT INTO product VALUES (30,'모니터',300000,2);
COMMIT;
SELECT * FROM product;

-- N:N 관계에서(또는 N:M 관계라고도 부름?)는 중간에 테이블을 하나 더 만들어줘야 한다? => 왜?
-- orders 만들어보기 / order_item
CREATE TABLE orders (
	order_id	NUMBER CONSTRAINT orders_orderid_pk PRIMARY KEY,
	user_id		varchar2(30)
	CONSTRAINT orders_userid_nn NOT NULL
	CONSTRAINT orders_userid_fk REFERENCES MEMBER(user_id),
	order_date DATE DEFAULT sysdate
);
INSERT INTO orders (order_id, user_id) VALUES (1,'user01');
INSERT INTO orders (order_id, user_id) VALUES (2,'user02');

-- 주문 상품 테이블
-- order_item, order_id, product_id, order_count
--SQL Error [2270] [42000]: ORA-02270: no matching unique or primary key for this column-list product 테이블에 primary key 없어서 이 에러 났었음 => 그 후 수정 진행
CREATE TABLE order_item (
	order_id	NUMBER CONSTRAINT order_item_orderid_fk REFERENCES orders(order_id), -- 레퍼런스를 건다? 이게 무슨 말? 그리고 왜 거는 건지?
	product_id	NUMBER CONSTRAINT order_item_productid_fk REFERENCES product(product_id),
	order_count NUMBER CONSTRAINT order_item_ordercount_nn NOT NULL,
	CONSTRAINT order_item_pk PRIMARY KEY (order_id,product_id) -- PRIMARY KEY를 2개 사용할 때 이런 식으로 사용한다? => 왜?
);
SELECT * FROM order_item;

INSERT INTO order_item VALUES (1,10,1);
INSERT INTO order_item VALUES (1,20,2);
INSERT INTO order_item VALUES (2,30,1);
COMMIT;

SELECT 
	o.order_id,
	m.user_name,
	m.user_phone,
	p.product_name,
	p.product_price,
	c.company_name,
	c.company_tel,
	oi.order_count,
	p.product_price*oi.order_count AS total_price,
	o.order_date
FROM orders o
JOIN MEMBER m
ON o.user_id = m.user_id
JOIN order_item oi
ON o.order_id = oi.ORDER_id
JOIN product p
ON oi.product_id = p.product_id
JOIN company c
ON p.company_id = c.company_id;

COMMIT;
SELECT * FROM order_item;


-- ==================================================
-- Normalization Quiz
-- ==================================================

-- 다음 테이블을 정규화하시오.

CREATE TABLE course_all (
    student_id      VARCHAR2(30),
    student_name    VARCHAR2(100),
    student_phone   VARCHAR2(20),
    course_name     VARCHAR2(100),
    teacher_name    VARCHAR2(100),
    teacher_phone   VARCHAR2(20),
    classroom_name  VARCHAR2(100),
    classroom_loc   VARCHAR2(100),
    course_price    NUMBER
);

SELECT * FROM course_all;
-- ==================================================
-- 힌트
-- ==================================================

-- 학생
-- 강사
-- 강의실
-- 과정
-- 수강신청

INSERT INTO course_all VALUES (
	's001',
	'장성호',
	'010-1111-1111',
	'java',
	'이호선',
	'010-2222-2222',
	'A강의실',
	'4층',
	1000000
);
INSERT INTO course_all VALUES (
	's001',
	'장성호',
	'010-1111-1111',
	'oracle',
	'삼호선',
	'010-3333-3333',
	'B강의실',
	'5층',
	400000
);
INSERT INTO course_all VALUES (
	's001',
	'장성호',
	'010-1111-1111',
	'spring',
	'사호선',
	'010-4444-4444',
	'C강의실',
	'6층',
	600000
);


SELECT * FROM course_all;

DELETE FROM course_all WHERE course_price = 5000000;
COMMIT;


CREATE TABLE student (
    student_id     VARCHAR2(30) CONSTRAINT student_studentid_pk PRIMARY KEY,
    student_name   VARCHAR2(100)  CONSTRAINT student_studentname_nn NOT NULL ,
    student_phone  VARCHAR2(20)
);
INSERT INTO student VALUES ('s001','장성호','010-1111-1111');
INSERT INTO student VALUES ('s002','장동건','010-9999-9999');
select * FROM student;


DROP TABLE course CASCADE CONSTRAINTS;
CREATE TABLE course (
	course_id      NUMBER CONSTRAINT course_id_pk PRIMARY KEY,
    course_name    VARCHAR2(100),
    course_price   NUMBER,
	teacher_id     NUMBER CONSTRAINT course_teacherid_nn NOT NULL,
    classroom_id   NUMBER CONSTRAINT course_classroomid_nn NOT NULL,
    CONSTRAINT course_teacherid_fk FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id),
    CONSTRAINT course_classroomid_fk FOREIGN KEY (classroom_id) REFERENCES classroom(classroom_id)
);
INSERT INTO course VALUES (
	1,
	'Java',
	500000,
	1,
	1
);
INSERT INTO course VALUES (
	2,
	'Oracle',
	400000,
	2,
	2
);
INSERT INTO course VALUES (
	3,
	'Spring',
	1000000,
	3,
	3
);
COMMIT;
SELECT * FROM student;

DROP TABLE enroll;
CREATE TABLE enroll (
    student_id   VARCHAR2(100),
    course_id    NUMBER,
    enroll_date DATE DEFAULT sysdate,
    CONSTRAINT enroll_pk PRIMARY KEY (student_id,course_id),
    CONSTRAINT enroll_studentid_fk FOREIGN KEY(student_id)  REFERENCES student(student_id),
    CONSTRAINT enroll_courseid_fk FOREIGN KEY(course_id)  REFERENCES course(course_id)
);
INSERT INTO enroll VALUES ('s001',1,sysdate);
INSERT into enroll VALUES ('s001',2,sysdate);
INSERT into enroll VALUES ('s002',1,sysdate);
COMMIT;
--student,course,enroll
SELECT * FROM enroll;


--3차
CREATE TABLE teacher (
	teacher_id   NUMBER CONSTRAINT teacher_id_pk PRIMARY KEY,
	teacher_name VARCHAR2(100) CONSTRAINT course_name_teachername_nn NOT NULL,
	teacher_phone VARCHAR2(20)
);
INSERT INTO teacher values(1,'이호선','010-2222-2222');
INSERT INTO teacher values(2,'삼호선','010-3333-3333');
INSERT INTO teacher values(3,'삼호선','010-4444-4444');

CREATE TABLE classroom (
	classroom_id   NUMBER CONSTRAINT classroom_id_pk PRIMARY KEY,
	classroom_name VARCHAR2(100) CONSTRAINT classroom_name_nn NOT NULL,
    classroom_loc  VARCHAR2(100) CONSTRAINT classroom_loc_nn NOT NULL
);
INSERT INTO classroom values(1,'A강의실','1층');
INSERT INTO classroom values(2,'B강의실','2층');
INSERT INTO classroom values(3,'C강의실','3층');

SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM classroom;


SELECT
	s.student_id,s.student_name,s.student_phone,
	t.teacher_name,
	c.course_id,c.course_name,c.course_price,
	e.enroll_date
FROM enroll e
JOIN student s
ON e.student_id = s.student_id
JOIN course c
ON e.course_id = c.course_id
JOIN teacher t
ON c.teacher_id = t.teacher_id;


COMMIT;
