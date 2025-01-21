
SHOW VARIABLES LIKE 'innodb_ft_min_token_size';

/*
innodb_ft_min_token_size=2
*/

CREATE DATABASE IF NOT EXISTS FulltextDB;
USE FulltextDB;
DROP TABLE IF EXISTS FulltextTbl;
CREATE TABLE FulltextTbl ( 
	id int AUTO_INCREMENT PRIMARY KEY, 	-- ���� ��ȣ
	title VARCHAR(15) NOT NULL, 		-- ��ȭ ����
	description VARCHAR(1000)  		-- ��ȭ ���� ���
);

INSERT INTO FulltextTbl VALUES
(NULL, '����, ���� �� ����','������ �ѷ��� �Ƿ� ������ �������� ȥ���� �ؿ� ���� ���ر� 8��'),
(NULL, '��ø','���� ���� ���尣ø 5�� ���� �Ͼ��ϰ� ������ Ư�� �Ƿ� �ٽɺο��� ħ�����ִ�.'),
(NULL, '���ڰ� ����� ��', '��å ���� �� �����̾߱�. �� ���� ���� ��� ��ī���� ���ô��ϴ� ����'), 
(NULL, '������Ʈ �̺� 5','�η� ������ ������ ����, �� ���ڰ� ��� ���� ������.'),
(NULL, '�ı��ڵ�','����� ��� ���� �ı��Ѵ�! �� ���ڸ� ���ϱ� ����, �� ������ ������ �׼� ����!'),
(NULL, 'ŷ���� ���',' ������ ����� �� �ð�ҳ���� ����� ���� ���� ��ȭ.'),
(NULL, '�׵�','�����ִ� Ȳ��ã�� ������Ʈ! 500�� �� ����� Ȳ�ݵ��ø� ã�ƶ�!'),
(NULL, 'Ÿ��Ÿ��','��� �ӿ� ħ���� ������ ���, ��ũ���� �ǻ�Ƴ� ������ ����'),
(NULL, '8���� ũ��������','���Ѻ� �λ� ������� ���� ���� �ܼӿ����� �̹��� ���'),
(NULL, '����� ����','����� ģ���� ��ں� �Ʒ��� �Բ� ���� �ߴ� ���� ���� �̾߱�'),
(NULL, '������ǥ','����ø��� ��ġ�� ���� ���� ������ ��Ű���� ������ǥ���� �����ȴ�.'),
(NULL, '���ũ Ż��','�״� ������ ���� ���ũ ������ ���ݵȴ�. �׸��� �������� Ż��.'),
(NULL, '�λ��� �Ƹ��ٿ�','�͵��� ������ ȣ�ڿ��� �����ͷ� ���ϸ鼭 �� �ٽ� ���� ������.'),
(NULL, '���� ���� ����','���� ������ �����ƴ� �� Ʈ������ ��������� ����'),
(NULL, '��Ʈ����',' 2199��.�ΰ� �γ��� ���� ��ǻ�Ͱ� �����ϴ� ����.');


SELECT * FROM FulltextTbl WHERE description LIKE '%����%' ;

CREATE FULLTEXT INDEX idx_description ON FulltextTbl(description);

SHOW INDEX FROM FulltextTbl;
// -- ��ü�� ���� ������ ��� 
SELECT * FROM FulltextTbl WHERE MATCH(description) AGAINST('����*' IN BOOLEAN MODE);

SELECT *, MATCH(description) AGAINST('����* ����*' IN BOOLEAN MODE) AS ���� 
	FROM FulltextTbl WHERE MATCH(description) AGAINST('����* ����*' IN BOOLEAN MODE);

SELECT * FROM FulltextTbl 
	WHERE MATCH(description) AGAINST('+����* +����*' IN BOOLEAN MODE);

SELECT * FROM FulltextTbl 
	WHERE MATCH(description) AGAINST('����* -����*' IN BOOLEAN MODE);

SET GLOBAL innodb_ft_aux_table = 'fulltextdb/fulltexttbl'; -- ��� �ҹ���
SELECT word, doc_count, doc_id, position 
	FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_TABLE;

DROP INDEX idx_description ON FulltextTbl;

CREATE TABLE user_stopword (value VARCHAR(30));

INSERT INTO user_stopword VALUES ('�״�'), ('�׸���'), ('�ؿ�');

SET GLOBAL innodb_ft_server_stopword_table = 'fulltextdb/user_stopword'; -- ��� �ҹ���
SHOW GLOBAL VARIABLES LIKE 'innodb_ft_server_stopword_table';

CREATE FULLTEXT INDEX idx_description ON FulltextTbl(description);

SELECT word, doc_count, doc_id, position 
	FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_TABLE;
