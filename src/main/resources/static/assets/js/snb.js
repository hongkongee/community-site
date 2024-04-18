// friends의 경우 서버에서 비동기 통신으로 친구 목록을 불러와서
// 객체 디스트럭처링 후 친구 user의 image 컬럼에 들어있는 image 주소를 불러와서
// img src 에 넣으면 된다. (innerHTML로 tag 추가, spring-webmvc의 detail.jsp 파일의 reply 참고)




    /* 친구 정보 */
    const $friends = document.querySelector('.friends');
    const $userInformation = document.getElementById('user-information');
    const $xBtn = document.getElementById('x-btn');

    $friends.onclick = e => {
      if(!e.target.matches('.friend')) return;
      e.preventDefault();
      
      // #user-information 의 p태그가 누른 대상의 닉네임이 되어야 한다.
      $userInformation.style.display = 'block';
      $userInformation.classList.add("animate");

      // 애니메이션이 끝나면 animate 클래스 제거하기
      setTimeout(function() {
          image.classList.remove("animate");
      }, 500); // Adjust the duration to match the transition duration
      
    };

    $xBtn.onclick = e => {
      console.log('x버튼 클릭');
      $userInformation.style.display = 'none';
    }

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
        
      
    })();

    




    /* 채팅 모달창 */
    // const $modal = document.getElementById();

    // addEventListener('click', () => {
    //   $modal.style.display = 'block';
    // });


    // appendPageActive();
