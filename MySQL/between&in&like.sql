USE  sqldb;
SELECT * FROM usertbl;

SELECT * FROM usertbl WHERE name = '���ȣ';

SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 AND height >= 182;

SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 OR height >= 182;

SELECT name, height FROM usertbl WHERE height >= 180 AND height <= 183;

SELECT name, height FROM usertbl WHERE height BETWEEN 180 AND 183;

SELECT name, addr FROM usertbl WHERE addr='�泲' OR  addr='����' OR addr='���';

SELECT name, addr FROM usertbl WHERE addr IN ('�泲','����','���');

SELECT name, height FROM usertbl WHERE name LIKE '��%';

SELECT name, height FROM usertbl WHERE name LIKE '_����';
