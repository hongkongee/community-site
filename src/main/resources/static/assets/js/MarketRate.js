
const $confirmButton = document.getElementById('confirmBtn');

const $selectElement = document.querySelector('.form-select');
const $selectedValue = $selectElement.value;
const $selectedText = $selectElement.options[$selectElement.selectedIndex].text;

const boardNo = document.getElementById('boardNo').textContent;
const textWriter = document.getElementById('textWriter').textContent;
const rate = document.getElementById('rate').textContent;


let selectedValue = $selectElement.value;


let selectedText = document.getElementById('why').value;
let textareaValue = document.getElementById('reportText').value; //1번에 호출


// const $textareaElement = document.getElementById('reportText'); //2번
// const $textareaValue = $textareaElement.value;


console.log('로그확인됨', $confirmButton);

const likeBtnClickHandler = e => {
  

  fetch(`/market/detail/${boardNo}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        boardNo: boardNo,
        textWriter: textWriter,
        message: textareaValue,
        chooseReason: selectedText,
        rate: rate

      })
    })
    .then(response => response.text())//response.json() : Controller 데이터 받음
    .then(data => {
      
      alert(data);//controller의 body(text 내용 출력)
      location.reload();
    });
};
