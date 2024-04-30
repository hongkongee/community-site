<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>상세 페이지</title>

  <%@ include file="../include/static-head.jsp" %>

  <link rel="stylesheet" href="/assets/css/header.css">
  <link rel="stylesheet" href="/assets/css/detail.css">
  <link rel="stylesheet" href="/assets/css/snb.css">



</head>

<body>

  <!-- 헤더 -->
  <%@ include file="../include/header.jsp" %>
  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>

  <!-- ================================= center wrapper ================================= -->


  <div class="wrapper">

    <!-- ==================== 게시글 영역 ==================== -->
    <section class="board">
      <div id="wrap" class="form-container" data-category="${b.category}">

        <!-- 게시글 카테고리 (누르면 해당 메뉴로 이동) -->
        <h1 id="bno"> <a href="/home/board/${b.category}">${b.categoryDescription}</a> </h1>


        <!-- 제목 -->
        <!-- <input type="text" id="title" name="title" value="${b.title}" readonly> -->
        <h1 id="title">${b.title}</h1>

        <div class="board-info" data-bno="${b.bno}" data-writer="${b.writer}" data-writeraccount="${b.writerAccount}">

          <div class="left-region">
            <!-- 작성자 -->
            <!-- 누르면 작성자가 쓴 글 목록, 작성자의 페이지, 1:1채팅, 신고하기, 차단하기 등 -->
            <h2 id="writer"><a href="#" id="writer-a">${b.writer}</a></h2>

            <div class="writer-info" data-writeraccount="${b.writerAccount}">
              <ul>
                <li><a href="#">게시글 보기</a></li>
                <li><a href="#">1:1 채팅</a></li>
                <li><a id="report-writer" href="#">신고하기</a></li>
                <li><a id="add-following" href="#" data-writeraccount="${b.writerAccount}">팔로잉</a></li>
              </ul>
            </div>

            <!-- 작성 날짜 시간 -->
            <h2 id="date">${b.regDate}</h2>
          </div>


          <div class="right-region">
            <!-- 누르면 클립보드에 현재 페이지의 URL이 들어감 -->
            <h2 id="copy-url"> <a href="#">URL 복사</a> </h2>

            <!-- 댓글 개수 : 누르면 댓글영역으로 이동-->
            <h2 id="see-reply"> <a href="#tag1"> 댓글 <span id="replyCntAbove" style="color: black"></span> </a></h2>

            <h2 id="view-count"> ${b.viewCount} </h2>

          </div>

        </div>






        <hr>

        <div id="board-img">
          <c:if test="${b.postImg != null}">
            <img src="/display${b.postImg}" alt="업로드 이미지">
          </c:if>

        </div>

        <!-- <label for="content">내용</label> -->
        <div id="content">${b.content}</div>

        <!-- 좋아요 -->
        <div class="like" id="like-data" data-likeornot="${l}">
          <!-- <i class="fa-solid fa-heart"></i> : check 됐을 때 -->
          <i class="fa-regular fa-heart"></i>
          <label class="like-label" for="flexCheckDefault" data-like-count="${b.likeCount}">
            좋아요 ${b.likeCount}
          </label>
        </div>


        <!-- 화면 이동에 관련한 버튼 -->
        <div class="buttons">

          <button class="list-btn" type="button" onclick="location.href='/home/board/all'">
            목록
          </button>
          <c:if test="${login.accountNumber eq b.writerAccount}">
            <button id="modify"> <a href="/home/modify/${b.bno}">수정</a></button>
            <button id="delete">삭제</button>
          </c:if>


        </div>

      </div>

    </section>

    <!-- ==================== 신고 모달 영역 ==================== -->
    <section class="report">
      <!-- Button trigger modal -->
      <button id="clame-btn" type="button" class="btn btn-primary" data-bs-toggle="modal"
        data-bs-target="#staticBackdrop">
        신고하기
      </button>

      <!-- Modal -->
      <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">


          <form id="report-form" action="/home/detail/report" method="post">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">${b.writer} 님을 신고</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">

                <!-- 모달 신고 내용 영역 -->


                <label for="report-object">신고 대상</label>
                <span> ${b.writer} </span>
                <br>



                <label for="report-question">신고 사유</label>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="clame-reason" value="advertisement"
                    id="advertisement">
                  <label class="form-check-label" for="flexCheckDefault">
                    광고 등 홍보성 게시글
                  </label>
                </div>

                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="clame-reason" value="bad" id="bad">
                  <label class="form-check-label" for="flexCheckChecked">
                    욕설 등 부적절한 언어
                  </label>
                </div>

                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="clame-reason" value="dispute" id="dispute">
                  <label class="form-check-label" for="flexCheckChecked">
                    게시판 성격과 맞지 않는 글
                  </label>
                </div>

                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="clame-reason" value="plaster" id="plaster">
                  <label class="form-check-label" for="flexCheckChecked">
                    도배성 글
                  </label>
                </div>


                <label for="report-reason">기타 사유가 있으면 말씀해주세요</label>
                <textarea rows="3" id="reportText" name="reportText" class="form-control"
                  placeholder="신고 사유를 입력해주세요"></textarea>


              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="submit" class="btn btn-primary">제출</button>
              </div>
            </div>
          </form>


        </div>
      </div>
    </section>

    <!-- ==================== 댓글 영역 ==================== -->
    <section class="reply">
      <a id="tag1"></a>

      <div id="replies" class="row">
        <!-- 댓글 작성 영역 -->
        <div class="card">
          <div class="card-body">
            <c:if test="${login == null}">
              <a href="/users/sign-in">댓글은 로그인 후에 작성할 수 있습니다.</a>
            </c:if>
            <c:if test="${login != null}">
              <div class="row">
                <div class="col-md-9">
                  <div class="form-group">
                    <label for="newReplyText" hidden>댓글 내용</label>
                    <textarea rows="3" id="newReplyText" name="replyText" class="form-control"
                      placeholder="댓글을 입력해주세요."></textarea>
                  </div>
                </div>
                <div class="col-md-3">
                  <div class="form-group">
                    <div class="profile-box">
                      <!--profilePicture로 수정-->
                      <c:if test="${login.profilePicture == null}">
                        <img src="/assets/img/jjanggu.jpg" alt="프사">
                      </c:if>
                      <!--profilePicture로 수정-->
                      <c:if test="${login.profilePicture != null}">
                        <c:choose>
                          <c:when test="${login.loginMethod == 'COMMON'}">
                            <!--profilePicture로 수정-->
                            <img src="/display${login.profilePicture}" alt="프사">
                          </c:when>
                          <c:otherwise>
                            <!--profilePicture로 수정-->
                            <img src="${login.profilePicture}" alt="프사">
                          </c:otherwise>
                        </c:choose>
                      </c:if>
                    </div>
                    <label for="newReplyWriter" hidden>댓글 작성자</label>
                    <input id="newReplyWriter" name="replyWriter" type="text" class="form-control" placeholder="작성자 이름"
                      style="margin-bottom: 6px;" value="${login.name}" readonly>
                    <button id="replyAddBtn" type="button" class="btn btn-dark form-control">등록
                    </button>
                  </div>
                </div>
              </div>
            </c:if>
          </div>
        </div> <!-- end reply write -->
        <!--댓글 내용 영역-->
        <div class="card">
          <!-- 댓글 내용 헤더 -->
          <div class="card-header">
            <div class="float-left">댓글 (<span id="replyCnt">0</span>)</div>
          </div>
          <!-- 댓글 내용 바디 -->
          <div id="replyCollapse" class="card">
            <div id="replyData">
              <!--
                    < JS로 댓글 정보 DIV삽입 >
                --> 댓글 내용
            </div>
            <!-- 댓글 페이징 영역 -->
            <ul class="pagination justify-content-center">
              <!--
                    < JS로 댓글 페이징 DIV삽입 >
                --> 댓글 페이징
            </ul>
          </div>
        </div> <!-- end reply content -->
      </div> <!-- end replies row -->
    </section>

    <div class="modal fade bd-example-modal-lg" id="replyModifyModal">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">

          <!-- Modal Header -->
          <div class="modal-header" style="background: #343A40; color: white;">
            <h4 class="modal-title">댓글 수정하기</h4>
            <button type="button" class="close text-white" data-bs-dismiss="modal">X</button>
          </div>

          <!-- Modal body -->
          <div class="modal-body">
            <div class="form-group">
              <input id="modReplyId" type="hidden">
              <label for="modReplyText" hidden>댓글내용</label>
              <textarea id="modReplyText" class="form-control" placeholder="수정할 댓글 내용을 입력하세요." rows="3"></textarea>
            </div>
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
            <button id="replyModBtn" type="button" class="btn btn-dark" style="font-size: 13px;">수정</button>
            <button id="modal-close" type="button" class="btn btn-danger" data-bs-dismiss="modal"
              style="font-size: 13px;">닫기
            </button>
          </div>
        </div>
      </div>
    </div>


  </div>


  <!-- 사이드바 자바스크립트 -->
  <script src="/assets/js/detail.js"></script>

  <script>
    // 댓글 기능

    // 댓글 기능 
    const replyURL = '/api/v1/replies';
    const loginAccount = '${login.accountNumber}'; // 로그인한 사람 계정
    const boardNo = '${b.bno}'
    const auth = '${login.auth}'; // 로그인한 사람 권한

    console.log(loginAccount);
    console.log(auth);

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
        tag += `<li class='page-item'><a class='page-link page-active' href='\${begin - 1}'>이전</a></li>`;
      }

      for (let i = begin; i <= end; i++) {
        let active = '';
        if (page.pageNo === i) {
          active = 'active';
        }
        tag += `<li class='page-item \${active}'><a class='page-link page-custom' href='\${i}'>\${i}</a></li>`;
      }

      if (next) {
        tag += `<li class='page-item'><a class='page-link page-active' href='\${end + 1}'>다음</a></li>`;
      }

      const $pageUl = document.querySelector('ul.pagination');
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
            profilePicture,
            loginMethod
          } = reply;
          console.log(profilePicture);

          

          tag += `
                     <div id='replyContent' class='card-body' data-replyId='\${rno}'>
                     <div class='row user-block'>
                     <span class='col-md-8'>`;

          let profileTag = '';
          if (profilePicture) {
            if (loginMethod.trim() === 'COMMON') {
              profileTag = `<img class='reply-profile' src='/display\${profilePicture}' alt='profile image' style="width: 45px; height: 45px; border-radius: 50%; overflow: hidden; font-size: 12px; margin-right: 20px;" >`;
            } else {
              profileTag = `<img class='reply-profile' src='/display\${profilePicture}' alt='profile image' style="width: 45px; height: 45px; border-radius: 50%; overflow: hidden; font-size: 12px; margin-right: 20px;" >`;
            }
          } else {
            profileTag =
              `<img class='reply-profile' src='/assets/img/jjanggu.jpg' alt='default profile' style="width: 45px; height: 45px; border-radius: 50%; overflow: hidden; font-size: 12px; margin-right: 20px;" >`;
          }
          tag += profileTag;

          //tag += (profile ? `<img class='reply-profile' src='/display\${login.profilePicture}' alt='profile image' >`
          //                  : `<img class='reply-profile' src='/assets/img/jjanggu.jpg' alt='anonymous image' >`);

          tag += `<b>\${writer}</b>
                     </span>
                     <span class='col-md-4 text-right' style="width= 30%;"><b style="font-size:13px;">\${updateDate ? updateDate : regDate}</b></span>
                     </div><br>
                     <div class='row'>
                     <div class='col-md-9'>\${text}</div>
                     <div class='col-md-3 text-right' style="display: flex;">`;

          if (auth === '관리자' || loginAccount === account) {
            tag += `
                       <a id='replyModBtn' class='fa-solid fa-user-pen' data-bs-toggle='modal' data-bs-target='#replyModifyModal' style="font-size:13px;">수정</a>&nbsp;
                       <a id='replyDelBtn' class='fa-solid fa-delete-left' href='#' style="font-size:13px;">삭제</a>`;
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
      document.getElementById('replyCntAbove').textContent = count;
      // 댓글 렌더링
      // 반복문을 이용해서 문자열로 작성한 tag를 댓글영역 div에 innerHTML로 그대로 삽입.
      document.getElementById('replyData').innerHTML = tag;

      // 페이지 렌더링 함수 호출
      renderPage(pageInfo);

    };

    function fetchGetReplies(pageNum = 1) {
      fetch(`\${replyURL}/\${bno}/page/\${pageNum}`)
        .then(res => res.json())
        .then(replyList => {
          console.log(replyList);

          renderReplies(replyList);
        });
    }

    function makePageButtonClickHandler() {
      const $pageUl = document.querySelector('.pagination');

      $pageUl.onclick = e => {
        if (!e.target.matches('.page-item a')) return;
        e.preventDefault();
        fetchGetReplies(e.target.getAttribute('href'));
      }


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
          bno: boardNo
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

            // 댓글 목록 새로고침
            fetchGetReplies();
          });

      }
    }



    // 댓글 삭제 + 수정모드 진입 이벤트 핸들러
    function makeReplyRemoveClickHandler() {

      const $replyData = document.getElementById('replyData');

      $replyData.onclick = e => {
        e.preventDefault();

        const rno = e.target.closest('#replyContent').dataset.replyid;

        if (e.target.matches('#replyDelBtn')) {
          if (!confirm('정말로 삭제하시겠습니까?')) return;

          fetch(`\${replyURL}/\${rno}`, {
              method: 'DELETE'
            })
            .then(res => {
              if (res.status == 200) {
                alert('댓글이 삭제되었습니다.');
                fetchGetReplies();
              } else {
                alert('오류가 발생했습니다. 관리자에게 문의하세요.');
                return;
              }
            });


        } else if (e.target.matches('#replyModBtn')) {
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


    // ================ 매인 실행부
    // 즉시 실행함수를 통해 페이지가 로딩되면 함수가 자동호출됨.
    (() => {
      // 댓글 서버에서 불러오기
      fetchGetReplies();

      // 페이지 번호 클릭 이벤트 핸들러
      makePageButtonClickHandler();

      // 댓글 삭제 & 수정 버튼 발생하는 이벤트 핸들러
      makeReplyRemoveClickHandler();

      // 댓글 수정 클릭 이벤트 핸들러
      makeReplyModifyClickhHandler();

    })();
  </script>

  <!-- bootstrap js -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
  </script>


</body>

</html>