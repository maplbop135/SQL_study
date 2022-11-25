-- ����1. �Ʒ� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. (��, �� �޿����� �ϳ��� ���� �Բ� ��Ÿ���ÿ�.)
--         ? �μ���ȣ
--         ? ����
--         ? ���� �μ� �� ���� �� �� �޿���
--         ? �μ��� �� �޿���
--         ? ��ü ��� �� �޿���
SELECT MAX(a.deptno) DEPTNO, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY ROLLUP (a.deptno, a.job);

-- ����2. �Ʒ� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. (��, �� �޿����� �ϳ��� ���� �Բ� ��Ÿ���ÿ�.)
--         ? �μ���ȣ
--         ? ����
--         ? ���� �μ� �� ���� �� �� �޿���
--         ? (������ �������) �μ��� �� �޿���
--         ? (�μ��� �������) ���� �� �� �޿���
--         ? ��ü ��� �� �޿���
SELECT MAX(a.deptno) DEPTNO, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY ROLLUP (a.deptno, a.job)
UNION
SELECT NULL, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY a.job;

-- ����3. �Ʒ� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. (��, �� �޿����� �ϳ��� ���� �Բ� ��Ÿ���ÿ�.)
--         ? �μ���ȣ
--         ? ����
--         ? ���� �μ� �� ���� �� �� �޿���
--         ? �μ��� �� �޿���
SELECT MAX(a.deptno) DEPTNO, a.job, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY a.deptno, ROLLUP (a.job);

-- ����4. �Ʒ� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. (��, ���� Į�� �� �� �޿����� ���� �ϳ��� ���� ��Ÿ���ÿ�.)
--         ? ���� Į��
--           ? �μ���ȣ
--           ? ����
--           ? ��ü
--         ? �� �޿���
--           ? ������ �� �޿���
--           ? �μ��� �� �޿���
--           ? ��ü ��� �� �޿���
SELECT a.job GROUP_COL, SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY a.job
UNION
SELECT TO_CHAR(a.deptno), SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY ROLLUP(a.deptno);

-- ����5. ? �Ʒ� ������ �־��� ���ó�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�.
--         ? �μ���ȣ (��, ��ü �μ� = All Departments)
--         ? ���� (��, ��ü ���� = All Jobs)
--         ? ���� �μ� �� ���� �� �� �޿���
--         ? �μ��� �� �޿���
--         ? ���� �� �� �޿���
--         ? ��ü ��� �� �޿���
SELECT NVL(TO_CHAR(a.deptno), 'All Departments') DEPTNO,
       NVL(a.job, 'All Jobs') JOB,
       SUM(a.sal) SUM_TOTAL
FROM   emp a
GROUP BY CUBE (a.job, a.deptno)
ORDER BY a.deptno;

-- ����6. �Ʒ� SQL�� HAVING���� �߰��Ͽ� ���� �׷��� �ߺ��� ������ ����ÿ�.
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

-- ����7. �Ʒ� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. (��, ��� ���� �ϳ��� ���� �Բ� ��Ÿ���ÿ�.)
--         ? �μ���ȣ
--         ? Ŀ�̼� (��, NULL�� ��� = No Commission)
--         ? ���� �μ��� �Ҽӵ� ��� ��
--         ? ������ Ŀ�̼� �ݾ��� �޴� �����
--         ? ��ü ��� ��
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

-- ����8. �Ʒ��� ���� ���� ��� �� �⵵�� �Ի��� ������� �޿� �Ұ�(�հ�)�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--        (�Ʒ� ������ ���� ������ �����ϰ� ����Ͻÿ�.)
SELECT EXTRACT(YEAR FROM a.hiredate) || '�⵵ �Ұ�' HIRE_YM,
       SUM(a.sal) SAL_TOTAL
FROM   emp a
GROUP BY EXTRACT(YEAR FROM a.hiredate)
UNION
SELECT TO_CHAR(a.hiredate, 'YYYY-MM'),
       a.sal
FROM   emp a;

SELECT *
FROM emp a;
