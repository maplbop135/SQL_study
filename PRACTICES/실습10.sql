-- 사전 준비
CREATE TABLE my_emp
(
  id NUMBER(4) NOT NULL,
  ename VARCHAR2(25),
  userid VARCHAR2(8),
  salary NUMBER(9, 2)
);

DESC my_emp;

-- 문제1. 다음 예제 데이터를 MY_EMP 테이블에 추가하시오.
--        (단, INSERT 절에 컬럼 목록을 나열하지 마시오.)
INSERT INTO my_emp (id, ename, userid, salary)
VALUES             (1, 'Patel', 'rpatel', 895);

-- 문제2. 다음 예제 데이터를 MY_EMP 테이블에 추가하시오.
INSERT ALL
  INTO my_emp (id, ename, userid, salary) VALUES (2, 'Dancs', 'bdancs', 860)
  INTO my_emp (id, ename, userid, salary) VALUES (3, 'Biri', 'bbiri', 1100)
  INTO my_emp (id, ename, userid, salary) VALUES (4, 'Newman', 'cnewman', 750)
SELECT *
FROM   DUAL;

-- 문제3. MY_EMP 테이블에 추가한 항목을 확인하시오.
SELECT *
FROM MY_EMP;

-- 문제4. “COMMIT” 을 수행하여 영구히 저장하시오.
COMMIT;

-- 문제5. 사원 ID “3”의 ENAME을 "Drexler"로 변경하시오.
UPDATE MY_EMP
SET    ename = 'Drexler'
WHERE  id = 3;

-- 문제6. 급여가 900 미만인 모든 사원의 급여를 “1000”으로 변경하시오.
UPDATE MY_EMP
SET    salary = 1000
WHERE  salary < 900;

-- 문제7. ENAME이 “Dancs”인 행을 삭제하시오.
DELETE FROM MY_EMP
WHERE  ename = 'Dancs';

-- 문제8. 다음 예제 데이터를 MY_EMP 테이블에 추가하시오.
INSERT INTO my_emp (id, ename, userid, salary)
VALUES             (5, 'Ropeburn', 'aropebur', 1550);

-- 문제9. MY_EMP 테이블의 데이터를 확인하시오.
SELECT * FROM MY_EMP;

-- 문제10. “COMMIT” 을 수행하여 영구히 저장하시오.
COMMIT;

-- 문제11. EMP 테이블에서 직무가 ‘ANALYST’인 사원 데이터를 MY_EMP에 입력하시오.
--         (단, 이름은 첫 글자만 대문자로, 급여는 ½로 차감하여 입력하시오)
INSERT INTO my_emp (id, ename, userid, salary)
SELECT a.empno, INITCAP(a.ename), NULL, a.sal/2
FROM   emp a
WHERE  a.job = 'ANALYST';

-- 문제12. MY_EMP 테이블을 EMP 테이블과 병합하시오. 
--         (즉, 동일한 사원 ID(사원 번호)가 있으면 이름과 급여 값을 수정하고, 없으면 새로 추가하시오.)
MERGE INTO my_emp a
     USING emp    b
        ON (a.id = b.empno)
WHEN MATCHED THEN
       UPDATE SET a.ename = b.ename,
                  a.salary = b.sal
WHEN NOT MATCHED THEN
               INSERT (a.id, a.ename, a.salary)
               VALUES (b.empno, b.ename, b.sal);

-- 문제13. “ROLLBACK” 을 수행하여 이전 트랜잭션의 데이터 변경사항을 취소하시오.
ROLLBACK;

-- 문제14. MY_EMP 테이블의 데이터를 확인하시오.
SELECT * FROM MY_EMP;