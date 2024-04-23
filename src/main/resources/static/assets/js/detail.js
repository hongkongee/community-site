const $writer = document.getElementById('writer');
const $writerInformation = document.querySelector('.writer-info');
const bno = document.querySelector('.board-info').dataset.bno; // 현재 페이지 글번호
const writer = document.querySelector('.board-info').dataset.writer; // 현재 페이지 작성자
let likeFlag = 0; // 쿠키 존재 여부 (1 이면 좋아요 이미 부여)
const $likeLabel = document.querySelector('.like .like-label'); // 좋아요 텍스트
const $heartBtn = document.querySelector('.like>i.fa-heart'); // 좋아요 하트 아이콘


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

// 댓글 기능 
const replyURL = '/api/v1/replies';
// const loginAccount = '${login.account}'; // 로그인한 사람 계정
const auth = '${login.auth}'; // 로그인한 사람 권한


// 댓글 삭제 + 수정모드 진입 이벤트 핸들러
function makeReplyRemoveClickHandler() {

  const $replyData = document.getElementById('replyData');

  $replyData.onclick = e => {
    e.preventDefault();

    const rno = e.target.closest('#replyContent').dataset.replyid;

    if (e.target.matches('#replyDelBtn')) {
      if (!confirm('정말로 삭제하시겠습니까?')) return;

      fetch(`${replyURL}/${rno}`, {
          method: 'DELETE'
        })
        .then(rest => {
          if (res.status == 200) {
            alert('댓글이 삭제되었습니다.');
            fetchGetReplies();
          } else {
            alert('오류가 발생했습니다. 관리자에게 문의하세요.');
            return;
          }
        });


    } else if (e.target.matche('#replyModBtn')) {
      // 기존에 작성한 댓글 내용을 가져오기
      const replyText = e.target.parentNode.previousElementSibling.textContent;
      // 읽어온 댓글 내용을 모달 바다에 집어넣기
      document.getElementById('modReplyText').value = replyText;
      // 읽어놓은 댓글번호도 모달 안에 있는 input hidden에 집어놓기
      document.getElementById('modReplyId').value = rno;

    }

  }

}

function makeReplyModifyClickhHandler() {

  const $modBtn = document.getElementById('replyModBtn');

  $modBtn.addEventListener('click', e => {

      const payload = {
        rno: +document.getElementById('modReplyId').value,
        text: document.getElementById('modReplyText').value
      };
      console.log(payload);

      const requestInfo = {
        method: 'PUT',
        headers: {
          'content-type': 'application/json'
        },
        body: JSON.stringify(payload)
      };

      fetch(replyURL, requestInfo)
        .then(res => {
          if (res.status == 200) {
            alert('댓글이 수정되었습니다.');
            document.getElementById('modal-close').click();
            return res.text();
          } else {
            alert('수정값에 문제가 있습니다. 내용을 확인하세요!');
            document.getElementById('modalReplyText').value = '';
            return;
          }
        })
        .then(data => {
          console.log(data);
          fetchGetReplies();
        });
  });

}


// 화면에 페이지 버튼들을 렌더링하는 함수
function renderPage({
  begin,
  end,
  prev,
  next,
  page,
  finalPage
}) {
  let tag = '';

  if (prev) {
    tag += `<li class='page-item'><a class='page-link page-active' href='${begin - 1}'>이전</a></li>`;
  }

  for (let i = begin; i <= end; i++) {
    let active = '';
    if (page.pageNo === i) {
      active = 'active';
    }
    tag += `<li class='page-item ${active}'><a class='page-link page-custom' href='${i}'>${i}</a></li>`;
  }

  if (next) {
    tag += `<li class='page-item'><a class='page-link page-active' href='${end + 1}'>다음</a></li>`;
  }

  const $pageUl = document.querySelector('.pagination');
  $pageUl.innerHTML = tag;

}


