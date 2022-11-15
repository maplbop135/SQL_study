-- ����1. ��� ����� ���� �ְ� �޿���, ���� �޿���, �� �޿���, ��� �޿����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, ��� �޿����� ����� ������ �ݿø��Ͽ� ǥ���Ͻÿ�.)
SELECT MAX(SAL) AS SAL_MAX,
       MIN(SAL) AS SAL_MIN,
       SUM(SAL) AS SAL_TOTAL,
       ROUND(AVG(SAL)) AS SAL_AVG
FROM   EMP;

-- ����2. ���� ���� �ְ� �޿���, ���� �޿���, �� �޿���, ��� �޿����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT JOB,
       MAX(SAL) AS SAL_MAX,
       MIN(SAL) AS SAL_MIN,
       SUM(SAL) AS SAL_TOTAL,
       ROUND(AVG(SAL)) AS SAL_AVG
FROM   EMP
GROUP BY JOB;

-- ����3. �� �μ����� �Ҽ� ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT DEPTNO,
       COUNT(*) AS CNT_EMP
FROM   EMP
GROUP BY DEPTNO;

-- ����4. ����� (�ߺ��� ������)���� ���� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT COUNT(DISTINCT(JOB)) AS CNT_JOB_TYPE
FROM   EMP;

-- ����5. �� ����� ���� �ְ� �޿��װ� ���� �޿����� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT MAX(SAL) - MIN(SAL)
FROM   EMP;

-- ����6. ������ ������(MGR)�� �ΰ� �ִ� ����� ���� ���� �޿����� ǥ���Ͻÿ�. (��, �����ڸ� �� �� ���� ��� �� ���� �޿����� $1,000 �̸��� �׷��� �����Ͻÿ�.)
SELECT MGR,
       MIN(SAL) AS SAL_MIN
FROM   EMP
WHERE  MGR IS NOT NULL
GROUP BY MGR
HAVING MIN(SAL) >= 1000;

-- ����7. �� �μ��� ���� �Ҽ� ��� �� �� �μ� �� ��� ����� ��� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, ��� �޿��� �Ҽ��� ��° �ڸ��� �ݿø��Ͻÿ�.)
SELECT DEPTNO,
       COUNT(*) AS CNT_EMP,
       ROUND(AVG(SAL), 2) AS SAL_AVG
FROM EMP
GROUP BY DEPTNO;

-- ����8. �� ��� �� �� 1981, 1982�⿡ �Ի��� ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT COUNT(*) AS CNT_EMP,
       COUNT(CASE WHEN (EXTRACT(YEAR FROM HIREDATE) = 1981) THEN 1 END) AS CNT_HIRE_1981,
       COUNT(CASE WHEN (EXTRACT(YEAR FROM HIREDATE) = 1982) THEN 1 END) AS CNT_HIRE_1982
FROM   EMP;

-- ����9. ���� ��, �Ի�⵵ ���� �� �޿����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT JOB,
       EXTRACT(YEAR FROM HIREDATE) AS HIRE_YEAR,
       SUM(SAL) AS SAL_TOTAL
FROM   EMP
GROUP BY JOB, EXTRACT(YEAR FROM HIREDATE);

-- ����10.  ������ ��CLERK��, ��MANAGER��, ���� �� ������ 3���� �׷�ȭ�Ͽ� �� �׷� ���� �ο� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, ���� �� �������� �Ʒ��� ���� ����Ÿ �������� ǥ���Ͻÿ�)
SELECT CASE WHEN JOB IN('CLERK', 'MANAGER')
            THEN JOB
            ELSE '��Ÿ ����'
       END AS JOB,
       COUNT(*) AS CNT_EMP
FROM   EMP
GROUP BY CASE WHEN JOB IN('CLERK', 'MANAGER')
              THEN JOB
              ELSE '��Ÿ ����'
         END;

-- ����11. ����(��ANALYST��, ��CLERK��, ��MANAGER��, ��PRESIDENT��, ��SALESMAN��) �� ��� ���� ���� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT COUNT(CASE WHEN JOB = 'ANALYST' THEN 1 END) AS CNT_ANALYST,
       COUNT(CASE WHEN JOB = 'CLERK' THEN 1 END) AS CNT_CLERK,
       COUNT(CASE WHEN JOB = 'MANAGER' THEN 1 END) AS CNT_MANAGER,
       COUNT(CASE WHEN JOB = 'PRESIDENT' THEN 1 END) AS CNT_PRESIDENT,
       COUNT(CASE WHEN JOB = 'SALESMAN' THEN 1 END) AS CNT_SALESMAN
FROM EMP;
