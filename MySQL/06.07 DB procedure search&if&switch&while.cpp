// procedure ��ȸ 
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.ROUTINES
    WHERE routine_schema = 'sqldb' AND routine_type = 'PROCEDURE';

SELECT parameter_mode, parameter_name, dtd_identifier
	FROM INFORMATION_SCHEMA.PARAMETERS
	WHERE specific_name = 'userProc3';
	
SHOW CREATE PROCEDURE sqldb.userProc3;



// if - else, switch, while
DROP PROCEDURE IF EXISTS ifelseProc;
DELIMITER $$
CREATE PROCEDURE ifelseProc(
    IN userName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; -- ���� ����
    SELECT birthYear into bYear FROM userTbl
        WHERE name = userName;
    IF (bYear >= 1980) THEN
            SELECT '���� ������..';
    ELSE
            SELECT '���̰� �����Ͻó׿�.' as a;
    END IF;
END $$
DELIMITER ;

CALL ifelseProc ('������');


DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc(
    IN userName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; 
    DECLARE tti  CHAR(3);-- ��
    SELECT birthYear INTO bYear FROM userTbl
        WHERE name = userName;
    CASE 
        WHEN ( bYear%12 = 0) THEN    SET tti = '������';
        WHEN ( bYear%12 = 1) THEN    SET tti = '��';
        WHEN ( bYear%12 = 2) THEN    SET tti = '��';
        WHEN ( bYear%12 = 3) THEN    SET tti = '����';
        WHEN ( bYear%12 = 4) THEN    SET tti = '��';
        WHEN ( bYear%12 = 5) THEN    SET tti = '��';
        WHEN ( bYear%12 = 6) THEN    SET tti = 'ȣ����';
        WHEN ( bYear%12 = 7) THEN    SET tti = '�䳢';
        WHEN ( bYear%12 = 8) THEN    SET tti = '��';
        WHEN ( bYear%12 = 9) THEN    SET tti = '��';
        WHEN ( bYear%12 = 10) THEN    SET tti = '��';
        ELSE SET tti = '��';
    END CASE;
    SELECT CONCAT(userName, '�� �� ==>', tti);
END $$
DELIMITER ;

CALL caseProc ('�����');


DROP TABLE IF EXISTS guguTBL;
CREATE TABLE guguTBL (txt VARCHAR(100)); -- ������ ����� ���̺�

DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE str VARCHAR(100); -- �� ���� ���ڿ��� ����
    DECLARE i INT; -- ������ ���ڸ�
    DECLARE k INT; -- ������ ���ڸ�
    SET i = 2; -- 2�ܺ��� ���
    
    WHILE (i < 10) DO  -- �ٱ� �ݺ���. 2��~9�ܱ���.
        SET str = ''; -- �� ���� ����� ������ ���ڿ� �ʱ�ȭ
        SET k = 1; -- ������ ���ڸ��� �׻� 1���� 9����.
        WHILE (k < 10) DO
            SET str = CONCAT(str, '  ', i, 'x', k, '=', i*k); -- ���ڿ� �����
            SET k = k + 1; -- ���ڸ� ����
        END WHILE;
        SET i = i + 1; -- ���ڸ� ����
        INSERT INTO guguTBL VALUES(str); -- �� ���� ����� ���̺� �Է�.
    END WHILE;
END $$
DELIMITER ;

CALL whileProc();
SELECT * FROM guguTBL;



