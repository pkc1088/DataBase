
SELECT name, height FROM usertbl 
   WHERE height > (SELECT height FROM usertbl WHERE Name = '���ȣ');

SELECT name, height FROM usertbl 
   WHERE height >= (SELECT height FROM usertbl WHERE addr = '�泲');

SELECT name, height FROM usertbl 
   WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '�泲');

SELECT name, height FROM usertbl 
   WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '�泲');

SELECT name, height FROM usertbl 
   WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '�泲');
   
SELECT name, height FROM usertbl 
  WHERE height IN (SELECT height FROM usertbl WHERE addr = '�泲');

// =ANY(��������)�� IN(��������)�� ���� 
