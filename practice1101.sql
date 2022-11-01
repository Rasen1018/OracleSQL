set serveroutput on;
declare
v_empno employees.employee_id%type;
v_name employees.first_name%type;
v_sal employees.salary%type;
v_date employees.hire_date%type;

begin
	select employee_id, first_name, salary, hire_date
	into v_empno, v_name, v_sal, v_date
	from employees
	where employee_id = '&empno';
	dbms_output.put_line(v_empno||' '||v_name||' '||v_sal||' '||v_date);
end;