DROP DATABASE IF EXISTS GisDB;
CREATE DATABASE GisDB;

USE GisDB;
CREATE TABLE StreamTbl (
   MapNumber CHAR(10),  -- �����Ϸù�ȣ
   StreamName CHAR(20),  -- ��õ�̸�
   Stream GEOMETRY ); -- ����������(��õ��ü)

INSERT INTO StreamTbl VALUES ( '330000001' ,  '�ѷ�õ', 
	ST_GeomFromText('LINESTRING (-10 30, -50 70, 50 70)'));
INSERT INTO StreamTbl VALUES ( '330000001' ,  '�Ⱦ�õ', 
	ST_GeomFromText('LINESTRING (-50 -70, 30 -10, 70 -10)'));
INSERT INTO StreamTbl VALUES ('330000002' ,  '�ϻ�õ', 
	ST_GeomFromText('LINESTRING (-70 50, -30 -30, 30 -60)'));

CREATE TABLE BuildingTbl (
   MapNumber CHAR(10),  -- �����Ϸù�ȣ
   BuildingName CHAR(20),  -- �ǹ��̸�
   Building GEOMETRY ); -- ����������(�ǹ���ü)
   
INSERT INTO BuildingTbl VALUES ('330000005' ,  '�ϳ�����', 
	ST_GeomFromText('POLYGON ((-10 50, 10 30, -10 10, -30 30, -10 50))'));
INSERT INTO BuildingTbl VALUES ( '330000001' ,  '�츮����', 
	ST_GeomFromText('POLYGON ((-50 -70, -40 -70, -40 -80, -50 -80, -50 -70))'));
INSERT INTO BuildingTbl VALUES ( '330000002' ,  '��Ƽ���ǽ���', 
	ST_GeomFromText('POLYGON ((40 0, 60 0, 60 -20, 40 -20, 40 0))'));

SELECT * FROM StreamTbl;

SELECT * FROM BuildingTbl;

SELECT * FROM StreamTbl WHERE ST_Length(Stream) > 140 ;

SELECT BuildingName, ST_AREA(Building) FROM BuildingTbl 
	WHERE ST_AREA(Building) < 500;
    
SELECT * FROM StreamTbl
UNION ALL
SELECT * FROM BuildingTbl;

-- </�ǽ� 1> --

SELECT StreamName, BuildingName, Building, Stream
   FROM BuildingTbl , StreamTbl 
   WHERE ST_Intersects(Building, Stream) = 1   AND StreamName = '�Ⱦ�õ';

SELECT ST_Buffer(Stream,5) FROM StreamTbl;
