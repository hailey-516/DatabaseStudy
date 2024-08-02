/*
        서브쿼리 (SUBQUERY)
        : 하나의 쿼리문 내에 포함된 또 다른 쿼리문
            메인 역할을 하는 쿼리문을 위해 보조 역할을 하는 쿼리문
*/

-- "노옹철" 사원과 같은 부서에 속한 사원 정보를 조회

-- 1) 노옹철 사원의 부서코드 조회 --> 'D9'
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서 코드가 'D9'인 사원 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위의 2개의 쿼리문을 하나로 합쳐본다면...
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                                                    FROM EMPLOYEE
                                                    WHERE EMP_NAME = '노옹철');

-- 전체 사원의 평균 급여보다 더 많은 급여를 받는 사원의 정보를 조회
-- 1) 전체 사원의 평균 급여 조회 (반올림 처리)
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 2) 평균급여(3047663)보다 더 많은 급여를 받는 사원 정보 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- 서브쿼리로 적용해보자...
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY > = ( SELECT ROUND(AVG(SALARY))
                                                FROM EMPLOYEE );
-----------------------------------------------------------
/*
        * 서브쿼리의 종류 *
            서브쿼리를 수행한 결과값이 몇행 몇열로 나오냐에 따라 분류
            
            - 단일행 서브쿼리 : 서브쿼리의 수행 결과가 오로지 1개일 때 (1행 1열)
            - 다중행 서브쿼리 : 서브쿼리의 수행 결과가 여러 행일 때 (N행 1열)
            - 다중열 서브쿼리 : 서브쿼리의 수행 결과가 한 행이고 여러 개의 컬럼일 때 (1행 N열)
            - 다중행 다중열 서브쿼리 : 서브쿼리의 수행 결과가 여러 행 여러 컬럼일 때 (N행 N열)
            
            >> 종류에 따라 서브쿼리 앞에 붙는 연산자가 달라짐!
*/

 -- 단일행 서브쿼리 : 서브쿼리 결과가 오로지 1개일 때!
 /*
        일반적인 비교연산자 사용 가능 : = != > < >= ...
 */
-- 전 직원의 평균 급여보다 더 적게 급여를 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < ( SELECT AVG(SALARY) FROM EMPLOYEE );

-- 최저급여를 받는 사원의 사원명, 급여, 입사일 조회
-- 최저급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = ( SELECT MIN(SALARY) FROM EMPLOYEE );

-- 노옹철 사원의 급여보다 많이 받는 사원의 사원명, 부서코드, 급여 조회
-- SALARY > 노옹철 사원의 급여
-- * 노옹철 사원의 급여
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                                         FROM EMPLOYEE
                                        WHERE EMP_NAME = '노옹철');

-- 위의 결과에서 부서코드를 부서명으로 변경하여 조회
-- * 오라클 구문 *
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
            AND SALARY > (SELECT SALARY
                                         FROM EMPLOYEE
                                        WHERE EMP_NAME = '노옹철');

-- * ANSI 구문 *
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                                         FROM EMPLOYEE
                                        WHERE EMP_NAME = '노옹철');

-- 부서별 급여합이 가장 큰 부서의 부서코드, 급여합을 조회
-- 1) 부서별 급여합 중 가장 큰 값 하나만 조회  .---> 17700000
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 부서별 급여합이 17700000인 부서의 부서코드, 급여합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- 두 쿼리문을 합해보자
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = ( SELECT MAX(SUM(SALARY))
                                                            FROM EMPLOYEE
                                                            GROUP BY DEPT_CODE );

-- 전지연 사원과 같은 부서의 사원들의 사번, 사원명, 연락처, 입사일, 부서명을 조회
-- (단, 전지연 사원은 제외하고 조회!)
-- * 오라클 구문 *
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
            AND DEPT_CODE = ( SELECT DEPT_CODE
                                                            FROM EMPLOYEE
                                                            WHERE EMP_NAME = '전지연' )
            AND EMP_NAME <> '전지연';


-- * ANSI 구문 *
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                                                    FROM EMPLOYEE
                                                    WHERE EMP_NAME = '전지연' )
                AND EMP_NAME != '전지연';
