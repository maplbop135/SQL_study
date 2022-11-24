-- ����1. �ڽ��� �����ڰ� ���� ����� �����ȣ�� �̸��� ����Ͻÿ�.
SELECT a.empno, a.ename
FROM   emp a
WHERE  a.mgr IS NULL;

-- ����2. ���� 1������ ���� ���(��)�� �����ڷ� �ΰ� �ִ� ������� �����ȣ�� �̸��� ����Ͻÿ�.
-- ��������
SELECT a.empno, a.ename
FROM   emp a
WHERE  a.mgr = (
				SELECT a.empno
				FROM   emp a
				WHERE  a.mgr IS NULL
			    );
-- ����
SELECT b.empno, b.ename
FROM   emp a, -- ������
       emp b  -- ���� ���
WHERE  a.mgr is null
       AND b.mgr = a.empno;
       
-- ����3. ���� 2������ ���� ���(��)�� �����ڷ� �ΰ� �ִ� ������� �����ȣ�� �̸��� ����Ͻÿ�.
-- ��������
SELECT a.empno, a.ename
FROM   emp a
WHERE  a.mgr IN (
				SELECT b.empno
				FROM   emp a, emp b
				WHERE  a.mgr is null
				       AND b.mgr = a.empno
				);
				
-- ����
SELECT c.empno, c.ename
FROM   emp a, -- ������
       emp b, -- ���� ���
       emp c  -- ���� ����� ���� ���
WHERE  a.mgr IS NULL
       AND b.mgr = a.empno
       AND c.mgr = b.empno;