/////수정하기 

const bno = document.getElementById('boardNo').textContent;
const modifyURL = `/market/detail/${bno}`; //백틱


// 수정 버튼 이벤트 발생
const $modifyBtn = document.getElementById('modifyBtn');
const $saveBtn = document.getElementById('saveEdit');


const $boardNo = document.getElementById('boardNo');

const $editedTitle = document.getElementById('editedTitle');
let editedTitle = document.getElementById('editedTitle').value;


const $editedContent = document.getElementById('editedContent');
let editedContent = document.getElementById('editedContent').value;


//수정 카테고리
const $editedCategory = document.getElementById('editedCategory');
let selectedCategory = document.getElementById('selectedCategory').value;


//가격
const $editedPrice = document.getElementById('editedPrice');
let editedPrice = document.getElementById('editedPrice').value;

//거래장소
const $editAddress = document.getElementById('editAddress');
let address = document.getElementById('address').value;


//닫기 버튼
const $modal = document.getElementById('editModal');

//삭제 버튼
const $deleteBtn = document.getElementById('content-Del');

//수정권한 부여
const currentAccount = '${login.account}';
const auth = '${login.auth}';



$modifyBtn.addEventListener('click', e => {
  console.log('수정 버튼 이벤트 발생!');
  //수정창에
  $editedTitle.value = document.getElementById('textTitle').textContent;
  $editedContent.value = document.getElementById('textContent').textContent;
  $editedCategory.value = document.getElementById('selectedCategory').textContent;
  $editedPrice.value = document.getElementById('price').textContent;
  $editAddress.value = document.getElementById('address').textContent;


  console.log($editedTitle.value);
  console.log($editedContent.value);
  makeModifyClickHandler();
})







// function makeCloseClickHandler() {
//   $closeBtn.onclick = e => {
//     console.log('닫기 버튼 클릭!');
//     $modal.style.display = "none"; // 모달을 숨김
//     location.reload(); // 화면 새로고침
//   };
// }

function makeModifyClickHandler() {
  console.log('수정 버튼 함수 실행!');

  if ($saveBtn) {
    $saveBtn.onclick = function() {
      if ($editedTitle.value === '' && $editedContent.value === '') {
        alert('내용은 필수입니다.');
        return;
      }


      const payload = {
        boardNo: bno,
        title: $editedTitle.value,
        text: $editedContent.value,
        category: $editedCategory.value,
        price: $editedPrice.value,
        address : $editAddress.value
    
      };

      const requestInfo = {
        method: 'PUT',
        headers: {
          'content-type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify(payload)
      };

      fetch(modifyURL, requestInfo)

        .then(res => {
          console.log(res.status);
          if (res.status === 200) {
            alert('내용 정상 변경');
            return res.text();
          } else {
            alert('입력값에 문제가 있습니다.');
            return res.text();
          }
        })

        .then(data => {
          console.log('응답 성공!', data);
          location.href='/market/detail/' + bno;
        });

    };
  }
}

// 삭제기능
$deleteBtn.addEventListener('click', e => {
  console.log('삭제 버튼 클릭!');

  if (confirm('정말로 삭제하시겠습니까?')) {
    deleteBoard();
    alert('삭제 되었습니다');
    window.location.href = '/market/list';
  }
});

function deleteBoard() {
  console.log('삭제 함수 내부');
  const requestInfo = {

    method: 'DELETE',
    headers: {
      'content-type': 'application/json; charset=utf-8'
    },
  };

  fetch(modifyURL, requestInfo)
    .then(res => {
      console.log(res.status);
      if (res.status === 200) {
        alert('게시물이 성공적으로 삭제되었습니다.');
        // 삭제 후 목록 페이지로 이동하거나, 홈 페이지로 리다이렉트할 수 있습니다.
        window.location.href = '/market/list'; // 목록 페이지로 이동
      } else {
        alert('게시물 삭제에 실패했습니다.');
        return;
      }
    });
}