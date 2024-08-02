/*
        선택함수
                * DECODE(비교대상(컬럼/연산식/함수식), 비교값1, 결과값1, 비교값2, 결과값2, ...)
                
                -- 자바에서 switch
                switch(비교대상) {
                    case 비교값1: 결과값
                    case 비교값2: 결과값
                    ...
                }
*/
-- 사번, 사원명, 주민번호, 성별 조회 
-- (성별은 다음과 같이 표시한다. 1: '남', 2: '여', 3: '남', 4: '여자', '알수없음')
SELECT EMP_ID 사번, EMP_NAME 사원명, EMP_NO 주민번호
                    , DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여', 3, '남자', 4, '여자', '알수없음') 성별
FROM EMPLOYEE;

-- 사원명, 기존급여, 인상된 급여 조회
/*
        직급이 J7인 사원은 10% 인상
                      J6                    15% 인상
                      J5                    20% 인상
        그 외에는                      5% 인상
*/

SELECT EMP_NAME 사원명, SALARY 기존급여
    , SALARY*DECODE(JOB_CODE,
                                                'J7', 1.1,
                                                'J6', 1.15,
                                                'J5', 1.2,
                                                1.05) "인상된 급여"
FROM EMPLOYEE;
/*
        CASE WHEN THEN : 조건식에 따라 결과값을 반환해주는 함수
        
        [표현법]
                        CASE
                                    WHEN 조건식1 THEN 결과값1
                                    WHEN 조건식2 THEN 결과값2
                                    ...
                                    ELSE 결과값
                        END
*/
-- 사원명, 급여, 급여에 따른 등급 조회
/*
        급여가...
        500만원 이상 '고급'
        350만원 이상 '중급'
        그외 '초급'
*/
SELECT EMP_NAME 사원명, SALARY 급여,
                CASE
                            WHEN SALARY >= 5000000 THEN '고급'
                            WHEN SALARY >= 3000000 THEN '중급'
                            ELSE '초급'
                END "급여에 따른 등급"
FROM EMPLOYEE;
-- ==================================================================
--------------------- 그룹 함수 ---------------------
/*
        * SUM : 해당 컬럼의 값들의 총 합을 반환해주는 함수
        
        [표현법]
                        SUM(숫자타입컬럼)
*/
-- 전체 사원의 총 급여를 조회
SELECT TO_CHAR(SUM(SALARY),'L999,999,999') 총급여
FROM EMPLOYEE;

-- 남자 사원들의 총 급여
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "남자 사원들의 총 급여"  -- 3
FROM EMPLOYEE   -- 1
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');    -- 2

-- 여자 사원들의 총 급여
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "여자 사원들의 총 급여"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 부서코드가 'D5'인 사원들의 총 연봉
SELECT TO_CHAR(SUM(SALARY*12), 'L999,999,999') "부서코드 D5인 사원들의 총 연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
        AVG : 해당 컬럼의 값들의 평균을 반환해주는 함수
        
        [표현법]
                        AVG(숫자타입컬럼)
*/
-- 전체 사원들의 평균 급여 조회
SELECT ROUND( AVG(SALARY) ) "전체 사원 평균 급여"
FROM EMPLOYEE;

/*
        * MIN : 해당 컬럼의 값들 중 가장 작은 값 반환해주는 함수
        
        [표현법] MIN(모든타입)
*/

SELECT MIN(EMP_NAME) "문자타입 최솟값", MIN(SALARY) "숫자타입 최솟값", MIN(HIRE_DATE) "날짜타입 최솟값"
FROM EMPLOYEE;

/*
        MAX : 해당 컬럼의 값들 중 가장 큰 값을 반환해주는 함수
        
        [표현법] MAX(모든타입)
*/

SELECT MAX(EMP_NAME) "문자타입 최댓값", MAX(SALARY) "숫자타입 최댓값", MAX(HIRE_DATE) "날짜타입 최댓값"
FROM EMPLOYEE;

/*
        COUNT : 행의 개수를 반환해주는 함수 (단, 조건이 있을 경우 해당 조건에 맞는 행의 개수를 반환)
        
        [표현법]
                        COUNT(*) : 조회된 결과에 모든 행의 개수를 반환
                        COUNT(컬럼) : 해당 컬럼값이 NULL이 아닌 것만 행의 개수로 세어 반환
                        COUNT(DISTINCT 컬럼) : 해당 컬럼값의 중복의 제거한 후 행의 개수를 세어 반환
                                                => 중복 제거 시 NULL은 포함하지 않고 개수가 세어짐!
*/
-- 전체 사원 수 조회
SELECT COUNT(*) "전체 사원 수" FROM EMPLOYEE;

-- 남자 사원 수 조회
SELECT COUNT(*) "남자 사원 수"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 보너스 받는 사원 수 조회
SELECT COUNT(BONUS) "보너스 받는 사원 수" FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 부서 배치 받은 사원 수 조회 => 부서 코드가 NULL이 아닌 행의 개수
SELECT COUNT(DEPT_CODE) FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

