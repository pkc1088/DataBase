INSERT INTO memberTBL values ('Figure', '����', '��⵵ ������ ������');

SELECT * FROM memberTBL;

UPDATE memberTBL SET memberAddress = '���� ������ ���ﵿ' WHERE memberName = '����';

select * from memberTBl;

delete from memberTBl where memberName = '����';

select * from memberTBL;

create table deletedMemberTBL (
	memberID char(8) ,
    memberName char(5) ,
    memberAddress char(20) ,
    deletedDate date --  ������ ��¥
);

DELIMITER //
create trigger trg_deletedMemberTBL -- Ʈ���� �̸�
	AFTER DELETE -- ���� �Ŀ� �۵��ϰ� ����
    ON memberTBL -- Ʈ���Ÿ� ������ ���̺�
    FOR EACH ROW -- �� �ึ�� �����Ŵ
BEGIN
	-- OLD ���̺��� ������ ������̺� ����
    INSERT INTO deletedMemberTBL
		VALUES (OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE());
END //
DELIMITER ;

select * from memberTBL;

Delete from memberTBL where memberName = '������';

select * from memberTBL;

select * from deletedMemberTBL;
