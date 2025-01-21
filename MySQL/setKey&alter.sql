
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  CONSTRAINT PRIMARY KEY PK_usertbl_userID (userID)	//-- 키 이름 필요없으면 키 이름 생략가능
);

DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
(   userID  CHAR(8) NOT NULL, 
    name    VARCHAR(10) NOT NULL, 
    birthYear   INT NOT NULL
);
ALTER TABLE usertbl
     ADD CONSTRAINT PK_usertbl_userID 
		PRIMARY KEY (userID);//	-- 이미 만들어진 테이블을 수정하는거임 alter로


CREATE TABLE prodTbl
( prodCode CHAR(3) NOT NULL,
  prodID   CHAR(4)  NOT NULL,
  prodDate DATETIME  NOT NULL,
  prodCur  CHAR(10) NULL
);
ALTER TABLE prodTbl
	ADD CONSTRAINT PK_prodTbl_proCode_prodID 
		PRIMARY KEY (prodCode, prodID) ;// -- prodcode와 proID를 합쳐서 기본키를 만들자 

//table 안에   CONSTRAINT PK_prodTbl_proCode_prodID 
	//			PRIMARY KEY (prodCode, prodID)  넣어서 만들어도됨 
	
//fk 설정의 경우
CREATE TABLE buytbl 
(  num INT AUTO_INCREMENT NOT NULL PRIMARY KEY , 
   userID  CHAR(8) NOT NULL, 
   prodName CHAR(6) NOT NULL,
   CONSTRAINT FK_usertbl_buytbl FOREIGN KEY(userID) REFERENCES usertbl(userID)
);

// 위 혹은 아래로 설정가능 
DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl 
(  num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userID  CHAR(8) NOT NULL, 
   prodName CHAR(6) NOT NULL 
);
ALTER TABLE buytbl
    ADD CONSTRAINT FK_usertbl_buytbl 
    FOREIGN KEY (userID) 
    REFERENCES usertbl(userID); 
    
    
// 기본테이블에 없는 데이터를 외래테이블에서 fk를 갖고 데이터 추가할순 없음 
// 그럴떈 set foreign key를 0으로 만들고 추가후 다시 1로 바꿔주던지 해야함 


USE sqldb;
ALTER TABLE usertbl
	ADD homepage VARCHAR(30)  -- 열추가
		DEFAULT 'http://www.hanbit.co.kr' -- 디폴트값
		NULL; -- Null 허용함
select * from usertbl;

ALTER TABLE usertbl
	DROP COLUMN mobile1;	// -- 제약조건있으면 set foreign key 0으로 만들고해야함

ALTER TABLE usertbl
	CHANGE COLUMN name uName VARCHAR(20) NULL ;

ALTER TABLE usertbl
	DROP PRIMARY KEY; 

ALTER TABLE buytbl
	DROP FOREIGN KEY buytbl_ibfk_1;
	
// fk 설정되어있으면서 부모테이블의 기본키를 변경할순 없다 
// foreignkeycheck를 0으로 만들고해야함 (기본키 아닌건 drop column 같은거 가능함 
UPDATE usertbl SET userID = 'VVK' WHERE userID='BBK';
SET foreign_key_checks = 0;
UPDATE usertbl SET userID = 'VVK' WHERE userID='BBK';
SET foreign_key_checks = 1;

