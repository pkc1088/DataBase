
==Physical Device==
4. 용량이 두 배 늘면 처리 속도는 2배 이상일 수 있음-> scalability issue. main memory는 8byte씩 읽어옴 한번에ssd, hdd는 4kbyte씩 읽어옴
10. read는 빠르지만 write는 한번에 블록을 지우고 한번에 써야하기에 느리다 -> read와 write가 Asymmetric함
17. locality를 고려해서 메모리에 올림. 사용 될 확률이 높은 데이터를 한번에 미리 가져옴
    블록 단위로 읽어옴 -> clustering 이라고 함
18. 1000번의 시간이 실제로 걸리지 않고 Hit Ratio 덕분에 더 짧게 걸림
19. 10 바이트를 읽어오라고 하지만 실제로는 더 큰 바이트를 읽어옴 한번에 천바이트씩 읽으면 10번만 읽으면 완료. 디스크 에세스 (=블록 에세스)를 줄여야 좋음. 파일처리는 즉 블러처리 속도를 줄이는 방법을 공부
20. 블록 사이즈를 너무 크게 만들면 히트률은 높여도 블록 자체를 읽는 시간이 오래걸리고, 메모리가 너무 큰 블록을 처리할 용량이 안됨. 불필요한 데이터 읽을 확률도 있음.

==I/O driver and buffer==

2. secondary memory device에서 바로 app program에 올라가는게 아니라 read함수(io driver)로 buffer에 잠시 저장했다가 올려줌. buffer는 4k(블럭사이즈)의 정수배로 설정되는데 app이 읽을 때 secondary에서 쓸 수 있으니 속도가 높아짐.
7. *pinneed block* : 어떤 경우라도 현재 사용중인 블록이 교체되어 디스크로 내려가는 일이 발생해서는 안된다. 따라서 연산중인 블록에는 Pin을 꽂아 페이지가 교체되는 것을 방지하고, 연산이 끝나면 Unpin하여 교체대상이 될 수 있도록 한다. 즉, Pinned block은 버퍼에 있는 블록 중 디스크로 교체되면 안되는 블록이다.

==File Organization and OS support==

3. HDD에서 관리할때는 physical 주소(트랙, 실린더 몇 번에 위치)이지만 그 바로 위에 위치한  io drvier에서 부터는 logical한 주소로 맵핑 테이블을 통해 맵핑을 시킨다(몇 번지에 위치한다). io driver는 OS의 가장 하위계층임. 
4. read를 호출하면 file system은 이를 쉘 메세지로 만들어서 function call을 기다림. 그 후 디코딩 해서 해당되는 함수를 호출해 줌.
5. *FAT* : file allocation table
7. Attribute에 파일의 이름, 종류 등을 기록해 둠. special 파일은 저장할 수 있는 파일이 아니라 키보드, 모니터 처럼 특수한 용도. Directory 파일은 데이터를 저장하는게 아니라 위치 기록하는 파일. Permission : rwxrwxrwx 같은 내용. Ownership : 내 유저아이디와 파일의 owner가 같은지 비교.
8. 데이터 안에는 그 정보가 어디에 관한 데이터인지 들어있음. 이는 블록넘버로 제시됨. 피지컬 주소가 맵핑으로 블록으로서 논리적으로 어디에 위치하는지 i-node가 포맷해줌 (블록 몇 번지인지). 블록(4k)에 파일(10k)을 넣으려면 블록 3개를 사용해야하며 파일이  저장되어 있는 블록 주소를 먼저 넣어야함 (블록에 대한 포인터). 즉 파일에 해당되는 i-node를 먼저 찾아가면 이 데이터가 어떤 블록에 저장되어있는지 알려줌. 블록의 전체 크기보다 파일이 더 큰게 들어오면 indirect block을 준비하고 그 블록 안에는 블록 주소만이 들어감 데이터는 넣지 않음. 주소하나 넣어놓는게 4byte라고 치면 그 블록에는 1000개가 들어감. 이 블록을 통해 4k * 1000의 파일을 저장가능(4MB * 10 개). 파일이 더 큰 용량 차지하면 indirect를 연쇄적으로 연결해 놓음 (40MB * 1000개 ). 
9. zone_nr에 이 블록이 indirect냐 double indirect(두 번 연쇄 포인터)인지 아니면 실제 데이터를 저장하고 있는 블록인지 나타냄. 프로세스마다 i-node 테이블이 만들어짐. 
10. 앞 두 블록은 os가 사용하는 용이므로 비워두고 그 다음부터 한 블록에 i-node를 40개 씩 넣을 수 있게 함. 한 i-node는 보통 100바이트. 파일 하나는 i-node 한 개에 대응됨. 그 후 실제 데이터를 넣을 수 있는 data block을 배치. 
11. */usr/lik/data.txt (오류)*. 저 명령어는 첫 '/'에 의해 루트에 해당되는 i-node를 읽음. 이 루트는 제일 첫 i-node에 넣음. 루트는 디렉토리 파일이기에 하위 파일 및 디렉토리의 정보를 갖고 있임. 즉 하위 파일 및 디렉토리의 i-node를 갖고 있는 것. 왼측의 숫자들은 i-node 숫자이다. 첫 칸은 current, 둘 째 칸은 parent 디렉토리인데 루트는 둘 다 자기자신이니 1임. bin은 i-node가 4라는 뜻. 그래서 명령어 usr을 통해 6번 i-node를 본다. 그 아이노드는 2번 블록에 해당되는 i-node에 위치(10pge)해 있을 것이고 그 안에  lik을 읽는데 이것도 디렉터리 타입임으로 i-node 따라 들어가면 마지막에 data.txt를 뜯어보면 이는 data 블록임으로 진짜 데이터가 있음. 마지막 그 블록이 몇 번째에 시작하는지, 읽는 중이라면 어디까지 읽었는지를 프로세스에 기록을 해둬야함. 이는 open file table에 의해서 관리됨. 즉 파일 하나 열었으면 어디까지 열었는지에 대한 정보를 기록해둠. fd는 int타입의 file descripter이며 테이블 번호를 입력받음. 
12. 그래서 read에 그 fd 값을 주면 그 번호에 맞는 데이터를 읽어오는 거임. 

- Boot block은 os가 어디에 위치해 있는지에 대한 정보를 갖고 있음. 그 포인터를 통해 os를 메인메모리에 로딩해서 시작됨. 이 Boot block으로 뛰게 해주는게 bootstrap이며 이는 bios가 최초로 처리해줌. 
- 즉 bios가 부팅디스크로 점프하도록 만듦. 그 디스크 안에 Boot block이 있고 이가 os를 실행하도록 하는거임. 
- 디폴트로 열어놓는 파일 (1번 input, 2번 output, 3번 error).

----

20. variable length 되는 이유 : 레코드 개수가 다름 -> fixed로 고쳐서 하면 편하나 storage 활용도 떨어짐 (reserved space). 
21. overflow block에 대해서는 overflow block에 대한 포인터를 설정해서 overflow area를 처리함.
22. 레코드 하나의 필드가 블록보다 커지는 경우를 *BLOB* 이라함 (이미지 파일 등). 이땐 이미지 자체를 저장하는게 아니라 이미지는 다른곳에 두고 그 파일의 이름을 집어넣으면 됨 (간단한 방법). 파란색처럼 따로 공간을 마련해놓고 포인터로 연결시킴 (일반적).   


==Index and Hash==

