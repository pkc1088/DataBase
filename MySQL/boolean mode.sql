SELECT * FROM newspaper 
  WHERE MATCH(article) AGAINST('��ȭ');

SELECT * FROM newspaper 
  WHERE MATCH(article) AGAINST('��ȭ ���');

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('��ȭ*' IN BOOLEAN MODE);

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('��ȭ ���' IN BOOLEAN MODE);

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('��ȭ ��� +����' IN BOOLEAN MODE);

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('��ȭ ��� -����' IN BOOLEAN MODE);
