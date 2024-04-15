<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>

    <%@ include file="../include/static-head.jsp" %>

    <link rel="stylesheet" href="/assets/css/mainpage.css" >
    <link rel="stylesheet" href="/assets/css/snb.css" >

  
  </head>
  <body>
  
    <!-- 사이드바 -->
    <%@ include file="../include/snb.jsp" %>


    <!-- center 영역 -->
    <div class="wrapper">
      
  
      <!-- ============= 인기 게시글 ============= -->
      <section class="hot">
        <h2> 인기 게시글</h2>
  
        <div class="btn-container">
  
          <a href="#">
            <i class="fa-solid fa-rotate-right"></i> <!-- 새로고침 아이콘 -->
          </a>
          
          <div class="btn-group"> <!-- 버튼 그룹 (부트스트랩) -->
            <a href="#" class="btn btn-primary active" aria-current="page">인기순</a>
            <a href="#" class="btn btn-primary">최신순</a>
          </div>
  
          
        </div>
        
  
  
  
  
        <div class="card-container"> <!-- 게시물 전체 영역 -->
          <!-- c:forEach -->
          <div class="card-wrapper"> <!-- 게시물 하나 영역 (더미데이터) -->
            <section class="card">
              <div class="card-image">
                <img src="/assets/img/test.jpg" alt="게시물 이미지">
              </div>
              <div class="card-title-wrapper">
                <h2 class="card-title"><a href="#">게시물 제목</a></h2>
                <div class="time-like-wrapper">
                  <div class="time">
  
                    <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>
                    
                  </div>
  
                  <div class="like">
                    <i class="fa-solid fa-heart"> 286</i>
                  </div>
                </div>
              </div>
  
            </section>
  
          </div>
  
          <div class="card-wrapper"> <!-- 게시물 하나 영역-->
            <section class="card">
              <div class="card-image">
                <img src="/assets/img/test.jpg" alt="게시물 이미지">
              </div>
              <div class="card-title-wrapper">
                <h2 class="card-title"><a href="#">게시물 제목</a></h2>
                <div class="time-like-wrapper">
                  <div class="time">
  
                    <i class="fa-regular fa-clock"> 2024-04-12 16:20</i>
                    
                  </div>
  
                  <div class="like">
                    <i class="fa-solid fa-heart"> 192</i>
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
                <h2 class="card-title"><a href="#">게시물 제목</a></h2>
                <div class="time-like-wrapper">
                  <div class="time">
  
                    <i class="fa-regular fa-clock">2024-04-12 16:20</i>
                    
                  </div>
  
                  <div class="like">
                    <i class="fa-solid fa-heart"> 114</i>
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
                <h2 class="card-title"><a href="#">게시물 제목</a></h2>
                <div class="time-like-wrapper">
                  <div class="time">
  
                    <i class="fa-regular fa-clock">2024-04-12 16:20</i>
                    
                  </div>
  
                  <div class="like">
                    <i class="fa-solid fa-heart"> 423</i>
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
                <h2 class="card-title"><a href="#">게시물 제목</a></h2>
                <div class="time-like-wrapper">
                  <div class="time">
  
                    <i class="fa-regular fa-clock"> 2024-04-12 16:20 </i>
                    
                  </div>
  
                  <div class="like">
                    <i class="fa-solid fa-heart"> 324 </i>
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


  

    
  </body>
  </html>