2. *Index*  : 블럭 넘버를 알려주어 메모리에 올린 후 빠르게 읽히게 해줌 (전체를 linear scan 할 필요 없음). 
3. 1단계 : 레코드 조건에 맞는 블록 조사. 2단계 : 찾아 읽음. 2단계 걸리는 시간은 읽어와야할 데이터 양에 비례함 (clustering으로 비슷한 데이터를 묶어놓는 방법으로 대안이 있음 -> attribute가 너무 많아지면 차원이 너무 커짐 (curse of dimension)). 결국 첫번째 단계 개선이 index와 hash의 목적임.
4. B_f률이 높을 수록 좋음(number of records / number of blocks). linear scan을 위한게 n / B_f이므로. Hash - 몇 번 디스크에 저장되어 있는지 알려줌
5. 일반 data file(messedup file)과 index file을 리니어스캔할 때의 차이는 B_f에서 큰 차이를 보임. B_f가 커지기에 disk access를 줄일 수 있음. sorting 시에도 이득을 봄. index file은 attribute에 해당하는 column의 개수 만큼 만들 수 있음. index file은 업데이트 할 때 그 인덱스 파일 개수만큼 여러번 업데이트 해주어야함 (data file은 한번만 해도 되지만). index는 아무대나 저장해놓고 그 저장된 위치를 인덱스 테이블에 써줌 (저장 위치가 안 중요). 해쉬는 저장하는 위치와 찾는 위치를 동일하게 함 (해쉬 펑션으로 나온 값에다 저장해야함) - primary index라 함.  primary index는 내가 어디에 저장할지 결정함. index는 secondary index로 봄. 
7. 테이블을 메모리에 집어 넣기엔 너무 크고 바이너리 트리안에 집어 넣기에도 파일 사이즈가 너무 커질 수 있음. 정렬 정도에 따라 search time이 커질 수 있음. 
8. 그래서 디스크에 집어넣음. 하나의 노드 크기는 - 맨 앞 4byte(노드 몇개 들어있는지 등 정보) + 뒤에 블록(4)에 브랜치 m개(포인터) 있다 가정하면 4 * m + 브랜치가 m개라는 건 element들은 m-1개 있음 그래서 블록(4) + 데이터(4)가 m-1개이니 8 * (m-1). 즉 4+4m+8(m-1) = 12m - 4가 하나의 노드 크기임. 이 값이 하나의 디스크 페이지(블록) 크기에 맞춰주는게 좋음. 12m - 4 = 4096 -> m = 360. 즉, 하나의 노드가 하나의 디스크 페이지가 되고 브랜치는 최대 360개 갖고 있다는 뜻.  이렇게 하면 height를 줄일 수 있음. 블록을 height 만큼만 찾으면 다 찾을 수 있다. 
9. m-way 탐색트리에서는 서치타임이 log_m(N)이 된다. 근데 편향되면 보장이 안됨. 이를 해결하는게 B-tree이다.
10. 새로운 노드를 리프에다 붙이는게 아니라 노드들을 반으로 갈라서 저장함. 이때 가운데 값을 위로 올림 (upward split). 이렇게하면 depth가 증가하지 않음. 근데 위에도 오버플로우 일어나고 그 위위 루트 노드도 오버플로우되면 depth 증가되긴함.  
11. 첫 그림에서 10, 20 있을 때 브릿지는 3개 있는 거임 (브릿지 벡터가 3). 여기서 30이 인서트되면 브릿지가 4개되니 오버플로우 됨 (m = 3으로 유지한다 했을 때). 
12. 마지막 구조에서 storage utilization은 0.5임. 이건 m이 3일때 이야기. S.U이 제일 떨어지는 순간은 split된 직후이다 (반은 놀고 있으니). 그래서 depth 따질 땐 제일 적게 채워진 n/2이 depth가 됨. 그래서 depth는 대략 log_m/2(n)이 되는 듯?
14. 노드에는 데이터만 있는게 아니라 그 숫자에 해당하는 블록번호도 있는거임. 
16. range로 서치하면 밑에 까지 갔다가 다시 위로 가면서 읽어들여야 하는데 노드들은 각각 별도의 블록으로 되어 있기에 읽은 후 다시 접근할때 메모리에 존재 하지 않을 수 있음 -> 다시 메모리로 읽어들여야하는 불상사 -> B+ Tree 사용. 
17. 모든 값들이 리프노드에 저장되어 있고 리프들 끼리 링크로 연결되어 있음. 즉 인터널 노드들을 중복헤서 리프에 한 번 더 저장함. 
20. 최소 bf = max bf / 2이고 n/(max bf/2) 가 리프노드를 blocking factor의 개수. 그 위 노드는 n/(max bf/2)^2 만큼 차있을 수 있음. 리프노드로 2 * (max bf / 2)^d  = n / (max bf / 2) 로 d(depth)를 구할 수 있다. 그게 d = log_m/2(n) 나옴. 식에서 m은 평균으로 잡음. max bf / 2는 최소로 잡은거임. (상수는 다 제외한 식이라 정확하게 알 필요는 없는 듯) . 뎁스 키워야 worst case 되는데 그러기 위해선 branch factor가 적어야하고 이게 max bf / 2 일 때임. nq는 query를 만족하는 객체의 개수. 그걸 blocking factor로 나누면 저 조건을 만족하는 블록 개수(리프노드)를 알 수 있음. 
- B+ tree 단점 : 필요한 데이터를 찾을때 한곳에 모여있지 않을 수가 있음 -> Hash의 primary key가 개선할 수 있음.


- 과제 : 바이너리 파일을 블럭에 집어넣기. 블록단위로 쪼개서 바이너리로 집어넣음. usigned int, float는 4바이트, char 도 계산해서 write함. 겹치지 말라는건 배율로 구조체 패딩주는거 말하는 듯. (2)에 id 포인터아니고 그냥 unsigned int로 수정. 빈칸생기면 다음 인서트가 거기에 들어갈 수 있게 하기 (append만 무한정 x). (4)번에 delete함수명은 마지막 e자 뺀다. 바이너리 파일을 읽기위한 read, write, lseek (c 기준), C++은 stream같은게 있음. 딜리트 된 곳에 데이터 저장하면 그 위치로 배정되는거임 (호출 요청받을 때). (1)에 year 파라미터 없애기. read write lseek도 가능은 한 듯

==Hash==

3. primary index : 어디서 데이터를 불러오고 어디에 저장하는지 둘 다 결정. 
4. hashfunction은 균일하게 분포되어 있어야 함(randomness). v1 != v2 <-> hash(v1) != hash(v2) 만족해야함. 
5. 해시펑션으로 나온값을 모듈러로 나눠줌
6. 한 쪽 블록에 집중적으로 많이 나올 경우가 생김. 
7. 그런 블록들에서 오버플로우 생기면 링크드 리스트로 연결된 다음 블록으로 전달 함 -> 효율 안 좋음.
10. 그걸 해결하기 위해 dynamic hash 사용. 프라이머리 인덱스 사용. 그 프라이머리 키에 의해 블록 결정되고 그 내부 블록은 B+ tree사용하는게 일반적인 dbms임. 원리 - 키를 펑션에 넣으면 해시값이 나오고 이걸 바이너리로 처리. 해시값으로 b0~b3가 나오면 블록 51번에 4개 저장함. 만약 추가적인 해시값 저장해야한다면 두 개로 나눠야 하는데. 기존 해시값들의 마지막 비트값(비트 31번)들이 0인지 1인지 보고 0인 애들과 1인 애들을 따로 모음. 0인 애들은 블록 51에 저장, 1인 애들은 또 다른 블록 52를 만들어서 저장. 테이블 상으로는 0인 애들은 b51을 가리키고, 1인 애들은 b52를 가리키는 인덱스에 저장 저장. 해시-테이블-블록(버켓) 구조임. 만약 1인 애들을 스플릿 해야한다면 01과 11로 또 스플릿 가능. 10의 경우 0이 아직 오버플로우 안 일어났으니 그대로 b51을 담고 있으면 됨. 이런식으로 미리 블록을 준비할 필요 없고 동적으로 확장가능. 해시는 레인지 서치에는 비효율적. exact mathc에 유리하니 키값으로 컨트롤하는게 좋음. B+ tree는 최소한 뎁스만큼 블록 어세스 시간 필요한데 dynamic hash는 수학 식으로 위치를 조사하기에 블록 어세스 시간이 필요하지 않거나 최대 1번만에 수행 가능함. 
12. prefix에 현재 몇 비트까지 쓰고 있는지는 표시해줌. 

==Multi-dimensional Index==

2. B+트리에서 처음부터 찾고 싶으면 제일 left로 가서 리니어 스캔함. -> 여러 조건이 걸린경우 depth 만큼 매번 내려가야하는 비효율 있음 -> multi diemnsional 나옴.
5. 두 어트리뷰트를 위해 2차원 인덱스를 만들어봄. 
6. 같은 간격으로 쪼개서 그리드로서 저장함. 각 그리드는 각 블록에 저장시킴. 이는 primary index적인 효과도 가짐.  또 비슷한 조건들이 비슷한 위치에 존재하게 됨 (clustering 효과). 이를 fixed grid라 함. 블록에는 물론 블록 주소도 들어 있음. 트리 안보고도 두 개 이상의 어트리뷰트를 효율적으로 알아낼 수 있다. 단, 어트리뷰트의 특정 구간에 너무 데이터가 집중되어있어서 하나의 블록 안에 저장하기엔 너무 클 수도 있음. 반대로 어떤 곳은 너무 널널함. 그래서 그리드 짜르는 간격을 가변적으로 설정함. 
7. 간격이 다르다는걸 알 수 있음. 각 데이터의 x, y좌표도 디렉토리 테이블(그리드 파일)에 저장해야함. 필요시 옆에 애들이랑 합해줄 수도 있음. Dead space : query의 빈 공간(불필요하게 데이터 읽어오는 공간), 
8. query는 5개의 블록이랑 겹침. 근데 데이터 없으니 헛수고.
9. 1개의 블록만 읽으면 됨 (여전히 dead space이지만). 
11. MBR을 계층적으로 만듦. 제일 큰게 루트 박스, 그 밑에 중간 사이즈 박스 딸려있고 등등 구조. query들어오면 루트에서 부터 겹쳐지는 애들 찾아 내려감. 그래서 가지 않아도 될 블록에는 안가게됨. 
12. 쪼개는 방법. 스플릿되면 그 그룹이 하나의 노드가 됨. B, B+트리가 스플릿후 노드 상위로 올리듯이 Rtree도 위로 올림. x축과 y축으로 짜르되 스플릿되어 새로 생기는 공간이 좁은게 더 좋다 dead space를 줄일 수 있으니. 
13. mdr 범위 좁으니까 B+ tree보다 데이터를 스캔하는 속도가 더 빠르다고 할 수 있음. 만약 50:50이 아니라 Bad Split 케이스를 7:3으로 짜르면 나아질 수 있다. (비율은 mdr 박스 내 데이터 포함 수). 
14. 넘어감


