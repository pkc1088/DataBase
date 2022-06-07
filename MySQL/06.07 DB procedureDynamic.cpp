DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tblName VARCHAR(20)
)
BEGIN
  SET @sqlQuery = CONCAT('SELECT * FROM ', tblName);
  PREPARE myQuery FROM @sqlQuery;
  EXECUTE myQuery;
  DEALLOCATE PREPARE myQuery;
END $$
DELIMITER ;

CALL nameProc ('userTBL');

// -- 밑에 처럼은 불가

DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tblName VARCHAR(20)
)
BEGIN
 SELECT * FROM tblName;
END $$
DELIMITER ;

CALL nameProc ('userTBL'); 
