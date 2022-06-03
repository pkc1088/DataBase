USE sqldb;
SELECT * 
   FROM buytbl	-- 이 테이블을 먼저 쓰면 먼저 출력됨
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
   WHERE buytbl.userID = 'JYP';      
   
SELECT  * 
	FROM buytbl 
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID 
	ORDER BY num;        


SELECT buytbl.userID, name, prodName, addr, mobile1 + mobile2 AS '연락처'
   FROM buytbl
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
	ORDER BY num;  
// -- userID 중복되니 buytbl. 붙여서 어디 유저아이디인지 명시


SELECT buytbl.userID, name, prodName, addr, mobile1 + mobile2 
  FROM buytbl, usertbl
  WHERE buytbl.userID = usertbl.userID 
  ORDER BY addr; 
  
  
 // 밑에 두개 동일 
  
SELECT DISTINCT U.userID, U.name,  U.addr
   FROM usertbl U
     INNER JOIN buytbl B
        ON U.userID = B.userID 
   ORDER BY U.userID ;

SELECT U.userID, U.name,  U.addr
   FROM usertbl U
   WHERE EXISTS (
      SELECT * 
      FROM buytbl B
      WHERE U.userID = B.userID );  
  

