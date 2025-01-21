SELECT * FROM newspaper 
  WHERE MATCH(article) AGAINST('영화');

SELECT * FROM newspaper 
  WHERE MATCH(article) AGAINST('영화 배우');

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('영화*' IN BOOLEAN MODE);

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('영화 배우' IN BOOLEAN MODE);

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('영화 배우 +공포' IN BOOLEAN MODE);

SELECT * FROM newspaper 
   WHERE MATCH(article) AGAINST('영화 배우 -남자' IN BOOLEAN MODE);
