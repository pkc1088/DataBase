import pymysql

conn, cur = None, None
data1, data2, data3, data4 = "","","",""
sql=""

conn=pymysql.connect(host='127.0.0.1',user='root',password='1234',db='pydb',charset='utf8')
cur=conn.cursor()
sql="create table if not exists userTable (id char(4), userName char(15), email char(20), birthYear int)"
cur.execute(sql)
while(True) :
    data1=input("����� ID ==> ")
    if data1 == "":
        break;
    data2=input("����� �̸� ==> ")
    data3=input("����� �̸��� ==> ")
    data4=input("����� ������� ==> ")
    sql="insert into userTable VALUES('"+data1+"','"+data2+"','"+data3+"',"+data4+")"
    cur.execute(sql)

conn.commit()
conn.close()

