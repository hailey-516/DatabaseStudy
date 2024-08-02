/*
    데이터 조회(추출) : SELECT
    
        SELECT 조회하고자 하는 정보 FROM 테이블명;
        SELECT * 또는 컬럼명1, 컬럼명2, ... FROM 테이블명;
*/
-- 모든 사원의 정보를 조회
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민등록번호, 핸드폰번호를 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE;

-- JOB 테이블에서 직급 이름만 조회
SELECT JOB_NAME FROM JOB;

-- DEPARTMENT 테이블의 모든 정보를 조회
SELECT * FROM DEPARTMENT;

-- 직원 테이블(EMPLOYEE)의 사원명, 이메일, 연락처, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

/*
    컬럼값에 산술 연산하기
    => SELECT절에 컬럼명 작성부분에 산술연산을 할 수 있음!
*/
-- 사원이름, 연봉 정보(SALARY * 12) 조회
-- SALARY*12  : SALLARY 컬럼 데이터에 12를 곱하여 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- 사원이름, 급여, 보너스, 연봉, 보너스 포함 연봉(급여 + (급여*보너스)) * 12 정보를 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + (SALARY*BONUS) *12)
FROM EMPLOYEE;

/*
    - 현재 날짜시간 정보 : SYSDATE
    - 가상 테이블(임시테이블) : DUAL
*/

-- 현재 시간 정보 조회
SELECT SYSDATE FROM DUAL;       -- YY/MM/DD 형식으로 조회됨!

-- 사원이름, 입사일, 근무일수(현재날짜 - 입사일) 조회
-- DATE타입 - DATE타입 => 일로 표시됨!
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

/*
     * 컬럼명 별칭 지정 : 연산식을 사용한 경우 의미파악이 어렵기 때문에, 별칭을 부여하여 명확하고 깔끔하게 조회 가능!
    
    [표현법] 1) 컬럼명 별칭
                      2) 컬럼명 AS 별칭
                      3) 컬럼명 "별칭" (띄어쓰기, 특수문자 있는 경우...)
                      4) 컬럼명 AS "별칭"
*/
-- 사원이름, 급여, 보너스, 연봉, 보너스 포함 연봉으로 각 별칭 부여하여 조회
SELECT EMP_NAME 사원이름, SALARY 급여, BONUS, SALARY*12 AS 연봉, (SALARY + (SALARY*BONUS) *12) "보너스 포함 연봉"
FROM EMPLOYEE;

/*
     * 리터럴 : 임의로 지정한 문자열('')
        - SELECT 절에 사용하는 경우 조회된 결과(Result set)에 반복적으로 표시됨
*/
-- 이름, 급여, '원' 조회
SELECT EMP_NAME 이름, SALARY 급여, '원' 단위
FROM EMPLOYEE;

/*
      연결 연산자 : ||
*/
SELECT SALARY || '원' AS 급여
FROM EMPLOYEE;

-- 사번, 이름, 급여를 한번에(한 컬럼에) 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- XXX의 급여는 XXXX원입니다
SELECT EMP_NAME || '의 급여는 ' || SALARY || '원입니다.' AS 급여정보
FROM EMPLOYEE;

-- 사원테이블에서 직급코드 조회
SELECT JOB_CODE 직급코드 FROM EMPLOYEE;

/*
      * 중복제거 : DISTINCT
*/
-- 사원테이블에서 직급코드 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
-- DISTINCT 는 한 번만 사용 가능
-- (JOB_CODE, DEPT_CODE) 를 한 쌍으로 묶어서 중복을 제거해줌!
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- =====================================================
/*
      * WHERE절 : 조회하고자 하는 데이터를 특정 조건에 따라 추출하고자 할 때 사용
    
    [표현법]
                    SELECT 컬럼명, 컬럼|데이터 기준 연산식
                    FROM 테이블명
                    WHERE 조건;
                    
    - 비교 연산자
            * 대소비교 : >, <,  >=, <=
            * 동등비교
                    - 같은지 : =
                    - 다른지 : !=, <>, ^=
*/
-- 사원테이블에서 부서코드가 'D9'인 사원들의 정보 조회
SELECT *                                    -- 전체컬럼을 조회할 건데
FROM EMPLOYEE                     -- EMPLOYEE 테이블에서
WHERE DEPT_CODE = 'D9';   -- DEPT_CODE의 값이 'D9'인 정보만 조회

