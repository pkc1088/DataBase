
DROP PROCEDURE IF EXISTS errorProc; 
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR 1146 SELECT '���̺��� �����Ф�' AS '�޽���';
    SELECT * FROM noTable;  -- noTable�� ����.  
END $$
DELIMITER ;
CALL errorProc();

DROP PROCEDURE IF EXISTS errorProc2; 
DELIMITER $$
CREATE PROCEDURE errorProc2()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
	SHOW ERRORS; -- ���� �޽����� ���� �ش�.
	SELECT '������ �߻��߳׿�. �۾��� ��ҽ��׽��ϴ�.' AS '�޽���'; 
	ROLLBACK; -- ���� �߻��� �۾��� �ѹ��Ų��.
    END;
    INSERT INTO usertbl VALUES('LSG', '�̻�', 1988, '����', NULL, 
								NULL, 170, CURRENT_DATE()); -- �ߺ��Ǵ� ���̵��̹Ƿ� ���� �߻�
END $$
DELIMITER ;
CALL errorProc2();


