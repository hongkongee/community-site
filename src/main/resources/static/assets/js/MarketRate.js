
const $confirmButton = document.getElementById('confirmBtn');

const $selectElement = document.querySelector('.form-select');
const $selectedValue = $selectElement.value;
const $selectedText = $selectElement.options[$selectElement.selectedIndex].text;

const boardNo = document.getElementById('boardNo').textContent; // 게시글 번호
const textWriter = document.getElementById('textWriter').textContent; // 작성자
const rate = document.getElementById('rate').textContent; // 작성자의 평점






let selectedValue = $selectElement.value;


let selectedText = document.getElementById('why').value;
let textareaValue = document.getElementById('reportText').value; //1번에 호출


// const $textareaElement = document.getElementById('reportText'); //2번
// const $textareaValue = $textareaElement.value;





console.log('로그확인됨', $confirmButton);

document.getElementById('confirmBtn').onclick = () => {
  const $chooseReason = document.getElementById('why'); // 선택지
  const $textareaValue = document.getElementById('reportText'); // 서술형

  const $rateStarFieldset = document.querySelector('.rate-star');
  const $checkedRadioButton = $rateStarFieldset.querySelector('input[name="rating"]:checked'); // 별점
  const rateValue = Number($checkedRadioButton.value); // 별점 값
  console.log(rateValue);

  console.log('좋아요 평가 제출~');
  const chooseReason = $chooseReason.value;
  const textareaValue = $textareaValue.value;
  if (chooseReason === '이유를 선택해주세요') {
    alert('이유를 선택해주세요!');
    return;
  } else if (rateValue === null) {
    alert('별점을 매겨주세요!');
    return;
  }

  console.log('boardNo: ', boardNo);
  console.log('textWriter: ', textWriter);
  console.log('chooseReason: ', chooseReason);
  console.log('textareaValue: ', textareaValue);
  

  fetch('/market/detail', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        boardNo: boardNo,
        textWriter: textWriter,
        message: textareaValue,
        chooseReason: chooseReason,
        rateValue: rateValue
      })
    })
    .then(response => response.text())//response.json() : Controller 데이터 받음
    .then(data => {
      
      alert(data);//controller의 body(text 내용 출력)
      location.reload();
    });
};
