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
          <span>#글번호 : </span><span class="boardNo">1</span>
          <span>#작성자 : </span><span class="textWriter">코리안네이마루</span><span>(본인인증완료)</span>
          <span>#신용도 : </span><span class="rate">9.3/10</span>
          <span>#작성시간 : </span><span class="updateDate">24.04.10 14:42</span><br>
          <span>#제목 : </span><span class="titleContent">손흥민 유니폼 팝니다</span>
          <span>#가격 : </span><span class="price">200000</span><span>원</span>
          <span>#판매자 선호 거래지역 : </span><span class="location">신촌역</span>
        </div>
      </div>




      <!-- Content 내용 -->
      <div class="content">
        <div class="Content1">
          <div class="content-Write">글쓰기</div>
          <div class="content-Del">삭제</div>
          <button id="modifyBtn" class="content-Rev" type="button" data-bs-toggle="modal"
            data-bs-target="#editModal">수정</button>
          <button class="content-Close" type="button">닫기</button>
          <div class="content-AddFav">상품 즐겨찾기</div>
          <div class="content-Otherproduct">#판매자의 다른상품</div>
        </div>
        <br>
        <div class="ContentBox">
          <img class="ContentImg"
            src="https://img3.yna.co.kr/etc/inner/EN/2023/08/13/AEN20230813000200315_01_i_P2.jpg" />
          <div id="normal" class="textContent">글 내용내용 입니다. 내용이에요~~~</div>
        </div>
        <!-- 지도 -->
        <%@ include file="../market/subMap.jsp" %>
      </div>


      <!-- 수정 내용 입력 모달 -->
      <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="editModalLabel">내용 수정</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <!-- 내용 수정 폼 -->
              <form id="editForm">
                <div class="form-group">
                  <label for="editedContent">수정할 내용</label>
                  <textarea class="form-control" id="editedContent" rows="3"></textarea>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <!-- 닫기 버튼 -->
              <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
              <!-- 수정 완료 버튼 -->
              <button type="button" class="btn btn-primary" id="saveEdit">수정 완료</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Reply 내용 -->
      <%@ include file="../market/subMarketReply.jsp" %>

      <!-- 광고 영역 -->
      <%@ include file="../market/subMarketAD.jsp" %>

    </div>

  </div>





  <script>
    const URL = '/market/modify';

    // 수정 버튼 이벤트 발생
    const $modifyBtn = document.getElementById('modifyBtn');
    const $saveBtn = document.getElementById('saveEdit'); //내가
    $modifyBtn.onclick = e => {
      console.log('수정 버튼 이벤트 발생!');

      document.getElementById('editedContent').value = document.getElementById('normal').textContent;

    }

    if ($saveBtn) {
      $saveBtn.onclick = e => {
        if (editedContent == '') {
          alert('내용은 필수입니다.');
          return;
        }

        const payload = {
          text: editedContent
        };

        const requestInfo = {
          method: 'POST',
          header: {
            'content-type': 'application/json'
          },
          body: JSON.stringify(payload)
        }

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
            $editedContent.value = '';

          });

      };
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


















