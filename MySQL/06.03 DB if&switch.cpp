
DROP PROCEDURE IF EXISTS ifProc2; 
USE employees;

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE hireDATE DATE; -- �Ի���
	DECLARE curDATE DATE; -- ����
	DECLARE days INT; -- �ٹ��� �ϼ�

	SELECT hire_date INTO hireDate -- hire_date ���� ����� hireDATE�� ����
	   FROM employees.employees
	   WHERE emp_no = 10001;

	SET curDATE = CURRENT_DATE(); -- ���� ��¥
	SET days =  DATEDIFF(curDATE, hireDATE); -- ��¥�� ����, �� ����

	IF (days/365) >= 5 THEN -- 5���� �����ٸ�
		  SELECT CONCAT('�Ի����� ', days, '���̳� �������ϴ�. �����մϴ�!');
	ELSE
		  SELECT '�Ի����� ' + days + '�Ϲۿ� �ȵǾ��׿�. ������ ���ϼ���.' ;
	END IF;
END $$
DELIMITER ;
CALL ifProc2();


DROP PROCEDURE IF EXISTS ifProc3; 
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    IF point >= 90 THEN
		SET credit = 'A';
    ELSEIF point >= 80 THEN
		SET credit = 'B';
    ELSEIF point >= 70 THEN
		SET credit = 'C';
    ELSEIF point >= 60 THEN
		SET credit = 'D';
    ELSE
		SET credit = 'F';
    END IF;
    SELECT CONCAT('�������==>', point), CONCAT('����==>', credit);
END $$
DELIMITER ;
CALL ifProc3();


DROP PROCEDURE IF EXISTS caseProc; 
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    CASE 
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
    END CASE;
    SELECT CONCAT('�������==>', point), CONCAT('����==>', credit);
END $$
DELIMITER ;
CALL caseProc();

