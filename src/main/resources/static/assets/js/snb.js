// friends의 경우 서버에서 비동기 통신으로 친구 목록을 불러와서
// 객체 디스트럭처링 후 친구 user의 image 컬럼에 들어있는 image 주소를 불러와서
// img src 에 넣으면 된다. (innerHTML로 tag 추가, spring-webmvc의 detail.jsp 파일의 reply 참고)



/* 팔로우 리스트 */
const URL = '/api/v1/follow'; // 팔로우에 관련된 요청 url
const currentAccount = '${login.account}'; // 현재 로그인
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

      tag += `<div id='followContent' class='card-body' data-userId='${accountNumber}'>
        <div class='row user-block'>
        <span class='col-md-8'>
        <div class="profile-box">`;

      // 프로필 사진
      let profileTag = '';
      if (profilePicture) { // 프로필 사진이 존재한다면 
        profileTag = `<img src="/display\${profilePicture}" alt="프사">`;

      } else { // 프로필 사진이 없다면
        profileTag = `<img src="/assets/img/jjanggu.jpg" alt="기본 프사">`;

      }

      tag += profileTag;

      tag += `</div><a class="friendName" data-userId='\${accountNumber}' href="#">${nickname}</a>
                <b>(${email})</b>
              </span>
            </div>
          </div>`;

      tagDetail += `<div id="follow-detail" data-userAccount="${accountNumber}">`;

      tagDetail += `<p>    
                        ${nickname} 님<i class="fa-solid fa-x"></i>
                    </p>`;

      tagDetail += `<ul>
                        <li id="my-page"><i class="fa-solid fa-house"></i></li>
                        <li id="chatting"><i class="fa-solid fa-message"></i></li>
                        <li id="follow"><i class="fa-solid fa-user-plus"></i></li>
                        <li id="ban"><i class="fa-solid fa-ban"></i></li>
                    </ul></div>`;
      
    }

  } else { // 팔로우가 없다면
    tag += "<div id='followContent' class='card-body'>팔로우가 없습니다.</div>";
  }


        
  // 팔로우 렌더링
  // 반복문을 이용해서 문자열로 작성한 tag를 댓글영역 div에 innerHTML로 그대로 삽입
  document.getElementById('followData').innerHTML = tag;
  document.getElementById('follow-information').innerHTML = tagDetail;

  // 팔로워 이름 클릭하면 정보창 나오게 하기
  clickMyFollower(follows);
  

};


// 서버에 POST 요청 보내기
function requestPost() {
  console.log('서버에 fetch!');

  fetch('/api/v1/follow/following/6')
  .then(res => res.json())
  .then(followList => {
    console.log('Server response:', followList);

    renderFollows(followList);
});
}





/* 친구 정보 */
const $friends = document.querySelector('.friends');
// const $userInformation = document.getElementById('user-information');
const $xBtn = document.querySelector('.x-btn');

function clickMyFollower(followList) {

  $friends.onclick = e => {
    if (!e.target.matches('.friendName')) return;
    e.preventDefault();
    console.log(e.target);

    // 이벤트가 발생된 곳(수정, 삭제버튼)에서 가장 가까운 #followContent에 붙은 유저 계정
    const userId = e.target.closest('#followContent').dataset.userId;
    console.log('클릭한 유저 아이디: ', userId);

    const $followDetail = document.querySelector(`#follow-detail[data-userAccount="${userId}"]`);
    $followDetail.style.display = 'block';


    
    
    // #user-information 의 p태그가 누른 대상의 닉네임이 되어야 한다.
    // $userInformation.style.display = 'block';
    // $userInformation.classList.add("animate");
  
    // 애니메이션이 끝나면 animate 클래스 제거하기
    setTimeout(function() {
        image.classList.remove("animate");
    }, 500); // Adjust the duration to match the transition duration
    
  };



}








// x버튼을 누르면 창닫기
// $xBtn.onclick = e => {
//   console.log('x버튼 클릭');
//   $userInformation.style.display = 'none';
// }

// 텍스트의 디자인을 바꾸는 함수.
function checkPresentPage() {
  const presentPage = window.location.href // 현재 페이지가
  console.log('현재 페이지: ', presentPage);

  if (presentPage.includes("/home/main")) { // 메인 페이지라면
    document.getElementById('home').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/home/all")) { // 또는 전체 게시판 페이지라면
    document.getElementById('all').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/home/rps")) { // 또는 가위바위보 페이지라면
    document.getElementById('game').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/game")) { // 게임 게시판이라면
    console.log('현재 페이지는 게임 게시판~');
    document.getElementById('game-board').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/movie")) { // 영화 게시판이라면
    document.getElementById('movie').firstChild.classList.add('highlight');

  } else if (presentPage.includes("/home/board/trip")) { // 여행 게시판이라면
    document.getElementById('trip').firstChild.classList.add('highlight');
    
  } else if (presentPage.includes("/market/main")) { // 당근 마켓이라면
    document.getElementById('second-hand').firstChild.classList.add('highlight');

  } else {
    console.log('아무것도 적용이 안됨');
  }
}



// 즉시실행함수
(() => {

  // 현재 페이지에 따라 메뉴 텍스트의 디자인을 바꾸는 함수.
  checkPresentPage();

  // 서버에 팔로우 정보 요청보내기
  requestPost();
    
  
})();

    




    /* 채팅 모달창 */
    // const $modal = document.getElementById();

    // addEventListener('click', () => {
    //   $modal.style.display = 'block';
    // });


    // appendPageActive();
