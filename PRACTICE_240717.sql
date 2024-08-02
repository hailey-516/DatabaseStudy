-- 1. EMPLOYEE 테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
-- WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';

-- 2. EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 3. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
-- WHERE NOT PHONE LIKE '010%';
WHERE PHONE NOT LIKE '010%';

-- 4. EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고 
--     고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회 
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%' ESCAPE '#' AND DEPT_CODE IN ('D9', 'D6') 
                        AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' AND SALARY >= 2700000;