// 화면에 댓글 태그들을 렌더링하는 함수
function renderReplies(replyList) {
  const {
    count,
    pageInfo,
    replies
  } = replyList;
  let tag = '';

  if (replies !== null && replies.length > 0) {
    for (let reply of replies) {
      // 객체 디스트럭처링
      const {
        rno,
        writer,
        text,
        regDate,
        updateDate,
        account,
        profile,
        loginMethod
      } = reply;

      tag += `
                     <div id='replyContent' class='card-body' data-replyId='${rno}'>
                     <div class='row user-block'>
                     <span class='col-md-8'>`;

      let profileTag = '';
      if (profile) {
        if (loginMethod.trim() === 'COMMON') {
          profileTag = `<img class='reply-profile' src='/local${profile}' alt='profile image' >`;
        } else {
          profileTag = `<img class='reply-profile' src='${profile}' alt='profile image' >`;
        }
      } else {
        profileTag = `<img class='reply-profile' src='/assets/img/anonymous.jpg' alt='anonymous image' >`;
      }
      tag += profileTag;

      //tag += (profile ? `<img class='reply-profile' src='/local\${profile}' alt='profile image' >`
      //                  : `<img class='reply-profile' src='/assets/img/anonymous.jpg' alt='anonymous image' >`);

      tag += `<b>${writer}</b>
                     </span>
                     <span class='col-md-4 text-right'><b>${updateDate ? updateDate : regDate}</b></span>
                     </div><br>
                     <div class='row'>
                     <div class='col-md-9'>${text}</div>
                     <div class='col-md-3 text-right'>`;

      if (auth === '관리자회원' || currentAccount === account) {
        tag += `
                     <a id='replyModBtn' class='btn btn-sm btn-outline-dark' data-bs-toggle='modal' data-bs-target='#replyModifyModal'>수정</a>&nbsp;
                     <a id='replyDelBtn' class='btn btn-sm btn-outline-dark' href='#'>삭제</a>`;
      }


      tag += `   </div>
                  </div>
                  </div>
                  `;
    }
  } else {
    tag += "<div id='replyContent' class='card-body'>댓글이 아직 없습니다!</div>";
  }
  // 댓글 수 렌더링
  document.getElementById('replyCnt').textContent = count;
  // 댓글 렌더링
  // 반복문을 이용해서 문자열로 작성한 tag를 댓글영역 div에 innerHTML로 그대로 삽입.
  document.getElementById('replyData').innerHTML = tag;

  // 페이지 렌더링 함수 호출
  renderPage(pageInfo);

};

function makePageButtonClickHandler() {
  const $pageUl = document.querySelector('.pagination');

  $pageUl.onclick = e => {
    if (!e.target.matches('.page-item a')) return;
    e.preventDefault();
    fetchGetReplies(e.target.getAttribute('href'));
  }


}

function fetchGetReplies(pageNum = 1) {
  fetch(`${replyURL}/${bno}/page/${pageNum}`)
    .then(res => res.json())
    .then(replyList => {
      console.log(replyList);

      renderReplies(replyList);
    })
}

// 댓글 추가 버튼 등록
const $replyAddBtn = document.getElementById('replyAddBtn');

// 댓글 버튼 이벤트
if ($replyAddBtn) {
  $replyAddBtn.onclick = e => {

    // 댓글 내용
    const $replyText = document.getElementById('newReplyText');
    // 댓글 작성자
    const $replyWriter = document.getElementById('newReplyWriter');

    // 공백 제거된 값을 얻기
    const textVal = $replyText.value.trim();
    const writerVal = $replyWriter.value.trim();

    // 사용자 입력값 검증
    if (textVal === '') {
      alert('댓글 내용은 필수값입니다.');
      return;
    } else if (writerVal === '') {
      alert('댓글 작성자는 필수값입니다.');
      return;
    } else if (writerVal.length < 2 || writerVal.length > 8) {
      alert('댓글 작성자는 2글자에서 8글자 사이로 작성하세요!');
      return;
    }

    // 서버로 보낼 데이터 준비. (js 객체)
    const payload = {
      text: textVal,
      author: writerVal,
      bno: bno
    };

    // 요청 방식 및 데이터를 전달할 정보 객체 만들기 (POST)
    const requestInfo = {
      method: 'POST',
      headers: {
        'content-type': 'application/json'
      },
      body: JSON.stringify(payload)
    }

    // 서버에서 POST 요청 보내기
    fetch(replyURL, requestInfo)
      .then(res => {
        console.log(res.status);
        if (res.status === 200) {
          alert('댓글이 정상 등록되었습니다.')
          return res.text();
        } else {
          alert('댓글 등록에 실패하였습니다.')
          return res.text();
        }
      })
      .then(data => {
        console.log('응답 성공! ', data);
        $replyText.value = '';
        $replyWriter.value = '';

        // 댓글 목록 새로고침
        fetchGetReplies();
      });

  }
}





// 좋아요 누르면 게시물 좋아요 수 1 증가시키고 취소하면 1 감소시키기
function likeCountUpDown(n) {
  console.log('좋아요 수를 변경합니다.');

  var formData = {
    bno: bno, // 게시글 번호
    number: n // likeCount에 더할 값
  };

  fetch("/home/detail/like", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
      console.log("Form submission successful:", data);
    })
    .catch(error => {
      console.error("Error submitting form:", error);
    });

}

// 페이지 진입 부터 좋아요 하트 체크여부 부여 (과거 이미 체크했다면 부여)
function alreadyLike() {

  // DB에 이미 저장됨 (이미 클릭) -> likeFlag = 1
  likeFlag = document.querySelector('.like').dataset.likeCookie;
  likeFlag = Number(likeFlag);
  console.log('이미 좋아요를 눌렀나요?', likeFlag);

  if (likeFlag === 1) { // 과거에 체크를 이미 했다면
    $heartBtn.classList.remove('fa-regular');
    $heartBtn.classList.add('fa-solid'); // 체크 부여
  } else { // 체크를 한 적이 없다면
    $heartBtn.classList.remove('fa-solid');
    $heartBtn.classList.add('fa-regular'); // 체크 해제
  }

}



