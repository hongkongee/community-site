<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">


  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/market.css">
  <link rel="stylesheet" href="/assets/css/snb.css">



</head>

<body>

  <%@ include file="../include/snb.jsp" %>


  <!-- 가운데 Content -->
  <div class="wrapper">

    <!-- ContentBox 내용 제일 위-->
    <div class="content-box">


      <%@ include file="../market/subMarketUserHeader.jsp" %>
      <!-- Head 내용 -->



      <!-- Title 내용 -->


      <div class="title">


        <div class="titleContentBox">
          <span>#작성자 : </span><span id="textWriter">${b.textWriter}</span>
          <span>#글번호 : </span><span id="boardNo">${b.boardNo}</span>
          <span>#신용도 : </span><span id="rate">5.0</span>
          <span>#작성시간 : </span><span id="updateDate">${b.updateDate}</span><br>
          <span>#제목 : </span><span id="textTitle">${b.textTitle}</span>
          <span>#가격 : </span><span id="price">${b.price}</span><span>원</span>
          <span>#판매자 선호 거래지역 : </span><span id="address">${b.address}</span>
          <span>#판매상태 : </span><span id="selectedCategory">${b.category}</span>
        </div>
      </div>




      <!-- Content 내용 -->
      <div class="content-group">
        <div class="Content1">

          <button class="content-list"><a href="/market/list">목록</a></button></button>
          <button class="content-Write"><a href="/market/write">글쓰기</a></button>
          <button id="content-Del">삭제</button>
          <button id="modifyBtn" class="content-Rev" type="button" data-bs-toggle="modal"
            data-bs-target="#editModal">간단수정</button>




        </div>
        <br>
        <div class="ContentBox">

          <div class="normal" id="textContent">${b.textContent}</div>
        </div>
        <!-- 지도 -->
        <%@ include file="../market/subMap.jsp" %>

        <!-- 광고 영역 -->
        <%@ include file="../market/subMarketAD.jsp" %>
      </div>


      <!-- 수정 내용 입력 모달 -->
      <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
        aria-hidden="true">

        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="editModalLabel">내용 수정</h5>
            </div>

            <div class="modal-body">
              <!-- 내용 수정 폼 -->
              <form id="editForm">
                <div class="form-group">
                  <label for="editedTitle">수정할 제목</label>
                  <input type="text" class="form-control" id="editedTitle" style="width: 100%;"
                    placeholder="수정할 제목 입력하세요">
                  <label for="editedContent">수정할 내용</label>
                  <textarea class="form-control-lg" id="editedContent" rows="20" cols="50"
                    style="width: 100%;"></textarea>
                  <select name="category" id="editedCategory">
                    <option value="sale">판매중</option>
                    <option value="sold">판매완료</option>
                  </select>

                  <br>
                  <label for="categorySelect">수정할 가격</label>
                  <input type="int" class="form-control" id="categorySelect" style="width: 100%;">


                </div>
              </form>
            </div>


            <div class="modal-footer">
              <!-- 닫기 버튼 -->
              <button type="button" class="btn btn-secondary" id="closeBtn" data-dismiss="modal">닫기</button>
              <!-- 수정 완료 버튼 -->
              <button type="button" class="btn btn-primary" id="saveEdit">수정 완료</button>
            </div>
          </div>
        </div>
      </div>



    </div>

  </div>





  <script>
    const URL = '/market/detail/${b.boardNo}';
    const bno = '${b.boardNo}';
    console.log('bno: ', bno);

    // 수정 버튼 이벤트 발생
    const $modifyBtn = document.getElementById('modifyBtn');
    const $saveBtn = document.getElementById('saveEdit');

    //수정요소
    const $boardNo = document.getElementById('boardNo'); //class . 찍기
    const $editedTitle = document.getElementById('editedTitle');
    const $editedContent = document.getElementById('editedContent');

    //수정 카테고리
    const $categorySelect = document.getElementById('categorySelect');
    const $selectedCategory = document.getElementById('selectedCategory');

    //가격
    const $editedPrice = document.getElementById('editedPrice');

    //닫기 버튼
    const $closeBtn = document.getElementById('closeBtn');
    const $modal = document.getElementById('editModal');

    //삭제 버튼
    const $deleteBtn = document.getElementById('content-Del');



    $modifyBtn.onclick = e => {
      console.log('수정 버튼 이벤트 발생!');
      $editedTitle.value = document.getElementById('textTitle').textContent;
      $editedContent.value = document.getElementById('textContent').textContent;
      $editedPrice.value = document.getElementById('price').textContent;
      $editedCategory.value = document.getElementById('editedCategory').textContent;

      console.log($editedTitle.value);
      console.log($editedContent.value);
      makeModifyClickHandler();
      makeCloseClickHandler();
    }


    if ($categorySelect) {
      $categorySelect.addEventListener('change', function () {
        $selectedCategory.textContent = $categorySelect.value === 'sale' ? '판매중' : '판매완료';
      });
    }




    function makeCloseClickHandler() {
      $closeBtn.onclick = e => {
        console.log('닫기 버튼 클릭!');
        $modal.style.display = "none"; // 모달을 숨김
        location.reload(); // 화면 새로고침
      };
    }

    function makeModifyClickHandler() {
      if ($saveBtn) {
        $saveBtn.onclick = e => {
          if ($editedTitle.value === '' && $editedContent.value === '') {
            alert('내용은 필수입니다.');
            return;
          }


          const payload = {
            boardNo: bno,
            title: $editedTitle.value,
            content: $editedContent.value,
            category: category.value,
            price: $editedPrice.value

          };

          const requestInfo = {
            method: 'PUT',
            headers: {
              'content-type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(payload)
          };

          fetch(URL, requestInfo)

            .then(res => {
              console.log(res.status);
              if (res.status === 200) {
                alert('내용 정상 변경');
                return res.text();
              } else {
                alert('입력값에 문제가 있습니다.');
                return res.text();
              }
            })

            .then(data => {
              console.log('응답 성공!', data);
              $editedTitle.value = '';
              $editedContent.value = '';
              $category.value = '';
              $price.value = '';
            });

        };
      }
    }

    // 삭제버튼
    $deleteBtn.onclick = e => {
      console.log('삭제 버튼 클릭!');

      if (confirm('정말로 삭제하시겠습니까?')) {
        deleteBoard();
        alert('삭제 되었습니다');
        window.location.href = '/market/list';
      }
    };

    function deleteBoard() {
      const requestInfo = {

        method: 'DELETE',
        headers: {
          'content-type': 'application/json; charset=utf-8'
        },
      };

      fetch(URL, requestInfo)
        .then(res => {
          console.log(res.status);
          if (res.status === 200) {
            alert('게시물이 성공적으로 삭제되었습니다.');
            // 삭제 후 목록 페이지로 이동하거나, 홈 페이지로 리다이렉트할 수 있습니다.
            window.location.href = '/market/list'; // 목록 페이지로 이동
          } else {
            alert('게시물 삭제에 실패했습니다.');
          }
        });
    }








    /* 친구 정보 
    const $friends = document.querySelector('.friends');
    const $userInformation = document.getElementById('user-information');
    const $xBtn = document.getElementById('x-btn');

    $friends.onclick = e => {
      if (!e.target.matches('.friend')) return;
      e.preventDefault();

      // #user-information 의 p태그가 누른 대상의 닉네임이 되어야 한다.
      $userInformation.style.display = 'block';

    };

    $xBtn.onclick = e => {
      console.log('x버튼 클릭');
      $userInformation.style.display = 'none';
    }


    const $del = document.querySelector('.content-Del');
    $del.onclick = e => {
      if (!e.target.matches('.del')) return;
      e.preventDefault();

      $userInformation.style.display = 'block';
    };

    $xBtn.onclick = e => {
      console.log('x버튼 클릭');
      $userInformation.style.display = 'none';

    }

    */
  </script>


</body>

</html>