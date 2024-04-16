<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Detail Page</title>

  <%@ include file="../include/static-head.jsp" %>

  <link rel="stylesheet" href="/assets/css/detail.css" >
  <link rel="stylesheet" href="/assets/css/snb.css" >

    

</head>

<body>

  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>

  <!-- ================================= center wrapper ================================= -->


  <div class="wrapper">

    <!-- ==================== 게시글 영역 ==================== -->
    <section class="board">
      <div id="wrap" class="form-container">

        <!-- 게시글 번호 (Primary key) -->
        <h1 id="bno">3142번</h1>
        

        <!-- 제목 -->
        <!-- <input type="text" id="title" name="title" value="${b.title}" readonly> -->
        <h1 id="title">게시글 제목</h1>

        <div class="board-info">

          <div class="left-region">
            <!-- 작성자 -->
            <!-- 누르면 작성자가 쓴 글 목록, 작성자의 페이지, 1:1채팅, 신고하기, 차단하기 등 -->
            <h2 id="writer"><a href="#" id="writer-a">작성자</a></h2> 

            <div class="writer-info">
              <ul>
                <li><a href="#">게시글 보기</a></li>
                <li><a href="#">1:1 채팅</a></li>
                <li><a id="claim-writer" href="#">신고하기</a></li>
                <li><a href="#">차단하기</a></li>
              </ul>
            </div>
            
            <!-- 작성 날짜 시간 -->
            <h2 id="date">2024-04-16 06:14</h2>
          </div>

  
          <div class="right-region">
            <!-- 누르면 클립보드에 현재 페이지의 URL이 들어감 -->
            <h2 id="copy-url"> <a href="#">URL 복사</a> </h2>
  
            <!-- 댓글 개수 : 누르면 댓글영역으로 이동-->
            <h2 id="see-reply"> <a href="#tag1"> 댓글 5</a></h2>
  
          </div>

        </div>

        
        
        

    
        <hr>
    
        
    
        <!-- <label for="content">내용</label> -->
        <div id="content">${b.content} 여기는 게시글 내용이 들어갈 자리입니다. <br> 
        게시글 내용을 자유롭게 써주세요 <br>
        게시글 내용 test</div>

        <div class="buttons">
            <button class="list-btn" type="button"
                    onclick="location.href='/home/all'">
                목록
            </button>
            <button id="modify">수정</button>
            <button id="delete">삭제</button>
        </div>

    </section>

    <!-- ==================== 신고 모달 영역 ==================== -->
    <section class="claim">
      <!-- Button trigger modal -->
      <button id="clame-btn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
        신고하기
      </button>

      <!-- Modal -->
      <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">


          <form id="claim-form" action="/home/detail/claim" method="post">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">작성자 님을 신고</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">

                <!-- 모달 신고 내용 영역 -->


                <label for="claim-object">신고 대상</label>
                <span> 작성자 </span>
                <br>

                

                  <label for="claim-question">신고 사유</label>
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="clame-reason" value="advertisement" id="advertisement">
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
                      지나친 정치/종교 논쟁
                    </label>
                  </div>

                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="clame-reason" value="plaster" id="plaster">
                    <label class="form-check-label" for="flexCheckChecked">
                      도배성 댓글
                    </label>
                  </div>


                  <label for="claim-reason">기타 사유가 있으면 말씀해주세요</label>
                  <textarea rows="3" id="claimText" name="claimText" class="form-control"
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

      <!-- 댓글 작성 영역 -->
      <div class="card">
          <div class="card-body">

              
                  <a href="/members/sign-in">댓글은 로그인 후에 작성할 수 있습니다.</a>
            
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
                                
                                      <!-- <img src="" alt="프사"> -->
                                 
                              </div>


                              <label for="newReplyWriter" hidden>댓글 작성자</label>
                              <input id="newReplyWriter" name="replyWriter" type="text"
                                    class="form-control" placeholder="작성자 이름"
                                    style="margin-bottom: 6px;" value="${login.name}" readonly>
                              <button id="replyAddBtn" type="button"
                                      class="btn btn-dark form-control">등록
                              </button>
                          </div>
                      </div>
                  </div>


          </div>
      </div> <!-- end reply write -->


       <!--댓글 내용 영역-->
       <div class="card">
          <!-- 댓글 내용 헤더 -->
          <div class="card-header" >
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



    </section>


    

  </div>
  



  <!-- ================================= JavaScript ================================= -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script>

  const $writer = document.getElementById('writer');
  const $writerInformation = document.querySelector('.writer-info');

  // 작성자 누르면 관련 기능 
  document.querySelector('body').onclick = (e) => {
    console.log(e.target);

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

    alert("Page URL copied to clipboard: " + currentPageUrl);

  };

  // 신고버튼 누르기
  const $clameWriter = document.getElementById('claim-writer');
  $clameWriter.onclick = () => {
    console.log('신고!!');
    document.getElementById('clame-btn').click();
  };

  // 신고 form 제출
  // document.getElementById('claim-form').addEventListener("submit", function(e) {

  //   console.log('신고 제출!');
  //   e.preventDefault();

  //   // true or false
  //   const advertisement = document.getElementById("advertisement").checked;
  //   const bad = document.getElementById("bad").checked;
  //   const dispute = document.getElementById("dispute").checked;
  //   const plaster = document.getElementById("plaster").checked;

  //   // String
  //   const message = document.getElementById("claimText").value; // 기타 신고 사유 textArea
  //   console.log(advertisement);
  //   console.log(bad);
  //   console.log(message);

  // });










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




    /* 채팅 모달창 */
    // const $modal = document.getElementById();

    // addEventListener('click', () => {
    //   $modal.style.display = 'block';
    // });


    // appendPageActive();




  </script>
  
</body>
</html>