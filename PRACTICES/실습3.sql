-- 문제1. 아래와 같이 모든 사원의 이름, 부서 번호, 부서 이름을 표시하는 SQL을 작성하시오.
SELECT a.ename, a.deptno, b.dname
FROM   emp a, dept b
WHERE  a.deptno = b.deptno;

-- 문제2. 10번 부서에 속하는 모든 사원의 직무와 부서 위치를 표시하시오.
SELECT a.job, b.loc
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND a.deptno = 10;

-- 문제3. 커미션을 받는 모든 사원의 이름, 부서 이름, 부서 위치를 표시하시오.
SELECT a.ename, b.dname, b.loc
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND a.comm > 0;

-- 문제4. 이름에 “A”(대문자)가 포함된 모든 사원의 이름과 부서 이름을 표시하시오
SELECT a.ename, b.dname
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND a.ename LIKE '%A%';

-- 문제5. “CHICAGO”에서 근무하는 모든 사원의 이름, 직무, 부서 번호 및 부서 이름을 표시하시오.
SELECT a.ename, a.job, b.deptno, b.dname
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND b.loc = 'CHICAGO';

-- 문제6. 각 사원의 이름 및 사원 번호를 해당 관리자의 이름 및 사원 번호와 함께 표시하고, 레이블(LABEL)을 순서대로 EMP_NM, EMP#, MGR_NM, MGR#로 지정하시오.
--        (단, 관리자가 없는 사원은 포함하지 않는다.)
SELECT a.ename AS EMP_NM,
       a.empno AS EMP#,
       b.ename AS MGR_NM,
       a.mgr AS MGR_#
FROM   emp a, -- 사원
       emp b -- 매니저
WHERE  a.mgr = b.empno;

-- 문제7. 각 사원의 이름 및 사원 번호를 해당 관리자의 이름 및 사원 번호와 함께 표시하고, 레이블(LABEL)을 순서대로 EMP_NM, EMP#, MGR_NM, MGR#로 지정하시오.
--        (단, 관리자가 없는 사원도 포함하여 표시하고, 결과 집합을 사원 번호(EMP#)를 기준으로 정렬하시오.)
SELECT a.ename AS EMP_NM,
       a.empno AS EMP#,
       b.ename AS MGR_NM,
       a.mgr AS MGR_#
FROM   emp a, -- 사원
       emp b -- 매니저
WHERE  a.mgr = b.empno(+)
ORDER BY a.empno;

-- 문제8. “MARTIN”과 같은 부서의 사원을 표시하고, 레이블을 순서대로 ENAME, DEPTNO, ENAME_1 로 지정하시오.
SELECT a.ename, b.deptno,
       b.ename AS ENAME_1
FROM   emp a, -- 마틴
       emp b -- 같은 부서 사원
WHERE  a.ename = 'MARTIN'
       AND b.deptno = a.deptno
       AND b.ename <> 'MARTIN';

-- 문제9. 각 사원들의 정보(사원 번호, 이름, 직무, 부서 이름, 급여)와 함께 급여에 대한 등급을 표시하고 결과를 급여의 내림차순, 사원 번호의 오름차순 기준으로 정렬하시오.
--        (단, 급여 등급은 SALGRADE 테이블 기준)
SELECT a.empno, a.ename, a.job, b.dname, a.sal, c.grade
FROM   emp a, dept b, salgrade c
WHERE  a.deptno = b.deptno
       AND a.sal BETWEEN c.losal AND c.hisal
ORDER BY a.sal DESC,
         a.empno;

-- 문제10. 이름이 “CLARK”인 사원보다 늦게 입사한 사원의 이름과 입사 일자를 표시하시오.
SELECT MAX(b.ename) AS ENAME,
       MAX(b.hiredate) AS HIREDATE
FROM   emp a,
       emp b
WHERE  a.ename = 'CLARK'
       AND b.hiredate > a.hiredate
GROUP BY b.empno;

-- 문제11. 자신의 관리자(MGR)보다 먼저 입사한 모든 사원의 이름과 입사 일자를 관리자의 이름 및 입사 일자와 함께 표시하고,
--         레이블을 순서대로 EMP_NM, EMP_HIRED, MGR_NM, MGR_HIRED로 지정하시오.
SELECT a.ename AS EMP_NM,
       a.hiredate AS EMP_HIRED,
       b.ename AS MGR_NM,
       b.hiredate AS MGR_HIRED
FROM   emp a, emp b
WHERE  a.mgr = b.empno
       AND b.hiredate > a.hiredate;
       
-- 문제12. 모든 부서의 부서 번호, 부서 이름과 함께 부서에 소속된 사원의 급여 합계를 표시하시오.
--         (단, 소속된 사원이 없는 부서도 포함하여 표시하고, 급여 합계는 0으로 표시하시오.)
SELECT b.deptno, b.dname,
       SUM(NVL(a.sal, 0)) AS SUM_SAL
FROM   emp a, dept b
WHERE  a.deptno(+) = b.deptno
GROUP BY dname, b.deptno;
