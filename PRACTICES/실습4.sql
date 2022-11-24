-- ����1. ���� �����ڸ� ����Ͽ� ������ ��ANALYST���� ����� �Ҽ� �μ��� ������ ��� �μ��� �μ���ȣ�� ǥ���Ͻÿ�. 
SELECT a.deptno
FROM   dept a
MINUS
SELECT a.deptno
FROM   emp a
WHERE  a.job = 'ANALYST';

-- ����2. ���� �����ڸ� ����Ͽ� ����� �� �� �Ҽӵ��� ���� �μ��� �μ� ��ȣ�� �μ� �̸��� ǥ���Ͻÿ�.
SELECT  a.deptno, a.dname
FROM    dept a
WHERE   a.deptno = (SELECT a.deptno
		FROM   dept a
		MINUS
		SELECT a.deptno
		FROM   emp a);

-- ����3. 20�� �μ��� �Ҽӵ� ������� ���հ� ������ ��CLERK���� ������� ������ ���� ���� ��, �Ʒ��� ���� �̸���
--        ������ ������ �����Ͽ� ǥ���Ͻÿ�. (��, ������ �̸� �� ������ ���� ����� �ѹ��� ǥ���Ͻÿ�)
SELECT  a.*
FROM    emp a
WHERE   a.deptno = 20
UNION
SELECT  a.*
FROM    emp a
WHERE   a.job = 'CLERK';

-- ����4. 20�� �μ��� �Ҽӵ� ������� ���հ� ������ ��CLERK���� ������� ������ ���� ���� ��, ���� ���տ� ��� ���Ե�
--        ������� �̸��� ������ ǥ���Ͻÿ�. (��, ������ �̸� �� ������ ���� ����� �ѹ��� ǥ���Ͻÿ�)
SELECT  a.*
FROM    emp a
WHERE   a.deptno = 20
INTERSECT
SELECT  a.*
FROM    emp a
WHERE   a.job = 'CLERK';

-- ����5. ���� �����ڸ� ����Ͽ� �Ʒ��� ������ �Բ� ��Ÿ���� SQL�� �ۼ��Ͻÿ�.
--          ? ��� ���(EMP)�� ������ �μ� ��ȣ
--          ? ��� �μ�(DEPT)�� �μ� ��ȣ�� �μ� �̸�
SELECT a.job, a.deptno, NULL
FROM   emp a
UNION ALL
SELECT NULL, a.deptno, a.dname
FROM   dept a;

-- ����6. ����� �Ҽ� �μ� �� ��� �޿�, ���� �� ��� �޿�, ��ü ����� ��� �޿��� �Բ� ǥ���Ͻÿ�.
--        (��, ��� �޿��� �Ҽ��� ��° �ڸ����� �ݿø��Ͽ� ��Ÿ���ÿ�)
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

-- ����7. ����� �Ҽ� �μ� �� ��� �޿�, ���� �� ��� �޿�, ��ü ����� ��� �޿��� �Բ� ǥ���Ͻÿ�.
--        (��, NULL ��� ������ ��ü��, ���μ� ��ü��, ��ȸ�� ��ü���� ����Ͻÿ�.)
SELECT TO_CHAR(a.deptno), NVL(NULL, '���� ��ü') JOB, ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
GROUP BY a.deptno
UNION ALL
SELECT NVL(NULL, '�μ� ��ü') DEPTNO, a.job, ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
GROUP BY a.job
UNION ALL
SELECT NVL(NULL, 'ȸ�� ��ü') DEPTNO, NVL(NULL, 'ȸ�� ��ü') JOB, ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a;

