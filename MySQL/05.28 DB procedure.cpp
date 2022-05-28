SELECT * FROM membertbl WHERE memberName = '¥Á≈¡¿Ã';
SELECT * FROM producttbl WHERE productName = '≥√¿Â∞Ì';

DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM membertbl WHERE memberName = '¥Á≈¡¿Ã';
	SELECT * FROM producttbl WHERE productName = '≥√¿Â∞Ì';
END //
DELIMITER ;

CALL myProc();