==Query Processing==

4. project는 원래 테이블에 영향 주지 않는 듯
6. join은 A와 B를 카티션프로덕트 한 것에 조건을 걸어서 추출함. 
7. rekational algebra를 적용하면 실행되는 순서가 결정됨. 그 후 조인 후 프로젝트 함.
   pie_studentName(select_student(student x professor)) 이런 방식으로 조인 먼저하고 셀렉션 후 셀렉션 해도 됨. 슬라이드 식 처럼 3.5가 아니라 4.49라고 하면 거의 0이 되기에 0 join Professor 하면 0나옴 -> 4.49 대상으론 위 방식이 좋음. B+ tree나 Hash가 있으면 join 할 떄 빠름. 부하가 얼마나 걸리는지에 따라 DBMS가 결정함. 
9. 넘어감
10. 오퍼레이터에 따라도 다르고 데이터의 분포에 따라도 다르기에 그런걸 고려해서 cost를 계산해야함. 
10. 이후 넘어감
16. Select operation의 경우 : 인덱스(score > 3.5)가 있으면 풀 스캔 안해도 됨. 말단 노드가 Nq개 일 때, B+tree의 depth + Nq/Blocking factors(맨 밑옆에서 옆으로 이동하는 시간)  + Nq(해당 블럭 읽음) 만큼 시간 걸림. 
19. ~넘어감.


----
----


==Transaction Management==
2. transaction은 read가 아닌 write(update)일 때 발생.
3. 파일이 쓰다가 최종반영 안되어 깨지는 경우를 inconsistent state라 함 (예약만 걸어놓고 자리 확정이 안된 상태 등). 아토믹한 오퍼레이션의 집합을 Transaction이라 함. All or nothing과 isolation이 보장되어야 함. isolation은 두 개의 transaction이 들어갔을 때 서로가 서로에게 영향을 주지 않아 함 (독립적). 
4. consistency : 좌석확정과 돈 지불 여부가 일치해야함. 
5. isolation : 트랜잭션들이 여러개 들어와도 서로 독립적으로 수행되도록해 영향 안끼치게 함. ACID가 만족되는 여러 오퍼레이션의 집합이 트렌잭션이다.
6. 넘어감.
7. 하나가 완전히 수행된 후 다른게 수행 : serial. 이 예시에선 concurrent도 올바르게 수행되긴 함 (이렇게 serial하게 수행한 것과 결과가 같은 concurrent를 serializable이라 함). 즉 serializability를 만족하는 concurrent tranjaction을 만들어주는게 중요. 
8. deadlock, concurrent tranjaction(동시에 여러개가 접근할 때) 상황에서 tranjaction의 fail로 이어질 수 있다(ACID의 속성을 깨트린다). deadlock의 경우 둘 중 하나의 트랜젝션을 kill하고 얘를 recovery해줌. concurrent 문제의 경우 동시성 제어로 해결함. T1과 T2를 concurrent하게 돌렸을 때 T2->T1 or T1->T2의 값 중 하나와 일치하면 serializable이라 함. 만약 T1의 read(B)가 T2 일어나기 전에 일어났으면 serializable 깨지게 됨. 
12. read후에 일어난 write, write 후 read 혹은 write 후 write는 서로 영향을 주기에 affect라 함. 첫 그림에서 r(a)-w(a)와 r(b)-w(b) 조합 세트를 순서를 바꿔도 serializable 함. S2처럼 사이클이 생기면 순서를 바꿀 수 없음. 
13. 그래서 사이클 프리되도록 트랜젝션을 만들어줘야 serializable하게 됨. 
14. 트랜잭션마다 timestamp를 달아놔서 시간을 보고 사이클이 생기는지 체크함.
15. two phase locking : 사이클이 생길것같으면 일단 대기(lock)시키고 다른 애 먼저 수행한 뒤 수행되게 함(unlock). semaphore 이용함. X lock : write에 대한 lock임 -> read와 write 모두 수행 불가. S lock : read는 괜찮고 write는 lock 시킴. 
16. unlock을 언제 해줘야 하느냐가 문제임. lock은 당연히 read나 write 이전에 하면 됨. 
17. T2가 아니라 T1이다 (오타). xlock(a) write(a) xunlock(a) xlock(b) write(b) xunlock(b) 가 T2이다. 이건 안되는 예시인듯
18. 되는 예시임. sunlock(a)를 slock(b) 다음에 해줌. SL(a)가 들어올때 이미 XL(a)가 걸려있기에 기다려야함 UL(a)가 나올때 까지. SL(B)도 XL(B)가 이미 걸려있기에 UL(B)다음에 올 수 있음. 이런 방식으로 serializable하게 만듦. 그래서 실제 r(A)는 그림 상 보다 뒤인 UL(A) 다음에 실행됨. 그럼 최종적으로 w(a)->r(a)  , w(b)->r(b) 방향의 화살표가 생김으로 사이클이 없어짐. 모든 락을 다 걸어준 다음에 풀어주는 방식을 쓴다 (2-phase lock : 첫 단계는 락을 걸어주기만 하고 두번째 단계에서는 read or write 이후 풀기만 한다). 
20. 17페이지의 경우임. 안되는 예시. SL(B)가 XL(B)보다 먼저 발생한다는 그림으로 이해하면 됨. w(a)->r(a)  , r(b)->w(b)가 되면서 사이클 생김.
22. slock 다음에 sunlock안해주고 바로 xlock 가능 (lock upgrading이라 함). 
23. ~24 넘어감.
25. 락 단위는 보통 블록단위임. 락 범위 작아질수록 동시성 좋아짐. 레코드 단위도 가능(락 걸고 푸는 것 자체의 오버헤드가 발생하긴 함).
26. slb xla rb ula xlb sla ula ulb ra wb ula ulb 이런 형태이면 deadlock conflict graph가 되는듯. 서로가 서로를 기다리게 됨. T1(rb) - T2(wa) - T1(ra) - T2(wb) 구조임. 데드락 해결하는 방법은 하나의 트렌잭션을 죽이는데 가장 데미지가 적은 트랜젝션 (시작한지 얼마안된 것)을 고른다. 
27. 트리 전체에 락을 거는게 아니라 A와 그 자식인 B한테까지만 걸어주는 듯. 그 후 풀어줄 때는 B는 걸어논 상태에서 A를 풀어줌 -> 항상 한 쌍씩 락을 걸어준다
28. w-timestamp : 제일 마지막에 write 된 시간. 
29. read를 할때 내 timestamp와 마지막으로 write한 TS를 비교함. 만약 내 TS가 먼저 일어났다면(T1(TS) - T2(Wts) - T1(Read)), 아예 이 트랜젝션을 죽이고 read 시점부터 다시 트랜젝션을 시작해서 안전하게 만듦(Ts와 Wts 사이에 일종의 dependency가 있었을 수도 있으니). 즉 트랜젝션을 시작하고 내가 읽을려고 하는데 이미 write 활동이 있었다면 다시 시작하는게 안전하다는 거임. 
30. write 오퍼레이션 만났을때 read TS가 먼저 수행됐는지 확인. write에 대해서도 동일인듯. 문제 생길때 마다 롤백해서 효율이 떨어져 보이나 트랜젝션 간 충돌이 일어날 확률은 크지 않음. 트랜젝션 수행되는 시간이 길지 않기 때문. 
31. 장점은 락을 시키는게 아니기에 사이클이 발생하지 않으므로 데드락이 안 생김. 
32. restart하는 오버헤드 있긴 함. 롤백 비용 + 리스타트 비용이 데드락 디텍션하는 two phase lock의 비용보다 크다. 이때 데드락을 detection은 항시 데몬으로 존재하기에 전자와 달리 확률을 따질 필요 없음. *두 트랜젝션 컨트롤 장단점 시험*
33. long duration이라 undo의 비용이 증가. 롱텀이라 트랜젝션 간 겹치는 부분이 잦게 발생되어 계속 리스타트 해야해서 concurrent가 아니라 serial하게 되어버릴 수 있음. nested tranjaction으로 해결할 수 있음. serializability가 아니라도 consistency가 꺠지지 않는 경우가 있음. 그걸 semantic consistency라 함 (무조건 serializability를 유지해야함은 아님을 의미하긴 함). approach 파트는 대충 알아만 두면 됨. 
36. fail 일어나기 전 항상 점검해야하는 일, fail 일어났을 떄 수행하는 일. 
37. 트렌잭션 각 오퍼레이션을 모두 log 기록. fail 발생하면 log data를 봐서 reovery함. 이떄 이 log 파일은 stable storage라는 이론상으로 절대적으로 안전한 저장소에 저장된다고 취급함. 
40. read오퍼레이션에 대해서는 log가 필요 없음. 복구할게 없으니. write만 고려함. 로그파일이 쌓이면 굉장히 커지는데 리커버리할때 그 로그파일의 위치를 알 수 있도록 인덱스가 필요함. 로그를 몰아서 한번에 업데이트해주는걸 deferred임. 한번에 해주는게 immediate. 로그파일이 몰아서 늦게 반영되니까 deferred보단 immediate가 최신화에 유리. fail이 일어날 경우 immediate는 즉시 반영되었으므로 리커버리에 불리하고(오버헤드) deferred는 기다린 상태에서 실패하기에 애초에 반영이 안되어있으니 다른 작업 필요하지 않음.
41. V: 새 값. 되돌릴 필요 없으니 올드 값 필요 없음. T commit을 만나면 모아뒀던 로그를 한번에 반영시킴. 
42. 커밋 안된건 지워버리면 됨. 커밋된건 한번더 커밋해줌. (redo) 
43. C 초기값 700인데 100 빼져서 600 됐다는 뜻. (a)의 경우 commit 안 일어났으니 fail 일어나도 그냥 다 지워버리면 그만. (b)에서 C에 대해서는 commit 안일어났으니 상관없고. commit가 일어난 T0에 대해 한 번 더 commit을 해줌(commit이 안될을 경우를 대비하는거인듯). (C)의 경우도 commit이 둘 다 일어났지만 crash 일어나면 안됐을 수도 있으니 T0, T1 둘 다 한번씩 commit 더 해주는듯 (확실하게 해주려고). 
45. immediate는 올드 값, 뉴값 둘 다 가짐. 문제 생기면 되돌려야하는 값을 알아야하니. (a)는 fail일어나면 T0 A, B에 대해서 undo를 해줘야함(950 -> 1000). (b)는 T0는 redo해서 확인사살해주고 T1은 안 끝났으니 undo(600 -> 700). (c)는 둘 다 커밋 됐으니 둘 다 redo 해서 확인해주면 됨. 
46. redo 작업은 같은 작업을 여러번 반복해주는거임 idempotent라함. 증감 같은건 redo할 수 없음. 
47. 로그파일이 너무 커지니 중간에 체크포인터를 주기적으로 설정. 이 체크포인트로 일정 조건 만족하는 오퍼레이션은 없애버림. 
48. 체크포인트 이전에 커밋된 애들은 롤백 세그먼트에서 다 지움. 그래서 체크포인트 이후만 보면됨. 만약 system failure 만나도 쳌포인트 이전에 커밋 끝난 T1은 고려 안함. 체크포인트 잦으면 오버헤드 줄어드는 효과있음. 
49. 업데이트할 때 현 페이지를 카피한 new page에 업데이트를 하고 완료되면 이걸 쓰고 fail 일어나면 기존 old page를 사용.  

