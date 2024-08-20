# 영화관 예매 및 관리 서비스

JSP/Servlet 기반 웹 프로젝트로<br>
일반 사용자를 위한 영화 예매 서비스와<br>
관리자를 위한 영화 등록 및 상영 관리 기능을 구현하였습니다.<br>
추가적으로, 같은 주제로 프로젝트를 진행한 분들과 [통합 API서버](https://github.com/JinhwanU/Cinema-API.git)를 구현하여 데이터를 공유했습니다.<br>
*******************
<br>

### 1. 프로젝트 기간

#### **2024.06.18(화) ~ 2022.07.12(금) [25일]**
  - 기능 구현 : 2024.06.18(화) ~ 2024.07.03(수)
  - 통합 API서버 개발 : 2024.07.06(토) ~ 2024.07.12(금)
<br><br>

### 2. 서비스 소개

<details>
   <summary><b>사용자 - 예매하기</b></summary>
<div markdown="1">

#### <mark>1. 상영 시간표에서 영화와 시간을 선택합니다</mark><br>
![예매 - 영화선택](https://github.com/user-attachments/assets/e99321cc-aa68-4bdd-a50b-ac3ea1825ef7)
*****************
#### <mark>2. 인원 설정 후 원하는 좌석을 선택하고 결제합니다.</mark><br>
![예매 - 좌석선택](https://github.com/user-attachments/assets/a754e4cd-4af5-47ae-99cd-01bd73ae2302)
*****************
<br><br><br>
</div>
</details>



<details>
   <summary><b>관리자 - 상영 관리</b></summary>
<div markdown="1">

#### <mark>1. 영화관에서 상영하고자 하는 영화를 검색하여 등록합니다.</mark><br>
![관리자 - 영화 등록](https://github.com/user-attachments/assets/6c64ca53-ff9f-4f25-9a04-9488147c258d)
*****************
#### <mark>2. 상영 일정을 등록합니다.</mark><br>
![관리자 - 상영일정 등록](https://github.com/user-attachments/assets/5b269aa5-e04d-4f56-a6a2-6026eb6dab35)
*****************
#### <mark>3. 날짜 및 상영관별로 상영 일정을 확인합니다.</mark><br>
![관리자 - 상영일정 관리](https://github.com/user-attachments/assets/20e746c3-b842-4b82-a3d2-2e591baaa3df)
*****************
<br><br><br>
</div>
</details>



<details>
   <summary><b>프로젝트 통합</b></summary>
<div markdown="1">

#### <mark>1. 통합 API서버에 HTTP 요청을 보내 다른 사람의 DB 데이터를 주고받을 수 있습니다. </mark><br>
![통합](https://github.com/user-attachments/assets/fb0b1d10-7a7e-4d2d-a700-db7b53d68972)
*****************
#### <mark>2. 다른 사람이 만든 상영일정 데이터를 가져와 예매 또한 가능합니다. </mark><br>
다음은 통합 API서버 기능 영상입니다.(3분)<br>
[구글드라이브 링크](https://drive.google.com/file/d/1ZK3ltfcLu2cVKy-n1gs8Up-pn9Xm4k_T/view?usp=sharing)
*****************
<br><br><br>
</div>
</details>
<br><br>

### 3. 기술 스택
![stack](https://github.com/user-attachments/assets/37deadb9-ad2c-4480-a3f3-0aa1e0f870b7)
<br><br>

### 4. 개발 환경
![개발 환경](https://github.com/user-attachments/assets/93c9a2c5-fff6-4a1d-8773-99264774642b)
<br><br>

### 5. 데이터베이스 테이블
![전체테이블(간략)](https://github.com/user-attachments/assets/8da44ec6-2ad5-4afa-8731-cb92c4b10842)
<br><br>

### 6. 문제 해결

<details>
<summary><b>비동기처리</b></summary>
<div markdown="1">       

<b><h3>문제 상황</h3></b>
비동기처리를 위해 Fetch API를 통해 입력 데이터를 전송하였으나 return 값이 비정상적인 상황<br>
<b><h3>문제 원인</h3></b>
HTTP 통신을 통해 데이터를 주고 받을 때는 데이터를 JSON 객체로 변경하여야한다.<br>
(단순 문자열, XML, YAML, HTML Form data 등과 같이 예외인 경우도 있다.)<br>
<b><h3>해결 방법</h3></b>
GSON 라이브러리를 사용하여 데이터를 JSON 객체로 변경해주었다.
<br><hr>
</div>
</details>


<details>
<summary><b>SQL Insert문 일괄 처리</b></summary>
<div markdown="1">       
<b><h3>문제 상황</h3></b>
'영화 상영일정 하나를 만들 때 좌석 100개가 함께 생성되어야한다'는 로직을 처리해야 하는 상황<br>
쿼리를 100번 따로 실행하면 프로그램 성능에 문제가 있을 것이라 생각하여 일괄 처리하는 방법을 모색하였다.<br>
<b><h3>해결 방법</h3></b>
Oracle DB를 사용하기 때문에 PL/SQL 블록으로 묶어 Insert문 100개를 한번에 서버로 전송하였다.<br>
반복처리는 myBatis의 foreach문을 활용하였다.<br>
<b><h3>느낀점</h3></b>
처음에 PL/SQL로 묶어 서버에 한번에 보냈을 때는 이 방법이 Batch처리인 줄 알았다.<br>
하지만 이 방식은 Batch처리가 아니며 Insert문의 개수만큼 트랜잭션이 생성된다는 사실을 알게되었다.<br>
(Batch 처리는 모든 Insert문을 한번에 처리하기 때문에 트랜잭션이 단 한개만 생성된다)<br>
차이점을 알게 됐으니 다음 프로젝트에서는 꼭 Batch처리를 해보도록 하겠다<br>
   
<br><hr>
</div>
</details>

<br><br>
