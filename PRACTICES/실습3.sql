-- ����1. �Ʒ��� ���� ��� ����� �̸�, �μ� ��ȣ, �μ� �̸��� ǥ���ϴ� SQL�� �ۼ��Ͻÿ�.
SELECT a.ename, a.deptno, b.dname
FROM   emp a, dept b
WHERE  a.deptno = b.deptno;

-- ����2. 10�� �μ��� ���ϴ� ��� ����� ������ �μ� ��ġ�� ǥ���Ͻÿ�.
SELECT a.job, b.loc
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND a.deptno = 10;

-- ����3. Ŀ�̼��� �޴� ��� ����� �̸�, �μ� �̸�, �μ� ��ġ�� ǥ���Ͻÿ�.
SELECT a.ename, b.dname, b.loc
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND a.comm > 0;

-- ����4. �̸��� ��A��(�빮��)�� ���Ե� ��� ����� �̸��� �μ� �̸��� ǥ���Ͻÿ�
SELECT a.ename, b.dname
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND a.ename LIKE '%A%';

-- ����5. ��CHICAGO������ �ٹ��ϴ� ��� ����� �̸�, ����, �μ� ��ȣ �� �μ� �̸��� ǥ���Ͻÿ�.
SELECT a.ename, a.job, b.deptno, b.dname
FROM   emp a, dept b
WHERE  a.deptno = b.deptno
       AND b.loc = 'CHICAGO';

-- ����6. �� ����� �̸� �� ��� ��ȣ�� �ش� �������� �̸� �� ��� ��ȣ�� �Բ� ǥ���ϰ�, ���̺�(LABEL)�� ������� EMP_NM, EMP#, MGR_NM, MGR#�� �����Ͻÿ�.
--        (��, �����ڰ� ���� ����� �������� �ʴ´�.)
SELECT a.ename AS EMP_NM,
       a.empno AS EMP#,
       b.ename AS MGR_NM,
       a.mgr AS MGR_#
FROM   emp a, -- ���
       emp b -- �Ŵ���
WHERE  a.mgr = b.empno;

-- ����7. �� ����� �̸� �� ��� ��ȣ�� �ش� �������� �̸� �� ��� ��ȣ�� �Բ� ǥ���ϰ�, ���̺�(LABEL)�� ������� EMP_NM, EMP#, MGR_NM, MGR#�� �����Ͻÿ�.
--        (��, �����ڰ� ���� ����� �����Ͽ� ǥ���ϰ�, ��� ������ ��� ��ȣ(EMP#)�� �������� �����Ͻÿ�.)
SELECT a.ename AS EMP_NM,
       a.empno AS EMP#,
       b.ename AS MGR_NM,
       a.mgr AS MGR_#
FROM   emp a, -- ���
       emp b -- �Ŵ���
WHERE  a.mgr = b.empno(+)
ORDER BY a.empno;

-- ����8. ��MARTIN���� ���� �μ��� ����� ǥ���ϰ�, ���̺��� ������� ENAME, DEPTNO, ENAME_1 �� �����Ͻÿ�.
SELECT a.ename, b.deptno,
       b.ename AS ENAME_1
FROM   emp a, -- ��ƾ
       emp b -- ���� �μ� ���
WHERE  a.ename = 'MARTIN'
       AND b.deptno = a.deptno
       AND b.ename <> 'MARTIN';

-- ����9. �� ������� ����(��� ��ȣ, �̸�, ����, �μ� �̸�, �޿�)�� �Բ� �޿��� ���� ����� ǥ���ϰ� ����� �޿��� ��������, ��� ��ȣ�� �������� �������� �����Ͻÿ�.
--        (��, �޿� ����� SALGRADE ���̺� ����)
SELECT a.empno, a.ename, a.job, b.dname, a.sal, c.grade
FROM   emp a, dept b, salgrade c
WHERE  a.deptno = b.deptno
       AND a.sal BETWEEN c.losal AND c.hisal
ORDER BY a.sal DESC,
         a.empno;

-- ����10. �̸��� ��CLARK���� ������� �ʰ� �Ի��� ����� �̸��� �Ի� ���ڸ� ǥ���Ͻÿ�.
SELECT MAX(b.ename) AS ENAME,
       MAX(b.hiredate) AS HIREDATE
FROM   emp a,
       emp b
WHERE  a.ename = 'CLARK'
       AND b.hiredate > a.hiredate
GROUP BY b.empno;

-- ����11. �ڽ��� ������(MGR)���� ���� �Ի��� ��� ����� �̸��� �Ի� ���ڸ� �������� �̸� �� �Ի� ���ڿ� �Բ� ǥ���ϰ�,
--         ���̺��� ������� EMP_NM, EMP_HIRED, MGR_NM, MGR_HIRED�� �����Ͻÿ�.
SELECT a.ename AS EMP_NM,
       a.hiredate AS EMP_HIRED,
       b.ename AS MGR_NM,
       b.hiredate AS MGR_HIRED
FROM   emp a, emp b
WHERE  a.mgr = b.empno
       AND b.hiredate > a.hiredate;
       
-- ����12. ��� �μ��� �μ� ��ȣ, �μ� �̸��� �Բ� �μ��� �Ҽӵ� ����� �޿� �հ踦 ǥ���Ͻÿ�.
--         (��, �Ҽӵ� ����� ���� �μ��� �����Ͽ� ǥ���ϰ�, �޿� �հ�� 0���� ǥ���Ͻÿ�.)
SELECT b.deptno, b.dname,
       SUM(NVL(a.sal, 0)) AS SUM_SAL
FROM   emp a, dept b
WHERE  a.deptno(+) = b.deptno
GROUP BY dname, b.deptno;