==Distributed DB - Overall== 
- 과제 : 3번 score는 min~max 값 range search. 함수이름 searchByScore임, 오타.
- 사용예에서 for문은 searchByID(&name, ID[i], ~) 임

3. cost(scalability)(큰 서버 하나 만드는 것 보다 작은 것 여러개가 유리), performance(병렬처리가능), reliability(백업 가능), accessiblility(availiability)(여러 곳에 있으니 접근성, 가용성 좋음) 면에서 centralized 보다 분산 시스템이 좋다. 
4. distrivuted system은 각각의 DB에 대해 os를 하나씩 갖고 있고(autonomous) 그 위에 global sysytem을 관리하는 global용 os가 있음 그리고 메모리가 공유되진 않음. parallel system은 os가 1개이고 메모리가 공유됨. 물음표 위치에 데이터 딕셔너리가 쌓인 카탈로그를 갖고 있어서 쿼리가 날라오면 적절한 위치로 배분해줌 (coordinator 혹은 미들웨어라함). 
7. 노드를 늘려도 성능향상이 어느정도부터 더 좋아지지 않는 이유 : write하는 행위에서 cost 발생하는데, 노드들 중 가장 늦게 write 처리한 시간으로 취급해야하며 추가적으로 tranjaction control 및 동기화 문제가 있기에 노드들을 늘리기만 한다고 linear 하게 speedup 하지는 않음. 또 시스템이 늘어나면 crash 발생할 확률도 커짐. 
10. middle ware가 한 쪽 DB 시스템에 과한 load 가 발생했을 시 balancing해줌 (Dyanmic하게 동작).
11. a방식은 클라이언트가 모든 내용을 restful로 서버에 보내버려서 서버에 부담이 생김. 반대로 e는 클라이언트가 모든 프로세싱을 다하고 서버는 db의 일부만 갖고 있도록 하는 역할만 함. a가 클라우딩컴퓨팅, e가 edging computing. 그 연장선이 p2p인듯
12. 클라우딩은 서버사이드에 모든걸 집어넣고 유저는 브라우저만 갖고 있음.
15. 데이터 중복시키는 방법(일부 사이트에는 일부db만 저장하기도 함)
16. consistency를 꺠드리는 것 : tranjaction에서 atomic을 꺠뜨리거나 concurrency 문제가 발생할 때임. 
- tranjaction manager가 coordinator가 돼서 요청된 쿼리에 필요한 사이트의 lock을 포괄적으로 관리해줌 (lock management).
17. snapshot replication은 deffered update와 비슷. near real-time replication은 다른 사이트들에도 즉각 업데이트 처리. 위 두 방식은 push protocol임(다른 사이트에 업데이트하라고 명령함). pull replication은 pull protocol으로서 로컬 사이트들이 요청을 함. 
18. 레코드 단위로 파티션,
20. lossless decomposition이 되도록 테이블을 쪼갬. 이때 쪼개진 테이블들의 키가 오버랩 되도록 쪼갬. 
22. 블록 단위로 replication 시킴.  raid 0 : reliable 하지 않음(redundancy가 없음). raid 1 : 블록을 적절하게 중복시킴 (parity block은 안 씀). raid5 : parity block 사용, 블록을 여러개로 쪼개서 여러곳에 저장. 


==Distributed Systems - Distributed Transactions==
18. T2가 T3의 리소스를 기다린다는 뜻 (site S1). global은 모든 wait-for 그래프를 갖고 있음. 그림의 글로벌은 사이클 생겨서 데드락 생김. 
19. T1은 T2의 락이 풀리길 기다림 (S1). 분산환경에서는 릴리즈가 된 상황을 글로벌한테 메세지를 보낼때 늦게 가고 다른 쪽으로도 연결을 시키면 글로벌 입장에서는 싸이클이 생겼다고 판단해서 하나를 죽일 수가 있음(false cycle). 그래서 락을 풀고 연결할때 코디네이터한테 잘 말해줘야함.
22. lease : 일정한 시간만큼 락 걸어주고 풀어줌 -> 사이클이 생기는지 체크할 필요가 없음. 
24. site의 시간과 내 시간을 합쳐서 클락을 만들어줌. 메세지를 보낸 시간 t1A는 메세지를 받은 t1B보다 작아야함 만약 그 반대라면 t1B = t1A + 1로 조정을 해줌. 이런 과정으로 글로벌하게 클락들을 주기적으로 수정해줌.  
26. 분산환경에서 크리티컬섹션을 처리를 관장함. 기존방식은 세마포어 관리하는 코디네이터를 사용했지만 이 방식은
27. 크리티컬섹션에 들어가겠다고 0번이 1과 2에게 자신의 타임스탬프를 보냈는데 1번은 크리티컬과 노상관이라 ok 사인 보내고 2번은 얘도 크리티컬에 들어가겠다고 메세지를 보냄(이때 0은 타임스탬프8이고 2는 12라 0번이 더 빠름). 0번의 타임스탬프가 더 빠르니까 2번은 ok 해줘야함. 그러면 0번은 ok를 모두에게 받았으니 크리티컬섹션에 들어갈수있음(b). 0번이 끝나면 2번이 들어감(c). 앞페이지 방식은 코디네이터와만 통신하면되는데 이건 모든 놈한테 메세지 보내야함(이떄 시스템들 중 하나가 크래시 일어나 ok 못 주면 0번은 계속 블럭된채 있어야함). 
28. 토큰을 갖고있어야 영역에 접근할수있고 토큰은 링을 만들어서 하나가 다음애한테 넘겨줌. 한번 링을돌때 걸리는 시간이 10초라고 할 때 10초만에 토큰이 안 오면 복구하는 시스템으로 이전 방법의 단점을 극복함. *token ring*
29. 이전 방식에서 만약 코디네이터가 죽었을때 다음 코디네이터를 찾는 방식, 각 노드에 번호 지정, 4번 노드가 코디네이터(7번)가 죽었다는걸 인지하고 4번보다 높은 번호에 다음 코디네이터가 되어달라고 메세지보냄. ok받으면 4번은 역할 끝남. 이제 5번도 election해야한다고 높은 번호들에 메세지보냄. 6번도 같은 방식으로 보냄. ok 받을 사람없음. 그럼 이제 6번이 코디네이터가 됨을 선언함. 홉은 한번 메세지 넘기는것, 홉카운트 : n/2 * 2 =  n. *Bully algorithm*
30. 3번이 코디네이터(1번)의 죽음을 발견함. 3번이 자기가 코디네이터 되겠다고 elect보냄. 4번은 그 메세지받고 elect(3,4)로 5한테 보냄. 이렇게 한바퀴 쭉 돌고나면 3번은 (3,4,5,7,8,2) 받는데 가장 앞쪽 메세지가 3이 본인이니까 당선된걸 알게됨. 이제 당선됨을 확정한다고 elected(3)을 쭉 보냄. 이떄 6번은 no response라 그냥 스킵함. 홉카운트 : 2n. *Ring algorithm*

