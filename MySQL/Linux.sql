show databases;

create database mydb;
use mydb;
create table mytbl(uname char(10));
insert into mytbl values ('마이리틀텔레비전');
select * from mytbl;

//Linux로  mysql 서버에 접속해봤음 
//특정 사용자로 접속하려면 "mysql -u 사용자이름 -p" 를 쓴다 
