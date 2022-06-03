

DROP PROCEDURE IF EXISTS whileProc; 
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT; -- 1���� 100���� ������ ����
	DECLARE hap INT; -- ���� ���� ������ ����
    SET i = 1;		-- ���� ������ declare�ϰ� set �ϸ� �Ǵµ� ������ set@
    SET hap = 0;

	WHILE (i <= 100) DO
		SET hap = hap + i;  -- hap�� ������ ���� i�� ���ؼ� �ٽ� hap�� ������� �ǹ�
		SET i = i + 1;      -- i�� ������ ���� 1�� ���ؼ� �ٽ� i�� ������� �ǹ�
	END WHILE;

	SELECT hap;   
END $$
DELIMITER ;
CALL whileProc();


DROP PROCEDURE IF EXISTS whileProc2; 
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i INT; -- 1���� 100���� ������ ����
    DECLARE hap INT; -- ���� ���� ������ ����
    SET i = 1;
    SET hap = 0;

    myWhile: WHILE (i <= 100) DO  -- While���� label�� ����
	IF (i%7 = 0) THEN
		SET i = i + 1;     
		ITERATE myWhile; -- ������ label������ ���� ��� ����
	END IF;
        
        SET hap = hap + i; 
        IF (hap > 1000) THEN 
		LEAVE myWhile; -- ������ label���� ����. ��, While ����.
	END IF;
        SET i = i + 1;
    END WHILE;

    SELECT hap;   
END $$
DELIMITER ;
CALL whileProc2();

