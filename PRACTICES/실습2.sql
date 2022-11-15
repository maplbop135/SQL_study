-- 문제1. 모든 사원에 대해 최고 급여액, 최저 급여액, 총 급여액, 평균 급여액을 표시하는 질의를 작성하시오. (단, 평균 급여액은 결과를 정수로 반올림하여 표시하시오.)
SELECT MAX(SAL) AS SAL_MAX,
       MIN(SAL) AS SAL_MIN,
       SUM(SAL) AS SAL_TOTAL,
       ROUND(AVG(SAL)) AS SAL_AVG
FROM   EMP;

-- 문제2. 직무 별로 최고 급여액, 최저 급여액, 총 급여액, 평균 급여액을 표시하는 질의를 작성하시오.
SELECT JOB,
       MAX(SAL) AS SAL_MAX,
       MIN(SAL) AS SAL_MIN,
       SUM(SAL) AS SAL_TOTAL,
       ROUND(AVG(SAL)) AS SAL_AVG
FROM   EMP
GROUP BY JOB;

-- 문제3. 각 부서별로 소속 사원 수를 표시하는 질의를 작성하시오.
SELECT DEPTNO,
       COUNT(*) AS CNT_EMP
FROM   EMP
GROUP BY DEPTNO;

-- 문제4. 사원의 (중복을 제외한)직무 유형 개수를 표시하는 질의를 작성하시오.
SELECT COUNT(DISTINCT(JOB)) AS CNT_JOB_TYPE
FROM   EMP;

-- 문제5. 전 사원에 대한 최고 급여액과 최저 급여액의 차액을 표시하는 질의를 작성하시오.
SELECT MAX(SAL) - MIN(SAL)
FROM   EMP;

-- 문제6. 동일한 관리자(MGR)를 두고 있는 사원들 별로 최저 급여액을 표시하시오. (단, 관리자를 알 수 없는 사원 및 최저 급여액이 $1,000 미만인 그룹은 제외하시오.)
SELECT MGR,
       MIN(SAL) AS SAL_MIN
FROM   EMP
WHERE  MGR IS NOT NULL
GROUP BY MGR
HAVING MIN(SAL) >= 1000;

-- 문제7. 각 부서에 대해 소속 사원 수 및 부서 내 모든 사원의 평균 급여를 표시하는 질의를 작성하시오. (단, 평균 급여는 소수점 둘째 자리로 반올림하시오.)
SELECT DEPTNO,
       COUNT(*) AS CNT_EMP,
       ROUND(AVG(SAL), 2) AS SAL_AVG
FROM EMP
GROUP BY DEPTNO;

-- 문제8. 총 사원 수 및 1981, 1982년에 입사한 사원 수를 표시하는 질의를 작성하시오.
SELECT COUNT(*) AS CNT_EMP,
       COUNT(CASE WHEN (EXTRACT(YEAR FROM HIREDATE) = 1981) THEN 1 END) AS CNT_HIRE_1981,
       COUNT(CASE WHEN (EXTRACT(YEAR FROM HIREDATE) = 1982) THEN 1 END) AS CNT_HIRE_1982
FROM   EMP;

-- 문제9. 직무 별, 입사년도 별로 총 급여액을 표시하는 질의를 작성하시오.
SELECT JOB,
       EXTRACT(YEAR FROM HIREDATE) AS HIRE_YEAR,
       SUM(SAL) AS SAL_TOTAL
FROM   EMP
GROUP BY JOB, EXTRACT(YEAR FROM HIREDATE);

-- 문제10.  직무를 ‘CLERK’, ‘MANAGER’, ‘그 외 직무’ 3개로 그룹화하여 각 그룹 별로 인원 수를 표시하는 질의를 작성하시오. (단, ‘그 외 직무’는 아래와 같이 ‘기타 직무’로 표시하시오)
SELECT CASE WHEN JOB IN('CLERK', 'MANAGER')
            THEN JOB
            ELSE '기타 직무'
       END AS JOB,
       COUNT(*) AS CNT_EMP
FROM   EMP
GROUP BY CASE WHEN JOB IN('CLERK', 'MANAGER')
              THEN JOB
              ELSE '기타 직무'
         END;

-- 문제11. 직무(‘ANALYST’, ‘CLERK’, ‘MANAGER’, ‘PRESIDENT’, ‘SALESMAN’) 별 사원 수를 각각 열로 표시하는 질의를 작성하시오.
SELECT COUNT(CASE WHEN JOB = 'ANALYST' THEN 1 END) AS CNT_ANALYST,
       COUNT(CASE WHEN JOB = 'CLERK' THEN 1 END) AS CNT_CLERK,
       COUNT(CASE WHEN JOB = 'MANAGER' THEN 1 END) AS CNT_MANAGER,
       COUNT(CASE WHEN JOB = 'PRESIDENT' THEN 1 END) AS CNT_PRESIDENT,
       COUNT(CASE WHEN JOB = 'SALESMAN' THEN 1 END) AS CNT_SALESMAN
FROM EMP;
