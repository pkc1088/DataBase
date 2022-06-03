USE sqldb;
CREATE TABLE stdtbl 
( stdName    VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);
CREATE TABLE clubtbl 
( clubName    VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);
CREATE TABLE stdclubtbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);
INSERT INTO stdtbl VALUES ('�����','�泲'), ('���ð�','����'), ('������','���'), ('������','���'),('�ٺ�Ŵ','����');
INSERT INTO clubtbl VALUES ('����','101ȣ'), ('�ٵ�','102ȣ'), ('�౸','103ȣ'), ('����','104ȣ');
INSERT INTO stdclubtbl VALUES (NULL, '�����','�ٵ�'), (NULL,'�����','�౸'), (NULL,'������','�౸'), (NULL,'������','�౸'), (NULL,'������','����'), (NULL,'�ٺ�Ŵ','����');

SELECT S.stdName, S.addr, SC.clubName, C.roomNo
   FROM stdtbl S 
      INNER JOIN stdclubtbl SC
           ON S.stdName = SC.stdName
      INNER JOIN clubtbl C
           ON SC.clubName = C.clubName 
   ORDER BY S.stdName;
  
SELECT C.clubName, C.roomNo, S.stdName, S.addr
   FROM  stdtbl S
      INNER JOIN stdclubtbl SC
         ON SC.stdName = S.stdName
      INNER JOIN clubtbl C
          ON SC.clubName = C.clubName
    ORDER BY C.clubName;

