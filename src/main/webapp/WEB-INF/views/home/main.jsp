<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>

    
    <%@ include file="../include/static-head.jsp" %>
    <link rel="stylesheet" href="/assets/css/header.css">

    <link rel="stylesheet" href="/assets/css/mainpage.css" >
    <link rel="stylesheet" href="/assets/css/snb.css" >
<link rel="stylesheet" href="/assets/css/weather.css">
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  
</head>
<body>

  <!-- 헤더 -->
  <%@ include file="../include/header.jsp" %>
  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>



  <!-- center 영역 -->
  <div class="wrapper">
    

    <!-- ============= 인기 게시글 ============= -->
    <section class="hot">
      <h2> 인기 게시글</h2>

      <div class="btn-container">

        <a href="/home/main">
          <i class="fa-solid fa-rotate-right"></i> <!-- 새로고침 아이콘 -->
        </a>
        
        <div class="btn-group" data-recent="${r}"> <!-- 버튼 그룹 (부트스트랩) -->
          <a href="#" id="popular" class="btn btn-primary" aria-current="page">인기순</a>
          <a href="#" id="recent" class="btn btn-primary">최신순</a>
        </div>

        
      </div>
      




      <div class="card-container"> <!-- 게시물 전체 영역 -->
        <c:forEach var="b" items="${bList}">

          <div class="card-wrapper"> <!-- 게시물 하나 영역 -->
            <section class="card" data-detail="/home/detail/${b.bno}" data-bno="${b.bno}">
              <div class="card-image">

                
                  <c:if test="${b.postImg == null}">
                    <img src="/assets/img/test.jpg" alt="기본 이미지">
                  </c:if>
              

                  <c:if test="${b.postImg != null}">
                    <img class="thumbnail" src="/display${b.postImg}" alt="업로드 이미지">
                  </c:if>
                
                
              </div>
              <div class="card-title-wrapper">
                <h2 class="card-title"><a href="/home/detail/${b.bno}">${b.title}</a></h2>
                <div class="time-like-wrapper">
                  <div class="time">
  
                    <i class="fa-regular fa-clock"> ${b.regDate2} </i>
                    
                  </div>
  
                  <div class="like">
                    <i class="fa-solid fa-heart"> ${b.likeCount} </i>
                  </div>
                </div>
              </div>
  
            </section>
  
          </div>
        </c:forEach>

        <!--
        <div class="card-wrapper">  게시물 하나 영역 (더미데이터) 
          <section class="card">
            <div class="card-image">
              <img src="/assets/img/test.jpg" alt="게시물 이미지">
            </div>
            <div class="card-title-wrapper">
              <h2 class="card-title"> <a href="#">게시물 제목</a> </h2>
              <div class="time-like-wrapper">
                <div class="time">

                  <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>
                  
                </div>
                <div class="like">
                  <i class="fa-solid fa-heart"> 332 </i>
                </div>
              </div>
            </div>
          

          </section>

        </div>
        -->

      </div>

    </section>

    <!-- ============= 당근마켓 ============= -->
    <section class="market">

      <div class="title-wrapper">
        <h2> 중고 장터 </h2>

        <a href="#" class="refresh">
          <i class="fa-solid fa-rotate-right"></i> <!-- 새로고침 아이콘 -->
        </a>
      </div>
      

      <div class="more-container">
        <a href="#" class="more-btn"> <!-- 더보기 -->
          더보기 
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </div>
      




      <div class="card-container"> <!-- 게시물 전체 영역 -->

        <!-- c:forEach -->


        <div class="card-wrapper"> <!-- 게시물 하나 영역 (더미데이터) -->
          <section class="card">
            <div class="card-image">
              <img src="/assets/img/test.jpg" alt="게시물 이미지">
            </div>
            <div class="card-title-wrapper">

              <a href="#">
                <h2 class="card-title">게임기 팝니다~</h2>
                <p>38,000원</p>

              </a>
              
              
              <div class="time-wrapper">
                <div class="time">
                  <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>                 
                </div>       
              </div>

            </div>

          </section>

        </div>

        <div class="card-wrapper"> <!-- 게시물 하나 영역 (더미데이터) -->
          <section class="card">
            <div class="card-image">
              <img src="/assets/img/test.jpg" alt="게시물 이미지">
            </div>
            <div class="card-title-wrapper">

              <a href="#">
                <h2 class="card-title">게임기 팝니다~</h2>
                <p>38,000원</p>

              </a>
              
              
              <div class="time-wrapper">
                <div class="time">
                  <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>                 
                </div>       
              </div>

            </div>

          </section>

        </div>

        <div class="card-wrapper"> <!-- 게시물 하나 영역 (더미데이터) -->
          <section class="card">
            <div class="card-image">
              <img src="/assets/img/test.jpg" alt="게시물 이미지">
            </div>
            <div class="card-title-wrapper">

              <a href="#">
                <h2 class="card-title">게임기 팝니다~</h2>
                <p>38,000원</p>

              </a>
              
              
              <div class="time-wrapper">
                <div class="time">
                  <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>                 
                </div>
              </div>

            </div>

          </section>

        </div>

        <div class="card-wrapper"> <!-- 게시물 하나 영역 (더미데이터) -->
          <section class="card">
            <div class="card-image">
              <img src="/assets/img/test.jpg" alt="게시물 이미지">
            </div>
            <div class="card-title-wrapper">

              <a href="#">
                <h2 class="card-title">게임기 팝니다~</h2>
                <p>38,000원</p>

              </a>
              
              
              <div class="time-wrapper">
                <div class="time">
                  <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>                 
                </div>       
              </div>

            </div>

          </section>

        </div>

    </section>

    <!-- ============= 스포츠 토토 ============= -->
    <section class="sports">
      <h2>경기 예측</h2>

    </section>

  </div>


  <!-- 메인페이지 자바스크립트 -->
  <script src="/assets/js/mainpage.js"></script>






</body>
</html>