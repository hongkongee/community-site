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

  <!-- Bootstrap CSS 라이브러리를 포함 -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

  <!-- jQuery 라이브러리를 포함 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <!-- Popper.js 라이브러리를 포함 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

  <!-- Bootstrap JavaScript 라이브러리를 포함 -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


  <style>
    #map-container {
      text-align: center;
    }

    #address-container {
      margin-top: 20px;
    }

    #googleMap {
      display: inline-block;
      /* inline-block으로 변경 */
      width: 500px;
      height: 500px;
    }
  </style>


</head>

<body>

  <%@ include file="../include/snb.jsp" %>

  <%@ include file="../include/headcss.jsp"%>
  <%@ include file="../include/header.jsp"%>

  <!-- 가운데 Content -->
  <div class="wrapper">

    <!-- ContentBox 내용 제일 위-->
    <div class="content-box">



      <!-- Head 내용 -->



      <!-- Title 내용 -->


      <div class="title">
        <div class="titleContentBox">
          <span>#작성자 : </span><span id="textWriter" name="textWriter">${b.textWriter}</span>
          <span>#글번호 : </span><span id="boardNo" name="boardNo">${b.boardNo}</span>
          <span>#판매자의 좋아요 받은 수 : </span><span id="rate" name="rate">${rate}</span>
          <span>#작성시간 : </span><span id="updateDate" name="updateDate">${b.updateDate}</span><br>
          <span>#제목 : </span><span id="textTitle" name="textTitle">${b.textTitle}</span>
          <span>#가격 : </span><span id="price" name="price">${b.price}</span><span>원</span>
          <span>#판매자 선호 거래지역 : </span><span id="address" name="address">${b.address}</span>
          <span>#판매상태 : </span><span id="selectedCategory" name="category">${b.category}</span>
        </div>
      </div>




      <!-- Content 내용 -->
      <div class="content-group">
        <div class="Content1">
          <button class="content-list"><a href="/market/list">목록</a></button></button>
          <button class="content-Write"><a href="/market/write">글쓰기</a></button>
          <button id="content-Del">삭제</button>
          <button id="modifyBtn" class="content-Rev" type="button" data-bs-toggle="modal"
            data-bs-target="#editModal">수정</button>
          <!-- 좋아요 버튼 -->
          <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
            좋아요
          </button>
        </div>
        <br>
        <div class="ContentBox">

          <div class="normal" id="textContent">${b.textContent}</div>
        </div>
        <!-- 지도 -->
        <div id="map-container">
          <div id="googleMap"></div>
        </div>

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
                  <textarea class="form-control-lg" id="editedContent" rows="50" cols="100"
                    style="width: 100%;"></textarea>

                  <select id="editedCategory">
                    <option value="sale">판매중</option>
                    <option value="sold">판매완료</option>
                  </select>

                  <br>
                  <label for="editedPrice">수정할 가격</label>
                  <input type="int" class="form-control" id="editedPrice" style="width: 100%;">

                  <label for="address">거래장소</label>
                  <input type="text" class="form-control" id="address" style="width: 100%;">

                </div>
              </form>
            </div>


            <div class="modal-footer">
              <!-- 닫기 버튼 -->
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
              <!-- 수정 완료 버튼 -->
              <button type="button" class="btn btn-primary" id="saveEdit">수정 완료</button>
            </div>
          </div>
        </div>
      </div>







      <!-- Modal -->
      <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">좋은 이유를 눌러주세요♡</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">


              <select class="form-select" id="why" aria-label="Default select example" name="chooseReason">
                <option selected>이유를 선택해주세요</option>
                <option value="판매자가 친절해서">판매자가 친절해서</option>
                <option value="저렴한 가격">저렴한 가격</option>
                <option value="가까운 거래장소">가까운 거래장소</option>
              </select>

              <label for="report-reason">기타 사유가 있으면 말씀해주세요</label>
              <textarea rows="3" id="reportText" name="message" class="form-control"
                placeholder="좋아요 이유를 입력해주세요"></textarea>


            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
              <button type="button" class="btn-primary" id="confirmBtn">확인</button>
            </div>
          </div>
        </div>
      </div>





    </div>
  </div>




  <script>
    let map;
    let center;
    const loginData = '${login}';
    console.log('loginData: ', loginData);


    function myMap() { //Google Maps 초기화
      var mapOptions = { //지도 초기화 정보
        center: new google.maps.LatLng(37.552550, 126.937703),
        zoom: 18
      };

      map = new google.maps.Map(document.getElementById("googleMap"), mapOptions); //mapOptions 사용자 설정 위치 
    }

    function searchAddress() { //입력한 주소를 받아 해당 주소의 위도와 경도를 검색
      var geocoder = new google.maps.Geocoder(); //주소 위도/경도 변환
      var address = '${b.address}';

      geocoder.geocode({
        'address': address
      }, function (results, status) { //변환할 주소, 콜백함수
        if (status === 'OK') {
          map.setCenter(results[0].geometry.location);
          var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
          });
        } else {
          alert('주소를 찾을 수 없습니다. 다른 주소를 입력해주세요.');
        }
      });
    }

    window.onload = function () { //다 되고 호출
      searchAddress();
    }


    document.getElementById('confirmBtn').onclick = e => {
      if (!loginData) {
        alert('로그인이 필요합니다.');
        return;
      }

      likeBtnClickHandler(e);
    }
  </script>


  <!-- 구글맵 API 호출 -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOCNKI6eODqFYglsYcSTmd0GDwNWUz8FU&callback=myMap">
  </script>

  <!-- 좋아요 호출 -->
  <script src="/assets/js/MarketRate.js"></script>

  <!-- 수정하기 호출 -->
  <script src="/assets/js/MarketModify.js"></script>





</body>

</html>