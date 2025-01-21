USE sqldb;
CREATE TABLE memberTBL (SELECT userID, name, addr FROM usertbl LIMIT 3); -- 3�Ǹ� ������
ALTER TABLE memberTBL 
	ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- PK�� ������
SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('BBK' , '�����', '�̱�');
INSERT INTO memberTBL VALUES('SJH' , '������', '����');
INSERT INTO memberTBL VALUES('HJY' , '���ֿ�', '���');
SELECT * FROM memberTBL;

INSERT IGNORE INTO memberTBL VALUES('BBK' , '�����', '�̱�'); -- �ߺ�
INSERT IGNORE INTO memberTBL VALUES('SJH' , '������', '����');
INSERT IGNORE INTO memberTBL VALUES('HJY' , '���ֿ�', '���');
SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('BBK' , '�����', '�̱�')
	ON DUPLICATE KEY UPDATE name='�����', addr='�̱�';
INSERT INTO memberTBL VALUES('DJM' , '��¥��', '�Ϻ�')
	ON DUPLICATE KEY UPDATE name='��¥��', addr='�Ϻ�';
SELECT * FROM memberTBL;
