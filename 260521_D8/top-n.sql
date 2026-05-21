-- top n query
SELECT * FROM emp;
SELECT rownum, e.* FROM emp e; -- 가상 컬럼 pseudo column

SELECT rownum, e.* FROM emp e
WHERE rownum <= 3;


-- top n query
SELECT * FROM (
	SELECT rownum AS rnum, e.* FROM (
		SELECT * FROM emp
		ORDER BY sal desc
	) e
)
WHERE rnum BETWEEN 4 AND 6;

SELECT * FROM emp
ORDER BY sal DESC
offset 3 ROWS -- 처음 3개를 건너뛰고
FETCH FIRST 3 ROWS ONLY; -- 다음 3개를 가져와라
-- FETCH NEXT 3 ROWS ONLY; FIRST 대신 NEXT를 써도 된다.

COMMIT;


--MyBatis 형식

--<< < 1|2|3|4|5|6 > >>
--page = 4
--SIZE = 3; 상수
--offset = (page-1)*size
--<SELECT id = "findPage" resultType="Emp">
--	SELECT * FROM emp
--	ORDER BY sal DESC
--	OFFSET #{offset} ROWS --처음 3개를 건너뛰고 
--	FETCH FIRST #{size} ROWS ONLY; -- 다음 3개를 가져와라  FIRST 대신에 next를 써도 된다.
--</SELECT>
