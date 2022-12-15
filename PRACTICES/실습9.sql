-- ����1.  �� ����� ���� �̸�, �޿�, �Ҽ� �μ���ȣ �� �Ҽ� �μ��� �޿� �հ踦 ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT a.ename,
       a.sal,
       a.deptno,
       SUM(a.sal) OVER (PARTITION BY a.deptno) AS SAL_TOTAL
FROM   emp a;

-- ����2.  �� ����� ���� �̸�, �޿�, �Ҽ� �μ���ȣ �� �ҼӺμ��� �޿� ���� �հ踦 ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--         (��, �ҼӺμ��� �޿� �հ�� �̸� ������ �����հ踦 ��Ÿ���ÿ�.)
SELECT a.ename,
       a.sal,
       a.deptno,
       SUM(a.sal) OVER (PARTITION BY a.deptno
                        ORDER BY a.ename, a.sal ROWS UNBOUNDED PRECEDING) AS SAL_TOTAL
FROM   emp a;

-- ����3. �� ����� ���� �̸�, �޿�, �Ҽ� �μ���ȣ, �Ҽ� �μ��� �ְ� �޿��� �� �ּ� �޿����� ǥ���ϴ� ���Ǹ� �ۼ�
--        �Ͻÿ�.
SELECT a.ename,
       a.sal,
       a.deptno,
       MAX(a.sal) OVER (PARTITION BY a.deptno) SAL_MAX,
       MIN(a.sal) OVER (PARTITION BY a.deptno) SAL_MIN
FROM   emp a;

-- ����4. �� ����� ���� �̸�, �޿�, �Ի� �⵵ �� ���� �⵵�� �Ի��� ������� ��� �޿����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻ�
--        ��. (��, ��� �޿����� ������ �ݿø��Ͽ� ǥ���Ͻÿ�.)
SELECT a.ename,
       a.sal,
       EXTRACT(YEAR FROM a.hiredate) HIRE_YEAR,
       ROUND(AVG(a.sal) OVER (PARTITION BY EXTRACT(YEAR FROM a.hiredate))) SAL_MIN
FROM   emp a;

-- ����5. �� ����� ���� �����ȣ, �̸�, �޿�, �μ���ȣ, ��� �޿����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
--        (��, ��� �޿����� �Ҽ� �μ��� ���� ����� �߿��� �ڽ��� �յ� �����ȣ�� ���� ������� ������� ���Ͻÿ�.)
SELECT a.empno,
       a.ename,
       a.sal,
       a.deptno,
       ROUND(AVG(a.sal) OVER (PARTITION BY a.deptno
                              ORDER BY a.empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) SAL_AVG
FROM   emp a;

-- ����6. �� ����� �Ҽ� �μ� ������ ������ �޿��� �������� -$500���� +$500���� ������ �޿��� �޴� ������� ����
--        ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (����� �̸�, �μ���ȣ, �޿� �� ��� ���� �˻� ������ �Բ� ��Ÿ���ÿ�.)
SELECT a.ename,
       a.deptno,
       a.sal,
       a.sal-500 RANGE_BEGIN,
       a.sal+500 RANGE_END,
       COUNT(*) OVER (PARTITION BY a.deptno
                      ORDER BY a.sal RANGE BETWEEN 500 PRECEDING AND 500 FOLLOWING) CNT_EMP_RANGE
FROM   emp a; 

-- ����7. �� ����� ���� ���� �Ҽ� �μ� ������ ���� �ٷ� ������ �Ի��� ����� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
--        (��, �Ʒ��� ���� ������ �Ǵ� ����� �̸�, �μ� ��ȣ, �Ի���, �޿��� �Բ� ��Ÿ���ÿ�.)
SELECT a.ename,
       a.deptno,
       a.hiredate,
       a.sal,
       LAG(a.sal) OVER (PARTITION BY a.deptno
                        ORDER BY a.hiredate) SAL_PRE_HIRE
FROM   emp a;


-- ����8. �޿��� ���� ������ 5������ ����� �̸�, �޿�, ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
--        (��, ���� ���� ���ؼ��� ���� ����(N)�� �����ϰ�, �� ���� ������ N+1 �� �ǵ��� ���Ǹ� �ۼ��Ͻÿ�.)
SELECT *
FROM   (SELECT a.ename,
               a.sal,
               DENSE_RANK() OVER (ORDER BY a.sal DESC) SAL_DENSE_RANK
        FROM   emp a
       )
WHERE SAL_DENSE_RANK <= 5;


-- ����9. �޿��� ���� ������ 5������ ����� �̸�, �޿�, ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, ���� ���� ���ؼ��� ��
--        �� ����(N)�� �����ϰ�, �� ���� ������ ���� ���� ������ŭ �ǳ� �ٵ��� ���Ǹ� �ۼ��Ͻÿ�.)
SELECT *
FROM   (SELECT a.ename,
               a.sal,
               RANK() OVER (ORDER BY a.sal DESC) SAL_RANK
        FROM   emp a
       )
