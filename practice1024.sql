select * FROM employees;

select * from departments d ;

SELECT employee_id, first_name, last_name
from employees;

SELECT phone_number, salary, hire_date
From employees;

--����� ������ ������ �� �빮�ڷ� ǥ��
select employee_id as id, first_name "�̸�", salary "�� ��"
from employees;

-- ||�� column �̾� ���̱�
select first_name ||' '|| last_name "�̸�"
from employees;

-- �߰��� ���ڿ� �߰� ����
select first_name || 'hire date is ' || hire_date
from employees;

-- ���� ���� ����
select first_name, salary, salary*12, (salary+300)*12
from employees;

select first_name ||'-'||last_name as name, salary*12 salary, (salary*12)+5000 bonus, phone_number "��ȭ��ȣ"
from employees;

-- �˻� ������ �߰��ϰ� ���� ���� where �� ���
select *
from employees
where salary >= 15000;

-- ���� ������ ���� ����� ��(AND, BETWEEN)
select first_name, salary
from employees
where salary >= 14000
and salary <= 17000;

select first_name, salary
from employees
where salary between 14000 and 17000;

-- OR ������
select first_name, salary
from employees
where salary < 14000
or salary > 17000;

select *
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

-- IN ������ : Ư�� �� ã��
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');

-- like ������ : %% ���̿� ���ڿ��� �����ؼ� �˻�
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
order by first_name asc, 2 desc; --asc(ascending) ���� ����, desc(descending)

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

-- lpad(), rpad() : 10�ڸ� �߿� ���� �ڸ��� '*'�� ä���
select first_name, lpad(first_name, 10, '*'), rpad(first_name, 10, '*')
from employees;

-- replace() : 'a'�� '*'�� ��ü
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

-- ���� 7��
select first_name, salary
from employees
where first_name like '%s%'
or first_name like '%S%';

-- ���� 8��
select *
from departments
order by length(department_name) desc;

-- ���� 10��
select first_name, salary, replace(phone_number, '.', '-'), hire_date
from employees
where hire_date <= '03/12/31';

select *
from regions;