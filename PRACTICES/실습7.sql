-- ����1. �̸��� ��JONES���� ����� ���� �Ͽ� �ִ� ��� ����� �̸�, �޿�, �μ� ��ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
SELECT a.ename, a.sal, a.deptno, a.mgr
FROM   emp a
START WITH  a.ename = 'JONES'
CONNECT BY a.mgr = PRIOR a.empno;

-- ����2. �̸��� ��ADAMS���� ����� ���� �����ڵ��� ��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--        (��, ������ ������ ���� �����ڵ��� ��� ��ȣ �� �̸��� ����Ͻÿ�.)
SELECT a.empno, a.ename
FROM   emp a
START WITH a.empno = (SELECT a.mgr
                      FROM   emp a
                      WHERE  a.ename = 'ADAMS')
CONNECT BY a.empno = PRIOR a.mgr;

-- ����3. �̸��� ��JONES���� ����� ���� �Ͽ� �ִ� ��� ����� ��� ��ȣ, �̸�, ������ ��� ��ȣ�� ǥ���ϴ� ���Ǹ�
--        �ۼ��Ͻÿ�. (��, �Ʒ��� ���� ��ENAME" ���� ���� ������ �ľ��� �� �ֵ��� �鿩���⸦ �����Ͻÿ�.)
SELECT a.empno,
       CASE WHEN LEVEL = 1
       THEN a.ename
       WHEN LEVEL = 2
       THEN '__'||a.ename
       ELSE '____'||a.ename
       END ENAME,
       a.mgr
FROM   emp a
START WITH a.ename = 'JONES'
CONNECT BY a.mgr = PRIOR a.empno;

-- ����4. (CONNECT BY ���� ������� �ʰ�) SELF JOIN�� ����Ͽ� 3�� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
DROP TABLE EMP_LV1;
DROP TABLE EMP_LV2;
DROP TABLE EMP_LV3;

CREATE TABLE EMP_LV1
AS
SELECT a.empno,
       a.ename,
       a.mgr
FROM   emp a
WHERE  a.ename = 'JONES';

CREATE TABLE EMP_LV2
AS
SELECT b.empno,
       '__'||b.ename ENAME,
       b.mgr
FROM   emp_lv1 a, emp b
WHERE  b.mgr = a.empno;

CREATE TABLE EMP_LV3
AS
SELECT b.empno,
       '____'||b.ename ENAME,
       b.mgr
FROM   emp_lv2 a, emp b
WHERE  b.mgr = a.empno;

SELECT *
FROM   emp_lv1
UNION
SELECT *
FROM   emp_lv2
UNION
SELECT *
FROM   emp_lv3;

-- ����5. ��� ����� ���� ���� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. (��, �̸��� ��BLAKE���� ����� ���� �Ͽ� �ִ�
--        ������ ������ ��ANALYST���� ������� ��� �����ϰ� ����Ͻÿ�.)
SELECT a.ename, a.job, a.empno, a.mgr
FROM   emp a
WHERE  a.job <> 'ANALYST'
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
           AND a.ename <> 'BLAKE';

-- ����6. ��� ����� ���� ���� ����(LEVEL) ���� �޿� �հ� �� ��� �޿��� ���Ͻÿ�.
SELECT '���� ���� '||LEVEL MGR_LV,
       SUM(a.sal) SUM_SAL,
       ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
GROUP BY LEVEL;

-- ����7. ��� ����� ���ֻ��� �����ڡ�, ���߰� �����ڡ�, ���Ϲ� ������� 3�׷����� ������, �� �׷� �� �޿� �հ� �� ��� �޿�
--        �� ���Ͻÿ�.
SELECT '�ְ� ������' MGR_LV,
       SUM(a.sal) SUM_SAL,
       ROUND(AVG(a.sal), 2) AVG_SAL
FROM   emp a
WHERE  a.ename = CONNECT_BY_ROOT a.ename
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
UNION
SELECT CASE WHEN MAX(CONNECT_BY_ISLEAF) = 1
            THEN '�Ϲ� ���'
            ELSE '�߰� ������'
       END,
       SUM(a.sal),
       ROUND(AVG(a.sal), 2)
FROM   emp a
WHERE  a.ename <> CONNECT_BY_ROOT a.ename
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
GROUP BY CONNECT_BY_ISLEAF;

-- ����8. ��� ����� ���ؼ� �Ʒ��� ���� �ڽ��� ���� ������(��)�� ��� �����Ͽ� ǥ���Ͻÿ�.
SELECT a.empno,
       a.ename,
       SUBSTR(SYS_CONNECT_BY_PATH(a.ename, ', '), 3, INSTR(SYS_CONNECT_BY_PATH(a.ename, ', '), ',', -1)-3) MANAGERS
FROM   emp a
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno;

-- ����9. ��� ����� ���� ���� ������ ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--        (��, ���� ���� ������ �μ� ��ȣ�� ��������, ��� �̸��� ������������ �����Ͽ� ��Ÿ���ÿ�.)
SELECT LEVEL,
       a.empno,
       LPAD('_', (LEVEL-1)*2, '_')||a.ename,
       a.deptno
FROM   emp a
START WITH a.ename = 'KING'
CONNECT BY a.mgr = PRIOR a.empno
ORDER SIBLINGS BY a.deptno DESC, a.ename;

-- ����10. �� ��� ���� �ڽ��� �޿� �� ���� �����ڵ��� �޿��� ���� ��ü �հ踦 ǥ���Ͻÿ�
SELECT MAX(CONNECT_BY_ROOT a.empno) EMPNO,
       MAX(CONNECT_BY_ROOT a.ename) ENAME,
       SUM(a.sal) SUM_SAL
FROM emp a
CONNECT BY a.empno = PRIOR a.mgr
GROUP BY CONNECT_BY_ROOT a.ename;


