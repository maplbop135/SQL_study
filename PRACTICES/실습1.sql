-- 문제1. 급여가 $2,000를 넘는 사원의 이름과 급여를 표시하는 질의를 작성하시오.
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL > 2000;

-- 문제2. 사원번호가 7369인 사원의 이름과 부서번호를 표시하는 질의를 작성하시오.
SELECT ENAME, DEPTNO
FROM   EMP
WHERE  EMPNO = 7369;

-- 문제3. 급여가 $1,000에서 $2,000 사이에 포함되지 않는 모든 사원의 이름과 급여를 표시하는 질의를 작성하시오.
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL NOT BETWEEN 1000 AND 2000;

-- 문제4. 1981년 2월 20일과 1982년 1월 23일 사이에 입사한 사원의 이름, 직무, 입사일을 표시하는 질의를 작성하시오.
SELECT ENAME, JOB, HIREDATE
FROM   EMP
WHERE  HIREDATE BETWEEN DATE '1981-02-20' AND DATE '1982-01-24' - 1/24/60/60;

-- 문제5. 10번 또는 20번 부서에 속하는 모든 사원의 이름과 부서번호를 표시하는 질의를 작성하시오.
SELECT ENAME, DEPTNO
FROM   EMP
WHERE  DEPTNO IN (10, 20);

-- 문제6. 급여가 $2,000 와 $3,000 사이이고, 부서번호가 10 또는 30인 사원의 이름과 급여를 표시하는 질의를 작성하시오.
SELECT ENAME, SAL
FROM   EMP
WHERE  (SAL BETWEEN 2000 AND 3000) AND DEPTNO IN (10, 30);

-- 문제7. 1987년에 입사한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하시오.
SELECT ENAME, HIREDATE
FROM   EMP
WHERE  TO_CHAR(HIREDATE, 'YYYY') = '1987';

-- 문제8. 관리자(MGR)가 없는 모든 사원의 이름과 직무를 표시하는 질의를 작성하시오.
SELECT ENAME, JOB
FROM   EMP
WHERE  MGR IS NULL;

-- 문제9. 커미션을 받지 않는 모든 사원의 이름과 급여 및 커미션을 표시하는 질의를 작성하시오.
SELECT ENAME, SAL, COMM
FROM   EMP
WHERE  COMM IS NULL OR COMM = 0;

-- 문제10. 이름의 세 번째 문자가 “A”인 모든 사원의 이름을 표시하는 질의를 작성하시오.
SELECT ENAME
FROM   EMP
WHERE  ENAME LIKE '__A%';

-- 문제11. 이름에 “E”와 “L”이 있는 모든 사원의 이름을 표시하는 질의를 작성하시오.
SELECT ENAME
FROM   EMP
WHERE  ENAME LIKE '%E%' AND ENAME LIKE '%L%';

-- 문제12. 직무가 매니저(MANAGER)인 사원 중에서, 급여가 $2,500보다 작거나 30번 부서에 속한 사원의 이름, 직무, 급여, 부서번호를 표시하는 질의를 작성하시오.
SELECT ENAME, JOB, SAL, DEPTNO
FROM   EMP
WHERE  JOB = 'MANAGER' AND (SAL < 2500 OR DEPTNO = 30);

-- 문제13. 급여가 $2,000을 넘는 사원의 이름과 급여를 급여가 높은 순으로 표시하는 질의를 작성하시오.
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL > 2000 ORDER BY SAL DESC;

-- 문제14. 급여가 $1000에서 $2000 사이에 포함되지 않는 모든 사원의 이름과 급여를 이름의 오름차순으로 정렬하여 표시하는 질의를 작성하시오. 
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL NOT BETWEEN 1000 AND 2000
           ORDER BY ENAME;

-- 문제15. 모든 사원의 이름과 급여 및 커미션을 커미션이 높은 순으로 표시하는 질의를 작성하시오. (단, 커미션이 없는 사람이 맨 마지막에 오도록 정렬하시오.)
SELECT ENAME, SAL, COMM
FROM   EMP ORDER BY COMM DESC NULLS LAST;

-- 문제16. 모든 사원의 이름과 직무를 표시하는 질의를 작성하시오. (단, 직무를 기준으로 CLERK, PRESIDENT, SALESMAN, ANALYST, MANAGER 순으로 정렬하시오.)
SELECT ENAME, JOB
FROM   EMP ORDER BY DECODE(JOB, 'CLERK', 1, 'PRESIDENT', 2, 'SALESMAN', 3, 'ANALYST', 4, 'MANAGER', 5);
