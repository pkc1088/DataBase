SELECT userID, SUM(amount) FROM buytbl GROUP BY userID;

SELECT userID AS '����� ���̵�', SUM(amount) AS '�� ���� ����'   -- as �� alias��
   FROM buytbl GROUP BY userID;

SELECT userID AS '����� ���̵�', SUM(price*amount) AS '�� ���ž�'  
   FROM buytbl GROUP BY userID;
   
   SELECT userID, AVG(amount) AS '��� ���� ����' FROM buytbl  GROUP BY userID;
