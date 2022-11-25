-- 문제1. 아래 내용을 표시하는 질의를 작성하십시오. (단, 총 급여액은 하나의 열에 함께 나타내시오.)
--         ? 부서번호
--         ? 직무
--         ? 동일 부서 내 직무 별 총 급여액
--         ? 부서별 총 급여액
--         ? 전체 사원 총 급여액
SELECT MAX(a.deptno) DEPTNO, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY ROLLUP (a.deptno, a.job);

-- 문제2. 아래 내용을 표시하는 질의를 작성하십시오. (단, 총 급여액은 하나의 열에 함께 나타내시오.)
--         ? 부서번호
--         ? 직무
--         ? 동일 부서 내 직무 별 총 급여액
--         ? (직무에 상관없이) 부서별 총 급여액
--         ? (부서에 상관없이) 직무 별 총 급여액
--         ? 전체 사원 총 급여액
SELECT MAX(a.deptno) DEPTNO, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY ROLLUP (a.deptno, a.job)
UNION
SELECT NULL, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY a.job;

-- 문제3. 아래 내용을 표시하는 질의를 작성하십시오. (단, 총 급여액은 하나의 열에 함께 나타내시오.)
--         ? 부서번호
--         ? 직무
--         ? 동일 부서 내 직무 별 총 급여액
--         ? 부서별 총 급여액
SELECT MAX(a.deptno) DEPTNO, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY a.deptno, ROLLUP (a.job);

-- 문제4. 아래 내용을 표시하는 질의를 작성하십시오. (단, 집계 칼럼 및 총 급여액은 각각 하나의 열에 나타내시오.)
--         ? 집계 칼럼
--           ? 부서번호
--           ? 직무
--           ? 전체
--         ? 총 급여액
--           ? 직무별 총 급여액
--           ? 부서별 총 급여액
--           ? 전체 사원 총 급여액
SELECT a.job GROUP_COL, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY a.job
UNION
SELECT TO_CHAR(a.deptno), SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY ROLLUP(a.deptno);

-- 문제5. ? 아래 내용을 주어진 결과처럼 표시하는 질의를 작성하십시오.
--         ? 부서번호 (단, 전체 부서 = All Departments)
--         ? 직무 (단, 전체 직무 = All Jobs)
--         ? 동일 부서 내 직무 별 총 급여액
--         ? 부서별 총 급여액
--         ? 직무 별 총 급여액
--         ? 전체 사원 총 급여액
SELECT NVL(TO_CHAR(a.deptno), 'All Departments') DEPTNO,
       NVL(a.job, 'All Jobs') JOB,
       SUM(a.sal) SUM_TOTAL
FROM   emp a
GROUP BY CUBE (a.job, a.deptno)
ORDER BY a.deptno;

-- 문제6. 아래 SQL에 HAVING절을 추가하여 집계 그룹의 중복이 없도록 만드시오.
-- SELECT a.deptno,
--        a.job,
--        NVL(SUM(a.sal), 0) SAL_TOTAL
-- FROM   emp a
-- GROUP BY a.deptno, ROLLUP(a.deptno, a.job);
SELECT a.deptno,
       a.job,
       NVL(SUM(a.sal), 0) SAL_TOTAL
FROM   emp a
GROUP BY a.deptno, ROLLUP(a.job);

-- 문제7. 아래 내용을 표시하는 질의를 작성하십시오. (단, 사원 수는 하나의 열에 함께 나타내시오.)
--         ? 부서번호
--         ? 커미션 (단, NULL일 경우 = No Commission)
--         ? 동일 부서에 소속된 사원 수
--         ? 동일한 커미션 금액을 받는 사원수
--         ? 전체 사원 수
SELECT TO_CHAR(a.deptno),
       NVL(NULL, '-') COMM,
       COUNT(a.empno) CNT
FROM   emp a
GROUP BY a.deptno
UNION
SELECT NVL(NULL, '-'),
       CASE WHEN GROUPING(a.comm) = 1
       THEN 'ALL'
       ELSE TO_CHAR(NVL(TO_CHAR(a.comm), 'No Commision'))
       END COMM,
       COUNT(a.empno) CNT
FROM   emp a
GROUP BY ROLLUP (a.comm);

-- 문제8. 아래와 같이 동일 년월 및 년도에 입사한 사원들의 급여 소계(합계)를 표시하는 질의를 작성하시오.
--        (아래 보기의 정렬 순서와 동일하게 출력하시오.)
SELECT EXTRACT(YEAR FROM a.hiredate) || '년도 소계' HIRE_YM,
       SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY EXTRACT(YEAR FROM a.hiredate)
UNION
SELECT TO_CHAR(a.hiredate, 'YYYY-MM'),
       a.sal
FROM   emp a;

SELECT *
FROM emp a;
