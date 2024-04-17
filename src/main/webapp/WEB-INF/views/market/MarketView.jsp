<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">


  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/market.css">
  <link rel="stylesheet" href="/assets/css/snb.css">



</head>

<body>

  <%@ include file="../include/snb.jsp" %>


  <!-- 가운데 Content -->
  <div class="wrapper">

    <!-- ContentBox 내용 제일 위-->
    <div class="content-box">


      <%@ include file="../market/subMarketUserHeader.jsp" %>
      <!-- Head 내용 -->



      <!-- Title 내용 -->
      <div class="title">
        <div class="titleContent">
          <span>#글번호 : </span><span class="boardNo">1</span>
          <span>#작성자 : </span><span class="textWriter">코리안네이마루</span><span>(본인인증완료)</span>
          <span>#신용도 : </span><span class="rate">9.3/10</span>
          <span>#작성시간 : </span><span class="updateDate">24.04.10 14:42</span><br>
          <span>#제목 : </span><span class="textTitle">유니폼 팝니다</span>
          <span>#가격 : </span><span class="price">200000</span><span>원</span>
          <span>#판매자 선호 거래지역 : </span><span class="location">신촌역</span>
        </div>
      </div>




      <!-- Content 내용 -->
      <div class="content">

        <!-- 컨텐츠 메뉴 -->
        <%@ include file="../market/subMarketContentHead.jsp" %>




        <div class="Content1">
          <div class="ContentBox">
            <img class="ContentImg"
              src="https://img3.yna.co.kr/etc/inner/EN/2023/08/13/AEN20230813000200315_01_i_P2.jpg" />
            <div id="normal" class="textContent">
              글을 입력하세요.


            </div>



          </div>
          <%@ include file="../market/subMap.jsp" %>

        </div>

        <!-- Reply 내용 -->
        <%@ include file="../market/subMarketReply.jsp" %>

        <!-- 광고 영역 -->
        <%@ include file="../market/subMarketAD.jsp" %>



      </div>











    </div>





    <script>
      /* 친구 정보 */
      const $friends = document.querySelector('.friends');
      const $userInformation = document.getElementById('user-information');
      const $xBtn = document.getElementById('x-btn');

      $friends.onclick = e => {
        if (!e.target.matches('.friend')) return;
        e.preventDefault();

        // #user-information 의 p태그가 누른 대상의 닉네임이 되어야 한다.
        $userInformation.style.display = 'block';

      };

      $xBtn.onclick = e => {
        console.log('x버튼 클릭');
        $userInformation.style.display = 'none';
      }


      const $del = document.querySelector('.content-Del');
      $del.onclick = e => {
        if (!e.target.matches('.del')) return;
        e.preventDefault();

        $userInformation.style.display = 'block';
      };

      $xBtn.onclick = e => {
        console.log('x버튼 클릭');
        $userInformation.style.display = 'none';

      }

  
      
      


      



    </script>
    

</body>

</html>