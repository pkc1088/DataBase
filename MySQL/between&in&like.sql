USE  sqldb;
SELECT * FROM usertbl;

SELECT * FROM usertbl WHERE name = '±è°æÈ£';

SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 AND height >= 182;

SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 OR height >= 182;

SELECT name, height FROM usertbl WHERE height >= 180 AND height <= 183;

SELECT name, height FROM usertbl WHERE height BETWEEN 180 AND 183;

SELECT name, addr FROM usertbl WHERE addr='°æ³²' OR  addr='Àü³²' OR addr='°æºÏ';

SELECT name, addr FROM usertbl WHERE addr IN ('°æ³²','Àü³²','°æºÏ');

SELECT name, height FROM usertbl WHERE name LIKE '±è%';

SELECT name, height FROM usertbl WHERE name LIKE '_Á¾½Å';
