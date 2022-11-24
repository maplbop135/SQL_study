-- 문제1. 집합 연산자를 사용하여 직무가 ‘ANALYST’인 사원의 소속 부서를 제외한 모든 부서의 부서번호를 표시하시오. 
SELECT a.deptno
FROM   dept a
MINUS
SELECT a.deptno
FROM   emp a
WHERE  a.job = 'ANALYST';

-- 문제2. 집합 연산자를 사용하여 사원이 한 명도 소속되지 않은 부서의 부서 번호와 부서 이름을 표시하시오.
SELECT  a.deptno, a.dname
FROM    dept a
WHERE   a.deptno = (SELECT a.deptno
		FROM   dept a
		MINUS
		SELECT a.deptno
		FROM   emp a);

-- 문제3. 20번 부서에 소속된 사원들의 집합과 직무가 ‘CLERK’인 사원들의 집합을 각각 구한 후, 아래와 같이 이름과
--        직무를 행으로 연결하여 표시하시오. (단, 동일한 이름 및 직무를 가진 사원은 한번만 표시하시오)
SELECT  a.*
FROM    emp a
WHERE   a.deptno = 20
UNION
SELECT  a.*
FROM    emp a
WHERE   a.job = 'CLERK';

-- 문제4. 20번 부서에 소속된 사원들의 집합과 직무가 ‘CLERK’인 사원들의 집합을 각각 구한 후, 양쪽 집합에 모두 포함된
--        사원들의 이름과 직무를 표시하시오. (단, 동일한 이름 및 직무를 가진 사원은 한번만 표시하시오)
SELECT  a.*
FROM    emp a
WHERE   a.deptno = 20
INTERSECT
SELECT  a.*
FROM    emp a
WHERE   a.job = 'CLERK';

-- 문제5. 집합 연산자를 사용하여 아래의 정보를 함께 나타내는 SQL을 작성하시오.
--          ? 모든 사원(EMP)의 직무와 부서 번호
--          ? 모든 부서(DEPT)의 부서 번호와 부서 이름
SELECT a.job, a.deptno, NULL
FROM   emp a
UNION ALL
SELECT NULL, a.deptno, a.dname
FROM   dept a;

-- 문제6. 사원의 소속 부서 별 평균 급여, 직무 별 평균 급여, 전체 사원의 평균 급여를 함께 표시하시오.
--        (단, 평균 급여는 소수점 둘째 자리까지 반올림하여 나타내시오)
SELECT a.deptno, null, ROUND(AVG(a.sal), 2) AS AVG_SAL
FROM   emp a
GROUP BY a.deptno
UNION ALL
SELECT NULL, a.job, ROUND(AVG(a.sal), 2) AS AVG_SAL
FROM   emp a
GROUP BY a.job
UNION ALL
SELECT NULL, NULL, ROUND(AVG(a.sal), 2) AS AVG_SAL
FROM   emp a;

-- 문제7. 사원의 소속 부서 별 평균 급여, 직무 별 평균 급여, 전체 사원의 평균 급여를 함께 표시하시오.
--        (단, NULL 대신 ‘직무 전체’, ‘부서 전체’, ‘회사 전체’를 출력하시오.)
SELECT TO_CHAR(a.deptno), NVL(NULL, '직무 전체') JOB, ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
GROUP BY a.deptno
UNION ALL
SELECT NVL(NULL, '부서 전체') DEPTNO, a.job, ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
GROUP BY a.job
UNION ALL
SELECT NVL(NULL, '회사 전체') DEPTNO, NVL(NULL, '회사 전체') JOB, ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a;

