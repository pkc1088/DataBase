drop database if exists warehouse;
create database warehouse;
use warehouse;

# done here 

create table `warehouse`.`s` (
	`sno` CHAR(4) NOT NULL,
    `sname` CHAR(10) not null,
    `status` INT not null,
    `city` VARCHAR(20) not null,
    PRIMARY KEY (`sno`)
   # ,FOREIGN KEY (sno)  references `warehouse`.`p`(pno)
    );
select * from s;
insert into s values('S1', 'Smtih', 20, 'London');
insert into s values('S2', 'Jones', 10, 'Paris');
insert into s values('S3', 'Blakes', 30, 'Paris');
insert into s values('S4', 'Clark', 20, 'London');
insert into s values('S5', 'Adams', 30, 'Athens');


create table `warehouse`.`p` (
	`pno` CHAR(4) NOT NULL,
    `pname` CHAR(10) not null,
    `color` CHAR(10) not null,
    `weight` float not null,
    `city` VARCHAR(20) not null,
    PRIMARY KEY (`pno`)
  #  , foreign key (pno) references `warehouse`.`s` (sno)
    );
select * from p;
insert into p values('P1', 'Nut', 'Red', 12.0, 'London');
insert into p values('P2', 'Bolt', 'Red', 17.0, 'Paris');
insert into p values('P3', 'Screw', 'Red', 17.0, 'Oslo');
insert into p values('P4', 'Screw', 'Red', 14.0, 'London');
insert into p values('P5', 'Cam', 'Red', 12.0, 'Paris');
insert into p values('P6', 'Cog', 'Red', 19.0, 'London');


create table `warehouse`.`j` (
	`jno` CHAR(4) NOT NULL,
    `jname` CHAR(10) NOT NULL,
    `city` VARCHAR(20) not null,
    PRIMARY KEY (`jno`));
select * from j;
insert into j values('J1', 'Sorter', 'Paris');
insert into j values('J2', 'Display', 'Rome');
insert into j values('J3', 'OCR', 'Athens');
insert into j values('J4', 'Console', 'Athens');
insert into j values('J5', 'RAID', 'London');
insert into j values('J6', 'EDS', 'Oslo');
insert into j values('J7', 'Tape', 'London');
/* UPDATE `warehouse`.`j` SET `jno` = 'J1' WHERE (`jno` = 'j1'); */

create table `warehouse`.`spj` (
	`sno` CHAR(4) NOT NULL,
    `pno` CHAR(4) NOT NULL,
    `jno` CHAR(4) NOT NULL,
    `qty` int not null,
    PRIMARY KEY (`sno`, `pno`, `jno`)
    ,FOREIGN KEY (sno)  references `warehouse`.`s`(sno),
	 FOREIGN KEY (pno)  references `warehouse`.`p`(pno),
	 FOREIGN KEY (jno)  references `warehouse`.`j`(jno)
    );
select * from spj;
insert into spj values('S1', 'P1', 'J1', 200);
insert into spj values('S1', 'P1', 'J4', 700);
insert into spj values('S2', 'P3', 'J1', 400);
insert into spj values('S2', 'P3', 'J2', 200);
insert into spj values('S2', 'P3', 'J3', 200);
insert into spj values('S2', 'P3', 'J4', 500);
insert into spj values('S2', 'P3', 'J5', 600);
insert into spj values('S2', 'P3', 'J6', 400);
insert into spj values('S2', 'P3', 'J7', 800);
insert into spj values('S2', 'P5', 'J2', 100);
insert into spj values('S3', 'P3', 'J1', 200);
insert into spj values('S3', 'P4', 'J2', 500);
insert into spj values('S4', 'P6', 'J3', 300);
insert into spj values('S4', 'P6', 'J7', 300);
insert into spj values('S5', 'P2', 'J2', 200);
insert into spj values('S5', 'P2', 'J4', 100);
insert into spj values('S5', 'P5', 'J5', 500);
insert into spj values('S5', 'P5', 'J7', 100);
insert into spj values('S5', 'P6', 'J2', 200);
insert into spj values('S5', 'P1', 'J4', 100);
insert into spj values('S5', 'P3', 'J4', 200);
insert into spj values('S5', 'P4', 'J4', 800);
insert into spj values('S5', 'P5', 'J4', 400);
insert into spj values('S5', 'P6', 'J4', 500);




create table `warehouse`.`dept` (
	`dno` VARCHAR(10) NOT NULL,
    `dname` CHAR(20) NOT NULL,
    `budget` VARCHAR(10) not null,
    PRIMARY KEY (`dno`)    
   
    );
select * from dept;
# Alter table dept modify dname CHAR(20); 
insert into dept values('D1', 'Marketing', '10');
insert into dept values('D2', 'Development', '12');
insert into dept values('D3', 'Research', '5');


create table `warehouse`.`emp` (
	`eno` CHAR(4) NOT NULL,
    `ename` CHAR(10) NOT NULL,
    `dno` VARCHAR(10) not null,
    `salary` char(10) not null,
    PRIMARY KEY (`eno`)
     ,FOREIGN KEY (`dno`)  references `warehouse`.`dept`(`dno`)
    );
select * from emp;
insert into emp values('E1', 'Lopez', 'D1', '40');
insert into emp values('E2', 'cheng', 'D1', '42');
insert into emp values('E3', 'Finzi', 'D2', '30');
insert into emp values('E4', 'saito', 'D2', '35');

show index from spj;
show index from dept;

# ALter table `warehouse`.`emp` Add foreign key (`dno`) references `warehouse`.`dept`(`dno`)