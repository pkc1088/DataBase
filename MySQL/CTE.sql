WITH abc(userid, total)
AS
(SELECT userid, SUM(price*amount)  
  FROM buyTBL GROUP BY userid )
SELECT * FROM abc ORDER BY userid DESC ;
//-- abc�� �����ϴ� ���̺��� �ƴ� 
WITH cte_usertbl(addr, maxHeight)
AS
  ( SELECT addr, MAX(height) FROM usertbl GROUP BY addr)
SELECT AVG(maxHeight*1.0) AS '�� ������ �ְ�Ű�� ���' FROM cte_usertbl;

