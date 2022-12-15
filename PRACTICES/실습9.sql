-- 문제1.  각 사원에 대해 이름, 급여, 소속 부서번호 및 소속 부서의 급여 합계를 표시하는 질의를 작성하시오.
SELECT a.ename,
       a.sal,
       a.deptno,
       SUM(a.sal) OVER (PARTITION BY a.deptno) AS SAL_TOTAL
FROM   emp a;

-- 문제2.  각 사원에 대해 이름, 급여, 소속 부서번호 및 소속부서의 급여 누적 합계를 표시하는 질의를 작성하시오.
--         (단, 소속부서의 급여 합계는 이름 순으로 누적합계를 나타내시오.)
SELECT a.ename,
       a.sal,
       a.deptno,
       SUM(a.sal) OVER (PARTITION BY a.deptno
                        ORDER BY a.ename, a.sal ROWS UNBOUNDED PRECEDING) AS SAL_TOTAL
FROM   emp a;

-- 문제3. 각 사원에 대해 이름, 급여, 소속 부서번호, 소속 부서의 최고 급여액 및 최소 급여액을 표시하는 질의를 작성
--        하시오.
SELECT a.ename,
       a.sal,
       a.deptno,
       MAX(a.sal) OVER (PARTITION BY a.deptno) SAL_MAX,
       MIN(a.sal) OVER (PARTITION BY a.deptno) SAL_MIN
FROM   emp a;

-- 문제4. 각 사원에 대해 이름, 급여, 입사 년도 및 동일 년도에 입사한 사원들의 평균 급여액을 표시하는 질의를 작성하시
--        오. (단, 평균 급여액은 정수로 반올림하여 표시하시오.)
SELECT a.ename,
       a.sal,
       EXTRACT(YEAR FROM a.hiredate) HIRE_YEAR,
       ROUND(AVG(a.sal) OVER (PARTITION BY EXTRACT(YEAR FROM a.hiredate))) SAL_MIN
FROM   emp a;

