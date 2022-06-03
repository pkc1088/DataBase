
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM stdtbl S 
      LEFT OUTER JOIN stdclubtbl SC
          ON S.stdName = SC.stdName
      LEFT OUTER JOIN clubtbl C
          ON SC.clubName = C.clubName
UNION 
SELECT S.stdName, S.addr, C.clubName, C.roomNo
   FROM  stdtbl S
      LEFT OUTER JOIN stdclubtbl SC
          ON SC.stdName = S.stdName
      RIGHT OUTER JOIN clubtbl C
          ON SC.clubName = C.clubName;
          

USE sqldb;
SELECT stdName, addr FROM stdtbl
   UNION ALL	-- union �� �ߺ����� union all �� �ߺ�����
SELECT clubName, roomNo FROM clubtbl;

SELECT name, CONCAT(mobile1, mobile2) AS '��ȭ��ȣ' FROM usertbl
   WHERE name NOT IN ( SELECT name FROM usertbl WHERE mobile1 IS NULL) ;

SELECT name, CONCAT(mobile1, mobile2) AS '��ȭ��ȣ' FROM usertbl
   WHERE name IN ( SELECT name FROM usertbl WHERE mobile1 IS NULL) ;

