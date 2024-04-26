<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Game Page</title>

  <%@ include file="../include/static-head.jsp" %>


  <link rel="stylesheet" href="/assets/css/header.css">
  <link rel="stylesheet" href="/assets/css/gamerps.css" >
  <link rel="stylesheet" href="/assets/css/snb.css" >
    
</head>
<body>

  <!-- 헤더 -->
  <%@ include file="../include/header.jsp" %>
  
  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>

  <!-- 게임 화면 -->

  <div class="wrapper">
    <section class="rps">
      <h2> 가위바위보 </h2>



      <!-- 베팅금액 입력하기 -->
      <div class="rps-bet">

        <!-- <form id="rps-betting" action="/home/rps/bet" method="post"> -->
          <input type="text" id="bet-point" name="bp" placeholder="베팅 금액을 입력해주세요">P <br>
          <div id="bet-btn">
            <button>제출</button>
          </div>
        <!-- </form> -->

      </div>
      


      
      <!-- 가위바위보 선택 -->
      <div class="rps-game">

        <!-- <form id="gameForm" action="/home/rps/game" method="POST">
          <input type="hidden" id="choiceInput" name="choice">
        </form> -->
      
        <button id="rock" class="rps-btn" ><img src="/assets/img/rock_image.jpg" alt="Rock"></button>
        <button id="paper" class="rps-btn" ><img src="/assets/img/paper_image.jpg" alt="Paper"></button>
        <button id="scissors" class="rps-btn" ><img src="/assets/img/scissors_image.jpg" alt="Scissors"></button>  

      </div>

      <!-- 가위바위보 진행중 -->
      <div class="progress-box">
        <div class="progress" role="progressbar" aria-label="Example 20px high" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 20px">
          <div class="progress-bar"></div>
        </div>
      </div>

      <!-- 가위바위보 결과 -->

      <div class="result">
        <div id="win">이겼습니다! 원금의 2배 획득</div>
        <div id="draw">무승부입니다.</div>
        <div id="lose">패배입니다...</div>
        <a class="btn btn-primary" href="/game/rps" role="button">다시 하기</a>
      </div>

      
    </section>
    
  </div>
  

  <!-- 가위바위보 자바스크립트 -->
  <script src="/assets/js/rps.js"></script>






  
</body>
</html>