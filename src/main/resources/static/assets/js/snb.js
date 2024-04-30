// friends의 경우 서버에서 비동기 통신으로 친구 목록을 불러와서
// 객체 디스트럭처링 후 친구 user의 image 컬럼에 들어있는 image 주소를 불러와서
// img src 에 넣으면 된다. (innerHTML로 tag 추가, spring-webmvc의 detail.jsp 파일의 reply 참고)



/* 팔로우 리스트 */
const URL = '/api/v1/follow'; // 팔로우에 관련된 요청 url
const currentAccount = '${login.account}'; // 현재 로그인
console.log(currentAccount);
const number = 6; // 팔로우 목록에 뜨는 팔로워 수


function renderFollows(follows) {
  let tag = '';
  let tagDetail = '';
  console.log('팔로우 정보 렌더링!');

  if (follows !== null && follows.length > 0) { // 팔로우가 존재한다면

    for (let follower of follows) {

      const {accountNumber, name, email, nickname, profilePicture} = follower;
      console.log('nickname:', nickname);
      console.log('email:', email);

      tag += `<div id='followContent' class='card-body' data-userid='${accountNumber}'>
        <div class='row user-block'>
        <span class='col-md-8'>
        <div class="profile-box" data-userid='${accountNumber}'>`;

      // 프로필 사진
      let profileTag = '';
      if (profilePicture) { // 프로필 사진이 존재한다면 
        profileTag = `<img src="/display${profilePicture}" alt="프사">`;
      } else { // 프로필 사진이 없다면
        profileTag = `<img src="/assets/img/jjanggu.jpg" alt="기본 프사">`;

      }

      tag += profileTag;

      tag += `</div><a class="friendName" data-userId='${accountNumber}' href="#">${nickname}</a>
                <b>(${email})</b>
              </span>
            </div>
          </div>`;

      tagDetail += `<div class="follow-detail" data-userAccount="${accountNumber}">`;

      tagDetail += `<p>    
                        ${nickname} 님<i class="fa-solid fa-x"></i>
                    </p>`;

      tagDetail += `<ul>
                        <li id="my-page"><i class="fa-solid fa-house"></i></li>
                        <li id="chatting"><i class="fa-solid fa-message"></i></li>
                        <li id="ban"><i class="fa-solid fa-user-minus"></i></i></li>
                    </ul></div>`;
      
    }

  } else { // 팔로우가 없다면
    tag += "<div id='followContent' class='card-body'>팔로우가 없습니다.</div>";
  }


        
  // 팔로우 렌더링
  // 반복문을 이용해서 문자열로 작성한 tag를 댓글영역 div에 innerHTML로 그대로 삽입
  document.getElementById('followData').innerHTML = tag;
  document.getElementById('follow-information').innerHTML = tagDetail;

  // 팔로워 이름 또는 프로필 이미지를 클릭하면 정보창 나오게 하기
  clickMyFollower();

  // x버튼을 클릭하면 정보창 닫기
  clickXbutton();
  

};


// 서버에 팔로잉 리스트 조회 POST 요청 보내기
function requestPost() {
  console.log('서버에 fetch!');

  fetch('/api/v1/follow/following/6')
  .then(res => res.json())
  .then(followList => {
    console.log('Server response:', followList);

    renderFollows(followList);
  });
}

// 서버에 팔로잉 취소(삭제) POST 요청 보내기
function deleteFollow(userAccount) {
  var formData = {
    userAccount: userAccount
  };

  fetch('/api/v1/follow/delete', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify(formData)
  })
  .then(response => response.text())
  .then(data => {
    console.log(data);
    alert('정상적으로 팔로잉을 취소했습니다.')
    location.reload(); // 새로고침
  });
    
}





/* 팔로워 정보 */

// 팔로워 이름을 누르면 정보창 뜨기
function clickMyFollower() {

  document.getElementById('followCollapse').onclick = e => {
    if (e.target.matches('.friendName')) {

      e.preventDefault();
      console.log('e.target: ', e.target);

      const userId = e.target.dataset.userid;
      console.log('클릭한 유저 아이디: ', userId);

      console.log(document.querySelector(`.follow-detail[data-useraccount=${userId}]`));
      document.querySelector(`.follow-detail[data-useraccount=${userId}]`).style.display = 'block';

    } else if (e.target.matches('.profile-box>img')) {
      console.log('e.target: ', e.target);
      const userId = e.target.parentNode.dataset.userid;
      console.log(document.querySelector(`.follow-detail[data-useraccount=${userId}]`));
      document.querySelector(`.follow-detail[data-useraccount=${userId}]`).style.display = 'block';

    }
    

  };

}

// x버튼을 누르면 창닫기
function clickXbutton() {
  document.getElementById('follow-information').onclick = e => {
    const userAccount = e.target.parentNode.parentNode.parentNode.dataset.useraccount;

    if (e.target.matches('.fa-x')) { // x버튼 클릭
      console.log('x버튼 클릭');
      e.target.parentNode.parentNode.style.display = 'none';

    } else if (e.target.matches('.fa-user-minus')) { // 팔로우 취소버튼 클릭
      console.log('팔로잉 취소!');
      console.log(userAccount);
      deleteFollow(userAccount);
    } else if (e.target.matches('.fa-house')) { // 집모양 아이콘 클릭

      window.location.href='/mypage/home/' + userAccount;
    } else if (e.target.matches('.fa-message')) {
      window.location.href = '/chat/chat';
    }
    
  }
}







// 텍스트의 디자인을 바꾸는 함수.
function checkPresentPage() {
  const presentPage = window.location.href // 현재 페이지가
  console.log('현재 페이지: ', presentPage);

  if (presentPage.includes("/home/main")) { // 메인 페이지라면
    document.getElementById('home').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/all")) { // 또는 전체 게시판 페이지라면
    document.getElementById('all').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/game/rps")) { // 또는 가위바위보 페이지라면
    document.getElementById('rsp').lastChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/normal")) { // 일반 게시판이라면
    console.log('현재 페이지는 게임 게시판~');
    document.getElementById('normal').lastChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/game")) { // 게임 게시판이라면
    console.log('현재 페이지는 게임 게시판~');
    document.getElementById('game-board').lastChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/movie")) { // 영화 게시판이라면
    document.getElementById('movie').lastChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/trip")) { // 여행 게시판이라면
    document.getElementById('trip').lastChild.classList.add('highlight');
    
  } else if (presentPage.includes("/home/board/market")) { // 당근 게시판이라면
    document.getElementById('market').lastChild.classList.add('highlight');
    
  } else if (presentPage.includes("/market/list")) { // 당근 마켓이라면
    document.querySelector('#second-hand>a').classList.add('highlight');

  } else {
    console.log('아무것도 적용이 안됨');
  }
}

// 서버에 로그인 유저 정보 (포인트 등) 가져오기
function loginUserInformation() {
  console.log('login User\'s information~');

  fetch('/home/snb', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    }})
  .then(res => res.json())
  .then(point => {

    console.log('point = ', point);
    document.getElementById('my-point-snb').textContent = point + ' P';

  });




}



// 즉시실행함수
(() => {

  // 현재 페이지에 따라 메뉴 텍스트의 디자인을 바꾸는 함수.
  checkPresentPage();

  // 서버에 팔로우 정보 요청보내기
  requestPost();

  // 서버에 로그인 유저 정보 요청보내기
  loginUserInformation();    
  
})();

    




    /* 채팅 모달창 */
    // const $modal = document.getElementById();

    // addEventListener('click', () => {
    //   $modal.style.display = 'block';
    // });


    // appendPageActive();