==Distributed Systems - Massively Distributed Systems==
34. 서버나 코디네이터가 하나도 없이 시스템들끼리만 통신하는것 : p2p, sensor network, broadcasting(서버가 전혀 없진 않음). 그러기 위해선 모든 노드는 데이터의 일부분만 지니고있음.
35. 전파를 날리면 전파의 커버리지에 있는 애들끼리 라우팅돼서 메세지 전달됨. 
36. 노드의 ip가 다 저장되어있음(infra structure 구축되어있음). 
40. 센트럴서버없는 n개 노드들은 hash table을 갖고있음. hash로 randomize함.
42. log_2(n)만큼의 홉카운트 안에 원하는 데이터를 찾을 수 있음. 테이블을 보고 원하는 데이터를 알만한 노드로 점프하는 행위를 반복하며 최종적으로 운하는 데이터를 찾음. 이런식으로 serverless 시킨거임. 




- Consensus Protocol
- 합의 프로토콜은 분산 시스템에서 여러 노드가 하나의 값에 대해 동의하도록 하는 프로토콜입니다. 이는 특히 복제된 상태 머신, 블록체인, 분산 데이터베이스 등에서 중요합니다. 가장 널리 알려진 합의 프로토콜은 Paxos와 Raft입니다.
- Paxos
- Paxos는 분산 시스템에서 합의를 달성하기 위한 알고리즘으로, 여러 변형이 존재합니다. 기본 Paxos 알고리즘은 다음과 같은 단계로 구성됩니다:
- **Proposer**는 제안된 값을 선택하고, 그 값을 다른 노드에 제안합니다.
- **Acceptor**는 제안을 받아들이거나 거부합니다. 다수의 Acceptor가 제안을 받아들이면 제안된 값이 선택됩니다.
- **Learner**는 최종 선택된 값을 학습합니다.
- Paxos는 안전성을 보장하지만, 합의에 도달하는 데 시간이 오래 걸릴 수 있습니다.
 - Raft
- Raft는 Paxos보다 이해하고 구현하기 쉽게 설계된 합의 알고리즘입니다. Raft는 리더 기반 합의 알고리즘으로 다음과 같은 단계로 구성됩니다:
- **Leader Election**: 하나의 리더가 선출되고, 다른 노드는 Follower가 됩니다.
- **Log Replication**: 리더는 클라이언트의 요청을 로그에 기록하고, 이를 다른 Follower에게 복제합니다.
- **Safety**: 다수의 Follower가 로그 항목을 커밋하면 해당 항목이 확정됩니다.
- Raft는 이해하기 쉽고 구현하기 쉬운 구조로 설계되었으며, 실제 시스템에서 많이 사용됩니다.
- **장점**: 네트워크 분할이나 노드 장애에 대해 견고합니다. Paxos와 비교하여 Raft는 이해하기 쉽고 구현하기 쉽습니다.
- **단점**: 복잡한 분산 환경에서 지연이 발생할 수 있습니다. Paxos는 이론 적으로는 안전하지만, 구현이 어렵고 성능 문제가 발생할 수 있습니다.
- 결론- **Consensus Protocol**은 분산 시스템에서 여러 노드가 하나의 값에 대해 합의할 수 있도록 설계되었으며, Paxos와 Raft가 대표적인 예입니다. 이 프로토콜은 네트워크 분할이나 노드 장애에 대해 견고하며, 특히 Raft는 이해하기 쉽고 구현하기 쉬운 구조로 설계되었습니다. 합의 프로토콜은 주로 복제된 상태 머신이나 블록체인 같은 시스템에서 사용됩니다.

- 2021 
- 1-1.위의 두 개의 transactions에 아래와 같이 SL(x), XL(x), 그리고 UL(x) 연산을 삽입하였다고 가정하자. 이 경우, T1과 T2의 세부 연산이 어떤 시간적 순서로 실행이 되면 Serializable하지 못하게 되는지 예로 설명하십시오.
- T1: SL(a) r(a) UL(a) SL(b) r(b) UL(b)
- T2: XL(a) w(a) UL(a) XL(b) w(b) UL(b)
- 1-2. 위 두 transactions의 적절한 위치에 2-Phase Locking Protocol로 SL(x), XL(x), UL(x)를 삽입하십시오 1-3. 위의 2-Phase Locking Protocol로 삽입된 lock과 unlock을 이용하면 serializable 하게 된다는 것을 예를 들어 설명하십시오. 1-4. 위 두 transactions의 read와 write 수행 순서가 어떻게 바뀌면 dead lock이 발생하는지 찾아보십시오. 1-5. 만일 dead lock이 발생되었을 경우 어떻게 해결하여야 하는지를 간단하게 설명하십시오. 1-6. 2-Phase Locking과 Timestamping 방법을 비교하십시오.

- T1: SL(a) r(a) UL(a)
- T2: XL(a) w(a) UL(a)
- T2: XL(b) w(b) UL(b)
- T1: SL(b) r(b) UL(b)
- 위 순서에서는 T1이 a를 읽은 후 T2가 a를 쓰게 되면 T1이 읽은 a와 T2가 쓴 a의 값이 다를 수 있습니다. 또한, T2가 b를 쓴 후 T1이 b를 읽게 되면 역시 일관성을 유지하지 못하게 됩니다.(사이클 발생)
- T1: SL(a) SL(b) r(a) r(b) UL(a) UL(b)
- T2: XL(a) XL(b) w(a) w(b) UL(a) UL(b) 이면 2phaselocking
- 1-SL(a) 2-XL(b) 1-SL(b) 2-XL(a)이면 데드락.


문제1. 다음은 Transaction은 극장의 i-번째 자리를 예약하는 pseudo-code이다. 

    Transaction(SeatTable, name, price, i) {
        Seat  readRecord(SeatTable,i); //read i-th record
        If(Seat.reserved == NO) {
        Seat.reservedYES;
        Seat.payment5000;
        Seat.namename;
        updateRecord(SeatTable,i,Seat);
        }
    }

1-1. 이 Transaction이 동시에 수행될 때 Serializable할 수 없는 상황을 예로 들어 서술하시오
- T1이 SeatTable의 i번째 레코드를 읽습니다.
- T2가 SeatTable의 i번째 레코드를 읽습니다.
- T1이 SeatTable의 i번째 좌석을 예약하고 업데이트합니다.
- T2가 SeatTable의 i번째 좌석을 예약하고 업데이트합니다.
- 두 트랜잭션 모두 i번째 좌석을 예약했다고 생각하지만, 실제로는 마지막에 업데이트된 트랜잭션만 유효한 예약이 됩니다. 이는 Serializability를 위반합니다.
1-2. 1-1. 의 예가 왜 Serializability가 만족될 수 없는지를 Conflict Graph로 설명하시오.
- Conflict Graph는 다음과 같은 간선을 갖습니다:
- T1 → T2 (T1이 읽은 후 T2가 씀)
- T2 → T1 (T2가 읽은 후 T1이 씀)
- Conflict Graph에 사이클이 존재하므로 이 스케줄은 Serializability를 만족하지 않습니다.
1-3. 이 문제를 해결하기 위하여서는 Two-Phase Locking Protocol에 따라 아래의 세 Operation을 적절한 위치에 삽입하시오. 단 Update는 Write와 동일하게 간주하시오.
- SLock(Table,i): Shared Lock on the i-th record of Table
- XLock(Table,i): Exclusive Lock on the i-th record of Table
- Unlock(Table,i): Unlock on the i-th record of Table.
코드 맨 위에 XLOCK(Table, i), 맨 밑에 unlock(Table, i). 위와 같이 XLock을 추가하여 트랜잭션이 i번째 레코드를 읽기 전에 해당 레코드에 대해 독점 잠금을 획득하게 합니다. 따라서 동시에 여러 트랜잭션이 동일한 레코드를 수정할 수 없게 되어 Serializability가 보장됩니다.



