
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10));
INSERT INTO testTbl VALUES(1, '���座��');
INSERT INTO testTbl VALUES(2, '����');
INSERT INTO testTbl VALUES(3, '����ũ');

DROP TRIGGER IF EXISTS testTrg;
DELIMITER // 
CREATE TRIGGER testTrg  -- Ʈ���� �̸�
    AFTER  DELETE -- �����Ŀ� �۵��ϵ��� ����
    ON testTbl -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW -- �� �ึ�� �����Ŵ
BEGIN
	SET @msg = '���� �׷��� ������' ; -- Ʈ���� ����� �۵��Ǵ� �ڵ��
END // 
DELIMITER ;

SET @msg = '';
INSERT INTO testTbl VALUES(4, '������');
SELECT @msg;
UPDATE testTbl SET txt = '����' WHERE id = 3;
SELECT @msg;
DELETE FROM testTbl WHERE id = 4;
SELECT @msg;

-- </�ǽ� 4> --



-- <�ǽ� 5> --

USE sqlDB;
DROP TABLE buyTbl; -- �������̺��� �ǽ��� �ʿ�����Ƿ� ����.
CREATE TABLE backup_userTbl
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr	  CHAR(2) NOT NULL, 
  mobile1	CHAR(3), 
  mobile2   CHAR(8), 
  height    SMALLINT,  
  mDate    DATE,
  modType  CHAR(2), -- ����� Ÿ��. '����' �Ǵ� '����'
  modDate  DATE, -- ����� ��¥
  modUser  VARCHAR(256) -- ������ �����
);


DROP TRIGGER IF EXISTS backUserTbl_UpdateTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_UpdateTrg  -- Ʈ���� �̸�
    AFTER UPDATE -- ���� �Ŀ� �۵��ϵ��� ����
    ON userTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '����', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

DROP TRIGGER IF EXISTS backUserTbl_DeleteTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_DeleteTrg  -- Ʈ���� �̸�
    AFTER DELETE -- ���� �Ŀ� �۵��ϵ��� ����
    ON userTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '����', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

UPDATE userTbl SET addr = '����' WHERE userID = 'JKW';
DELETE FROM userTbl WHERE height >= 177;

SELECT * FROM backup_userTbl;

TRUNCATE TABLE userTbl;

SELECT * FROM backup_userTbl;

DROP TRIGGER IF EXISTS userTbl_InsertTrg;
DELIMITER // 
CREATE TRIGGER userTbl_InsertTrg  -- Ʈ���� �̸�
    AFTER INSERT -- �Է� �Ŀ� �۵��ϵ��� ����
    ON userTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW 
BEGIN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '�������� �Է��� �õ��߽��ϴ�. ������ ������ ������ ��ϵǾ����ϴ�.';
END // 
DELIMITER ;

INSERT INTO userTbl VALUES('ABC', '����', 1977, '����', '011', '1111111', 181, '2019-12-25');

USE sqlDB;
DROP TRIGGER IF EXISTS userTbl_BeforeInsertTrg;
DELIMITER // 
CREATE TRIGGER userTbl_BeforeInsertTrg  -- Ʈ���� �̸�
    BEFORE INSERT -- �Է� ���� �۵��ϵ��� ����
    ON userTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW 
BEGIN
    IF NEW.birthYear < 1900 THEN
        SET NEW.birthYear = 0;
    ELSEIF NEW.birthYear > YEAR(CURDATE()) THEN
        SET NEW.birthYear = YEAR(CURDATE());
    END IF;
END // 
DELIMITER ;

INSERT INTO userTbl VALUES
  ('AAA', '����', 1877, '����', '011', '1112222', 181, '2022-12-25');
INSERT INTO userTbl VALUES
  ('BBB', '����', 2977, '���', '011', '1113333', 171, '2019-3-25');


SHOW TRIGGERS FROM sqlDB;

DROP TRIGGER userTbl_BeforeInsertTrg;


