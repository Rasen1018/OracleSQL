select * FROM employees;

select * from departments d ;

SELECT employee_id, first_name, last_name
from employees;

SELECT phone_number, salary, hire_date
From employees;

--영어는 별명을 설정할 때 대문자로 표기
select employee_id as id, first_name "이름", salary "연 봉"
from employees;

-- ||로 column 이어 붙이기
select first_name ||' '|| last_name "이름"
from employees;

-- 중간에 문자열 추가 가능
select first_name || 'hire date is ' || hire_date
from employees;

-- 단항 연산 가능
select first_name, salary, salary*12, (salary+300)*12
from employees;

select first_name ||'-'||last_name as name, salary*12 salary, (salary*12)+5000 bonus, phone_number "전화번호"
from employees;

-- 검색 조건을 추가하고 싶을 때는 where 절 사용
select *
from employees
where salary >= 15000;

-- 구간 사이의 값을 출력할 때(AND, BETWEEN)
select first_name, salary
from employees
where salary >= 14000
and salary <= 17000;

select first_name, salary
from employees
where salary between 14000 and 17000;

-- OR 연산자
select first_name, salary
from employees
where salary < 14000
or salary > 17000;

select *
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

-- IN 연산자 : 특정 값 찾기
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');

-- like 연산자 : %% 사이에 문자열을 포함해서 검색
select first_name, last_name, salary
from employees
where first_name like '%is%';

-- is null / is not null
select first_name, salary, manager_id ,commission_pct
from employees
where commission_pct is null
and manager_id is null;

select first_name, salary
from employees
order by first_name asc, 2 desc; --asc(ascending) 생략 가능, desc(descending)

select department_id, salary, first_name
from employees
order by department_id asc;

select department_id, salary, first_name
from employees
order by 1 asc, 2 desc;

select INItcap('apple') from dual;
select lower('APPLE') from dual;
select upper('apple') from dual;
select 'HelloWorld!', substr('HelloWorld!', 1, 3), substr('HelloWorld!', -3, 2)
from dual;

-- lpad(), rpad() : 10자리 중에 남은 자리를 '*'로 채우기
select first_name, lpad(first_name, 10, '*'), rpad(first_name, 10, '*')
from employees;

-- replace() : 'a'를 '*'로 대체
select first_name, replace(first_name, 'a', '*'),
replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;

select to_char(sysdate) from employees;

select first_name, hire_date, round(months_between(sysdate, hire_date), 0)
from employees
where department_id =110;

select first_name, to_char(salary*12, '$999,999.99') "SAL"
from employees
where department_id <= 110;

select sysdate, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;

select first_name, nvl(commission_pct, 0)
from employees;

select first_name, to_char(hire_date, 'yyyy-mm') from employees;

-- 예제 7번
select first_name, salary
from employees
where first_name like '%s%'
or first_name like '%S%';

-- 예제 8번
select *
from departments
order by length(department_name) desc;

-- 예제 10번
select first_name, salary, replace(phone_number, '.', '-'), hire_date
from employees
where hire_date <= '03/12/31';

select *
from regions;