문제 3: Timestamp protocol을 이용하여 concurrency control을 하려고 한다.

문제 3-1] 이 경우 Conflict graph에 Cycle이 생기지 않는 이유를 read(Q) operation을 예로 들어, 설명하시오.
- 트랜잭션 간의 의존 관계가 시간 순서대로 정렬됩니다. 따라서 Conflict Graph에서 Cycle이 발생하지 않습니다.
문제 3-2] Transaction에 따라 Timestamp protocol이 2 phase locking protocol에 비하여 성능이 좋을 수도 또는 나쁠 수도 있다. 어떤 경우에 timestamp protocol의 성능이 크게 떨어지는지 설명하시오. 
 - long TA -> restart + rollback
문제 4: Log를 이용한 Recovery에서 checkpoint 가 필요한 이유를 간단하게 설명하시오.
- 복구 시간 단축 : checkpoint 이전에 commit됐으면 ignore, failure이전에 commit 됐으면 redo, 아니면 undo라서. Checkpoint 이전의 로그 기록은 더 이상 필요하지 않기 때문에 제거할 수 있습니다.


문제 1: log를 이용하여 transaction의 recovery를 Deferred Modification 방법으로 수행하고자 한다.
문제 1-1] 평상시에 저장되는 log record에는 어떤 정보가 포함되어야 하는가?
- 트랜잭션 ID, 데이터항목, 변경 후 값 < T, x, V>
문제 1-2] Transaction의 수행 도중 시스템이 정지되었을 경우, Recovery 절차를 설명하시오.
- deferred : 커밋된건 한번 더 커밋해주고 안된건 지워버리면 됨.
문제 1-3] 이 경우 Checkpoint 가 왜 필요한지 설명하시오.
- Checkpoint 이전의 로그 기록은 더 이상 필요하지 않기 때문에 제거할 수 있습니다. 복구시간단축
문제 1-4] Deferred Modification과 Immediate Modification의 경우 log의 형식은 어떻게 다른가?
- deferred는 old value를 갖고있지 않아도됨.
문제 3: Serializability를 하고, 이것이 왜 Transaction의 처리에 필요한지 설명하시오 
- Serializability는 트랜잭션 시스템에서 동시에 실행되는 트랜잭션들이 직렬화 가능하도록 보장하는 것입니다. 이는 트랜잭션의 병행 수행 결과가 각 트랜잭션이 순차적으로 단일 스레드에서 실행된 것과 동일한 결과를 가져야 한다는 의미입니다. 데이터 무결성과 일관성을 유지함. 트잭의 ACID 보장
문제 4: Two-Phase Locking Protocol과 Two-Phase Commit Protocol을 구별하여 각기 설명하시오.
- 2PL : 트랜잭션의 직렬성을 보장하는 방법. 확장단계, 축소단계
- 2PC : 분산 시스템에서 트랜잭션의 원자성을 보장하는 방법. prepare, commit 단계


-  Fixed Size Record (고정 길이 레코드)
- **구조**: 모든 레코드가 동일한 크기를 가집니다. 각 레코드는 사전에 정의된 고정된 길이의 필드로 구성됩니다.
- **저장 방식**: 고정 크기의 레코드를 저장할 때 파일 시스템은 각 레코드의 크기를 미리 알고 있으므로, 각 레코드를 일정한 간격으로 파일에 저장합니다. 이로써 레코드를 읽고 쓰는 데 효율적입니다.
- **장점**:
    1. 레코드를 읽고 쓰는 데 일관된 시간이 소요됩니다.
    2. 레코드의 위치를 계산하기가 쉽습니다.
    3. 데이터베이스와 같은 응용 프로그램에서 고정 길이의 필드를 사용하는 경우 매우 유용합니다.
Variable Length Record (가변 길이 레코드)
- **구조**: 각 레코드의 크기가 다를 수 있습니다. 레코드는 필드의 길이가 가변적이거나 레코드 간 구조가 서로 다를 수 있습니다.
- **저장 방식**: 각 레코드의 크기가 다르기 때문에 파일 시스템은 레코드의 크기와 위치를 표시하기 위한 추가적인 메타데이터가 필요합니다. 일반적으로 레코드의 시작과 길이를 지정하는 헤더를 사용하여 레코드를 구분합니다.
- **장점**:
    1. 유연성이 높습니다. 다양한 형식과 길이의 데이터를 저장할 수 있습니다.
    2. 공간의 효율성이 높습니다. 필요한 만큼의 공간만 사용하여 레코드를 저장할 수 있습니다.
    3. 특정 응용 프로그램에서 필요한 데이터 구조를 정의하기에 적합합니다.
 파일 시스템 관점에서의 차이점:
- **저장 방식**: Fixed size record의 경우 각 레코드를 일정한 간격으로 파일에 저장하는 반면, Variable length record의 경우 각 레코드의 시작 위치와 길이를 따로 저장하여 파일에 저장합니다.
- **액세스 방식**: Fixed size record의 경우 레코드의 위치를 쉽게 계산할 수 있으므로 빠르게 액세스할 수 있지만, Variable length record의 경우 레코드의 시작 위치와 길이를 먼저 찾아야 하므로 액세스 속도가 상대적으로 느릴 수 있습니다.
- **메타데이터**: Variable length record의 경우 각 레코드의 시작 위치와 길이를 저장하기 위한 추가적인 메타데이터가 필요합니다. 이는 파일 크기를 늘리고 파일 시스템 자원을 소비할 수 있습니다.

- 슬롯 페이지 구조에서는 각 페이지의 맨 앞(또는 맨 뒤)에 헤더가 위치하고, 이 헤더는 페이지 내의 각 레코드에 대한 메타데이터(예: 레코드의 위치, 길이 등)를 포함하는 엔트리의 목록을 관리합니다. 각 엔트리는 해당 페이지 내에서 레코드의 실제 위치를 가리킵니다. 이 구조는 다음과 같은 이유로 사용됩니다:
- 슬롯 페이지(slotted page) 구조에서 포인터가 직접 레코드를 가리키지 않고 헤더의 레코드 항목(entry)을 가리키는 이유는 주로 페이지 내에서 레코드의 유연한 관리와 빠른 재조정을 가능하게 하기 위해서입니다. 이 구조는 페이지 내에서 레코드가 추가되거나 삭제될 때 발생할 수 있는 불필요한 데이터 이동을 최소화하여 효율성을 높입니다.
1. **유연한 레코드 관리**: 레코드의 실제 내용은 페이지 내의 임의의 위치에 저장될 수 있으며, 헤더에 저장된 포인터(엔트리)만 업데이트하면 됩니다. 이로 인해 레코드를 페이지 내 다른 위치로 이동시킬 때 전체 레코드를 옮기는 대신, 헤더의 포인터 정보만 변경하면 됩니다.
2. **효율적인 공간 활용**: 레코드의 삭제나 크기 변경 시 공간의 재배치가 필요할 때, 실제 레코드 데이터의 이동보다는 헤더의 엔트리를 조정하는 것이 더 간단하고 빠릅니다. 이는 특히 크기가 큰 레코드를 다룰 때 공간과 시간을 절약할 수 있습니다.
3. **데이터 무결성 유지**: 포인터가 헤더의 엔트리를 가리키게 함으로써, 레코드의 위치가 변경되더라도 다른 구성 요소들이 여전히 유효한 참조를 유지할 수 있습니다. 이는 레코드의 직접적인 위치 변경이 외부 시스템이나 캐시에 영향을 미치지 않도록 합니다.
- 즉 블록 헤더의 엔트리에는 레코드에 대한 포인터들이 저장되어 있기에 레코드들은 페이지 내 어떤 위치든 노상관이고 이 헤더만 잘 관리하면 위의 장점들을 취할 수 있음.

- insert 10, 20 하면  branch factor는 3개이다. branch factor가 m이면 값은 m-1개 들어갈 수 있다. 
- m-way에서는 m-1개의 키를 가질 수 있음 키는 delimeter를 말하는 듯(구분자). m개의 자식을 가지면 m-1개의 요소를 가질 수 있다. 이때 delimiter + block number = 4 + 4 = 8이고 8(m-1)이 됨. 자식이 m개 이니까 4m. 맨 앞 4바이트 -> 4+4m+8(m-1).
- B-tree는 ceiling(m/2)를 인터널 노드로 갖는다. 그래서 3 way라 치면 인터널은 2개만 가능
- DepthBtree​=logm−1​(N+1)
- DepthB+tree​=logm​(N)

Hash ppt만 다시 보기

number of records in a block
블럭 1개에 record 몇 개 들어가는지가 bf이다.

hit ratio
rh = nh/na

