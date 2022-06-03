CREATE DATABASE moviedb;

USE moviedb;
CREATE TABLE movietbl 
  (movie_id        INT,
   movie_title     VARCHAR(30),
   movie_director  VARCHAR(20),
   movie_star      VARCHAR(20),
   movie_script    LONGTEXT,
   movie_film      LONGBLOB
) DEFAULT CHARSET=utf8mb4;

INSERT INTO movietbl VALUES ( 1, '���鷯 ����Ʈ', '���ʹ���', '���� �Ͻ�',  
	LOAD_FILE('C:/SQL/Movies/Schindler.txt'), LOAD_FILE('C:/SQL/Movies/Schindler.mp4') );

SELECT * FROM movietbl;

SHOW variables LIKE 'max_allowed_packet';

SHOW variables LIKE 'secure_file_priv';

USE moviedb;
TRUNCATE movietbl; -- ���� �� ��� ����

INSERT INTO movietbl VALUES ( 1, '���鷯 ����Ʈ', '���ʹ���', '���� �Ͻ�',  
	LOAD_FILE('C:/SQL/Movies/Schindler.txt'), LOAD_FILE('C:/SQL/Movies/Schindler.mp4') );
INSERT INTO movietbl VALUES ( 2, '���ũ Ż��', '����ũ �ٶ�Ʈ', '�� �κ�',  
	LOAD_FILE('C:/SQL/Movies/Shawshank.txt'), LOAD_FILE('C:/SQL/Movies/Shawshank.mp4') );    
INSERT INTO movietbl VALUES ( 3, '��Ʈ ����ĭ', '����Ŭ ��', '�ٴϿ� ���� ���̽�',
	LOAD_FILE('C:/SQL/Movies/Mohican.txt'), LOAD_FILE('C:/SQL/Movies/Mohican.mp4') );

SELECT * FROM movietbl;


SELECT movie_script FROM movietbl WHERE movie_id=1 
	INTO OUTFILE 'C:/SQL/Movies/Schindler_out.txt'  
	LINES TERMINATED BY '\\n';

SELECT movie_film FROM movietbl  WHERE movie_id=3 
	INTO DUMPFILE 'C:/SQL/Movies/Mohican_out.mp4';
