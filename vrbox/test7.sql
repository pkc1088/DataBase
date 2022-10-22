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
select * from s join p on s.city = p.city;
select * from s left join p on s.city = p.city where p.city is null;
	// without "is null" means that makes all records about s.city = p.city like 3x3+2x2+3x3
    // but I gave left join so involving other leftover A records
    // if I add 'is null' which means that 'Athen', record of A, has null columns about B, since 
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
select * from p where exists(select*from s where p.city = s.city);
select * from p where p.city IN (select DISTINCT s.city from s);

#7.4 - 1
select * from s, sp, p where s.sno=sp.sno and p.pno=sp.pno and p.pno='P2';

#8.4 - 3
select * from s sx where exists( select * from sp spx where spx.sno = sx.sno and spx.pno = 'P3');

#8.4 - 4
select sx.sname from s sx where exists
	(select * from sp spx where sx.sno  = spx.sno and exists
		(select * from p px where px.pno = spx.pno and px.color = 'Red')
    );
select sx.sname from s sx where exists
	(select * from sp spx, p px where sx.sno = spx.sno and px.pno = spx.pno and px.color = 'Red');
    
#8.4 - 5
select sx.sname from s sx where exists (select * from sp spx, sp spy 
	where sx.sno = spx.sno and spx.pno = spy.pno and spy.sno = 'S2');

#8.4 - 6
select sx.sname from s sx where not exists(
	select * from p px where not exists(
		select * from sp spx where spx.sno = sx.sno and spx.pno = px.pno
    )
);   

#8.5 - 3
select spx.pno, sum(spx.qty) * px.weight as totalWeight from sp spx, p px 
	where px.pno = spx.pno group by spx.pno;

#8.5 - 4
select px.pno, sum(spx.qty) from p px, sp spx 
	where px.pno = spx.pno group by spx.pno;	#group by px.pno <- same

#8.5 - 6
select sx.sno, count(spx.pno) from s sx, sp spx where spx.sno = sx.sno group by sx.sno;

#8.6 - 4
select distinct s.city, p.city from s join sp join p on s.sno = sp.sno and sp.pno = p.pno;

#8.6 - 10
select DISTINCT s.sname from s 
	where s.sno IN(select sp.sno from sp where sp.pno = 'P2');

#8.6 - 11
select sx.sname from s sx where exists(
	select * from sp spx where sx.sno = spx.sno and exists (
		select * from p px where px.color = 'Red' and px.pno = spx.pno
    )
);
select distinct s.sname from s where s.sno in (
	select sp.sno from sp where sp.pno in (
		select p.pno from p where p.color = 'Red'
    )
);

select * from s;
select * from p;
select * from sp;
