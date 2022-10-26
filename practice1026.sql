-----------SubQuery-----------

-- Den보다 많은 급여를 받는 사원은?
SELECT EMPLOYEE_ID , FIRST_NAME , SALARY  
FROM employees
WHERE salary > (SELECT salary
		 		FROM EMPLOYEES e
		 		WHERE FIRST_NAME='Den');

-- 최소 급여를 받는 직원 이름은?
SELECT FIRST_NAME , SALARY, EMPLOYEE_ID 
FROM EMPLOYEES e
WHERE salary = (SELECT min(salary)
				FROM EMPLOYEES);

-- 각 부서별 최고급여를 받는 사원은?
SELECT d.DEPARTMENT_ID , d.DEPARTMENT_NAME , e.FIRST_NAME , e.SALARY 			
FROM EMPLOYEES e , DEPARTMENTS d 
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
AND (e.department_id, salary) IN (SELECT DEPARTMENT_ID , max(SALARY)
								  FROM EMPLOYEES e2
								  GROUP BY DEPARTMENT_ID);

-- from 절에 SubQuery								 
SELECT e.DEPARTMENT_ID , e.EMPLOYEE_ID , e.FIRST_NAME , e.SALARY 
FROM EMPLOYEES e , (SELECT DEPARTMENT_ID , max(SALARY) SALARY 
				    FROM EMPLOYEES e2
				    GROUP BY DEPARTMENT_ID) s
WHERE e.DEPARTMENT_ID = s.department_id
AND e.SALARY = s.salary;
		
--예제 1번
SELECT count(EMPLOYEE_ID)
FROM EMPLOYEES e
WHERE SALARY < (SELECT avg(nvl(SALARY, 0))
				FROM EMPLOYEES);

-- 예제 3번 (각 업무별로 급여의 총합은?)
SELECT j.JOB_TITLE , js.sal
FROM JOBS j , (SELECT e.JOB_ID , sum(e.SALARY) sal
			   FROM EMPLOYEES e 
			   GROUP BY e.JOB_ID ) js
WHERE j.JOB_ID = js.JOB_ID
ORDER BY 2 desc;

SELECT j.JOB_TITLE , sum(e.SALARY)
FROM JOBS j , EMPLOYEES e 
WHERE j.JOB_ID = e.JOB_ID 
GROUP BY j.JOB_TITLE 
ORDER BY 2 desc;

--예제 4번 (자신의 부서 평균 급여보다 급여가 많은 직원은?)
SELECT e.EMPLOYEE_ID , e.LAST_NAME , e.SALARY 
FROM EMPLOYEES e , (SELECT e2.department_id, avg(nvl(salary, 0)) AS salary
					FROM EMPLOYEES e2
					GROUP BY e2.department_id) s
WHERE e.DEPARTMENT_ID = s.department_id
AND e.salary > s.salary;

--rownum : 순서를 제대로 표현해주기 위해서 SubQuery로 우선 순위 지정
SELECT rownum, FIRST_NAME , salary
FROM (SELECT FIRST_name, salary
	  FROM EMPLOYEES
	  ORDER BY salary desc)
-- rownum은 SubQuery의 select문을 한 번 돌면서 하나씩 배정
WHERE rownum <= 10;

-- rownum 순서 제대로 뽑아오기
SELECT rn, first_name, salary
FROM (SELECT rownum rn, first_name, salary
	  FROM (SELECT first_name, salary
	        FROM EMPLOYEES
	        ORDER BY salary desc)
     )
WHERE rn >= 11
AND rn <= 20;

-- 종합 문제 1
SELECT FIRST_NAME ||' '|| LAST_NAME "이름", SALARY "연봉", 
	   d.DEPARTMENT_NAME "부서 이름", HIRE_DATE
FROM EMPLOYEES e, DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND HIRE_DATE = (SELECT max(HIRE_DATE)
				 FROM EMPLOYEES e);
				
-- 종합 문제 2
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , j.JOB_TITLE , e.SALARY, s.salary
FROM EMPLOYEES e , JOBS j ,(SELECT DEPARTMENT_ID , avg(nvl(SALARY, 0)) SALARY 
					FROM EMPLOYEES e
					GROUP BY DEPARTMENT_ID) s
WHERE e.JOB_ID = j.JOB_ID
AND e.DEPARTMENT_ID = s.DEPARTMENT_ID
AND s.SALARY = (SELECT Max(salary)
				FROM (SELECT DEPARTMENT_ID , avg(nvl(SALARY, 0)) SALARY
					  FROM EMPLOYEES e
					  GROUP BY DEPARTMENT_ID) s);
					 
-- 종합 문제 3
SELECT d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d  ,
	 (SELECT DEPARTMENT_ID , avg(nvl(SALARY, 0)) SALARY 
	  FROM EMPLOYEES e
	  GROUP BY DEPARTMENT_ID
	  ORDER BY 2 desc) s
WHERE e.DEPARTMENT_ID  = d.DEPARTMENT_ID 
AND e.DEPARTMENT_ID = s.DEPARTMENT_ID
AND rownum = 1;

-- 종합 문제 4
select region_name
from regions
where region_id =  (select r.region_id
                    from employees e, departments d, locations l, countries c, regions r
                    where e.department_id = d.department_id
                    and   d.location_id = l.location_id
                    and   l.country_id = c.country_id
                    and   c.region_id = r.region_id
                    group by r.region_id
                    having avg(salary) = (select max(avg(salary))
                                          from employees e, departments d, locations l, countries c, regions r
                                          where e.department_id = d.department_id
                                          and   d.location_id = l.location_id
                                          and   l.country_id = c.country_id
                                          and   c.region_id = r.region_id
                                          group by r.region_id));
                                          
-- 종합 문제 5
select job_title
from jobs
where job_id = (select job_id
                from employees
                group by job_id
                having avg(salary) = (select max(avg(salary))
                                      from employees
                                      group by job_id));