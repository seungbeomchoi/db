--------------------------------------------------
-- DEPT 테이블 / scott에서 진행
--------------------------------------------------

CREATE TABLE dept (--테이블 만드는 명령어
    deptno NUMBER(2) PRIMARY KEY,-- deptno, dname, loc는 컬럼명. 그 옆은 데이터 타입(NUMBER 등)
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

COMMIT;

--------------------------------------------------
-- EMP 테이블
--------------------------------------------------

CREATE TABLE emp (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    deptno NUMBER(2),
    CONSTRAINT fk_dept FOREIGN KEY (deptno)
    REFERENCES dept(deptno)
);

INSERT INTO emp VALUES
(7369, 'SMITH', 'CLERK', 7902,
TO_DATE('1980-12-17','YYYY-MM-DD'),
800, NULL, 20);

INSERT INTO emp VALUES
(7499, 'ALLEN', 'SALESMAN', 7698,
TO_DATE('1981-02-20','YYYY-MM-DD'),
1600, 300, 30);

INSERT INTO emp VALUES
(7521, 'WARD', 'SALESMAN', 7698,
TO_DATE('1981-02-22','YYYY-MM-DD'),
1250, 500, 30);

INSERT INTO emp VALUES
(7566, 'JONES', 'MANAGER', 7839,
TO_DATE('1981-04-02','YYYY-MM-DD'),
2975, NULL, 20);

INSERT INTO emp VALUES
(7654, 'MARTIN', 'SALESMAN', 7698,
TO_DATE('1981-09-28','YYYY-MM-DD'),
1250, 1400, 30);

INSERT INTO emp VALUES
(7698, 'BLAKE', 'MANAGER', 7839,
TO_DATE('1981-05-01','YYYY-MM-DD'),
2850, NULL, 30);

INSERT INTO emp VALUES
(7782, 'CLARK', 'MANAGER', 7839,
TO_DATE('1981-06-09','YYYY-MM-DD'),
2450, NULL, 10);

INSERT INTO emp VALUES
(7788, 'SCOTT', 'ANALYST', 7566,
TO_DATE('1987-07-13','YYYY-MM-DD'),
3000, NULL, 20);

INSERT INTO emp VALUES
(7839, 'KING', 'PRESIDENT', NULL,
TO_DATE('1981-11-17','YYYY-MM-DD'),
5000, NULL, 10);

INSERT INTO emp VALUES
(7844, 'TURNER', 'SALESMAN', 7698,
TO_DATE('1981-09-08','YYYY-MM-DD'),
1500, 0, 30);

INSERT INTO emp VALUES
(7876, 'ADAMS', 'CLERK', 7788,
TO_DATE('1987-07-13','YYYY-MM-DD'),
1100, NULL, 20);

INSERT INTO emp VALUES
(7900, 'JAMES', 'CLERK', 7698,
TO_DATE('1981-12-03','YYYY-MM-DD'),
950, NULL, 30);

INSERT INTO emp VALUES
(7902, 'FORD', 'ANALYST', 7566,
TO_DATE('1981-12-03','YYYY-MM-DD'),
3000, NULL, 20);

INSERT INTO emp VALUES
(7934, 'MILLER', 'CLERK', 7782,
TO_DATE('1982-01-23','YYYY-MM-DD'),
1300, NULL, 10);

COMMIT;

--------------------------------------------------
-- SALGRADE 테이블
--------------------------------------------------

CREATE TABLE salgrade (
    grade NUMBER,
    losal NUMBER,
    hisal NUMBER
);

INSERT INTO salgrade VALUES (1, 700, 1200);
INSERT INTO salgrade VALUES (2, 1201, 1400);
INSERT INTO salgrade VALUES (3, 1401, 2000);
INSERT INTO salgrade VALUES (4, 2001, 3000);
INSERT INTO salgrade VALUES (5, 3001, 9999);