DROP DATABASE IF EXISTS KingHotDB;
CREATE DATABASE KingHotDB;

USE KingHotDB;
//-- [�ոſ� «��] ü���� ���̺� (�� ����� ����)
CREATE TABLE Restaurant
(restID int auto_increment PRIMARY KEY,  -- ü���� ID
 restName varchar(50),	        -- ü���� �̸�
 restAddr varchar(50),	        -- ü���� �ּ�
 restPhone varchar(15),	        -- ü���� ��ȭ��ȣ
 totSales  BIGINT,		        -- �� �����			
 restLocation geometry ) ;	        -- ü���� ��ġ

//-- [�ոſ� «��] 1ȣ��~9ȣ�� �Է�
INSERT INTO Restaurant VALUES
 (NULL, '�ոſ� «�� 1ȣ��', '���� ������ ��ȭ��', '02-111-1111', 1000, ST_GeomFromText('POINT(-80 -30)')),
 (NULL, '�ոſ� «�� 2ȣ��', '���� ���� ���굿', '02-222-2222', 2000, ST_GeomFromText('POINT(-50 70)')),
 (NULL, '�ոſ� «�� 3ȣ��', '���� �߶��� ���', '02-333-3333', 9000, ST_GeomFromText('POINT(70 50)')),
 (NULL, '�ոſ� «�� 4ȣ��', '���� ������ ���ǵ�', '02-444-4444', 250, ST_GeomFromText('POINT(80 -10)')),
 (NULL, '�ոſ� «�� 5ȣ��', '���� ���빮�� �ϰ��µ�', '02-555-5555', 1200, ST_GeomFromText('POINT(-10 50)')),
 (NULL, '�ոſ� «�� 6ȣ��', '���� ������ ������', '02-666-6666', 4000, ST_GeomFromText('POINT(40 -30)')),
 (NULL, '�ոſ� «�� 7ȣ��', '���� ���ʱ� ���ʵ�', '02-777-7777', 1000, ST_GeomFromText('POINT(30 -70)')),
 (NULL, '�ոſ� «�� 8ȣ��', '���� �������� ��굿', '02-888-8888', 200, ST_GeomFromText('POINT(-40 -50)')),
 (NULL, '�ոſ� «�� 9ȣ��', '���� ���ı� ������', '02-999-9999', 600, ST_GeomFromText('POINT(60 -50)'));

SELECT restName, ST_Buffer(restLocation, 3) as 'ü����' FROM Restaurant;

//-- ���� ������ ���̺�
CREATE TABLE Manager
 (ManagerID int auto_increment PRIMARY KEY,   -- ���������� id
  ManagerName varchar(5),	              -- ���������� �̸�
  MobilePhone varchar(15),	              -- ���������� ��ȭ��ȣ
  Email varchar(40),                      -- ���������� �̸���
  AreaName varchar(15),                 -- ���������
  Area geometry SRID 0) ;                       -- ������� ������

INSERT INTO Manager VALUES
 (NULL, '������', '011-123-4567', 'johnbann@kinghot.com',  '���� ��/�Ϻ�����',
   ST_GeomFromText('POLYGON((-90 0, -90 90, 90 90, 90 -90, 0 -90, 0  0, -90 0))')) ,
 (NULL, '������', '019-321-7654', 'dangtang@kinghot.com', '���� ��������',
   ST_GeomFromText('POLYGON((-90 -90, -90 90, 0 90, 0 -90, -90 -90))'));

SELECT ManagerName, Area as '������' FROM Manager WHERE ManagerName = '������';
SELECT ManagerName, Area as '������' FROM Manager WHERE ManagerName = '������';

//-- ������� ���� ���̺�
CREATE TABLE Road
 (RoadID int auto_increment PRIMARY KEY,  -- ���� ID
  RoadName varchar(20),           -- ���� �̸�
  RoadLine geometry );              -- ���� ��

INSERT INTO Road VALUES
 (NULL, '�����Ϸ�',
   ST_GeomFromText('LINESTRING(-70 -70 , -50 -20 , 30 30,  50 70)'));

SELECT RoadName, ST_BUFFER(RoadLine,1) as '�����Ϸ�' FROM Road;

SELECT ManagerName, Area as '������' FROM Manager WHERE ManagerName = '������';
SELECT ManagerName, Area as '������' FROM Manager WHERE ManagerName = '������';
SELECT restName, ST_Buffer(restLocation, 3) as 'ü����' FROM Restaurant;
SELECT RoadName, ST_BUFFER(RoadLine,1) as '�����Ϸ�' FROM Road;


SELECT ManagerName, AreaName, ST_Area(Area) as "���� m2" FROM Manager;

SELECT M.ManagerName,
       R.restName,
       R.restAddr,
       M.AreaName 
FROM Restaurant R, Manager M
WHERE ST_Contains(M.AREA, R.restLocation) = 1 
ORDER BY M.ManagerName;

SELECT R2.restName,
       R2.restAddr,
       R2.restPhone, 
       ST_Distance(R1.restLocation, R2.restLocation) AS "1ȣ������ �Ÿ�"
FROM Restaurant R1, Restaurant R2
WHERE R1.restName='�ոſ� «�� 1ȣ��'
ORDER BY ST_Distance(R1.restLocation, R2.restLocation) ;

SELECT Area INTO @eastNorthSeoul FROM Manager WHERE AreaName = '���� ��/�Ϻ�����';
SELECT Area INTO @westSeoul FROM Manager WHERE AreaName = '���� ��������';
SELECT ST_Union(@eastNorthSeoul, @westSeoul) AS  "��� ���������� ��ģ ����" ;

SELECT  Area INTO @eastNorthSeoul FROM Manager WHERE ManagerName = '������';
SELECT  Area INTO @westSeoul FROM Manager WHERE ManagerName = '������';
SELECT  ST_Intersection(@eastNorthSeoul, @westSeoul) INTO @crossArea ;
SELECT DISTINCT R.restName AS "�ߺ� ���� ����"
    FROM Restaurant R, Manager M
    WHERE ST_Contains(@crossArea, R.restLocation) = 1;


SELECT  ST_Buffer(RoadLine, 30) INTO @roadBuffer FROM Road;
SELECT R.restName AS "�����Ϸ� 30M �̳� ����"
   FROM Restaurant R
   WHERE ST_Contains(@roadBuffer,R.restLocation) = 1;

SELECT  ST_Buffer(RoadLine, 30) INTO @roadBuffer FROM Road;
SELECT  ST_Buffer(RoadLine, 30) as '�����Ϸ� 30m' FROM Road;
SELECT  ST_Buffer(R.restLocation, 5) as 'ü����' -- ������ �ణ ũ�� ���
   FROM Restaurant R
   WHERE ST_Contains(@roadBuffer, R.restLocation) = 1;
SELECT RoadLine as '�����Ϸ�' FROM Road;