--------------------------------------------------------------------
/*
        다중행 서브쿼리 : 서브쿼리 수행 결과가 여러 행인 경우 (N행 1열)
        
        IN (서브쿼리) : 여러 개의 결과값 중에 하나라도 일치하는 값이 있다면 조회
        > ANY (서브쿼리) : 여러 개의 결과값 중에서 하나라도 큰 경우가 있으면 조회
        < ANY (서브쿼리) : 여러 개의 결과값 중에서 하나라도 작은 경우가 있다면 조회
                * 비교대상 > 결과값1 OR 비교대상 > 결과값2 OR 비교대상 > 결과값3 ...
                
        > ALL (서브쿼리) : 여러 개의 모든 결과값보다 클 경우 조회
        < ALL (서브쿼리) : 여러 개의 모든 결과값보다 작을 경우 조회
                * 비교대상 > 결과값1 AND 비교대상 > 결과값2 AND 비교대상 > 결과값3 ...
*/
-- 유재식 사원 또는 윤은해 사원과 같은 직급인 사원들의 정보 조회 (사번/사원명/직급코드/급여)
-- * 유재식 사원 또는 윤은해 사원의 직급 코드 조회
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해');

-- * 직급코드가 'J3' 또는 'J7'인 사원들의 정보를 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- 서브쿼리로 적용해보기
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ( SELECT JOB_CODE
                                                    FROM EMPLOYEE
                                                    WHERE EMP_NAME IN ('유재식', '윤은해'));
                                                    
-- 대리 직급인 사원들 중 과장 직급의 사원의 최소 급여보다 많이 받는 사원 정보 조회(사번, 이름, 직급명, 급여)
-- * 과장 직급의 급여 -- 3760000, 2200000, 2500000
SELECT SALARY
FROM EMPLOYEE
            JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- * > ANY 연산자를 사용하여 비교
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
            AND SALARY > ANY ( 3760000, 2200000, 2500000)
            AND JOB_NAME = '대리';

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
            AND SALARY > ANY (  SELECT SALARY
                                                           FROM EMPLOYEE
                                                                JOIN JOB USING(JOB_CODE)
                                                          WHERE JOB_NAME = '과장'   )
            AND JOB_NAME = '대리';

------------------------------------------------------------------
/*
        다중열 서브쿼리 : 서브쿼리 수행 결과가 행은 하나이고, 컬럼(열) 수가 여러 개인 경우
*/

-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원 정보를 조회
--  1) 하이유 사원의 부서코드, 직급코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- --------------------
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                                                    FROM EMPLOYEE
                                                    WHERE EMP_NAME = '하이유')
            AND JOB_CODE = (SELECT JOB_CODE
                                                        FROM EMPLOYEE
                                                        WHERE EMP_NAME = '하이유');

-- * 다중행 서브쿼리를 사용할 경우
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = ( SELECT DEPT_CODE, JOB_CODE
                                                                                FROM EMPLOYEE
                                                                                WHERE EMP_NAME = '하이유');
                                                                                
-- 박나라 사원과 같은 직급코드, 같은 사수를 가지고 있는 사원 정보 조회 (사원명, 직급코드, 사수번호)
-- 1) 박나라 사원의 직급코드, 사수번호를 조회
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라';

-- 2) 같은 직급코드 같은 사수를 가지고 있는 사원 정보를 조회
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = ( SELECT JOB_CODE, MANAGER_ID
                                                                                    FROM EMPLOYEE
                                                                                    WHERE EMP_NAME = '박나라' )
            AND EMP_NAME != '박나라';  -- 박나라 사원을 제외하고자 한다면...
-------------------------------------------------------------------
/*
        다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행, 여러 개의 열인 경우
*/
-- 각 직급별 최소급여를 받는 사원 정보를 조회
-- 1) 각 직급별 최소급여
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
/*
J1	8000000
J2	3700000
J4	1550000
J3	3400000
J7	1380000
J5	2200000
J6	2000000
*/
-- 2) 각 직급별 최소급여를 받는 사원 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' AND SALARY = 8000000
            OR JOB_CODE = 'J2' AND SALARY = 3700000
            OR JOB_CODE = 'J3' AND SALARY = 3400000;
            -- ...;
            
-- 서브쿼리 적용
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN ( SELECT JOB_CODE , MIN(SALARY)
                                                                            FROM EMPLOYEE
                                                                            GROUP BY JOB_CODE);
                                                                            
