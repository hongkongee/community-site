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
      <div class="rps-bet">

        <!-- <form id="rps-betting" action="/home/rps/bet" method="post"> -->
          <input type="text" id="bet-point" name="bp" placeholder="베팅 금액을 입력해주세요">P <br>
          <div id="bet-btn">
            <button>제출</button>
          </div>
        <!-- </form> -->

      </div>
      


      
      <!-- 가위바위보 진행 -->
      <div class="rps-game">

        <!-- <form id="gameForm" action="/home/rps/game" method="POST">
          <input type="hidden" id="choiceInput" name="choice">
        </form> -->
      
        <button id="rock" class="rps-btn" ><img src="/assets/img/rock_image.jpg" alt="Rock"></button>
        <button id="paper" class="rps-btn" ><img src="/assets/img/paper_image.jpg" alt="Paper"></button>
        <button id="scissors" class="rps-btn" ><img src="/assets/img/scissors_image.jpg" alt="Scissors"></button>  

      </div>
      
    </section>
    
  </div>
  





  <script>
    // 베팅
    const $betButton = document.getElementById('bet-btn'); // 베팅 버튼
    const $betPoint = document.getElementById('bet-point'); // 베팅 포인트

    const $rpsBet = document.querySelector('.rps-bet'); // 베팅 영역
    const $rpsArea = document.querySelector('.rps-game'); // 게임 영역
    const $form = document.getElementById('rps-betting') // form 태그

    const myPoint = 30000; // 내 포인트
    const minPoint = 5000; // 최소 베팅 포인트

    $betButton.onclick = e => {
      console.log("베팅 버튼 클릭");
      const betPoint = $betPoint.value.trim();
      console.log(betPoint);

      if (isNaN(betPoint)) { // 문자열로 입력한 경우
        alert('올바른 형식으로 입력해주세요.');
        event.preventDefault(); // form submit 중단
        return;
      } else if (betPoint > myPoint) { // 자신의 포인트보다 더 많은 금액을 베팅한 경우
        alert('포인트가 부족합니다.');
        return;
      } else if (betPoint < minPoint) {
        alert('최소 5000P이상 베팅하셔야 합니다.');
        return;



      } else {

        $rpsBet.style.display = 'none';
        $rpsArea.style.display = 'block';

      }

      

    };

    const $rpsBtn = document.querySelectorAll('.rps-btn');
    




    // 가위바위보

    function sendChoice(choice) {
      fetch('/your-endpoint', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json'
          },
          body: JSON.stringify({ choice: choice })
      })
      .then(response => {
          if (!response.ok) {
              throw new Error('Network response was not ok');
          }
          return response.json();
      })
      .then(data => {
          console.log('Server response:', data);
          // Handle server response as needed
      })
      .catch(error => {
          console.error('There was a problem with the fetch operation:', error);
      });
    }


    document.getElementById("scissors").addEventListener("click", function() {
        sendChoice("scissors");
    });

    document.getElementById("rock").addEventListener("click", function() {
        sendChoice("rock");
    });

    document.getElementById("paper").addEventListener("click", function() {
        sendChoice("paper");
    });



  </script>
  
</body>
</html>