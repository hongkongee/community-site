// 가위바위보 기능 자바스크립트 
 
 // 베팅
 const $betButton = document.getElementById('bet-btn'); // 베팅 버튼
 const $betPoint = document.getElementById('bet-point'); // 베팅 포인트

 const $rpsBet = document.querySelector('.rps-bet'); // 베팅 영역
 const $rpsArea = document.querySelector('.rps-game'); // 게임 영역
 const $form = document.getElementById('rps-betting') // form 태그

 const myPoint = Number(document.querySelector('.rps-bet').dataset.point); // 내 포인트
 const myId = document.querySelector('.rps-bet').dataset.account; // 내 아이디
 const minPoint = 50; // 최소 베팅 포인트
 let betPoint = -1; // 입력 베팅 포인트

 const $rpsBtn = document.querySelectorAll('.rps-btn'); // 가위바위보 최종 버튼
 let rpsResult; // 가위바위보 결과 from 서버

 $betButton.onclick = e => {
   console.log("베팅 버튼 클릭");
   betPoint = $betPoint.value.trim();
   console.log(betPoint);

   if (isNaN(betPoint)) { // 문자열로 입력한 경우
     alert('올바른 형식으로 입력해주세요.');
     event.preventDefault(); // form submit 중단
     return;
   } else if (betPoint > myPoint) { // 자신의 포인트보다 더 많은 금액을 베팅한 경우
     alert('포인트가 부족합니다.');
     return;
   } else if (betPoint < minPoint) {
     alert('최소 50P이상 베팅하셔야 합니다.');
     return;



   } else {

     $rpsBet.style.display = 'none';
     $rpsArea.style.display = 'block';

   }

   

 };

 $resultScreen = document.querySelector('section.rps .result');
 const $resultMsg = document.getElementById('result-msg');

 // 결과 화면
 function whatResultOnScreen(rr) { // rr : 가위바위보 결과 (WIN, DRAW, LOSE 중 하나)
   console.log("스크린 화면 결정 스크립트 실행!");
   console.log('rr: ', rr);
   

   $resultScreen.style.display = 'block';

   if (rr === 'WIN') {
     console.log("승리");
     $resultMsg.textContent = '이겼습니다! 원금의 2배 ' +  2 * $betPoint.value.trim() + 'P 획득!!!';
    //  document.getElementById('win').style.display = 'block';
    //  document.getElementById('draw').style.display = 'none';
    //  document.getElementById('lose').style.display = 'none';

   } else if (rr === 'DRAW') {
    $resultMsg.textContent = '무승부입니다';
    //  document.getElementById('draw').style.display = 'block';
    //  document.getElementById('win').style.display = 'none';
    //  document.getElementById('lose').style.display = 'none';

   } else { // LOSE
    $resultMsg.textContent = '패배입니다... ' + $betPoint.value.trim() + 'P 손실';
    //  document.getElementById('lose').style.display = 'block';
    //  document.getElementById('win').style.display = 'none';
    //  document.getElementById('draw').style.display = 'none';

   }


 }




 // 가위바위보 입력값을 서버에 전송
 function sendChoice(choice) {
   fetch('/game/rps/start', {
       method: 'POST',
       headers: {
           'content-type': 'application/json'
       },
       body: JSON.stringify({ 
         'betPoint': betPoint,
         'choice': choice 
       })
   })
   .then(response => response.text())
   .then(data => {
       console.log('Server response:', data);
       // "WIN", "LOSE", or "DRAW"
       rpsResult = data;
   })
   .catch(error => {
       console.error('There was a problem with the fetch operation:', error);
   });

   $rpsArea.style.display = 'none';
   document.querySelector('.progress-box').style.display = 'block';

   // 2초 뒤 실행
   setTimeout(function() {
     console.log('rpsResult: ', rpsResult);
     document.querySelector('.progress-box').style.display = 'none';
     whatResultOnScreen(rpsResult);
   }, 2000);

   
   
 }


 // 가위 or 바위 or 보 버튼 중 하나를 클릭 시
 document.getElementById("scissors").addEventListener("click", function() {
     sendChoice("scissors");
 });

 document.getElementById("rock").addEventListener("click", function() {
     sendChoice("rock");
 });

 document.getElementById("paper").addEventListener("click", function() {
     sendChoice("paper");
 });


// 즉시실행함수
(() => {

  console.log('myPoint: ', myPoint);
  console.log('myId: ', myId);
  
  
})();