-- 문제5. 각 사원에 대해 사원번호, 이름, 급여, 부서번호, 평균 급여액을 표시하는 질의를 작성하시오. 
--        (단, 평균 급여액은 소속 부서가 같은 사원들 중에서 자신의 앞뒤 사원번호를 가진 사원들을 대상으로 구하시오.)
SELECT a.empno,
       a.ename,
       a.sal,
       a.deptno,
       ROUND(AVG(a.sal) OVER (PARTITION BY a.deptno
                              ORDER BY a.empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) SAL_AVG
FROM   emp a;

-- 문제6. 각 사원의 소속 부서 내에서 본인의 급여를 기준으로 -$500부터 +$500까지 범위의 급여를 받는 사원들의 수를
--        표시하는 질의를 작성하시오. (사원의 이름, 부서번호, 급여 및 사원 수의 검색 범위를 함께 나타내시오.)
SELECT a.ename,
       a.deptno,
       a.sal,
       a.sal-500 RANGE_BEGIN,
       a.sal+500 RANGE_END,
       COUNT(*) OVER (PARTITION BY a.deptno
                      ORDER BY a.sal RANGE BETWEEN 500 PRECEDING AND 500 FOLLOWING) CNT_EMP_RANGE
FROM   emp a; 

-- 문제7. 각 사원에 대해 동일 소속 부서 내에서 본인 바로 이전에 입사한 사원의 급여를 표시하는 질의를 작성하시오. 
--        (단, 아래와 같이 기준이 되는 사원의 이름, 부서 번호, 입사일, 급여를 함께 나타내시오.)
SELECT a.ename,
       a.deptno,
       a.hiredate,
       a.sal,
       LAG(a.sal) OVER (PARTITION BY a.deptno
                        ORDER BY a.hiredate) SAL_PRE_HIRE
FROM   emp a;


-- 문제8. 급여가 높은 순으로 5위까지 사원의 이름, 급여, 순위를 표시하는 질의를 작성하시오. 
--        (단, 동일 값에 대해서는 동일 순위(N)를 인정하고, 그 다음 순위는 N+1 이 되도록 질의를 작성하시오.)
SELECT *
FROM   (SELECT a.ename,
               a.sal,
               DENSE_RANK() OVER (ORDER BY a.sal DESC) SAL_DENSE_RANK
        FROM   emp a
       )
WHERE SAL_DENSE_RANK <= 5;


-- 문제9. 급여가 높은 순으로 5위까지 사원의 이름, 급여, 순위를 표시하는 질의를 작성하시오. (단, 동일 값에 대해서는 동
--        일 순위(N)를 인정하고, 그 다음 순위는 동일 순위 개수만큼 건너 뛰도록 질의를 작성하시오.)
SELECT *
FROM   (SELECT a.ename,
               a.sal,
               RANK() OVER (ORDER BY a.sal DESC) SAL_RANK
        FROM   emp a
       )
WHERE SAL_RANK <= 5;

-- 문제10. 급여가 높은 순으로 5위까지 사원의 이름, 입사일, 급여, 순위를 표시하는 질의를 작성하시오. (단, 동일 값(급여)
--         에 대해서 동일 순위를 인정하지 않고, 급여가 동일하면 입사일이 빠른 순서로 순위를 매기시오.)
SELECT *
FROM   (SELECT a.ename,
               a.hiredate,
               a.sal,
               RANK() OVER (ORDER BY a.sal DESC, a.hiredate) SAL_RN
        FROM   emp a
       )
WHERE SAL_RN <= 5;

-- 문제11. 부서별 총 급여액 중에서 각 소속 사원의 급여 비중(%)을 표시하는 질의를 작성하시오. (단, 급여 비중은 반올림
--         하여 소수점 둘째 자리까지 나타내고, 사원의 이름, 부서번호, 급여를 함께 출력하시오.)
SELECT a.ename,
       a.deptno,
       a.sal,
       ROUND(RATIO_TO_REPORT(a.sal) OVER (PARTITION BY a.deptno)*100, 2) || '%' SAL_RATIO
FROM   emp a;


-- 문제12. 각 사원에 대해 동일 직무 내에서 자신이 입사 하기 바로 전에 입사한 사원의 급여와 자신의 급여 차를 구하시오.
--         (단, 각 사원의 이름, 직무, 입사 일자, 급여를 함께 출력하시오.)
SELECT a.ename,
       a.job,
       a.hiredate,
       a.sal,
       a.sal - LAG(a.sal) OVER (PARTITION BY a.job
                        ORDER BY a.hiredate) SAL_DIFF
FROM   emp a;

-- 문제13. 각 사원의 이름, 직무, 입사 일자와 함께 자신과 동일한 직무를 가진 사원들 중 가장 먼저 입사한 사원의 이름을
--         표시하시오.
SELECT a.ename,
       a.job,
       a.hiredate,
       FIRST_VALUE(a.ename) OVER (PARTITION BY a.job
                             ORDER BY a.hiredate) SAL_DIFF
FROM   emp a;

-- 문제14. 각 사원에 대해 이름, 입사 일자, 커미션과 함께 자신 보다 먼저 입사한 사원들이 받았던 커미션 중 가장 높았던
--         커미션 금액을 표시하시오.
SELECT a.ename, a.hiredate, a.comm,
       MAX(a.HIGHEST_COMM) OVER(ORDER BY a.hiredate) HIGHEST_COMM
FROM   (SELECT a.ename,
               a.hiredate,
               a.comm,
               LAG(a.comm) OVER (ORDER BY a.hiredate) HIGHEST_COMM
        FROM   emp a) a;


-- 문제15. 각 사원에 대해 이름, 입사 일자, 커미션과 함께 자신보다 뒤에 입사한 사원들 중 가장 먼저 커미션을 받은 사원의
--         커미션 금액을 표시하시오. (단, 커미션을 받은 사원이 없으면 ‘No Comm’이라고 표시하시오.)
SELECT a.ename, a.hiredate, a.comm,
       NVL(TO_CHAR(LAST_VALUE(HIGHEST_COMM) IGNORE NULLS OVER(ORDER BY a.hiredate DESC)), 'No Comm') NEXT_COMM
FROM   (SELECT a.ename,
               a.hiredate,
               a.comm,
               NULLIF(LAG(a.comm) IGNORE NULLS OVER (ORDER BY a.hiredate DESC), 0) HIGHEST_COMM
        FROM   emp a) a
ORDER BY a.hiredate;

SELECT a.ename, a.hiredate, a.comm FROM emp a ORDER BY a.hiredate;

