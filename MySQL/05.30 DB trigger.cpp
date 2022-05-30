INSERT INTO memberTBL values ('Figure', '연아', '경기도 군포시 당정동');

SELECT * FROM memberTBL;

UPDATE memberTBL SET memberAddress = '서울 강남구 역삼동' WHERE memberName = '연아';

select * from memberTBl;

delete from memberTBl where memberName = '연아';

select * from memberTBL;

create table deletedMemberTBL (
	memberID char(8) ,
    memberName char(5) ,
    memberAddress char(20) ,
    deletedDate date --  삭제한 날짜
);

DELIMITER //
create trigger trg_deletedMemberTBL -- 트리거 이름
	AFTER DELETE -- 삭제 후에 작동하게 지정
    ON memberTBL -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	-- OLD 테이블의 내용을 백업테이블에 삽입
    INSERT INTO deletedMemberTBL
		VALUES (OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE());
END //
DELIMITER ;

select * from memberTBL;

Delete from memberTBL where memberName = '당탕이';

select * from memberTBL;

select * from deletedMemberTBL;