// 좋아요 누르면 하트 색깔 바뀌기
function clickHeartBtn() {
  console.log(likeFlag);

  if (likeFlag === 0) {
    console.log('하트버튼 클릭!');
    if ($heartBtn.classList.contains('fa-solid')) { // 체크가 된 상태 라면
      likeCountUpDown(-1);
      $heartBtn.classList.remove('fa-solid');
      $heartBtn.classList.add('fa-regular'); // 체크 해제
      $likeLabel.textContent = '좋아요 ' + $likeLabel.dataset.likeCount;

    } else { // 체크가 안 된 상태라면
      likeCountUpDown(1);
      $heartBtn.classList.remove('fa-regular');
      $heartBtn.classList.add('fa-solid'); // 체크 부여

      // 클릭할 때마다 likeCount 실시간 반영
      const realTimeLike = Number($likeLabel.dataset.likeCount) + 1
      $likeLabel.textContent = '좋아요 ' + realTimeLike;
    }

  }

  if (likeFlag === 1) {

    if ($heartBtn.classList.contains('fa-solid')) { // 체크가 된 상태 라면
      likeCountUpDown(-1);
      $heartBtn.classList.remove('fa-solid');
      $heartBtn.classList.add('fa-regular'); // 체크 해제
      const realTimeLike = Number($likeLabel.dataset.likeCount) - 1
      $likeLabel.textContent = '좋아요 ' + realTimeLike

    } else { // 체크가 안 된 상태라면
      likeCountUpDown(1);
      $heartBtn.classList.remove('fa-regular');
      $heartBtn.classList.add('fa-solid'); // 체크 부여
      $likeLabel.textContent = '좋아요 ' + $likeLabel.dataset.likeCount;
    }

  }




};


// 클릭 이벤트 발생
document.querySelector('.wrapper').onclick = e => {
  console.log(e.target);

  if (e.target.matches('#writer-a')) { // 작성자를 누르면

    if ($writerInformation.style.display === 'none') {
      $writerInformation.style.display = 'block'; // 창이 뜬다
    } else {
      $writerInformation.style.display = 'none'
    }

    return;
  }

  if (e.target.matches('.writer-info a')) { // 선택지를 누르면
    return; // 창을 닫지 않는다.
  }

  if (e.target.matches('.like>i.fa-heart')) { // 좋아요를 누르면
    clickHeartBtn();
    return;
  }

  // 그 외의 영역을 누르면
  console.log('창 닫기');
  $writerInformation.style.display = 'none'; // 창이 없어진다

};






// 신고버튼 누르기
const $clameWriter = document.getElementById('report-writer');
$clameWriter.onclick = () => {
  console.log('신고!!');
  document.getElementById('clame-btn').click();
};




// 신고 form 제출
document.getElementById('report-form').addEventListener("submit", function (e) {

  console.log('신고 제출!');
  e.preventDefault(); // form 기능 없애기

  // true or false checkbox 배열
  var interests = [];
  var checkboxes = document.querySelectorAll('input[name="clame-reason"]:checked');
  console.log(checkboxes); // nodelist

  checkboxes.forEach(function (checkbox) { // 배열 고차 함수
    interests.push(checkbox.value); // 체크한 항목만 모아둔 배열 (정제된 형태의 배열)
  });
  console.log(interests);

  var message = document.getElementById("reportText").value;

  // *********************** AJAX : 서버에 유저 신고 요청 보내기 ***********************

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
  document.getElementById("reportText").value = '';
  document.getElementById("advertisement").checked = false;
  document.getElementById("bad").checked = false;
  document.getElementById("dispute").checked = false;
  document.getElementById("plaster").checked = false;



});

// 팔로잉 누르기
const $addFollowing = document.getElementById('add-following');
$addFollowing.onclick = () => {
  console.log('팔로잉!!');
  const writerAccount = $addFollowing.dataset.writeraccount;
  console.log(writerAccount);

  var formData = {
    writerAccount: writerAccount
  };

  fetch('/api/v1/follow/add', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      // Parse the response body as JSON
      return response.json();
    })
    .then(data => {
      console.log('1인 경우에만 정상 팔로우 처리 완료: ', data);

      if (data === 1) {
        alert('정상적으로 팔로잉 했습니다.');
        location.reload(); // 새로고침
      } else if (data === 2) {
        alert('자기 자신은 팔로잉할 수 없습니다.');
      } else if (data === 3) {
        alert('이미 팔로잉한 회원입니다.');
      }


    });

};


// 즉시 실행 함수
(() => {

  // 댓글 서버에서 불러오기
  fetchGetReplies();

  // 페이지 번호 클릭 이벤트 핸들러
  makePageButtonClickHandler();

  // 댓글 삭제 & 수정 버튼 발생하는 이벤트 핸들러
  makeReplyRemoveClickHandler();

  // 댓글 수정 클릭 이벤트 핸들러
  makeReplyModifyClickhHandler();

  alreadyLike();


})();