-- ����1. ���� ���̺� ���Ǽ��� ������� DEPT01 ���̺��� �����Ͻÿ�. 
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- DEPTNO                        NUMBER      2
-- DNAME                         VARCHAR2    14
CREATE TABLE DEPT01
(
  DEPTNO    NUMBER(2),
  DNAME     VARCHAR2(14)
);

-- ����2. ���� ���̺� ���Ǽ��� ������� EMP01 ���̺��� �����Ͻÿ�.
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- EMPNO                         NUMBER      4
-- ENAME                         VARCHAR2    10
-- DEPTNO                        NUMBER      2
CREATE TABLE EMP01
(
  EMPNO    NUMBER(4),
  ENAME    VARCHAR2(10),
  DEPTNO   NUMBER(2) 
);

-- ����3. �� �̸�(ENAME)�� ���� ����� ǥ���� �� �ֵ��� EMP01 ���̺� ������ �����Ͻÿ�.
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- EMPNO                         NUMBER      4
-- ENAME                         VARCHAR2    50
-- DEPTNO                        NUMBER      2
ALTER TABLE EMP01
MODIFY
(
  ENAME VARCHAR2(50)
);

-- ����4. DEPT01 �� EMP01 ���̺��� ��� DATA DICTIONARY�� ����Ǿ����� Ȯ���Ͻÿ�. (��Ʈ : USER_TABLES)
SELECT table_name
FROM   user_tables
WHERE  table_name = 'DEPT01' OR table_name = 'EMP01';

-- ����5. EMP ���̺� ������ ������� EMP02 ���̺��� �����Ͻÿ�. (��, ��� ��ȣ, �̸�, �޿�, �μ� ��ȣ Į���� ����
--        ��Ű��, EMP02 ���̺��� �÷� �̸��� ���� ID, ENAME, SALARY �� DEPT_ID�� �����Ͻÿ�.)
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- ID                            NUMBER      4
-- ENAME                         VARCHAR2    10
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
CREATE TABLE EMP02
(
  ID      NUMBER(4),
  ENAME   VARCHAR2(10),
  SALARY  NUMBER(7, 2),
  DEPT_ID NUMBER(2)
);

-- ����6. EMP01 ���̺��� �����Ͻÿ�.
DROP TABLE EMP01;

-- ����7. EMP02 ���̺��� �̸��� ��EMP01���� �����Ͻÿ�.
ALTER TABLE EMP02 RENAME TO EMP01;

-- ����8. DEPT01 �� EMP01 ���̺� ���̺��� �����ϴ� �ڸ�Ʈ�� �߰��� ��, DATA DICTIONARY���� �߰��� �׸���
--        Ȯ���Ͻÿ�. (��Ʈ : USER_TAB_COMMENTS)
COMMENT ON TABLE DEPT01 IS '�μ� ���̺�';
COMMENT ON TABLE EMP01 IS '���� ���̺�';
SELECT table_name, comments
FROM   user_tab_comments
WHERE  comments IS NOT NULL;

-- ����9. EMP01 ���̺��� ENAME Į���� ������ ��, ���̺� ������ Ȯ���Ͻÿ�.
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- ID                            NUMBER      4
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
ALTER TABLE EMP01
DROP COLUMN ename;

-- ����10. EMP01 ���̺��� ID Į���� PRIMARY KEY ���� ������ �߰��Ͻÿ�.
--         (��, ���� ������ ������ �� �̸��� ��PK_EMP01���� �����Ͻÿ�.)
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- ID        PK                  NUMBER      4
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
ALTER TABLE EMP01 ADD CONSTRAINT PK_EMP01 PRIMARY KEY (ID);

-- ����11. DEPT01 ���̺��� DEPTNO Į���� PRIMARY KEY ���� ������ �����Ͻÿ�.
--         (��, ���� ������ ������ �� �̸��� ��PK_DEPT01���� �����Ͻÿ�.)
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- DEPTNO    PK                  NUMBER      2
-- DNAME                         VARCHAR2    14
ALTER TABLE DEPT01 ADD CONSTRAINT PK_DEPT01 PRIMARY KEY (DEPTNO);

-- ����12. �������� �ʴ� �μ�(DEPT01)�� ����� �������� �ʵ��� EMP01 ���̺��� DEPT_ID Į���� FOREIGN KEY
--         ���������� �߰��Ͻÿ�. (��, ���� ������ ������ �� �̸��� ��EMP01_DEPTNO_FK���� �����Ͻÿ�.)
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- ID        PK                  NUMBER      4
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
--
-- �÷� �̸� Ű ���� NULL �⺻�� ������ ���� ����
-- DEPTNO    PK                  NUMBER      2
-- DNAME                         VARCHAR2    14
ALTER TABLE EMP01
ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY (DEPT_ID) REFERENCES DEPT01 (DEPTNO);

-- ����13. USER_CONSTRAINTS �並 ��ȸ�Ͽ� EMP01 ���̺� ���� ������ �߰��Ǿ����� Ȯ���Ͻÿ�.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_CONSTRAINT_NAME
FROM   user_constraints
WHERE  TABLE_NAME = 'EMP01';

-- ����14. ? EMP01 ���̺��� ������ �����Ͽ� ���� �ڸ��� 2, �Ҽ��� ���� �ڸ��� 2�� NUMBER ������ ������
-- COMMISSION Į���� �߰��Ͻÿ�.
--  - Ŀ�̼� ���� ��0������ ũ���� Ŀ�̼� Į���� ���� ������ �߰��Ͻÿ�.
--  - ���������� ������ �� �̸��� CK_COMMISSION���� �����Ͻÿ�.
ALTER TABLE EMP01
ADD         COMMISSION NUMBER(2, 2);

ALTER TABLE EMP01
ADD CONSTRAINT CK_COMMISSION CHECK(commission > 0);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM   user_constraints
WHERE  TABLE_NAME = 'EMP01';

