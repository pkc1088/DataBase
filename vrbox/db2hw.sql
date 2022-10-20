select * from s;
select * from p;
select * from j;
select * from spj;
select * from emp;
select * from dept;

create index pindex on p(city);
show index from p;

create or replace view `view1` AS select sno, pno, qty from spj where jno = 'j1';
select * from view1;

##################

create table `warehouse`.`deletedEmp` (
	`eno` CHAR(4) NOT NULL,
    `ename` CHAR(20) NOT NULL,
    `dno` char(4) NOT NULL,
    `salary` CHAR(10) not null,
    PRIMARY KEY (`eno`));
select * from deletedEmp;
 # Drop table `warehouse`.`deletedEmp`;
DROP TRIGGER IF EXISTS `warehouse`. `emp_BEFORE_DELETE`;
DELIMITER $$ 
use `warehouse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `warehouse`.`emp_BEFORE_DELETE` 
	BEFORE DELETE 
    ON `emp`
    FOR EACH ROW
BEGIN 
	insert into deletedEmp values(old.eno, old.ename, old.dno, old.salary);
END $$ 
DELIMITER ;
show triggers;

# not done
delete from emp where salary > 40;
select * from emp;
select * from deletedEmp;