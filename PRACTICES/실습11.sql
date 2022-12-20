-- 문제1. 다음 테이블 정의서를 기반으로 DEPT01 테이블을 생성하시오. 
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- DEPTNO                        NUMBER      2
-- DNAME                         VARCHAR2    14
CREATE TABLE DEPT01
(
  DEPTNO    NUMBER(2),
  DNAME     VARCHAR2(14)
);

-- 문제2. 다음 테이블 정의서를 기반으로 EMP01 테이블을 생성하시오.
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- EMPNO                         NUMBER      4
-- ENAME                         VARCHAR2    10
-- DEPTNO                        NUMBER      2
CREATE TABLE EMP01
(
  EMPNO    NUMBER(4),
  ENAME    VARCHAR2(10),
  DEPTNO   NUMBER(2) 
);

-- 문제3. 긴 이름(ENAME)을 가진 사원의 표시할 수 있도록 EMP01 테이블 구조를 변경하시오.
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- EMPNO                         NUMBER      4
-- ENAME                         VARCHAR2    50
-- DEPTNO                        NUMBER      2
ALTER TABLE EMP01
MODIFY
(
  ENAME VARCHAR2(50)
);

-- 문제4. DEPT01 및 EMP01 테이블이 모두 DATA DICTIONARY에 저장되었는지 확인하시오. (힌트 : USER_TABLES)
SELECT table_name
FROM   user_tables
WHERE  table_name = 'DEPT01' OR table_name = 'EMP01';

-- 문제5. EMP 테이블 구조를 기반으로 EMP02 테이블을 생성하시오. (단, 사원 번호, 이름, 급여, 부서 번호 칼럼만 포함
--        시키고, EMP02 테이블의 컬럼 이름을 각각 ID, ENAME, SALARY 및 DEPT_ID로 지정하시오.)
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
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

-- 문제6. EMP01 테이블을 삭제하시오.
DROP TABLE EMP01;

-- 문제7. EMP02 테이블의 이름을 “EMP01”로 변경하시오.
ALTER TABLE EMP02 RENAME TO EMP01;

-- 문제8. DEPT01 및 EMP01 테이블에 테이블을 설명하는 코멘트를 추가한 후, DATA DICTIONARY에서 추가한 항목을
--        확인하시오. (힌트 : USER_TAB_COMMENTS)
COMMENT ON TABLE DEPT01 IS '부서 테이블';
COMMENT ON TABLE EMP01 IS '직원 테이블';
SELECT table_name, comments
FROM   user_tab_comments
WHERE  comments IS NOT NULL;

-- 문제9. EMP01 테이블에서 ENAME 칼럼을 삭제한 후, 테이블 구조를 확인하시오.
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- ID                            NUMBER      4
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
ALTER TABLE EMP01
DROP COLUMN ename;

-- 문제10. EMP01 테이블의 ID 칼럼에 PRIMARY KEY 제약 조건을 추가하시오.
--         (단, 제약 조건을 생성할 때 이름을 “PK_EMP01”로 지정하시오.)
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- ID        PK                  NUMBER      4
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
ALTER TABLE EMP01 ADD CONSTRAINT PK_EMP01 PRIMARY KEY (ID);

-- 문제11. DEPT01 테이블의 DEPTNO 칼럼에 PRIMARY KEY 제약 조건을 생성하시오.
--         (단, 제약 조건을 생성할 때 이름을 “PK_DEPT01”로 지정하시오.)
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- DEPTNO    PK                  NUMBER      2
-- DNAME                         VARCHAR2    14
ALTER TABLE DEPT01 ADD CONSTRAINT PK_DEPT01 PRIMARY KEY (DEPTNO);

-- 문제12. 존재하지 않는 부서(DEPT01)에 사원이 배정되지 않도록 EMP01 테이블의 DEPT_ID 칼럼에 FOREIGN KEY
--         제약조건을 추가하시오. (단, 제약 조건을 생성할 때 이름은 “EMP01_DEPTNO_FK”로 지정하시오.)
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- ID        PK                  NUMBER      4
-- SALARY                        NUMBER      7,2
-- DEPT_ID                       NUMBER      2
--
-- 컬럼 이름 키 유형 NULL 기본값 데이터 유형 길이
-- DEPTNO    PK                  NUMBER      2
-- DNAME                         VARCHAR2    14
ALTER TABLE EMP01
ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY (DEPT_ID) REFERENCES DEPT01 (DEPTNO);

-- 문제13. USER_CONSTRAINTS 뷰를 조회하여 EMP01 테이블에 제약 조건이 추가되었는지 확인하시오.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_CONSTRAINT_NAME
FROM   user_constraints
WHERE  TABLE_NAME = 'EMP01';

-- 문제14. ? EMP01 테이블의 구조를 변경하여 십진 자릿수 2, 소수점 이하 자릿수 2인 NUMBER 데이터 유형의
-- COMMISSION 칼럼을 추가하시오.
--  - 커미션 값이 “0”보다 크도록 커미션 칼럼에 제약 조건을 추가하시오.
--  - 제약조건을 생성할 때 이름은 CK_COMMISSION으로 지정하시오.
ALTER TABLE EMP01
ADD         COMMISSION NUMBER(2, 2);

ALTER TABLE EMP01
ADD CONSTRAINT CK_COMMISSION CHECK(commission > 0);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM   user_constraints
WHERE  TABLE_NAME = 'EMP01';

