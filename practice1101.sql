set verify off;
set serveroutput on;
/
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
/
declare
v_no1 number := &no1;
v_no2 number := &no2;
v_sum number;

begin
    v_sum := v_no1 + v_no2;
    dbms_output.put_line('첫번째 수: '||v_no1||', 두번째 수: '||v_no2||', 합은: '||v_sum||' 입니다');
end;
/
create or replace procedure hr.update_salary
(v_empno in number)
is
begin
    update employees
    set salary = salary * 1.1
    where employee_id = v_empno;
    commit;
end update_salary;
/
select * from employees
where employee_id =114;
/
execute update_salary(114);
/
create or replace function hr.fc_update_salary(v_empno in number)
return number
as
    pragma autonomous_transaction;
    v_salary employees.salary%type;
begin
    update employees
    set salary = salary * 1.1
    where employee_id = v_empno;
    commit;
    select salary
    into v_salary
    from employees
    where employee_id = v_empno;
    return v_salary;
end;
/
create or replace procedure print_emp(v_input employees.employee_id%type)
is
    v_row employees%rowtype;
begin
    select employee_id, first_name, salary, department_id
    into v_row.employee_id, v_row.first_name, v_row.salary, v_row.department_id
    from employees
    where employee_id = v_input;
    
    dbms_output.put_line
    (v_row.employee_id||' '||v_row.first_name||' '||v_row.salary||' '||v_row.department_id);
end print_emp;
/
execute print_emp(114);
/
create or replace procedure rowType_test
(p_empno in employees.employee_id%Type)
    ia
/
create or replace procedure table_test
 (v_deptno employees.department_id%type)
 is
    type empno_table is table of employees.employee_id%type index by binary_integer;
    type ename_table is table of employees.first_name%type index by binary_integer;
    type sal_table is table of employees.salary%type index by binary_integer;
    
    empno_tab empno_table;
    ename_tab ename_table;
    sal_tab sal_table;
    i binary_integer:=0;
begin
    dbms_output.enable;
    for emp_list in (select employee_id, first_name, salary
                     from employees
                     where department_id = v_deptno) loop
        i := i+1;
        empno_tab(i) := emp_list.employee_id;
        ename_tab(i) := emp_list.first_name;
        sal_tab(i) := emp_list.salary;
    end loop;
    
    for cnt in 1..i loop
        dbms_output.put_line('사원번호 : '|| empno_tab(cnt));
        dbms_output.put_line('사원이름 : '|| ename_tab(cnt));
        dbms_output.put_line('사원급여 : '|| sal_tab(cnt));
    end loop;
end table_test;
/
execute table_test(100);
/
create or replace procedure update_test
(v_empno in employees.employee_id%type,
 v_sal in employees.salary%type)
is
    v_emp employees%rowtype;
begin dbms_output.enable;
    update employees
    set salary = v_sal
    where employee_id = v_empno;
    commit;
    
    dbms_output.put_line('Data Update Success ');
    
    select employee_id, last_name, salary
    into v_emp.employee_id, v_emp.last_name, v_emp.salary
    from employees
    where employee_id = v_empno;
    dbms_output.put_line('**** 업데이트 완료 ****');
    dbms_output.put_line('EMP NO : '||v_emp.employee_id);
    dbms_output.put_line('EMP NAME : '||v_emp.last_name);
    dbms_output.put_line('EMP SALARY : '||v_emp.salary);
End;
/
select *
from employees
where employee_id = '113';
/
execute update_test(113, 9900);