-- 사원테이블에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드 조회
SELECT EMP_NAME 사원명, SALARY 급여, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 부서코드가 D1이 아닌 사원들의 정보 조회(사원명, 급여, 부서코드)
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';

-- 급여가 400만원 이상인 사원의 사원명, 부서코드, 급여 정보를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- ================================================
------------------- 실습 ---------------------------
-- ** 연봉은 보너스 제외 **
-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회 (별칭 적용)
SELECT EMP_NAME AS 사원명, SALARY AS  급여, HIRE_DATE AS 입사일, SALARY * 12 AS 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회 (별칭 적용) 
SELECT EMP_NAME AS 사원명, SALARY AS 급여, SALARY * 12 AS 연봉, DEPT_CODE AS 부서코드
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;

-- 3. 직급코드 'J3'가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회 (별칭 적용)
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_CODE 직급코드, ENT_YN 퇴사여부
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 4. 급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여 조회 (별칭 적용)
--          AND, OR로 조건을 연결할 수 있음
SELECT EMP_NAME AS 사원명, EMP_ID AS 사번, SALARY AS 급여
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- ==============================================================
/*
      * BETWEEN AND : 조건식에서 사용되는 구문
    => ~ 이상 ~ 이하인 범위에 대한 조건을 제시하는 구문
    
    [표현법]
                    비교대상컬럼명 BETWEEN 최솟값 AND 최댓값
                    => 해당 컬럼의 값이 최솟값 이상이고 최댓값 이하인 경우
*/
-- 급여가 350만원 이상이고 600만원 이하인 사원의 사원명, 사번, 급여 조회 (BETWEEN AND x)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- 급여가 350만원 이상이고 600만원 이하인 사원의 사원명, 사번, 급여 조회 (BETWEEN AND 적용!)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

/*
      * NOT : 오라클에서의 논리부정연산자
*/
-- 급여가 350만원 미만 또는 600만원 초과인 사원의 사원명, 사번, 급여 조회 (NOT x)
SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

SELECT EMP_NAME 사원명, EMP_ID 사번, SALARY 급여
FROM EMPLOYEE
-- WHERE  SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY  BETWEEN 3500000 AND 6000000;
-- NOT은 BETWEEN 앞에 붙이거나 컬럼명 앞에 붙여서 사용 가능!

/*
     * IN : 비교대상컬럼값이 제시한 값들 중에 일치하는 값이 있는 경우 조회하는 연산자
    
    [표현법]
                    비교대상컬럼명 IN ('값1', '값2', '값3', ...)
*/
-- 부서코드가 D6이거나 D8이거나 D5인 사원들의 사원명, 부서코드, 급여를 조회 (IN x)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- 부서코드가 D6이거나 D8이거나 D5인 사원들의 사원명, 부서코드, 급여를 조회 (IN 사용!)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 9. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 
--     고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
-- WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '2002/01/01';
WHERE DEPT_CODE IN ('D9', 'D5') AND HIRE_DATE<'02/01/01';
-- =============================================================
/*
     * LIKE : 비교하고자하는 컬럼의 값이 제시한 특정 패턴에 만족할 경우 조회
    
    => 특정 패턴 : '%', '_'를 와일드카드로 사용
            * '%' : 0글자 이상
                ex) 비교대상컬럼명 LIKE '문자%' => 비교대상컬럼의 값에 문자로 "시작"되는 것을 조회
                        비교대상컬럼명 LIKE '%문자' => 비교대상컬럼의 값이 문자로 "끝"나는 것을 조회
                        비교대상컬럼명 LIKE '%문자%' => 비교대상컬럼의 값에 문자가 "포함"되는 것을 조회 (키워드 검색)
            * '_' : 1글자
                ex) 비교대상컬럼명 LIKE '_문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 한 글자가 올 경우 조회
                        비교대상컬럼명 LIKE '__문자' => 비교대상컬럼의 값에서 문자 앞에 무조건 두 글자가 올 경우 조회
                        비교대상컬럼명 LIKE '_문자_' => 비교대상컬럼의 값에서 문자 앞, 뒤에 무조건 한 글자씩 있을 경우 조회
*/
-- 사원들 중에 전씨인 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 사원 이름에 하가 포함된 사원의 사원명, 주민번호, 연락처 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 사원 이름의 가운데 글자가 하인 사원의 사원명, 연락처 조회 (이름 3글자만 있다면...)
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 사원들 중 연락처의 3번째 자리가 1인 사원의 사번, 사원명, 연락처, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 사원들 중 이메일에 4번째자리가 _인 사원의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- => 와일드카드로 사용되는 문자와 컬럼에 담긴 문자가 동일하기 때문에 모두 와일드카드로 인지됨!
--        따라서, 구분을 해줘야 함! (=> 나만의 와일드카드 사용하기!  ESCAPE 를 사용하여 등록 후 적용)

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';       -- 평가 때 가끔 나옴!
-- =======================================================
/*
     * IS NULL / IS NOT NULL : 컬럼값에 NULL이 있을 경우 NULL값을 비교할 때 사용하는 연산자
*/
-- 보너스를 받지 않는 사원(BONUS의 값이 NULL!)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- 보너스를 받는 사원(BONUS의 값이 NULL이 아님!)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL;     -- BONUS가 NULL인 것 자체를 부정

