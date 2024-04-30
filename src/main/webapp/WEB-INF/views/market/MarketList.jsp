<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>MarketList Page</title>


  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/allpage.css">
  <link rel="stylesheet" href="/assets/css/snb.css">

  <!-- 즐겨찾기 js defer -->
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

    .boardList th {

      text-align: center;
      /* 텍스트를 가운데 정렬합니다. */
      margin: 10px;
      /* 적절한 내부 여백을 설정합니다. */
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
              <th>이미지</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회수</th>
              <th id="favBtn" name="favBtn">즐겨찾기</th>
              <th>판태상태</th>
              <th>가격</th>
              <th>거래장소</th>
            </tr>
          </thead>




          <tbody>

            <c:forEach var="s" items="${bList}">
              <!-- 게시글 하나 -->
              <tr class="post" data-bno="${s.boardNo}">

                <td id="bno" class="bno">${s.boardNo}</td>

                <c:choose>
                  <c:when test="${s.file != null}">
                    <td id="board-img" style="height: 50px; width: 50px; vertical-align: middle;">
                      <img style="width: 100%; height: 100%;" src="/display${s.file}" alt="업로드 이미지">
                    </td>
                  </c:when>

                  <c:otherwise>
                    <td id="board-img" style="height: 50px; width: 50px; vertical-align: middle;"></td>
                  </c:otherwise>
                </c:choose>

                <td id="textTitle" name="textTitle"> <a href="/market/detail/${s.boardNo}"> ${s.textTitle} </a></td>
                <td id="textWriter" name="textWriter">${s.textWriter}</td>
                <td id="updateDate" name="updateDate">${s.updateDate}</td>
                <td id="viewCount" name="viewCount" data-view-count="${s.viewCount}"> ${s.viewCount}</td>

                <td class="favorite" name="favorite" data-bno="${s.boardNo}">
                  <c:if test="${s.isFavorite == 1}">
                    <i class="fa-solid fa-star" id="favOn" data-fav-on="{$s.favOn}"></i>
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


          <!-- 댓글 페이징 영역 -->
          <!-- <ul class="pagination justify-content-center"> -->
          <!--
                < JS로 댓글 페이징 DIV삽입 >
            -->
          <!-- </ul>  -->


          <div class="bottom-section">

            <!-- 페이지 버튼 영역 -->
            <nav aria-label="Page navigation example">
              <ul class="pagination pagination-lg pagination-custom">
                <c:if test="${maker.page.pageNo != 1}">
                  <li class="page-item"><a class="page-link"
                      href="/market/list?pageNo=1&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&lt;&lt;</a>
                  </li>
                </c:if>


                <c:if test="${maker.prev}">
                  <li class="page-item"><a class="page-link"
                      href="/market/list?pageNo=${maker.begin-1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">prev</a>
                  </li>
                </c:if>

                <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                  <li data-page-num="${i}" class="page-item">
                    <a class="page-link"
                      href="/market/list?pageNo=${i}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">${i}</a>
                  </li>
                </c:forEach>

                <c:if test="${maker.next}">
                  <li class="page-item"><a class="page-link"
                      href="/market/list?pageNo=${maker.end+1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">next</a>
                  </li>
                </c:if>

                <c:if test="${maker.page.pageNo != maker.finalPage}">
                  <li class="page-item"><a class="page-link"
                      href="/market/list?pageNo=${maker.finalPage}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&gt;&gt;</a>
                  </li>
                </c:if>

              </ul>
            </nav>

          </div>
      </div>





      </table>





  </div>
  </section>
  </div>



  <script>
    // 화면에 페이지 버튼들을 렌더링하는 함수
    // function renderPage({
    //   begin,
    //   end,
    //   prev,
    //   next,
    //   page,
    //   finalPage
    // }) {
    //   let tag = '';

    //   if (prev) {
    //     tag += `<li class='page-item'><a class='page-link page-active' href='\${begin - 1}'>이전</a></li>`;
    //   }

    //   for (let i = begin; i <= end; i++) {
    //     let active = '';
    //     if (page.pageNo === i) {
    //       active = 'active';
    //     }
    //     tag += `<li class='page-item \${active}'><a class='page-link page-custom' href='\${i}'>\${i}</a></li>`;
    //   }

    //   if (next) {
    //     tag += `<li class='page-item'><a class='page-link page-active' href='\${end + 1}'>다음</a></li>`;
    //   }

    //   const $pageUl = document.querySelector('ul.pagination');
    //   $pageUl.innerHTML = tag;

    // }



    // function makePageButtonClickHandler() {
    //   const $pageUl = document.querySelector('.pagination');

    //   $pageUl.onclick = e => {
    //     if (!e.target.matches('.page-item a')) return;
    //     e.preventDefault();
    //     fetchGetReplies(e.target.getAttribute('href'));
    //   }

    // }

















    //메뉴 버튼 전체 클릭 이벤트
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




    //즐겨찾기만 보기

    //즐겨찾기 글자요소
    const $favBtn = document.getElementById('favBtn');
    //즐겨찾기(검은별)요소
    const $favOn = document.getElementById('favOn');


    $favBtn.addEventListener('click', function (e) {

      //favOn 버튼의 활성화 상태를 토글
      $favBtn.classList.toggle('active'); //우선 선언


      //favON 버튼의 활성화 여부 확인
      const isFavOn = $favBtn.classList.contains('active'); //boolean
      console.log('isFavOn: ', isFavOn);

      // 모든 포스트 요소들 가져오기
      const bListItems = [...document.querySelectorAll('.post')]; //querySelectorAll 유사배열 ->[... ] 배열화 后 forEach
      console.log('bListItem: ', bListItems);
      bListItems.forEach(item => { //a.forEach(b ) 이름 다르게

        //포스트의 즐겨찾기 여부 확인
        const isFavorite = item.querySelector('.favorite i').classList.contains('fa-solid');
        console.log('isFavorite: ', isFavorite);

        //즐겨찾기가 활성화되어 있고 즐겨찾기가 아닌 포스트를 감춤
        //즐겨찾기가 비활성화되어 있으면 모든 포스트 보이기
        if (isFavOn && !isFavorite) {
          console.log('즐겨찾기 활성화 and isFavorite: false');
          item.style.display = 'none'; //감추기
        } else {
          item.style.display = 'table-row' //보이기
        }
      });




      // fetch('/market/favorite', {
      //     method: 'POST', // HTTP POST 요청
      //     headers: {
      //       'Content-Type': 'application/json' // JSON 형식의 데이터를 전송할 것임을 지정
      //     },
      //     body: JSON.stringify({ // 전송할 데이터를 JSON 문자열로 변환하여 body에 설정
      //       isFavOn: isFavOn
      //     })
      //   })
      //   .then(response => {
      //     // 응답을 처리
      //     if (!response.ok) {
      //       throw new Error('Network response was not ok');
      //     }
      //     return response.json(); // JSON 형식의 응답 데이터를 JavaScript 객체로 변환
      //   })
      //   .then(data => {
      //     // 성공적으로 데이터를 받았을 때의 처리
      //     console.log(data); // 받은 데이터를 콘솔에 출력하거나 필요한 처리를 수행
      //   })
      //   .catch(error => {
      //     // 요청이 실패했을 때의 처리
      //     console.error('There was a problem with your fetch operation:', error);
      //   });

    });









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


    // (() => {

    //   // 페이지 번호 클릭 이벤트 핸들러
    //   makePageButtonClickHandler();
    // })();


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