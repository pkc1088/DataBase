/*
SELECT * FROM warehouse.p;

(select * from p where weight < 14) union (select * from p where weight >14);

select A.pno, A.pname, A.color, A.weight, A.city from (select * from p where weight < 19) A 
left join (select * from p where weight < 15) B on A.pno = B.pno;	

select A.pno, A.pname, A.color, A.weight, A.city from (select * from p where weight < 19) A 
left join (select * from p where weight < 15) B on A.pno = B.pno where B.pno is NULL;	

select A.pno, A.pname, A.color, A.weight, A.city from (select * from p where weight < 20) A 
join (select * from p where weight < 15) B on A.pno = B.pno;	// same as inner join & cross join

select * from emp;
select * from dept;
select * from emp cross join dept;

select * from p where weight < 15 or city = 'Oslo';

(select A.pno, A.pname, A.color, A.weight, A.city from (select * from p where weight < 15) A 
left join (select * from p where weight < 14) B on A.pno = B.pno where B.pno is NULL) 
union 
(select B.pno, B.pname, B.color, B.weight, B.city from (select * from p where weight < 17) A 
right join (select * from p where weight < 20) B on A.pno = B.pno where A.pno is NULL);	
*/

/*
select * from s;
select * from p;
select * from s,p where s.city = p.city;
select * from s left join p on s.city = p.city where p.city is null;
	// without "is null" means that make all records about s.city = p.city like 3x3+2x2+3x3
    // but I gave left join so involving other leftover A records
    // if I add is null which means that 'Athen', record of A, has null columns about B, since 
    // it has nothing to do with B. so that query returns 'Athen'

(select * from p where weight < 19);
(select * from p where weight < 15);
select * from (select * from p where weight < 19) A 
join (select * from p where weight < 15) B on A.weight = B.weight;
	// A has {1,2,3,4,5} ele, B has {1,4,5} ele, {1}, {5} matches so 2x2 + 1x1 = 5 ele returns
    // and thats all about JOIN
select * from (select * from p where weight < 19) A 
left join (select * from p where weight < 15) B on A.weight = B.weight;
	// which involves leftover A records
select * from (select * from p where weight < 19) A 
left join (select * from p where weight < 15) B on A.weight = B.weight where B.weight is null;
	// "B.weight is null" finally makes {A - (AnB)} 
    
(select * from p where weight < 19);
(select * from p where weight < 15);
select * from (select * from p where weight < 19) A 
inner join (select * from p where weight < 15) B on A.pno = B.pno;
	//contrainted with primarykey which is 'pno' returns un-duplicated ele, that is inner join
*/
select * from s;
select * from p;
select * from sp;
select * from s, sp, p where s.sno=sp.sno and p.pno=sp.pno and p.pno='P2';
