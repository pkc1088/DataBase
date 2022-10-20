use warehouse;
select * from s;
select sname, city from s;
select sname from s where city = 'paris';

create index myindex on s(city);
show index from s;
select sname from s where sno > 'S2'; #index scan

create or replace view `new_view` AS select sname, sno from s where status > 20;
select * from new_view;

DELIMITER $$
use `warehouse` $$
create procedure `new_procedure` ()
begin
select * from s;
select city from s where status > 20;
end$$
DELIMITER ;
call new_procedure();



create table `warehouse`.`deletedDept` (
	`dno` CHAR(4) NOT NULL,
    `dname` CHAR(20) NOT NULL,
    `budget` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' not null,
    PRIMARY KEY (`dno`));
select * from deletedDept;

DROP TRIGGER IF EXISTS `warehouse`. `dept_BEFORE_DELETE`;
DELIMITER $$ 
use `warehouse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `warehouse`.`dept_BEFORE_DELETE` 
	BEFORE DELETE 
    ON `dept`
    FOR EACH ROW
BEGIN 
	insert into deletedDept values(old.dno, old.dname, old.budget);
END $$ 
DELIMITER ;
show triggers;

select * from dept;
select * from deletedDept;
delete from dept where budget > 10;
