<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>All page</title>

    <%@ include file="../include/static-head.jsp" %>

    <!-- header css -->
    <link rel="stylesheet" href="/assets/css/header.css" >

    <link rel="stylesheet" href="/assets/css/allpage.css" >
    <link rel="stylesheet" href="/assets/css/snb.css" >


</head>
<body>


    <!-- 헤더 -->
    <%@ include file="../include/header.jsp" %>

    <!-- 사이드바 -->
    <%@ include file="../include/snb.jsp" %>


    <!-- center 영역 -->
    <div class="wrapper">

        <section class="all">
          <h2> ${li} </h2>

          <!-- <c:if test="${login != null}"> -->
            <button class="add-btn"><a id="go-write-page" href="/home/write"> 글쓰기 </a></button>
          <!-- </c:if> -->
    
          <div class="list-container">
    
            <table>
              
    
              
              <thead class="head-wrapper"> <!-- 게시판 헤드 -->
                <tr>
                  <th>글번호</th>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일</th>
                  <th>조회수</th>
                </tr>
              </thead>
              
                
              
    
              <tbody>

                <c:forEach var="b" items="${bList}">
                  <div class="one-board">
                    <tr class="post"> <!-- 게시글 하나 -->
                      <td id="bno">${b.bno}</td>
                      <td id="category">${b.category}</td>
                      <td id="title"> <a href="#" data-bno="${b.bno}"> ${b.title} </a></td> <!-- 게시글 페이지로-->
                      <td id="writer"> <a href="#">${b.writer}</a></td> <!-- 유저 정보 페이지 -->
                      <td id="date">${b.regDate}</td>
                      <td id="view">${b.viewCount}</td>
                    </tr>

                  </div>


                </c:forEach>
    
            
                
                
                
                <!-- <tr class="post"> 
                  <td id="bno">2</td>
                  <td id="title"> <a href="#"> Sample Post 2 </a></td>
                  <td id="writer"><a href="#">홍길동</a></td></td>
                  <td id="date">2024-04-15</td>
                  <td id="view">100</td>
                </tr> -->
    
    
    
                
                <!-- Add more rows as needed -->
              </tbody>
            </table>
    
          </div>
          
    
        </section>
    
     
    
    
    
        <!-- 게시글 목록 하단 영역 -->
        <div class="bottom-section">
    
          <!-- 페이지 버튼 영역 -->
          <nav aria-label="Page navigation example">
              <ul class="pagination pagination-lg pagination-custom">
    
    
                  <c:if test="${maker.page.pageNo != 1}">
                      <li class="page-item"><a class="page-link"
                                                href="/board/list?pageNo=1&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&lt;&lt;</a>
                      </li>
                  </c:if>
    
                  <c:if test="${maker.prev}">
                      <li class="page-item"><a class="page-link"
                                                href="/board/list?pageNo=${maker.begin-1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">prev</a>
                      </li>
                  </c:if>
    
                  <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                      <li data-page-num="${i}" class="page-item">
                          <a class="page-link"
                              href="/board/list?pageNo=${i}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">132</a>
                      </li>
                  </c:forEach>
    
                  <c:if test="${maker.next}">
                      <li class="page-item"><a class="page-link"
                                                href="/board/list?pageNo=${maker.end+1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">next</a>
                      </li>
                  </c:if>
    
                  <c:if test="${maker.page.pageNo != maker.finalPage}">
                      <li class="page-item"><a class="page-link"
                                                href="/board/list?pageNo=${maker.finalPage}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&gt;&gt;</a>
                      </li>
                  </c:if>
    
              </ul>
          </nav>
    
      </div> <!-- bottom-section end -->
    
    
    
    
    
    </div> <!-- wrapper end -->

    <script>


      const $tbody = document.querySelector('tbody');

      // 게시물 상세 조회
      $tbody.addEventListener('click', e => {

        console.log('이벤트 타겟: ', e.target);

        if (e.target.matches('#title a')) {
          const bno = e.target.dataset.bno;
          console.log('bno: ', bno);
          window.location.href = '/home/detail/' + bno;
        }

      });


    </script>

    
</body>
</html>