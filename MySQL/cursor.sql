DROP PROCEDURE IF EXISTS cursorProc;
DELIMITER $$
CREATE PROCEDURE cursorProc()
BEGIN
    DECLARE userHeight INT; -- ���� Ű
    DECLARE cnt INT DEFAULT 0; -- ���� �ο� ��(=���� ���� ��)
    DECLARE totalHeight INT DEFAULT 0; -- Ű�� �հ�
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- ���� �� ����(�⺻�� FALSE)

    DECLARE userCuror CURSOR FOR-- Ŀ�� ����
        SELECT height FROM userTbl;

    DECLARE CONTINUE HANDLER -- ���� ���̸� endOfRow ������ TRUE�� ���� 
        FOR NOT FOUND SET endOfRow = TRUE;
    
    OPEN userCuror;  -- Ŀ�� ����

    cursor_loop: LOOP
        FETCH  userCuror INTO userHeight; -- �� Ű 1���� ����
        
        IF endOfRow THEN -- ���̻� ���� ���� ������ Loop�� ����
            LEAVE cursor_loop;
        END IF;

        SET cnt = cnt + 1;
        SET totalHeight = totalHeight + userHeight;        
    END LOOP cursor_loop;
    
    -- �� Ű�� ����� ����Ѵ�.
    SELECT CONCAT('�� Ű�� ��� ==> ', (totalHeight/cnt));
    
    CLOSE userCuror;  -- Ŀ�� �ݱ�
END $$
DELIMITER ;

CALL cursorProc();



ALTER TABLE userTbl ADD grade VARCHAR(5);  -- �� ��� �� �߰�

DROP PROCEDURE IF EXISTS gradeProc;
DELIMITER $$
CREATE PROCEDURE gradeProc()
BEGIN
    DECLARE id VARCHAR(10); -- ����� ���̵� ������ ����
    DECLARE hap BIGINT; -- �� ���ž��� ������ ����
    DECLARE userGrade CHAR(5); -- �� ��� ����
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; 

    DECLARE userCuror CURSOR FOR-- Ŀ�� ����
        SELECT U.userid, sum(price*amount)
            FROM buyTbl B
                RIGHT OUTER JOIN userTbl U
                ON B.userid = U.userid
            GROUP BY U.userid, U.name ;

    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET endOfRow = TRUE;
    
    OPEN userCuror;  -- Ŀ�� ����
    grade_loop: LOOP
        FETCH  userCuror INTO id, hap; -- ù �� ���� ����
        IF endOfRow THEN
            LEAVE grade_loop;
        END IF;

        CASE  
            WHEN (hap >= 1500) THEN SET userGrade = '�ֿ����';
            WHEN (hap  >= 1000) THEN SET userGrade ='�����';
            WHEN (hap >= 1) THEN SET userGrade ='�Ϲݰ�';
            ELSE SET userGrade ='���ɰ�';
         END CASE;
        
        UPDATE userTbl SET grade = userGrade WHERE userID = id;
    END LOOP grade_loop;
    
    CLOSE userCuror;  -- Ŀ�� �ݱ�
END $$
DELIMITER ;

CALL gradeProc();
SELECT * FROM userTBL;

