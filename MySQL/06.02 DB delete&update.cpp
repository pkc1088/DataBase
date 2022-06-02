UPDATE testTbl4
    SET Lname = '없음'
    WHERE Fname = 'Kyoichi';
select * from testtbl4 ;

USE sqldb;
UPDATE buytbl SET price = price * 1.5 ;

USE sqldb;
DELETE FROM testTbl4 WHERE Fname = 'Aamer';

DELETE FROM testTbl4 WHERE Fname = 'Aamer'  LIMIT 5;

DELETE FROM bigTbl1; // -- 행별로 지움 
DROP TABLE bigTbl2;	// 전체지움 
TRUNCATE TABLE bigTbl3; // delete와 동일 but 트랜잭션 로그를 기록하지 않아 속도빠름

