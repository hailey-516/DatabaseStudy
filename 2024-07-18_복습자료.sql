-- === 아래 내용을 조회할 수 있는 SQL문을 작성 ===
-- 사원 정보 중 사원번호, 이름, 월급을 조회
		SELECT EMP_ID "사원 번호", EMP_NAME 이름, SALARY AS 월급
		FROM EMPLOYEE;
-- 부서코드가 'D9'인 사원의 이름, 부서코드 조회
		SELECT EMP_NAME, DEPT_CODE          -- (3)
		FROM EMPLOYEE;          -- (1)
        WHERE DEPT_CODE = 'D9';         -- (2)
-- 실행 순서 : FROM -> WHERE -> SELECT
/*
SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9';
SELECT EMP_NAME 이름, DEPT_CODE 부서코드 FROM EMPLOYEE WHERE DEPT_CODE = 'D9';
*/

-- 연락처의 4번째자리가 7인 직원의 이름, 연락처 조회
		SELECT EMP_NAME, PHONE
		FROM EMPLOYEE
		WHERE PHONE LIKE '___7%';   --'XXX7'
-- LIKE 문의 와일드카드 : _ (1글자를 의미), % (0글자 이상을 의미)

-- 직급코드가 'J7'인 직원 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
		SELECT EMP_NAME 이름, SALARY 급여, JOB_CODE 직급코드
		FROM EMPLOYEE
		WHERE JOB_CODE = 'J7' -- (1) 직급코드가 'J7'인
                            AND SALARY >= 2000000;  -- (2) 급여가 200만원 이상
                            
-- 전체 사원 정보를 최근 입사일 기준으로 정렬하여 조회
		SELECT *
		FROM EMPLOYEE
		ORDER BY HIRE_DATE DESC;
        -- *기본값* ASC NULLS LAST -- NULL 값을 뒤쪽에 배치하여 조회
        --                  DESC NULLS FIRST -- NULL 값을 앞쪽에 배치하여 조회