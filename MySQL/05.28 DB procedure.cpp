SELECT * FROM membertbl WHERE memberName = '������';
SELECT * FROM producttbl WHERE productName = '�����';

DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM membertbl WHERE memberName = '������';
	SELECT * FROM producttbl WHERE productName = '�����';
END //
DELIMITER ;

CALL myProc();
