create or replace view emp_v2 AS
select employee_id, first_name, last_name, salary
from employees
where department_id = 10
union
select employee_id, first_name, last_name, salary
from employees
where department_id = 20;
/
select employee_id, first_name, last_name
from emp_v2
where salary > 1000;
/
SELECT s.�����ȣ , s.�õ� , s.�õ����� , s.�ñ��� , s.�ñ������� ,s.���θ��ڵ� ,
	   s.���θ� , s.���θ��� s.�ǹ���ȣ���� , s.�ǹ���ȣ�ι� , s.�ñ�����ǹ��� , s.�������� ,
	   s.�������� , s.�������� , s.�����ι�
FROM ����Ư���� s
WHERE �����ȣ ='1234';

DROP TABLE cust;
CREATE TABLE cust(
  c_id    NUMBER(20),
  c_name  varchar2(100) NOT NULL,
  c_addr  varchar2(100),
  c_zcode NUMBER(5),
  c_desc  varchar2(200),
  PRIMARY key(c_id)
);
DROP SEQUENCE seq_cust_c_id ;
CREATE SEQUENCE seq_cust_c_id
INCREMENT BY 1 
START WITH 1 ;


DROP TABLE goods;
CREATE TABLE goods(
  g_id    NUMBER(20),
  g_name  varchar2(100) NOT NULL,
  g_stock NUMBER(10),
  g_price NUMBER(20),
  g_desc  varchar2(200),
  PRIMARY key(g_id)
);
DROP SEQUENCE seq_goods_g_id ;
CREATE SEQUENCE seq_goods_g_id
INCREMENT BY 1 
START WITH 1 ;


DROP TABLE orders;
CREATE TABLE orders(
	o_id NUMBER(20),
	o_date DATE NOT NULL,
	o_c_id number(10),
	o_g_id number(20),
	o_desc varchar2(200),
	PRIMARY key(g_id),
	CONSTRAINT c_order_fk1 FOREIGN KEY (o_c_id)
	REFERENCES cust(c_id),
	CONSTRAINT c_orders_fk2 FOREIGN KEY (o_g_id)
	REFERENCES goods(g_id),
);
DROP SEQUENCE seq_o_id;
CREATE SEQUENCE seq_o_id
INCREMENT BY 1
START WITH 1;

DECLARE
vno varchar2(20);
BEGIN
	SELECT to_char(sysdate, 'yyyy/mm/dd') INTO vno
	FROM dual;
	dbms_output.put_line(vno);
END;