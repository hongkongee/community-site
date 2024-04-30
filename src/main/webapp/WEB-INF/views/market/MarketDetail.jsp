<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>게시판 글쓰기</title>


  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/snb.css">

  <link rel="stylesheet" href="/assets/css/market.css">


  <style>
    /* 구글맵 */
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

    /* 좋아요 */
    @import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

    .rate-star {
      display: inline-block;
      border: 0;
      margin-right: 15px;
    }

    .rate-star>input {
      display: none;
    }

    .rate-star>label {
      float: right;
      color: #ddd
    }

    .rate-star>label:before {
      display: inline-block;
      font-size: 1rem;
      padding: .3rem .2rem;
      margin: 0;
      cursor: pointer;
      font-family: FontAwesome;
      content: "\f005 ";
    }

    .rate-star .half:before {
      content: "\f089 ";
      position: absolute;
      padding-right: 0;
    }

    .rate-star input:checked~label,
    .rate-star label:hover,
    .rate-star label:hover~label {
      color: #f73c32 !important;
    }

    .rate-star input:checked+.rate-star label:hover,
    .rate-star input input:checked~label:hover,
    .rate-star input:checked~.rate-star label:hover~label,
    .rate-star label:hover~input:checked~label {
      color: #f73c32 !important;
    }
  </style>


</head>

<body>

  <%@ include file="../include/header.jsp"%>

  <%@ include file="../include/snb.jsp" %>

  <!-- 가운데 Content -->
  <div class="wrapper">

    <!-- ContentBox 내용 제일 위-->
    <div class="content-box">



      <!-- Head 내용 -->

      <div class="titleContentBox">
        <span>#작성자 : </span><span id="textWriter" name="textWriter">${b.textWriter}</span>
        <span class="title-content">#글번호 : </span><span id="boardNo" name="boardNo">${b.boardNo}</span>
        <span class="title-content">#작성시간 : </span><span id="updateDate" name="updateDate">${b.updateDate}</span>
        <span class="title-content">#가격 : </span><span id="price" name="price">${b.price}</span><span>원</span><br>
        <span class="title-content">#판매자 선호 거래지역 : </span><span id="address" name="address">${b.address}</span>
        <span class="title-content">#판매상태 : </span><span id="selectedCategory" name="category">${b.category}</span>
        <span class="title-content">#판매자의 좋아요 받은 수 : </span><span id="rate" name="rate">${rate}</span><br><br>
        
        
        <span class="title-content">#제목 : </span><span id="textTitle" name="textTitle">${b.textTitle}</span>
      </div>


      <!-- Title 내용 -->







      <!-- Content 내용 -->
      <div class="content-group">





        <div class="Content1">
          <button class="content-list"><a href="/market/list">목록</a></button>

          <c:if test="${login.accountNumber == b.textWriter}">
            <button class="content-Write"><a href="/market/write">글쓰기</a></button>
            <button id="content-Del">삭제</button>
            <button id="modifyBtn" class="content-Rev" type="button" data-bs-toggle="modal"
              data-bs-target="#editModal">수정</button>
            <!-- 좋아요 버튼 -->

          </c:if>

          <c:if test="${login.accountNumber ne b.textWriter}">
            <button type="button"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">
              좋아요
            </button>
          </c:if>


        </div>
        <br>


        <div id="board-img">
          <c:if test="${b.file != null}">
            <img src="/display${b.file}" alt="업로드 이미지" style="width: 50vw;">
          </c:if>
        </div>




        <div class="textContent" id="textContent" name="textContent">${b.textContent}</div>

        <!-- <div class="normal" id="textContent">${b.textContent}</div> -->

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
                    style="width: 100%; height: 60%;" ></textarea>

                  <select id="editedCategory" name="category">
                    <option value="sale">판매중</option>
                    <option value="sold">판매완료</option>
                  </select>

                  <br>
                  <label for="editedPrice">수정할 가격</label>
                  <input type="int" class="form-control" id="editedPrice" style="width: 100%;">

                  <label for="editAddress">수정할 거래장소</label>
                  <input type="text" class="form-control" id="editAddress" style="width: 100%;">

                  <div>
                    <img src="/display${b.file}" alt="업로드 이미지" style="width: 100%;">
                  </div>



                  <!-- 이미지 업로드 -->
                  <div class="mb-3">
                    <label for="formFile" class="form-label">사진 업로드</label>
                    <input class="form-control" type="file" id="formFile" name="formFile" accept="image/*"
                      value="${b.file}">
                  </div>

                  <br>





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







      <!-- 판매자 평가 Modal -->
      <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">좋은 이유를 눌러주세요♡</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

              <fieldset class="rate-star">
                <input type="radio" id="rating5" name="rating" value="5"><label for="rating5" title="5점"></label>
                <input type="radio" id="rating4" name="rating" value="4"><label for="rating4" title="4점"></label>
                <input type="radio" id="rating3" name="rating" value="3"><label for="rating3" title="3점"></label>
                <input type="radio" id="rating2" name="rating" value="2"><label for="rating2" title="2점"></label>
                <input type="radio" id="rating1" name="rating" value="1"><label for="rating1" title="1점"></label>
              </fieldset>

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

    //구글맵 검색api
    function searchAddress(e) { //입력한 주소를 받아 해당 주소의 위도와 경도를 검색
      var geocoder = new google.maps.Geocoder(); //주소 위도/경도 변환
      var address = '${b.address}';


      if (address === null) {
        return null;
      } else if (address) {
        geocoder.geocode({
          'address': address
        }, function (results, status) { //변환할 주소, 콜백함수
          if (status === 'OK') {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
            });
          }
          // else {
          //   alert('주소를 찾을 수 없습니다. 다른 주소를 입력해주세요.');
          // }
        });
      }
    }

    window.onload = function () { //다 되고 호출
      searchAddress();
    }


    // 좋아요 버튼 실행 조건
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