WHERE SAL_RANK <= 5;

-- ����10. �޿��� ���� ������ 5������ ����� �̸�, �Ի���, �޿�, ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, ���� ��(�޿�)
--         �� ���ؼ� ���� ������ �������� �ʰ�, �޿��� �����ϸ� �Ի����� ���� ������ ������ �ű�ÿ�.)
SELECT *
FROM   (SELECT a.ename,
               a.hiredate,
               a.sal,
               RANK() OVER (ORDER BY a.sal DESC, a.hiredate) SAL_RN
        FROM   emp a
       )
WHERE SAL_RN <= 5;

-- ����11. �μ��� �� �޿��� �߿��� �� �Ҽ� ����� �޿� ����(%)�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, �޿� ������ �ݿø�
--         �Ͽ� �Ҽ��� ��° �ڸ����� ��Ÿ����, ����� �̸�, �μ���ȣ, �޿��� �Բ� ����Ͻÿ�.)
SELECT a.ename,
       a.deptno,
       a.sal,
       ROUND(RATIO_TO_REPORT(a.sal) OVER (PARTITION BY a.deptno)*100, 2) || '%' SAL_RATIO
FROM   emp a;


-- ����12. �� ����� ���� ���� ���� ������ �ڽ��� �Ի� �ϱ� �ٷ� ���� �Ի��� ����� �޿��� �ڽ��� �޿� ���� ���Ͻÿ�.
--         (��, �� ����� �̸�, ����, �Ի� ����, �޿��� �Բ� ����Ͻÿ�.)
SELECT a.ename,
       a.job,
       a.hiredate,
       a.sal,
       a.sal - LAG(a.sal) OVER (PARTITION BY a.job
                        ORDER BY a.hiredate) SAL_DIFF
FROM   emp a;

-- ����13. �� ����� �̸�, ����, �Ի� ���ڿ� �Բ� �ڽŰ� ������ ������ ���� ����� �� ���� ���� �Ի��� ����� �̸���
--         ǥ���Ͻÿ�.
SELECT a.ename,
       a.job,
       a.hiredate,
       FIRST_VALUE(a.ename) OVER (PARTITION BY a.job
                             ORDER BY a.hiredate) SAL_DIFF
FROM   emp a;

-- ����14. �� ����� ���� �̸�, �Ի� ����, Ŀ�̼ǰ� �Բ� �ڽ� ���� ���� �Ի��� ������� �޾Ҵ� Ŀ�̼� �� ���� ���Ҵ�
--         Ŀ�̼� �ݾ��� ǥ���Ͻÿ�.
SELECT a.ename, a.hiredate, a.comm,
       MAX(a.HIGHEST_COMM) OVER(ORDER BY a.hiredate) HIGHEST_COMM
FROM   (SELECT a.ename,
               a.hiredate,
               a.comm,
               LAG(a.comm) OVER (ORDER BY a.hiredate) HIGHEST_COMM
        FROM   emp a) a;


-- ����15. �� ����� ���� �̸�, �Ի� ����, Ŀ�̼ǰ� �Բ� �ڽź��� �ڿ� �Ի��� ����� �� ���� ���� Ŀ�̼��� ���� �����
--         Ŀ�̼� �ݾ��� ǥ���Ͻÿ�. (��, Ŀ�̼��� ���� ����� ������ ��No Comm���̶�� ǥ���Ͻÿ�.)
SELECT a.ename, a.hiredate, a.comm,
       NVL(TO_CHAR(LAST_VALUE(HIGHEST_COMM) IGNORE NULLS OVER(ORDER BY a.hiredate DESC)), 'No Comm') NEXT_COMM
FROM   (SELECT a.ename,
               a.hiredate,
               a.comm,
               NULLIF(LAG(a.comm) IGNORE NULLS OVER (ORDER BY a.hiredate DESC), 0) HIGHEST_COMM
        FROM   emp a) a
ORDER BY a.hiredate;

SELECT a.ename, a.hiredate, a.comm FROM emp a ORDER BY a.hiredate;