- transaction(TA) : a set of ACID operations
- all or nothing, consistency(수행과 결과가 일치), isolation(TA독립적), durability(성공적인 TA후 DB는 persist)
- serializable : serial하게 수행한 것과 결과가 같은 게 있는 concurrent TA
- 사이클 프리되도록 트랜젝션을 만들어줘야 serializable 하게 됨
- 그 두 가지 방법 two phase locking과 timestamping
- two phase locking : Exclusive mode(X) -  read와 write를 lock, Shared mode(S) - read는 괜찮고 write는 lock. 첫 단계는 락을 걸어주기만 하고 두번째 단계에서는 read or write 이후 풀기만 한다
- 공유 모드 (Shared Mode, S-잠금): 데이터 항목을 읽기 위해 사용. 트랜잭션이 데이터 항목을 읽기 위해 S-잠금을 요청하면 다른 트랜잭션도 해당 항목에 대해 S-잠금을 획득하여 동시에 읽을 수 있습니다.여러 트랜잭션이 동시에 데이터 항목을 읽을 수 있으므로 병행성이 높아집니다. S-잠금은 데이터 항목의 업데이트를 허용하지 않습니다. 즉, 다른 트랜잭션이 해당 항목에 대해 배타 모드(Exclusive Mode, X-잠금)를 요청하면 S-잠금을 기다려야 합니다.
- 배타 모드 (Exclusive Mode, X-잠금): 데이터 항목을 쓰기(읽기/수정) 위해 사용. 트랜잭션이 데이터 항목을 수정하기 위해 X-잠금을 요청하면 다른 트랜잭션은 해당 항목에 대해 어떤 잠금(S 또는 X)을 획득할 수 없습니다. 오직 하나의 트랜잭션만이 X-잠금을 획득할 수 있습니다. 트랜잭션이 데이터 항목을 독점적으로 접근할 수 있으므로 데이터의 일관성을 보장할 수 있습니다. X-잠금을 획득한 트랜잭션은 해당 잠금을 해제할 때까지 다른 트랜잭션이 해당 항목을 읽거나 수정할 수 없습니다. 따라서 병행성이 낮아질 수 있습니다.
- 두 모드의 관계: S-잠금끼리는 호환되지만, X-잠금은 다른 X-잠금 및 S-잠금과 호환되지 않습니다.
- S-잠금과 S-잠금: 호환됨 (여러 트랜잭션이 동시에 읽기 가능)
- S-잠금과 X-잠금: 호환되지 않음 (읽기와 쓰기가 동시에 불가능)
- X-잠금과 X-잠금: 호환되지 않음 (동시에 하나의 트랜잭션만 쓰기 가능)

- slock 다음에 sunlock안해주고 바로 xlock 가능 (lock upgrading이라 함)
- 그 반대는 downgrade
- lock manager : TA의 락 요청을 관리함.
- T1(SLA), T2(SLB), T1(XLB), T2(XLA) 상황이면 데드락이다. 데드락 해결하는 방법은 하나의 트렌잭션을 죽이는데 가장 데미지가 적은 트랜젝션 (시작한지 얼마안된 것)을 고른다. 
- Tree lock : 데드락 방지위한 기술. 트리 전체에 락을 거는게 아니라 A와 그 자식인 B한테까지만 걸어주는 듯. 그 후 풀어줄 때는 B는 걸어논 상태에서 A를 풀어줌 즉 항상 한 쌍씩 락을 걸어준다. 한 번에 하나의 쌍 (부모-자식)만 락을 걸고 풀어주므로, 트리 전체에 락을 걸지 않고도 일관성을 유지할 수 있다는 점입니다.
- TimeStamp(TS) <= Write TS 일때 Read Ts하려는데 WTS가 TS보다 먼저 일어난 저 상황이면 read 시점 부터 다시 TA를 시작함(TS와 WTS간 디펜던시가 존재할 수 있으니). 읽으려고 하는데 이미 write 활동이 있다면 다시 시작하는게 안전하다. 
- TimeStamp(TS) < Read TS  일때 Write TS하려는데  RTS가 TS보다 먼저 일어난 상황도 마찬가지로 write를 거절하고 롤백시킴. 
- TimeStamp(TS) < Write TS 일때 write하는 행위도 롤백됨. 
- TS의 락을 걸지 않기에 사이클 발생 안 해 데드락 발생하지 않지만 롤백 및 재시작하는 오버헤드가 크다.
- P_RB * (C_RB+C_RStart) > P_DL * C_DL + C_DLDetect
- Dead Lock Detection은 항시 데몬으로 존재하기에 전자와 달리 확률(P)을 따질 필요 없음
- Long Duration TA : undo의 비용이 증가. 롱텀이라 트랜젝션 간 겹치는 부분이 잦게 발생되어 계속 리스타트 해야해서 concurrent가 아니라 serial하게 되어버릴 수 있음. nested tranjaction으로 해결할 수 있음.
- Recovery : fail 일어나기 전 항상 점검해야하는 일, fail 일어났을 떄 수행하는 일로 나뉨.
- 트렌잭션 각 오퍼레이션을 모두 log 기록. fail 발생하면 log data를 봐서 reovery함. 이떄 이 log 파일은 stable storage라는 이론상으로 절대적으로 안전한 저장소에 저장된다고 취급함. 
- DB에 반영하기 전에 변경사항을 처리하는 recovery의 두 가지 방식 log-based recovery와 shadow-paging
- Log Based Recovery : 로그는 stable storage에 저장되어야함 (write로그만). 로그파일이 쌓이면 굉장히 커지는데 리커버리할때 그 로그파일의 위치를 알 수 있도록 인덱스가 필요함. 로그를 commit 이후 몰아서 한번에 업데이트해주는걸 deferred. 매번 해주는게 immediate. 로그파일이 몰아서 늦게 반영되니까 deferred보단 immediate가 최신화에 유리. fail이 일어날 경우 immediate는 즉시 반영되었으므로 리커버리에 불리하고(오버헤드) deferred는 기다린 상태에서 실패하기에 애초에 반영이 안되어있으니 다른 작업 필요하지 않음. Deferred는 <Ti, X, V> : 되돌릴 필요 없으니 올드 값 필요 없음. Immediate는 <Ti, X, V_old, V_new>
- In Deferred Method, During recovery after a crash, a transaction needs to be redone if and only if both <Ti, start> and<Ti,  commit> are there in the log(redo Ti). 즉 커밋된건 한번 더 커밋해주고 안된건 지워버리면 됨.
- In Immediate Method, Undo if the log <Ti, start>, but not <Ti, commit>. Redo if the log both the record <Ti, start> and <Ti, commit>. 즉 커밋된건 redo 안된건 undo 시킴.
- idempotent : 연산을 여러 번 적용하더라도 결과가 달라지지 않는 성질. Log record에서 operation들은 idempotent해야함 아니면 잘못된 결과를 야기함.
- 로그파일이 너무 커지니 중간에 체크포인터를 주기적으로 설정. 체크포인트 이전에 커밋 완료된 얘들은 롤백 세그먼트에서 지움, 체크포인트와 failure 사이에 commit 완료된 TA는 redo해주고 아직 commit 안된 얘는 undo.
- Shadow Paging : 업데이트할 때 현 페이지를 카피한 new page에 업데이트를 하고 완료되면 이걸 쓰고 fail 일어나면 기존 old page를 사용.  

- Distributed DB : cost(scalability)(큰 서버 하나 만드는 것 보다 작은 것 여러개가 유리), performance(병렬처리가능), reliability(백업 가능), accessiblility(availiability)(여러 곳에 있으니 접근성, 가용성 좋음) 면에서 장점.
- 시스템 수를 무한정 늘린다고 속도가 빨라지진 않음. 결국 가장 늦게 write 처리한 시간에 맞춰야하고 TA control 및 동기화 문제, crash 발생 확률도 커지기 때문.
- MiddleWare : Middleware dynamically binds the requests from clients to server.  한 쪽 DB 시스템에 과한 load 가 발생했을 시 balancing해줌(Load-Balancing). Fault-Tolerance(어느 한 모듈에 Fault (장애)가 발생하더라도 시스템운영에 전혀 지장을 주지 않도록 설계된 시스템)
- 서버가 interface, application, DB 다 부담하는 cloud computing(대규모 데이터 처리와 중앙 집중식 관리에 유리)
- 클라가 다 부담하는걸 edging computing(실시간 데이터 처리와 로컬 데이터 처리에 유리). 
- **Cloud Computing**은 자원 풍부성, 확장성, 데이터 일관성, 관리 및 유지보수의 장점을 제공하지만, 지연 시간, 대역폭 사용, 연결성 의존성, 프라이버시 및 보안 문제의 단점이 있습니다. (자확데) - 딥러닝 ai 연구
- **Edge Computing**은 대역폭 절약, 보안 및 프라이버시 강화, 지연 시간 감소와 같은 장점을 제공하지만, 데이터 일관성 관리, 자원 제한, 관리 복잡성과 같은 단점이 있습니다. (대보지) - p2p
- DB를 로컬들에 일부 혹은 전부를 복제해서 저장하는데 Replicated DB를 관리하는 방법 : consistency를 꺠드리지 말아야함(TA에서 atomic을 깨뜨리는 등).
- *Snapshot replication* : 중앙 사이트에 모든 로그기록 업데이트하고 로컬들에게 주기적으로 적절한 로그를 보내주면 로컬사이트들은 그들의 DB에 업데이트한다.
- *Near Real-Time replication* : 업데이트가 발생하면 다른 사이트에도 즉각 반영. 위 두 방식은 push protocol(다른 사이트에 업데이트하라고 명령)
- *Pull replication* : 로컬들이 필요할때 업데이트 요청을 보냄
- Partitioning : horizontal partitioning은 테이블을 서브테이블로 쪼갬(local optimization, security, communication overhead, efficiency 고려)
- vertical partitioning : 몇몇의 disjoint table로 DB를 쪼갬. PK를 공유하기에 Join operations을 필수로 써야함. 즉 lossless decomposition이 되도록 테이블을 쪼갬. 이때 쪼개진 테이블들의 키가 오버랩 되도록 쪼갬. 
- Raid는 0~6으로 갈수록 블록의 중복성(redundancy)를 늘려서 저장
- HDFS(hadoop file system) : to support a very large number of storage nodes. maps each block id to data nodes containing a replica of the block(name node), maps a block id to a physical location on disk(data node). 즉 네임노드는 데이터노드가 어디있는지를 트랙킹하고 데이터노드는 실제 DB 디스크와 맵핑되어있음. 백업노드는 네임노드의 카피를 백업함.

