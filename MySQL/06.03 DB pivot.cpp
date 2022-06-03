USE sqldb;
CREATE TABLE pivotTest
   (  uName CHAR(3),
      season CHAR(2),
      amount INT );

INSERT  INTO  pivotTest VALUES
	('±è¹ü¼ö' , '°Ü¿ï',  10) , ('À±Á¾½Å' , '¿©¸§',  15) , ('±è¹ü¼ö' , '°¡À»',  25) , ('±è¹ü¼ö' , 'º½',    3) ,
	('±è¹ü¼ö' , 'º½',    37) , ('À±Á¾½Å' , '°Ü¿ï',  40) , ('±è¹ü¼ö' , '¿©¸§',  14) ,('±è¹ü¼ö' , '°Ü¿ï',  22) ,
	('À±Á¾½Å' , '¿©¸§',  64) ;
SELECT * FROM pivotTest;

SELECT uName, 
  SUM(IF(season='º½', amount, 0)) AS 'º½', 
  SUM(IF(season='¿©¸§', amount, 0)) AS '¿©¸§',
  SUM(IF(season='°¡À»', amount, 0)) AS '°¡À»',
  SUM(IF(season='°Ü¿ï', amount, 0)) AS '°Ü¿ï',
  SUM(amount) AS 'ÇÕ°è' FROM pivotTest GROUP BY uName ;