-- 각 부서별로 최고급여를 받는 사원 정보 조회
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN ( SELECT DEPT_CODE, MAX(SALARY)
                                                                            FROM EMPLOYEE
                                                                            GROUP BY DEPT_CODE);
-------------------------------------------------------------------
/*
        인라인 뷰 : 서브쿼리를 FROM절에 사용하는 것 
                            => 서브쿼리의 수행 결과를 마치 테이블처럼 사용하는 것
*/
-- 사원들의 사번, 이름, 보너스 포함 연봉, 부서코드를 조회
-- * 보너스 포함 연봉이 NULL이 아니어야 하고, 보너스 포함 연봉이 3000만원 이상인 사원들만 조회
--                                => NVL :  NULL인 경우 다른 값으로 변경
SELECT EMP_ID 사번, EMP_NAME 이름, (SALARY + (SALARY* NVL(BONUS, 0)))*12 "보너스 포함 연봉", DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE (SALARY + (SALARY* NVL(BONUS, 0)))*12 > 30000000
ORDER BY 3 DESC;

-- => TOP-N분석 : 상위 N개를 조회
SELECT ROWNUM, 사번, 이름, "보너스 포함 연봉", 부서코드
FROM ( SELECT EMP_ID 사번, EMP_NAME 이름, (SALARY + (SALARY* NVL(BONUS, 0)))*12 "보너스 포함 연봉", DEPT_CODE 부서코드
                FROM EMPLOYEE
                WHERE (SALARY + (SALARY* NVL(BONUS, 0)))*12 > 30000000
                ORDER BY 3 DESC )
WHERE ROWNUM <= 5; -- 1, 2, 3, 4, 5

-- 가장 최근에 입사한 사원 5명을 조회
-- 입사일 기준 내림차순 정렬 (사번, 이름, 입사일)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT ROWNUM, 사번, 이름, 입사일
FROM ( SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일
                FROM EMPLOYEE
                ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;
----------------------------------------------------------------
/*
        순서를 매기는 함수 (WINDOW FUNCTION)
        
        - RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 동일한 인원 수만큼 건너뛰고 순위 계산
        - DENSE_RANK() OVER(정렬기준) :  동일한 순위가 있더라도 그 다음 등수를 +1해서 순위를 계산
        
        * SELECT절에서만 사용 가능!
*/
-- 급여가 높은 순서대로 순위를 매겨 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;
--> 공동 19위인 2명이 있고, 그 뒤의 순위는 21위로 표시됨.

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;
--> 공동 19인 2명 이후에 그 위의 순서가 20위로 표시됨. (+1)

--> 상위 5명만 조회
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;
-- WHERE 순위 <= 5; --> 오류 발생! WHERE절에서는 별칭 사용 불가!

SELECT *
FROM ( SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
                FROM EMPLOYEE )
WHERE 순위 <= 5;

-- 상위 3등 ~ 5등 조회
SELECT *
FROM ( SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
                FROM EMPLOYEE )
WHERE 순위 >= 3 AND 순위 <= 5;
-------------------------------------------------------------------
--1) ROWNUM을 활용하여 급여가 가장 높은 5명을 조회하려 했으나, 제대로 조회가 되지 않았다.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 문제점 (원인) : 정렬이 되기 전에 5명이 추려졌음
-- 해결방안
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM ( SELECT EMP_NAME, SALARY
                FROM EMPLOYEE
                ORDER BY SALARY DESC )
WHERE ROWNUM <= 5;

-- 2) 부서별 평균급여가 270만원을 초과하는 부서에 해당하는 부서코드, 부서별 총 급여합, 부서별 평균급여, 부서별 사원 수를 조회
SELECT DEPT_CODE, SUM(SALARY) "총합", AVG(SALARY) AS "평균", COUNT(*) "인원수"
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- 문제점 (원인) :  부서별 평균 급여를 확인해야 하는데, 사원 개개인의 급여를 확인했다.
-- 해결방안

SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS "평균", COUNT(*) "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE ASC;

-- 또는
SELECT *
FROM ( SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS "평균", COUNT(*) "인원수"
                FROM EMPLOYEE
                GROUP BY DEPT_CODE
                -- ORDER BY DEPT_CODE ASC
                )
WHERE 평균 > 2700000;