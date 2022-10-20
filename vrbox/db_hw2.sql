drop database if exists ERR_hw2;
create database ERR_hw2;
use ERR_hw2;

create table `ERR_hw2`.`Warehouses` (
	`wno` CHAR(4) NOT NULL,
    `wname` CHAR(10) not null,
    `size` INT not null,
    `owner` VARCHAR(20) not null,
    PRIMARY KEY (`wno`)
   # ,FOREIGN KEY (sno)  references `warehouse`.`p`(pno)
    );