
const $writer = document.getElementById('writer');
const $writerInformation = document.querySelector('.writer-info');
const bno = document.querySelector('.board-info').dataset.bno; // 현재 페이지 글번호
const writer = document.querySelector('.board-info').dataset.writer; // 현재 페이지 작성자

// 작성자 누르면 관련 기능 
document.querySelector('.wrapper').onclick = e => {

  if(e.target.matches('#writer-a')) { // 작성자를 누르면

    if ($writerInformation.style.display === 'none') {
      $writerInformation.style.display = 'block'; // 창이 뜬다
    } else {
      $writerInformation.style.display = 'none'
    }
    
    return;
  }

  if (e.target.matches('.writer-info a'))  { // 선택지를 누르면
    return; // 창을 닫지 않는다.
  }
  // 그 외의 영역을 누르면
  console.log('창 닫기');
  $writerInformation.style.display = 'none'; // 창이 없어진다

};



// URL 복사하기
const $copyUrl = document.querySelector('h2#copy-url>a');
$copyUrl.onclick = () => {

  console.log('url 복사!');
  var currentPageUrl = window.location.href;
  console.log(currentPageUrl);

  var tempInput = document.createElement("input");
  tempInput.setAttribute("value", currentPageUrl);
  document.body.appendChild(tempInput);

  tempInput.select();

  document.execCommand("copy");

  document.body.removeChild(tempInput);

  alert("페이지 URL이 복사되었습니다.: " + currentPageUrl);

};

// 신고버튼 누르기
const $clameWriter = document.getElementById('report-writer');
$clameWriter.onclick = () => {
  console.log('신고!!');
  document.getElementById('clame-btn').click();
};



// 신고 form 제출
document.getElementById('report-form').addEventListener("submit", function(e) {

  console.log('신고 제출!');
  e.preventDefault(); // form 기능 없애기

  // true or false checkbox 배열
  var interests = [];
  var checkboxes = document.querySelectorAll('input[name="clame-reason"]:checked');
  console.log(checkboxes); // nodelist

  checkboxes.forEach(function(checkbox) { // 배열 고차 함수
      interests.push(checkbox.value); // 체크한 항목만 모아둔 배열 (정제된 형태의 배열)
  });
  console.log(interests);

  var message = document.getElementById("reportText").value;

  // *********************** AJAX : 서버에 요청 보내기 ***********************

  var formData = {
      bno: bno, // 게시글 번호
      writer: writer, // 게시글 작성자
      message: message, // text area 기타 사유 메세지
      interests: interests // 체크된 박스만 모아둔 배열
  };

  // Send the form data to the server
  fetch("/home/detail/report", {
      method: "POST",
      headers: {
          "Content-Type": "application/json"
      },
      body: JSON.stringify(formData)
  })
  .then(response => response.text())
  .then(data => {
      console.log("Form submission successful:", data);
      // Handle server response as needed
  })
  .catch(error => {
      console.error("Error submitting form:", error);
  });

  alert('정상적으로 신고되었습니다.');
  document.querySelector('.modal-content .modal-footer .btn-secondary').click(); 
  document.getElementById("reportText").value='';
  document.getElementById("advertisement").checked=false;
  document.getElementById("bad").checked=false;
  document.getElementById("dispute").checked=false;
  document.getElementById("plaster").checked=false;

  (() => {

    
      
    
  })();

  

});


