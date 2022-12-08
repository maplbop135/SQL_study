-- ����1. PIVOT ���� ����Ͽ� ������ 'CLERK'�� ����� �޿� �հ踦 "CLERK_SUMSAL" ����, ������ 'MANAGER'��
--        ����� �޿� �հ踦 "MANAGER_SUMSAL" ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT *
FROM   (SELECT a.job, a.sal FROM emp a) a
PIVOT  (SUM(a.sal) FOR job IN ('CLERK' AS CLERK_SUMSAL, 'MANAGER' AS MANAGER_SUMSAL));

-- ����2. PIVOT ���� ����Ͽ� �� �μ����� ������ 'CLERK'�� ����� �޿� �հ踦 "CLERK_SUMSAL" ����, ������
--        'MANAGER'�� ����� �޿� �հ踦 "MANAGER_SUMSAL" ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT *
FROM   (SELECT a.deptno, a.job, a.sal FROM emp a) a
PIVOT  (SUM(a.sal) FOR job IN ('CLERK' AS CLERK_SUMSAL, 'MANAGER' AS MANAGER_SUMSAL));

-- ����3. PIVOT ���� ����Ͽ� �� ���� ���� �ش� �޿� ��޿� ���� ��� ���� ��Ÿ���� ���Ǹ� �ۼ��Ͻÿ�.
--        (�޿���� �� ��� ���� GRADE1_CNT ~ GRADE5_CNT ���� ��Ÿ���ÿ�.)
SELECT *
FROM   (SELECT a.job, b.grade FROM emp a, salgrade b WHERE a.sal BETWEEN b.losal and b.hisal) a
PIVOT  (COUNT(*) CNT FOR grade IN (1 GRADE1, 2 GRADE2, 3 GRADE3, 4 GRADE4, 5 GRADE5));

-- ����4. PIVOT ���� ����Ͽ� �Ի�⵵ ���� �� ������ �Ի��� ��� ���� ��Ÿ���� ���Ǹ� �ۼ��Ͻÿ�.
--        (���� �Ի��� ��� ���� M01_CNT ~ M12_CNT ���� ��Ÿ���ÿ�.)
SELECT *
FROM   (SELECT EXTRACT(YEAR FROM a.hiredate) HIRE_YEAR, EXTRACT(MONTH FROM a.hiredate) HIRE_MONTH FROM emp a) a
PIVOT  (COUNT(*) CNT FOR hire_month IN(1 M01, 2 M02, 3 M03, 4 M04,
                                       5 M05, 6 M06, 7 M07, 8 M08,
                                       9 M09,10 M10,11 M11,12 M12));

-- ����5. UNPIVOT ���� ����Ͽ� �޿���� ���̺��� ���� �޿��� �ְ� �޿��� �ϳ��� ��(STD_SAL)�� ��Ÿ����, �̸�
--        ������ �� �ִ� ��(SAL_GB)�� �߰��Ͽ� ���� ��('LOW', 'HIGH')�� ��Ÿ���ÿ�.
SELECT *
FROM   salgrade
UNPIVOT (STD_SAL FOR SAL_GB IN(losal AS 'LOW', hisal AS 'HIGH'));

-- ����6. UNPIVOT ���� ����Ͽ� 20�� �μ��� �� Į�� ������ ������ ������ ��Ÿ���ÿ�.
--        (��, ���� ���̺�(DEPT)�� Į�� ���� INFO_GB ����, Į�� ���� INFO_VAL ���� ��Ÿ���ÿ�.)
SELECT *
FROM   (SELECT TO_CHAR(a.deptno) DEPTNO, a.dname, a.loc FROM dept a WHERE deptno = 20) a
UNPIVOT (INFO_VAL FOR INFO_GB IN(deptno, dname, loc));

-- ����7. �Ʒ� SQL�� UNPIVOT ���� �߰��Ͽ� ��(���� ���)�� ��(������ ���)���� ��ȯ�Ͻÿ�.
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

