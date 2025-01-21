
USE sqldb;
SELECT JSON_OBJECT('name', name, 'height', height) AS 'JSON ��'
	FROM usertbl 
    WHERE height >= 180;

SET @json='{ "usertbl" :
  [
	{"name":"�����","height":182},
	{"name":"�̽±�","height":182},
	{"name":"���ð�","height":186}
  ]
}' ;
SELECT JSON_VALID(@json) AS JSON_VALID;
SELECT JSON_SEARCH(@json, 'one', '���ð�') AS JSON_SEARCH;
SELECT JSON_EXTRACT(@json, '$.usertbl[2].name') AS JSON_EXTRACT;
SELECT JSON_INSERT(@json, '$.usertbl[0].mDate', '2009-09-09') AS JSON_INSERT;
SELECT JSON_REPLACE(@json, '$.usertbl[0].name', 'ȫ�浿') AS JSON_REPLACE;
SELECT JSON_REMOVE(@json, '$.usertbl[0]') AS JSON_REMOVE;


