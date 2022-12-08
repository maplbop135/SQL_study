-- 문제1. PIVOT 절을 사용하여 직무가 'CLERK'인 사원의 급여 합계를 "CLERK_SUMSAL" 열로, 직무가 'MANAGER'인
--        사원의 급여 합계를 "MANAGER_SUMSAL" 열로 표시하는 질의를 작성하시오.
SELECT *
FROM   (SELECT a.job, a.sal FROM emp a) a
PIVOT  (SUM(a.sal) FOR job IN ('CLERK' AS CLERK_SUMSAL, 'MANAGER' AS MANAGER_SUMSAL));

-- 문제2. PIVOT 절을 사용하여 각 부서별로 직무가 'CLERK'인 사원의 급여 합계를 "CLERK_SUMSAL" 열로, 직무가
--        'MANAGER'인 사원의 급여 합계를 "MANAGER_SUMSAL" 열로 표시하는 질의를 작성하시오.
SELECT *
FROM   (SELECT a.deptno, a.job, a.sal FROM emp a) a
PIVOT  (SUM(a.sal) FOR job IN ('CLERK' AS CLERK_SUMSAL, 'MANAGER' AS MANAGER_SUMSAL));

-- 문제3. PIVOT 절을 사용하여 각 직무 별로 해당 급여 등급에 속한 사원 수를 나타내는 질의를 작성하시오.
--        (급여등급 별 사원 수는 GRADE1_CNT ~ GRADE5_CNT 열로 나타내시오.)
SELECT *
FROM   (SELECT a.job, b.grade FROM emp a, salgrade b WHERE a.sal BETWEEN b.losal and b.hisal) a
PIVOT  (COUNT(*) CNT FOR grade IN (1 GRADE1, 2 GRADE2, 3 GRADE3, 4 GRADE4, 5 GRADE5));

-- 문제4. PIVOT 절을 사용하여 입사년도 별로 각 월마다 입사한 사원 수를 나타내는 질의를 작성하시오.
--        (월별 입사한 사원 수는 M01_CNT ~ M12_CNT 열로 나타내시오.)
SELECT *
FROM   (SELECT EXTRACT(YEAR FROM a.hiredate) HIRE_YEAR, EXTRACT(MONTH FROM a.hiredate) HIRE_MONTH FROM emp a) a
PIVOT  (COUNT(*) CNT FOR hire_month IN(1 M01, 2 M02, 3 M03, 4 M04,
                                       5 M05, 6 M06, 7 M07, 8 M08,
                                       9 M09,10 M10,11 M11,12 M12));

-- 문제5. UNPIVOT 절을 사용하여 급여등급 테이블의 최저 급여와 최고 급여를 하나의 열(STD_SAL)에 나타내고, 이를
--        구분할 수 있는 열(SAL_GB)을 추가하여 구분 값('LOW', 'HIGH')을 나타내시오.
SELECT *
FROM   salgrade
UNPIVOT (STD_SAL FOR SAL_GB IN(losal AS 'LOW', hisal AS 'HIGH'));

-- 문제6. UNPIVOT 절을 사용하여 20번 부서의 각 칼럼 정보를 각각의 행으로 나타내시오.
--        (단, 원본 테이블(DEPT)의 칼럼 명은 INFO_GB 열에, 칼럼 값은 INFO_VAL 열에 나타내시오.)
SELECT *
FROM   (SELECT TO_CHAR(a.deptno) DEPTNO, a.dname, a.loc FROM dept a WHERE deptno = 20) a
UNPIVOT (INFO_VAL FOR INFO_GB IN(deptno, dname, loc));

-- 문제7. 아래 SQL에 UNPIVOT 절을 추가하여 열(왼쪽 결과)을 행(오른쪽 결과)으로 전환하시오.
SELECT *
FROM   (SELECT COUNT(CASE WHEN A.SAL BETWEEN    0 AND  999 THEN 1 END) AS CNT_SAL_0000,
               COUNT(CASE WHEN A.SAL BETWEEN 1000 AND 1999 THEN 1 END) AS CNT_SAL_1000,
               COUNT(CASE WHEN A.SAL BETWEEN 2000 AND 2999 THEN 1 END) AS CNT_SAL_2000,
               COUNT(CASE WHEN A.SAL BETWEEN 3000 AND 3999 THEN 1 END) AS CNT_SAL_3000,
               COUNT(CASE WHEN A.SAL BETWEEN 4000 AND 4999 THEN 1 END) AS CNT_SAL_4000,
               COUNT(CASE WHEN A.SAL BETWEEN 5000 AND 5999 THEN 1 END) AS CNT_SAL_5000
         FROM EMP A)
UNPIVOT (CNT_EMP FOR SAL_RANGE IN(CNT_SAL_0000 AS '   0 ~  999',
                                  CNT_SAL_1000 AS '1000 ~ 1999',
                                  CNT_SAL_2000 AS '2000 ~ 2999',
                                  CNT_SAL_3000 AS '3000 ~ 3999',
                                  CNT_SAL_4000 AS '4000 ~ 4999',
                                  CNT_SAL_5000 AS '5000 ~ 5999'));

