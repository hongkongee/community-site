<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Game Page</title>

  <%@ include file="../include/static-head.jsp" %>

  <link rel="stylesheet" href="/assets/css/gamerps.css" >
  <link rel="stylesheet" href="/assets/css/snb.css" >
    
</head>
<body>

  
  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>

  <!-- 게임 화면 -->

  <div class="wrapper">
    <section class="rps">
      <h2> 가위바위보 </h2>

      <!-- 베팅금액 입력하기 -->
      <form id="rps-betting" action="/home/game/bet" method="POST">
        <input type="text" id="bet-money" name="bet" placeholder="베팅 금액을 입력해주세요">P <br>
        <input type="button" id="bet-btn" value="제출">
      </form>
      

      <form id="gameForm" action="/play" method="POST">
        <input type="hidden" id="choiceInput" name="choice">
      </form>
    
      <button onclick="submitChoice('rock')"><img src="/assets/img/rock_image.jpg" alt="Rock"></button>
      <button onclick="submitChoice('paper')"><img src="/assets/img/paper_image.jpg" alt="Paper"></button>
      <button onclick="submitChoice('scissors')"><img src="/assets/img/scissors_image.jpg" alt="Scissors"></button>

    </section>
    
  </div>
  





  <script>
// 가위바위보
  function submitChoice(choice) {
      document.getElementById("choiceInput").value = choice;
      document.getElementById("gameForm").submit();
  }



  </script>
  
</body>
</html>