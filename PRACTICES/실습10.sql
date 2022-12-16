-- ���� �غ�
CREATE TABLE my_emp
(
  id NUMBER(4) NOT NULL,
  ename VARCHAR2(25),
  userid VARCHAR2(8),
  salary NUMBER(9, 2)
);

DESC my_emp;

-- ����1. ���� ���� �����͸� MY_EMP ���̺� �߰��Ͻÿ�.
--        (��, INSERT ���� �÷� ����� �������� ���ÿ�.)
INSERT INTO my_emp (id, ename, userid, salary)
VALUES             (1, 'Patel', 'rpatel', 895);

-- ����2. ���� ���� �����͸� MY_EMP ���̺� �߰��Ͻÿ�.
INSERT ALL
  INTO my_emp (id, ename, userid, salary) VALUES (2, 'Dancs', 'bdancs', 860)
  INTO my_emp (id, ename, userid, salary) VALUES (3, 'Biri', 'bbiri', 1100)
  INTO my_emp (id, ename, userid, salary) VALUES (4, 'Newman', 'cnewman', 750)
SELECT *
FROM   DUAL;

-- ����3. MY_EMP ���̺� �߰��� �׸��� Ȯ���Ͻÿ�.
SELECT *
FROM MY_EMP;

-- ����4. ��COMMIT�� �� �����Ͽ� ������ �����Ͻÿ�.
COMMIT;

-- ����5. ��� ID ��3���� ENAME�� "Drexler"�� �����Ͻÿ�.
UPDATE MY_EMP
SET    ename = 'Drexler'
WHERE  id = 3;

-- ����6. �޿��� 900 �̸��� ��� ����� �޿��� ��1000������ �����Ͻÿ�.
UPDATE MY_EMP
SET    salary = 1000
WHERE  salary < 900;

-- ����7. ENAME�� ��Dancs���� ���� �����Ͻÿ�.
DELETE FROM MY_EMP
WHERE  ename = 'Dancs';

-- ����8. ���� ���� �����͸� MY_EMP ���̺� �߰��Ͻÿ�.
INSERT INTO my_emp (id, ename, userid, salary)
VALUES             (5, 'Ropeburn', 'aropebur', 1550);

-- ����9. MY_EMP ���̺��� �����͸� Ȯ���Ͻÿ�.
SELECT * FROM MY_EMP;

-- ����10. ��COMMIT�� �� �����Ͽ� ������ �����Ͻÿ�.
COMMIT;

-- ����11. EMP ���̺��� ������ ��ANALYST���� ��� �����͸� MY_EMP�� �Է��Ͻÿ�.
--         (��, �̸��� ù ���ڸ� �빮�ڷ�, �޿��� ���� �����Ͽ� �Է��Ͻÿ�)
INSERT INTO my_emp (id, ename, userid, salary)
SELECT a.empno, INITCAP(a.ename), NULL, a.sal/2
FROM   emp a
WHERE  a.job = 'ANALYST';

-- ����12. MY_EMP ���̺��� EMP ���̺�� �����Ͻÿ�. 
--         (��, ������ ��� ID(��� ��ȣ)�� ������ �̸��� �޿� ���� �����ϰ�, ������ ���� �߰��Ͻÿ�.)
MERGE INTO my_emp a
     USING emp    b
        ON (a.id = b.empno)
WHEN MATCHED THEN
       UPDATE SET a.ename = b.ename,
                  a.salary = b.sal
WHEN NOT MATCHED THEN
               INSERT (a.id, a.ename, a.salary)
               VALUES (b.empno, b.ename, b.sal);

-- ����13. ��ROLLBACK�� �� �����Ͽ� ���� Ʈ������� ������ ��������� ����Ͻÿ�.
ROLLBACK;

-- ����14. MY_EMP ���̺��� �����͸� Ȯ���Ͻÿ�.
SELECT * FROM MY_EMP;