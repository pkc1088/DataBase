
DROP DATABASE IF EXISTS triggerDB;
CREATE DATABASE IF NOT EXISTS triggerDB;

USE triggerDB;
CREATE TABLE orderTbl -- ���� ���̺�
	(orderNo INT AUTO_INCREMENT PRIMARY KEY, -- ���� �Ϸù�ȣ
          userID VARCHAR(5), -- ������ ȸ�����̵�
	 prodName VARCHAR(5), -- ������ ����
	 orderamount INT );  -- ������ ����
CREATE TABLE prodTbl -- ��ǰ ���̺�
	( prodName VARCHAR(5), -- ���� �̸�
	  account INT ); -- ���� ���Ǽ���
CREATE TABLE deliverTbl -- ��� ���̺�
	( deliverNo  INT AUTO_INCREMENT PRIMARY KEY, -- ��� �Ϸù�ȣ
	  prodName VARCHAR(5), -- ����� ����		  
	  account INT UNIQUE); -- ����� ���ǰ���

INSERT INTO prodTbl VALUES('���', 100);
INSERT INTO prodTbl VALUES('��', 100);
INSERT INTO prodTbl VALUES('��', 100);

-- ��ǰ ���̺��� ������ ���ҽ�Ű�� Ʈ����
DROP TRIGGER IF EXISTS orderTrg;
DELIMITER // 
CREATE TRIGGER orderTrg  -- Ʈ���� �̸�
    AFTER  INSERT 
    ON orderTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW 
BEGIN
    UPDATE prodTbl SET account = account - NEW.orderamount 
        WHERE prodName = NEW.prodName ;
END // 
DELIMITER ;

-- ������̺� �� ��� ���� �Է��ϴ� Ʈ����
DROP TRIGGER IF EXISTS prodTrg;
DELIMITER // 
CREATE TRIGGER prodTrg  -- Ʈ���� �̸�
    AFTER  UPDATE 
    ON prodTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW 
BEGIN
    DECLARE orderAmount INT;
    -- �ֹ� ���� = (���� ���� ���� - ���� ���� ����)
    SET orderAmount = OLD.account - NEW.account;
    INSERT INTO deliverTbl(prodName, account)
        VALUES(NEW.prodName, orderAmount);
END // 
DELIMITER ;

INSERT INTO orderTbl VALUES (NULL,'JOHN', '��', 5);

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;ALTER TABLE deliverTBL CHANGE prodName productName VARCHAR(5);

ALTER TABLE deliverTBL CHANGE prodName productName VARCHAR(5);

INSERT INTO orderTbl VALUES (NULL, 'DANG', '���', 9);

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;

-- </�ǽ� 7> --

