USE sqldb;
SELECT * 
   FROM buytbl	-- �� ���̺��� ���� ���� ���� ��µ�
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
   WHERE buytbl.userID = 'JYP';      
   
SELECT  * 
	FROM buytbl 
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID 
	ORDER BY num;        


SELECT buytbl.userID, name, prodName, addr, mobile1 + mobile2 AS '����ó'
   FROM buytbl
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
	ORDER BY num;  
// -- userID �ߺ��Ǵ� buytbl. �ٿ��� ��� �������̵����� ���


SELECT buytbl.userID, name, prodName, addr, mobile1 + mobile2 
  FROM buytbl, usertbl
  WHERE buytbl.userID = usertbl.userID 
  ORDER BY addr; 
  
  
 // �ؿ� �ΰ� ���� 
  
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
  