- Distributed transaction : 각 사이트는 ta coordinator, ta manager 가짐. 
- *TA coordinator : 최초의 트젝을 시작시킴, 서브 트젝을 적절하게 사이트들에 배분함, 각 사이트의 트젝들이 종료하는걸 코디네이트함.
- *TA manager : 복구를 위한 로그를 유지, 사이트에서 실행중인 트잭의 commit, abor, execution을 관리함.
- *즉 TA coorinator는 분산 시스템의 중앙 조정 역할을 하며 여러 TA manager(개별 DB 서버에 위치함)를 포함하는 환경에서 동작함.*
- 사이트 failure, 메세지 손실, 통신링크 failure, 네트워크 파티션에서 fail이 발생할 수 있음. 
- *commit protocol은 사이트들의 atomicity를 보장하는데 사용됨.* 여러 사이트에서 실행되는 트젝은 모든 사이트들에서 commit되거나 abort되어야함. 즉 한 사이트에서만 커밋되거나 어볼트 될 순 없다. 우린 fail-stop 모델이라 가정한 프로토콜만 다룸 (fail된 사이트는 그냥 동작하지 않고 다른 위험을 야기하지 않음)
 - *Two-Phase Commit (2PC)*
 - 2PC는 분산 시스템에서 트랜잭션을 원자적으로 수행하기 위한 프로토콜입니다. 이는 데이터베이스나 다른 분산 시스템에서 여러 노드가 하나의 트랜잭션을 성공적으로 수행하도록 보장합니다. 네트워크 장애나 노드 실패 시 복구가 어렵고, Coordinator의 장애로 인해 시스템이 블록될 수 있는 단점이 있습니다. 2PC는 다음 두 가지 주요 단계로 구성됩니다: 
- 1단계: Prepare 단계 (투표 단계)
- Coordinator (조정자)가 트랜잭션을 시작하고 모든 참여자(Participant)에게 `prepare` 요청을 보냅니다.
- 각 참여자는 트랜잭션이 성공할 수 있는지 여부를 결정하고, `ready` (트랜잭션 준비 완료) 또는 `no` (트랜잭션 준비 불가)로 응답합니다.
- 참여자는 트랜잭션이 성공 가능하면 로그에 기록하고 준비 상태를 유지합니다.
- 2단계: Commit 단계 (결정 단계)
- Coordinator는 모든 참여자로부터 `ready` 응답을 받으면 트랜잭션을 `commit` 하기로 결정하고, 모든 참여자에게 `commit` 메시지를 보냅니다.
- 한 명이라도 `no` 응답을 받으면 트랜잭션을 `abort` 하기로 결정하고, 모든 참여자에게 `abort` 메시지를 보냅니다.
- 각 참여자는 조정자의 지시에 따라 트랜잭션을 `commit`하거나 `abort`합니다.
- **장점**: 원자성을 보장하여 트랜잭션의 일관성을 유지할 수 있습니다.
- **단점**: Coordinator가 고장나면 트랜잭션이 블록될 수 있습니다. 네트워크 장애나 노드 실패 시 복구가 복잡합니다.

- *Site Failure 시
- 사이트가 복구할때 로그를 보고 실패 지점의 TA의 운명을 결정함. 로그가 commit T  를 포함하면 redo(T). abort T를 포함하면 undo(T). ready T를 포함하면 사이트는 coordinator한테 결정해달라고 함. 
- 로그에 T에 대한 어떠한 제어 기록도 없다는 것은 사이트가 코디네이터의 prepare T 메시지에 응답하기 전에 실패했음을 의미한다. 사이트의 실패로 인해 그러한 응답을 보낼 수 없게 되었기 때문에 코디네이터는 abort T, 사이트는 undo(T)를 해야함. 
- 위 상황에 대해 double transaction에서는 트랜잭션 T가 준비 상태에 있지만 아직 커밋되지도 중단되지도 않은 상태를 나타내며, 이는 분산 시스템에서 데이터 일관성과 자원 관리 문제를 초래할 수 있음을 의미합니다.
- *Coordinator Failure 시
- 활성 사이트 로그에 commit T 레코드가 있으면 T는 commit. 
- 활성 사이트 로그에 abort T 가 있으면 T는 abort
- 어떤 활성 사이트 로그에 ready T가 없으면 T는 abort.
- 위 경우 해당하지 않으면 경우 모든 활성 사이트는 로그에 ready T 기록을 가지고 있지만 commit T또는 abort T와 같은 추가적인 제어 기록이 없습니다. 이 상황에서는 활성 사이트가 코디네이터가 복구되어 결정사항을 알 때까지 기다려야 합니다.
- 활성 사이트는 코디네이터가 복구될 때까지 기다려야 할 수도 있습니다. 이는 트랜잭션 처리가 지연되고 자원이 잠기게 되는 문제를 일으킬 수 있습니다.
- *요약하면* 
- *site fail : commit -> redo / abort -> undo / ready -> coordinator.*
- *cordi fail : commit -> commit / abort -> abort / no ready -> abort / only ready -> wait site to be recovered* 
- Single lock manager : lock manager는 선택된 하나의 사이트(S)에서 동작함. (모든 락 요청은 중앙 lock manager에 보내짐). 데이터의 레플리카가 존재하는 어떤 사이트들 중 하나와도 트랜젝션은 거기서 데이터를 읽을수 있다. write는 해당 데이터에 대해 모든 레플리카들에 대해 수행되어야 함. 간단한 구현과 간단한 데드락 처리의 장점을 갖지만 lock manager가 보틀넥이 되거나 lock manager 실패시 시스템이 vulnerable하다는 단점. 
- Distributed lock manger : 락킹 기능은 lock manager에 의해 각 사이트에 이식됨. *락매니저가 각 로컬 데이터의 접근을 컨트롤함*. 락킹은 각 사이트 별로 따로따로 수행됨. 모든 레플리카들은 lock 된 후 업데이트 되어야 함. 작업이 분산되기에 failure에 robust(튼튼한)한 장점을 갖지만 글로벌 데드락에 걸릴 가능성이 있고 락매니저는 반드시 데드락 탐지 기법과 협업해야한다는 단점이 있음.
- centralized deadlock detection에선 global wait-for graph는 싱글 사이트에서 구축되고 유지된다 (deadlock detection coordinator). 
- global wait-for graph는 새 엣지가 추가되거나 제거될 때, 로컬 wiat-for  graph에 많은 변화가 생길때, 코디네이터가 cycle-detection을 유발시킬 때 구축될 수 있다. 만약 코디네이터가 사이클을 발견했다면 희생자를 선택해서 롤백시키고 모든 사이트에 알려줌.
- *데드락 정의 : 둘 이상의 프로세스가 서로가 가진 한정된 자원을 요청하는 경우 발생하는 것으로, 프로세스가 진전되지 못하고 대기 상태에 빠지는 현상.*
- false cycle : 분산환경에서, 릴리즈가 된 상황을 글로벌한테 메세지 보낸 것이 늦게 도착하고 이때 다른 쪽으로도 연결을 시키면 글로벌 입장에서는 싸이클이 생겼다고 판단해서 하나를 죽일 수가 있음. 그래서 락을 풀고 연결할때 코디네이터한테 잘 말해줘야함. 2 phase locking 기법에서 생길 수 있는 단점임.
- Lease : 일정한 시간만큼 락 걸어주고 풀어줌 -> 사이클이 생기는지 체크할 필요가 없음. 프로토콜에서 코디네이터가 하나일 때 사용될 수 있으며 만약 코디네이터가 죽으면 백업 코디네이터에 의해 획득 될 수 있음.



