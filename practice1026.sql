-----------SubQuery-----------

-- Den���� ���� �޿��� �޴� �����?
SELECT EMPLOYEE_ID , FIRST_NAME , SALARY  
FROM employees
WHERE salary > (SELECT salary
		 		FROM EMPLOYEES e
		 		WHERE FIRST_NAME='Den');

-- �ּ� �޿��� �޴� ���� �̸���?
SELECT FIRST_NAME , SALARY, EMPLOYEE_ID 
FROM EMPLOYEES e
WHERE salary = (SELECT min(salary)
				FROM EMPLOYEES);

-- �� �μ��� �ְ�޿��� �޴� �����?
SELECT d.DEPARTMENT_ID , d.DEPARTMENT_NAME , e.FIRST_NAME , e.SALARY 			
FROM EMPLOYEES e , DEPARTMENTS d 
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
AND (e.department_id, salary) IN (SELECT DEPARTMENT_ID , max(SALARY)
								  FROM EMPLOYEES e2
								  GROUP BY DEPARTMENT_ID);

-- from ���� SubQuery								 
SELECT e.DEPARTMENT_ID , e.EMPLOYEE_ID , e.FIRST_NAME , e.SALARY 
FROM EMPLOYEES e , (SELECT DEPARTMENT_ID , max(SALARY) SALARY 
				    FROM EMPLOYEES e2
				    GROUP BY DEPARTMENT_ID) s
WHERE e.DEPARTMENT_ID = s.department_id
AND e.SALARY = s.salary;
		
--���� 1��
SELECT count(EMPLOYEE_ID)
FROM EMPLOYEES e
WHERE SALARY < (SELECT avg(nvl(SALARY, 0))
				FROM EMPLOYEES);

-- ���� 3�� (�� �������� �޿��� ������?)
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

--���� 4�� (�ڽ��� �μ� ��� �޿����� �޿��� ���� ������?)
SELECT e.EMPLOYEE_ID , e.LAST_NAME , e.SALARY 
FROM EMPLOYEES e , (SELECT e2.department_id, avg(nvl(salary, 0)) AS salary
					FROM EMPLOYEES e2
					GROUP BY e2.department_id) s
WHERE e.DEPARTMENT_ID = s.department_id
AND e.salary > s.salary;

--rownum : ������ ����� ǥ�����ֱ� ���ؼ� SubQuery�� �켱 ���� ����
SELECT rownum, FIRST_NAME , salary
FROM (SELECT FIRST_name, salary
	  FROM EMPLOYEES
	  ORDER BY salary desc)
-- rownum�� SubQuery�� select���� �� �� ���鼭 �ϳ��� ����
WHERE rownum <= 10;

-- rownum ���� ����� �̾ƿ���
SELECT rn, first_name, salary
FROM (SELECT rownum rn, first_name, salary
	  FROM (SELECT first_name, salary
	        FROM EMPLOYEES
	        ORDER BY salary desc)
     )
WHERE rn >= 11
AND rn <= 20;

-- ���� ���� 1
SELECT FIRST_NAME ||' '|| LAST_NAME "�̸�", SALARY "����", 
	   d.DEPARTMENT_NAME "�μ� �̸�", HIRE_DATE
FROM EMPLOYEES e, DEPARTMENTS d 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND HIRE_DATE = (SELECT max(HIRE_DATE)
				 FROM EMPLOYEES e);
				
-- ���� ���� 2
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
					 
-- ���� ���� 3
SELECT d.DEPARTMENT_NAME 
FROM EMPLOYEES e , DEPARTMENTS d  ,
	 (SELECT DEPARTMENT_ID , avg(nvl(SALARY, 0)) SALARY 
	  FROM EMPLOYEES e
	  GROUP BY DEPARTMENT_ID
	  ORDER BY 2 desc) s
WHERE e.DEPARTMENT_ID  = d.DEPARTMENT_ID 
AND e.DEPARTMENT_ID = s.DEPARTMENT_ID
AND rownum = 1;

-- ���� ���� 4
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
                                          
-- ���� ���� 5
select job_title
from jobs
where job_id = (select job_id
                from employees
                group by job_id
                having avg(salary) = (select max(avg(salary))
                                      from employees
                                      group by job_id));