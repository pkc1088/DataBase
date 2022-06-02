SELECT name, mDate FROM usertbl ORDER BY mDate;

SELECT name, mDate FROM usertbl ORDER BY mDate DESC;

SELECT name, height FROM usertbl ORDER BY height DESC, name ASC;

SELECT addr FROM usertbl;

SELECT addr FROM usertbl ORDER BY addr;

SELECT DISTINCT addr FROM usertbl;

USE employees;

SELECT emp_no, hire_date FROM employees 
   ORDER BY hire_date ASC
   LIMIT 5;

SELECT emp_no, hire_date FROM employees 
   ORDER BY hire_date ASC, emp_no
   LIMIT 100, 5;
