-- 문제1. 자신의 관리자가 없는 사원의 사원번호와 이름을 출력하시오.
SELECT a.empno, a.ename
FROM   emp a
WHERE  a.mgr IS NULL;

-- 문제2. 문제 1번에서 구한 사원(들)을 관리자로 두고 있는 사원들의 사원번호와 이름을 출력하시오.
-- 서브쿼리
SELECT a.empno, a.ename
FROM   emp a
WHERE  a.mgr = (
				SELECT a.empno
				FROM   emp a
				WHERE  a.mgr IS NULL
			    );
-- 조인
SELECT b.empno, b.ename
FROM   emp a, -- 관리자
       emp b  -- 관리 사원
WHERE  a.mgr is null
       AND b.mgr = a.empno;
       
-- 문제3. 문제 2번에서 구한 사원(들)을 관리자로 두고 있는 사원들의 사원번호와 이름을 출력하시오.
-- 서브쿼리
SELECT a.empno, a.ename
FROM   emp a
WHERE  a.mgr IN (
				SELECT b.empno
				FROM   emp a, emp b
				WHERE  a.mgr is null
				       AND b.mgr = a.empno
				);
				
-- 조인
SELECT c.empno, c.ename
FROM   emp a, -- 관리자
       emp b, -- 관리 사원
       emp c  -- 관리 사원의 관리 사원
WHERE  a.mgr IS NULL
       AND b.mgr = a.empno
       AND c.mgr = b.empno;