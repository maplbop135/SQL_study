-- 문제1. 이름이 “JONES”인 사원의 관리 하에 있는 모든 사원의 이름, 급여, 부서 번호를 표시하는 질의를 작성하시오
SELECT a.ename, a.sal, a.deptno, a.mgr
FROM   emp a
START WITH  a.ename = 'JONES'
CONNECT BY a.mgr = PRIOR a.empno;

-- 문제2. 이름이 “ADAMS”인 사원의 상위 관리자들을 모두 표시하는 질의를 작성하시오.
--        (단, 본인을 제외한 상위 관리자들의 사원 번호 및 이름을 출력하시오.)
SELECT a.empno, a.ename
FROM   emp a
START WITH a.empno = (SELECT a.mgr
                      FROM   emp a
                      WHERE  a.ename = 'ADAMS')
CONNECT BY a.empno = PRIOR a.mgr;

-- 문제3. 이름이 “JONES”인 사원의 관리 하에 있는 모든 사원의 사원 번호, 이름, 관리자 사원 번호를 표시하는 질의를
--        작성하시오. (단, 아래와 같이 “ENAME" 열은 관리 계층을 파악할 수 있도록 들여쓰기를 적용하시오.)
SELECT a.empno,
       CASE WHEN LEVEL = 1
       THEN a.ename
       WHEN LEVEL = 2
       THEN '__'||a.ename
       ELSE '____'||a.ename
       END ENAME,
       a.mgr
FROM   emp a
START WITH a.ename = 'JONES'
CONNECT BY a.mgr = PRIOR a.empno;

-- 문제4. (CONNECT BY 절을 사용하지 않고) SELF JOIN을 사용하여 3번 문제를 표시하는 질의를 작성하시오.
DROP TABLE EMP_LV1;
DROP TABLE EMP_LV2;
DROP TABLE EMP_LV3;

CREATE TABLE EMP_LV1
AS
SELECT a.empno,
       a.ename,
       a.mgr
FROM   emp a
WHERE  a.ename = 'JONES';

CREATE TABLE EMP_LV2
AS
SELECT b.empno,
       '__'||b.ename ENAME,
       b.mgr
FROM   emp_lv1 a, emp b
WHERE  b.mgr = a.empno;

CREATE TABLE EMP_LV3
AS
SELECT b.empno,
       '____'||b.ename ENAME,
       b.mgr
FROM   emp_lv2 a, emp b
WHERE  b.mgr = a.empno;

SELECT *
FROM   emp_lv1
UNION
SELECT *
FROM   emp_lv2
UNION
SELECT *
FROM   emp_lv3;

-- 문제5. 모든 사원에 대해 관리 계층을 표시하는 질의를 작성하시오. (단, 이름이 “BLAKE”인 사원의 관리 하에 있는
--        사원들과 직무가 “ANALYST”인 사원들은 모두 제외하고 출력하시오.)
SELECT a.ename, a.job, a.empno, a.mgr
FROM   emp a
WHERE  a.job <> 'ANALYST'
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
           AND a.ename <> 'BLAKE';

-- 문제6. 모든 사원에 대해 관리 계층(LEVEL) 별로 급여 합계 및 평균 급여를 구하시오.
SELECT '관리 계층 '||LEVEL MGR_LV,
       SUM(a.sal) SUM_SAL,
       ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
GROUP BY LEVEL;

-- 문제7. 모든 사원을 ‘최상위 관리자’, ‘중간 관리자’, ‘일반 사원’의 3그룹으로 나누고, 각 그룹 별 급여 합계 및 평균 급여
--        를 구하시오.
SELECT '최고 관리자' MGR_LV,
       SUM(a.sal) SUM_SAL,
       ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
WHERE  a.ename = CONNECT_BY_ROOT a.ename
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
UNION
SELECT CASE WHEN MAX(CONNECT_BY_ISLEAF) = 1
            THEN '일반 사원'
            ELSE '중간 관리자'
       END,
       SUM(a.sal),
       ROUND(AVG(a.sal), 2)
FROM   emp a
WHERE  a.ename <> CONNECT_BY_ROOT a.ename
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
GROUP BY CONNECT_BY_ISLEAF;

-- 문제8. 모든 사원에 대해서 아래와 같이 자신의 상위 관리자(들)를 모두 나열하여 표시하시오.
SELECT a.empno,
       a.ename,
       SUBSTR(SYS_CONNECT_BY_PATH(a.ename, ', '), 3, INSTR(SYS_CONNECT_BY_PATH(a.ename, ', '), ',', -1)-3) MANAGERS
FROM   emp a
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno;

-- 문제9. 모든 사원에 대해 관리 계층을 표시하는 질의를 작성하시오.
--        (단, 동일 계층 내에서 부서 번호의 내림차순, 사원 이름의 오름차순으로 정렬하여 나타내시오.)
SELECT LEVEL,
       a.empno,
       LPAD('_', (LEVEL-1)*2, '_')||a.ename,
       a.deptno
FROM   emp a
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
ORDER SIBLINGS BY a.deptno DESC, a.ename;

-- 문제10. 각 사원 별로 자신의 급여 및 상위 관리자들의 급여에 대한 전체 합계를 표시하시오
SELECT MAX(CONNECT_BY_ROOT a.empno) EMPNO,
       MAX(CONNECT_BY_ROOT a.ename) ENAME,
       SUM(a.sal) SUM_SAL
FROM emp a
CONNECT BY a.empno = PRIOR a.mgr
GROUP BY CONNECT_BY_ROOT a.ename;

 
