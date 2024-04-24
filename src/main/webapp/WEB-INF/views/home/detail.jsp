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
  <link rel="stylesheet" href="/assets/css/detail.css" >
  <link rel="stylesheet" href="/assets/css/snb.css" >

    

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

            <div class="writer-info">
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
            <h2 id="see-reply"> <a href="#tag1"> 댓글 53 </a></h2>

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
        <div class="like" data-like-cookie="${l}">
          <!-- <i class="fa-solid fa-heart"></i> : check 됐을 때 -->
          <i class="fa-regular fa-heart"></i>
          <label class="like-label" for="flexCheckDefault" data-like-count="${b.likeCount}">
            좋아요 ${b.likeCount}
          </label>
        </div>


        <!-- 화면 이동에 관련한 버튼 -->
        <div class="buttons">
            <button class="list-btn" type="button"
                    onclick="location.href='/home/all'">
                목록
            </button>
            <button id="modify">수정</button>
            <button id="delete">삭제</button>
        </div>

      </div>

    </section>

    <!-- ==================== 신고 모달 영역 ==================== -->
    <section class="report">
      <!-- Button trigger modal -->
      <button id="clame-btn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
        신고하기
      </button>

      <!-- Modal -->
      <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
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

                                <c:if test="${login.profile == null}">
                                  

                                </c:if>
                                
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
  

  <!-- 사이드바 자바스크립트 -->
  <script src="/assets/js/detail.js"></script>


  <!-- bootstrap js -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

  
</body>
</html>