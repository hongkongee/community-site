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

  <script src="/assets/js/MarketAddFav.js" defer></script>


  <style>
    .btn-primary {
      padding: auto;
    }

    .anchor {
      display: block;
      background-color: red;
    }

    .post {
      cursor: pointer;
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
            <tr class="boardList">
              <th>글번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회수</th>
              <th>즐겨찾기</th>
              <th>판태상태</th>
              <th>가격</th>
              <th>거래장소</th>
              <th>좋아요</th>
            </tr>
          </thead>




          <tbody>

            <c:forEach var="s" items="${bList}">
              <!-- 게시글 하나 -->
              <tr class="post" data-bno="${s.boardNo}">
                
                <td id="bno" class="bno">${s.boardNo}</td>
                <td id="textTitle" name="textTitle"> <a href="/market/detail/${s.boardNo}"> ${s.textTitle} </a></td>
                <td id="textWriter" name="textWriter">${s.textWriter}</td>
                <td id="updateDate" name="updateDate">${s.updateDate}</td>
                <td id="viewCount" name="viewCount" data-view-count="${s.viewCount}"> ${s.viewCount}</td>

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
                <td id="rate" name="rate"> ${s.rate}</td>


              </tr>
            </c:forEach>

            <!-- Add more rows as needed -->
          </tbody>
        </table>

      </div>
    </section>
  </div>



  <script>

    document.querySelector('tbody').onclick = e => {
      console.log('클릭 이벤트 발생');
      if (e.target.matches('.fa-star')) {
        clickFav(e);
        return;
      }
      const bno = e.target.closest('tr.post').dataset.bno;
      console.log('bno : ', bno);
      window.location.href = '/market/detail/' + bno;
    }








    // document.addEventListener('DOMContentLoaded', function () {
    //   const $posts = document.querySelectorAll('.post');

    //   $posts.forEach(post => {
    //     post.addEventListener('click', function (e) {
    //       // 클릭된 요소가 a 태그인 경우 (제목을 클릭한 경우)
    //       if (e.target.tagName === 'A') {
    //         return; // detail 페이지로 이동하는 기본 동작 수행
    //       }

    //       // 클릭된 요소가 tr 태그이고, 클릭된 요소가 즐겨찾기 아이콘이 아닌 경우
    //       if (this.contains(e.target) && !e.target.classList.contains('favorite')) {
    //         const boardNo = document.querySelector('.bno').textContent;
    //         location.href = `/market/detail/${boardNo}`;
    //       }
    //     });
    //   });
    // });





    document.addEventListener('DOMContentLoaded', function () {
      // viewCount id를 가진 요소를 취득
      const viewCountElement = document.getElementById('viewCount');

      // viewCount id를 가진 요소가 존재하는 경우에만 작업 수행
      if (viewCountElement) {
        // viewCount id를 가진 요소 내의 모든 <option> 요소 취득
        const options = viewCountElement.querySelectorAll('option');

        // 각 <option> 요소에 스타일 적용
        options.forEach(option => {
        //배열 메서드인 forEach()를 사용하여 배열 또는 유사 배열 객체의 각 요소에 대해 반복

          const viewCount = parseInt(option.getAttribute('data-view-count'));
          //parseInt(...): 이 함수는 문자열을 정수로 변환
          if (viewCount > 10) {
            option.style.color = 'red';
            option.style.fontWeight = 'bold';
            
          }
        });
      }
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