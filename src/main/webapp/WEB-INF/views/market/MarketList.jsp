<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>All page</title>

  
  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/allpage.css">
  <link rel="stylesheet" href="/assets/css/snb.css">

  <script src="/assets/js/MarketList.js" defer></script>


  <style>

    .btn-primary {
      padding: auto;
    }

    .anchor {
      display: block;
      background-color: red;
    }
  </style>

</head>

<body>

  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>

  <%@ include file="../include/headcss.jsp"%>
  <%@ include file="../include/header.jsp"%>

  <!-- center 영역 -->
  <div class="wrapper">

    <section class="all">
      <h2> 중고 거래 게시글</h2>
      <button type="button" class="btn btn-primary"><a href="/market/write">글쓰기</a></button>


      <div class="list-container">

        <table>



          <thead class="head-wrapper">
            <!-- 게시판 헤드 -->
            <tr>
              <th>글번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회수</th>
              <th>즐겨찾기</th>
              <th>판태상태</th>
              <th>가격</th>
              <th>거래장소</th>
            </tr>
          </thead>




          <tbody>

            <c:forEach var="s" items="${bList}">
              <tr class="post">
                <!-- 게시글 하나 -->
                <td id="bno">${s.boardNo}</td>
                <td id="textTitle" name="textTitle"> <a href="/market/detail/${s.boardNo}"> ${s.textTitle} </a></td>
                <td id="textWriter" name="textWriter">${s.textWriter}</td>
                <td id="updateDate" name="updateDate">${s.updateDate}</td>
                <td id="viewCount" name="viewCount"> ${s.viewCount}</td>

                <td class="favorite" name="favorite" data-bno="${s.boardNo}">
                  <c:if test="${s.isFavorite == 1}">
                    <i class="fa-solid fa-star"></i>
                  </c:if>

                  <c:if test="${s.isFavorite == 0}">
                    <i class="fa-regular fa-star"></i>
                  </c:if>

                </td>

                <td id="category" name="category">${s.category}</td>
                <td id="price" name="price">${s.price}</td>
                <td id="address" name="address">${s.address}</td>


              </tr>
            </c:forEach>

            <!-- Add more rows as needed -->
          </tbody>
        </table>



      </div>
    </section>
  </div>
  <script>
    const $post = document.querySelector('post');

    $post.addEventListener('click', e => {
      if (e.target === e.currentTarget) {
        location.href = '/market/detail/${s.boardNo}';
        console.log("e.target === e.currentTarget");


      }
      console.log("클릭됨");
      location.href = '/market/detail/${s.boardNo}';

    });



    // const $addFavButtons = document.querySelectorAll('#addFav');

    // $addFavButtons.forEach(button => {
    //   button.addEventListener('click', function () {
    //     const boardNo = this.getAttribute('data-boardNo');
    //     const isAddFav = this.getAttribute('data-favorite') === 'true';

    //     if (isAddFav) {
    //       this.innerHTML = '&#x2606;'; // 외곽 별로 변경
    //     } else {
    //       this.innerHTML = '&#x2665;'; // 하트로 변경
    //     }

    //     fetch(`/market/list/${boardNo}?addFav=${!isAddFav}`, {
    //         method: 'POST',
    //         headers: {
    //           'Content-Type': 'application/json',
    //         },
    //         body: JSON.stringify({
    //           isAddFav: !isAddFav
    //         }),
    //       })
    //       .then(response => response.json())
    //       .then(data => {
    //         if (data.success) {
    //           this.setAttribute('data-favorite', !isAddFav);
    //         } else {
    //           alert('즐겨찾기 상태를 업데이트하는데 실패했습니다.');
    //         }
    //       })
    //       .catch(error => {
    //         console.error('Error:', error);
    //         alert('서버와의 통신에 문제가 발생했습니다.');
    //       });
    //   });
    // });
  </script>

</body>

</html>