-- ����1. �޿��� $2,000�� �Ѵ� ����� �̸��� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL > 2000;

-- ����2. �����ȣ�� 7369�� ����� �̸��� �μ���ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, DEPTNO
FROM   EMP
WHERE  EMPNO = 7369;

-- ����3. �޿��� $1,000���� $2,000 ���̿� ���Ե��� �ʴ� ��� ����� �̸��� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL NOT BETWEEN 1000 AND 2000;

-- ����4. 1981�� 2�� 20�ϰ� 1982�� 1�� 23�� ���̿� �Ի��� ����� �̸�, ����, �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, JOB, HIREDATE
FROM   EMP
WHERE  HIREDATE BETWEEN DATE '1981-02-20' AND DATE '1982-01-24' - 1/24/60/60;

-- ����5. 10�� �Ǵ� 20�� �μ��� ���ϴ� ��� ����� �̸��� �μ���ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, DEPTNO
FROM   EMP
WHERE  DEPTNO IN (10, 20);

-- ����6. �޿��� $2,000 �� $3,000 �����̰�, �μ���ȣ�� 10 �Ǵ� 30�� ����� �̸��� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, SAL
FROM   EMP
WHERE  (SAL BETWEEN 2000 AND 3000) AND DEPTNO IN (10, 30);

-- ����7. 1987�⿡ �Ի��� ��� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, HIREDATE
FROM   EMP
WHERE  TO_CHAR(HIREDATE, 'YYYY') = '1987';

-- ����8. ������(MGR)�� ���� ��� ����� �̸��� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, JOB
FROM   EMP
WHERE  MGR IS NULL;

-- ����9. Ŀ�̼��� ���� �ʴ� ��� ����� �̸��� �޿� �� Ŀ�̼��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, SAL, COMM
FROM   EMP
WHERE  COMM IS NULL OR COMM = 0;

-- ����10. �̸��� �� ��° ���ڰ� ��A���� ��� ����� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME
FROM   EMP
WHERE  ENAME LIKE '__A%';

-- ����11. �̸��� ��E���� ��L���� �ִ� ��� ����� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME
FROM   EMP
WHERE  ENAME LIKE '%E%' AND ENAME LIKE '%L%';

-- ����12. ������ �Ŵ���(MANAGER)�� ��� �߿���, �޿��� $2,500���� �۰ų� 30�� �μ��� ���� ����� �̸�, ����, �޿�, �μ���ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, JOB, SAL, DEPTNO
FROM   EMP
WHERE  JOB = 'MANAGER' AND (SAL < 2500 OR DEPTNO = 30);

-- ����13. �޿��� $2,000�� �Ѵ� ����� �̸��� �޿��� �޿��� ���� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL > 2000 ORDER BY SAL DESC;

-- ����14. �޿��� $1000���� $2000 ���̿� ���Ե��� �ʴ� ��� ����� �̸��� �޿��� �̸��� ������������ �����Ͽ� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
SELECT ENAME, SAL
FROM   EMP
WHERE  SAL NOT BETWEEN 1000 AND 2000
           ORDER BY ENAME;

-- ����15. ��� ����� �̸��� �޿� �� Ŀ�̼��� Ŀ�̼��� ���� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, Ŀ�̼��� ���� ����� �� �������� ������ �����Ͻÿ�.)
SELECT ENAME, SAL, COMM
FROM   EMP ORDER BY COMM DESC NULLS LAST;

-- ����16. ��� ����� �̸��� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, ������ �������� CLERK, PRESIDENT, SALESMAN, ANALYST, MANAGER ������ �����Ͻÿ�.)
SELECT ENAME, JOB
FROM   EMP ORDER BY DECODE(JOB, 'CLERK', 1, 'PRESIDENT', 2, 'SALESMAN', 3, 'ANALYST', 4, 'MANAGER', 5);