-- 사수가 없는 사원(MANAGER_ID의 값이 NULL!)들의 사원명, 사수 사번(MANAGER_ID), 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서 배치를 받지 않았지만, 보너스를 받고 있는 사원의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- =========================================================
/*
        * 연산자 우선순위
            (0) ()
            (1) 산술연산자 : * / + -
            (2) 연결연산자 : ||
            (3) 비교연산자 : > < >= <= = != ...
            (4) IS NULL / LIKE '패턴' / IN
            (5) BETWEEN AND
            (6) NOT
            (7) AND
            (8) OR
*/
-- 직급 코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원의 모든 정보를 조회
SELECT *
FROM EMPLOYEE
-- WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;
-- ===========================================================
/*
        * ORDER BY : SELECT문의 가장 마지막 줄에 작성, 실행순서 또한 마지막에 실행
        
        [표현법]
                        SELECT 조회할 컬럼, ...
                        FROM 테이블명
                        WHERE 조건식
                        ORDER BY 정렬기준이되는컬럼 | 별칭 | 컬럼순번 [ASC|DESC] [NULLS FIRST | NULLS LAST]
                        
                        * ASC : 오름차순 정렬 (기본값)
                        * DESC : 내림차순 정렬
                        
                        * NULLS FIRST : 정렬하고자 하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 앞에 배치 (DESC인 경우 기본값)
                        * NULLS LAST : 정렬하고자하는 컬럼의 값이 NULL인 경우 해당 데이터를 맨 뒤에 배치 (ASC인 경우 기본값)
                        => NULL 값은 큰 값으로 분류되어 정렬됨!
*/
-- 모든 사원의 사원명, 연봉 조회 (연봉별 내림차순 정렬)
SELECT EMP_NAME, SALARY * 12 연봉
FROM EMPLOYEE
-- ORDER BY SALARY * 12 DESC; --  정렬기준이되는컬럼(연산식)
-- ORDER BY 연봉 DESC; -- 별칭 사용
ORDER BY 2 DESC; -- 컬럼 순번 사용 (오라클에서는 1부터 시작!)

-- 보너스 기준으로 정렬해보기
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; -- 기본값 (ASC, NULLS LAST)
-- ORDER BY BONUS ASC; -- NULLS LAST
-- ORDER BY BONUS ASC NULLS LAST;
-- ORDER BY BONUS DESC;    -- NULLS FIRST (DESC 정렬인 경우 기본값!)
ORDER BY BONUS DESC, SALARY ASC; -- 보너스는 내림차순, 급여는 오름차순 => 보너스 값을 내림차순 정렬하는데, 같은 값인 경우 급여의 값을 오름차순으로 정렬

