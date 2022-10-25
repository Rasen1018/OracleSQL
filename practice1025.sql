--count() 함수
SELECT count(*), count(COMMISSION_PCT)
FROM employees;

--avg() 함수 : null 값이 있는 경우 빼고 계산함
SELECT count(*), sum(salary), avg(salary)
FROM employees;

SELECT count(*), sum(salary), avg(nvl(salary, 0))
FROM employees;

--max() / min() 함수 : 여러 건의 데이터를 순서대로 정렬 후 값을 구하기 때문에 
--데이터가 많을 때는 느리다
SELECT count(*), max(salary), min(salary)
FROM employees;

-- group by() 함수 : group by 항목에 대해서 그룹별 계산
SELECT DEPARTMENT_ID , avg(e.salary)
FROM EMPLOYEES e 
GROUP by DEPARTMENT_ID
ORDER BY department_id;

SELECT department_id, job_id, count(*), sum(salary)
from employees
GROUP BY department_id, job_id;

--예제 : 연봉 합계가 20000 이상인 부서의 인원수와 연봉 총합
SELECT DEPARTMENT_ID , COUNT(*), sum(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID
HAVING sum(SALARY) > 20000;
--AND department_id = 100;

--예제 1번
SELECT max(SALARY) "최고임금", min(SALARY) "최저임금", 
  	   max(salary)-min(salary) "최고임금 - 최저임금"
FROM EMPLOYEES e;

--예제 2번
SELECT TO_char(MAX(HIRE_DATE), 'yyyy"년" mm"월" dd"일"')
FROM EMPLOYEES e ;

--예제 3번
SELECT DEPARTMENT_ID , avg(nvl(SALARY, 0)), max(SALARY), min(SALARY)
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID 
ORDER BY DEPARTMENT_ID DESC;

--예제 4번
SELECT JOB_ID , avg(nvl(SALARY, 0)), max(SALARY), min(SALARY)
FROM EMPLOYEES e 
GROUP BY JOB_ID 
ORDER BY JOB_ID DESC;

--예제 5번
SELECT TO_char(min(HIRE_DATE), 'yyyy"년" mm"월" dd"일"')
FROM EMPLOYEES e ;

--예제 6번
SELECT DEPARTMENT_ID , avg(nvl(SALARY, 0)) "평임", min(SALARY) "최임",
	   avg(nvl(SALARY, 0))-min(SALARY) "평임-최임"
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID
HAVING avg(nvl(SALARY, 0))-min(SALARY) < 2000
ORDER BY 4 DESC;

--예제 7번
SELECT JOB_ID , max(salary) "최고", min(salary) "최저", 
	   max(salary)-min(salary) "최고-최저 차이"
FROM EMPLOYEES e
GROUP BY JOB_ID 
ORDER BY 4 DESC;

--case~end문
SELECT employee_id, salary,
		CASE WHEN job_id = 'AC_ACCOUNT' THEN salary + salary*0.1
			 WHEN job_id = 'AC_MGR' THEN salary + salary*0.2
			 ELSE SALARY 
		 END salary
FROM employees;

SELECT FIRST_NAME , DEPARTMENT_ID,
		CASE WHEN DEPARTMENT_ID >= 10 AND DEPARTMENT_ID <=50 THEN 'A-TEAM'
			 WHEN DEPARTMENT_ID >= 60 AND DEPARTMENT_ID <=100 THEN 'B-TEAM'
			 WHEN DEPARTMENT_ID >= 110 AND DEPARTMENT_ID <=150 THEN 'C-TEAM'
			 ELSE '팀없음'
		END team -- case문 COLUMN명 결정
FROM EMPLOYEES e;

--EQUI join : 같은 column을 기준으로 join / null은 조인안됨
SELECT first_name, e.DEPARTMENT_ID ,
		department_name, d.DEPARTMENT_ID
FROM EMPLOYEES e , DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID  ; --JOIN 조건

SELECT first_name,
		job_title, j.JOB_ID 
FROM EMPLOYEES e , JOBS j 
WHERE e.JOB_ID = j.JOB_ID ;

SELECT first_name,
		department_name,
		job_title
FROM EMPLOYEES e , DEPARTMENTS d , JOBS j 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND e.JOB_ID = j.JOB_ID;

--
SELECT em.FIRST_NAME , mg.FIRST_NAME 
FROM EMPLOYEES em , EMPLOYEES mg
WHERE em.MANAGER_ID = mg.EMPLOYEE_ID 
AND em.EMPLOYEE_ID =101;

--right outer join
SELECT e.DEPARTMENT_ID , e.FIRST_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d 
WHERE e.DEPARTMENT_ID (+) = d.DEPARTMENT_ID ;

--full outer join
SELECT e.DEPARTMENT_ID , e.FIRST_NAME , d.DEPARTMENT_NAME 
FROM EMPLOYEES e FULL OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

--예제 1
SELECT em.EMPLOYEE_ID , em.FIRST_NAME , d.DEPARTMENT_NAME , mg.FIRST_NAME 
FROM EMPLOYEES em , DEPARTMENTS d , EMPLOYEES mg 
WHERE em.MANAGER_ID = mg.EMPLOYEE_ID 
AND em.DEPARTMENT_ID = d.DEPARTMENT_ID ;

-- 예제 2
SELECT r.REGION_NAME , c.COUNTRY_NAME 
FROM REGIONS r, COUNTRIES c 
WHERE r.REGION_ID = c.REGION_ID 
ORDER BY 1 DESC, 2 DEsc;

-- 예제 3
SELECT d.DEPARTMENT_ID , d.DEPARTMENT_NAME , e.MANAGER_ID , e.FIRST_NAME ,
		l.CITY , c.COUNTRY_NAME , r.REGION_NAME 
FROM DEPARTMENTS d ,EMPLOYEES e, LOCATIONS l, COUNTRIES c, REGIONS r
WHERE d.MANAGER_ID = e.EMPLOYEE_ID 
AND d.LOCATION_ID = l.LOCATION_ID 
AND	l.COUNTRY_ID = c.COUNTRY_ID 
AND c.REGION_ID = r.REGION_ID  ;

-- 예제 4번
SELECT e.EMPLOYEE_ID , e.FIRST_NAME || ' ' || e.LAST_NAME 
FROM JOB_HISTORY jh , JOBS j , EMPLOYEES e 
WHERE jh.JOB_ID = j.JOB_ID 
AND jh.EMPLOYEE_ID = e.EMPLOYEE_ID 
AND j.JOB_TITLE = 'Public Accountant';

-- 예제 6번
SELECT em.EMPLOYEE_ID , em.LAST_NAME , mg.HIRE_DATE "매니저 채용 날짜", em.HIRE_DATE "사원 채용 날짜"
FROM EMPLOYEES em , EMPLOYEES mg
WHERE em.MANAGER_ID = mg.EMPLOYEE_ID 
AND em.HIRE_DATE < mg.HIRE_DATE ; 