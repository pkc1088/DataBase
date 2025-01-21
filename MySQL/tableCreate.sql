drop database if exists sqldb;
create database sqldb;
use sqldb;
create table usertbl ( 	
	userID char(8) NOT NULL PRIMARY KEY,
	name varchar(10) NOT NULL, -- varchar�� ������ char�� ������
    birthYear INT NOT NULL,
    addr char(2) not null,
    mobile1 char(3),
    mobile2 char(8),
    height smallint,
    mDate DATE
);

create table buytbl (
	num int auto_increment not null primary key,
    userID char(8) not null,
    prodName char(6) not null,
    groupName char(4),
    price int not null,
    amount smallint not null,
    foreign key (userID) references usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '�̽±�', 1987, '����', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '�����', 1979, '�泲', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '���ȣ', 1971, '����', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '������', 1950, '���', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '���ð�', 1979, '����', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '�����', 1963, '����', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '������', 1969, '�泲', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '������', 1972, '���', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '������', 1965, '���', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '�ȭ', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '�����', '����', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '�����', '����', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', 'û����', '�Ƿ�', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '�޸�', '����', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', 'å'    , '����', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', 'å'    , '����', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', 'û����', '�Ƿ�', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '�ȭ', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', 'å'    , '����', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '�ȭ', NULL   , 30,   2);

select * from usertbl;
select * from buytbl;

USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;

CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl);
SELECT * FROM buytbl3;

USE sqldb;
CREATE TABLE testTbl1 (id  int, userName char(3), age int);
INSERT INTO testTbl1 VALUES (1, 'ȫ�浿', 25);
INSERT INTO testTbl1(id, userName) VALUES (2, '����');
INSERT INTO testTbl1(userName, age, id) VALUES ('�ϴ�', 26,  3);
SELECT LAST_INSERT_ID(); 

