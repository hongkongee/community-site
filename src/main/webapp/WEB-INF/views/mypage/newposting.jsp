<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <link rel="stylesheet" href="/assets/css/newposting.css">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

  <link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>

<body>
  <%@ include file="../include/headcss.jsp"%>
  <%@ include file="../include/header.jsp"%>

  <div class="newposting-wrapper">
    <div class="second-wrapper">
      <div class="main-title-wrapper">
        <h1 class="main-title">게시글 작성</h1>
      </div>

      <form action="/mypage/newposting" method="post" enctype="multipart/form-data">
        <!-- 카테고리 선택 영역 -->
        <select class="form-select" name="category" aria-label="Default select example" required>
          <option selected>게시판을 선택해 주세요</option>
          <option value="normal">질문</option>
          <option value="game">코드 공유</option>
          <option value="movie">취업</option>
          <option value="trip">IT 소식</option>
          <option value="market">자유 게시판</option>
        </select>

        <!-- 제목 입력 영역 -->
        <div class="mb-3">
          <!-- <label for="exampleFormControlInput1" class="form-label"></label> -->
          <input type="text" name="title" class="form-control" id="exampleFormControlInput1" placeholder="제목을 입력해 주세요">
        </div>

        <br>

        <!-- 이미지 업로드 영역 -->
        <div class="mb-3">
          <!-- <label for="formFile" class="form-label">Default file input example</label> -->
          <input class="form-control" type="file" multiple="multiple" name="file" id="formFile" accept="image/*">
          <div class="upload-box">파일 첨부</div>
        </div>


        <!-- 내용 입력 영역 -->
        <div class="mb-3">
          <!-- <label for="exampleFormControlTextarea1" class="form-label"></label> -->
          <textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="20"
            placeholder="내용을 입력하세요"></textarea>
        </div>

        <!-- 게시물 쓰기 버튼 -->
        <div class="buttons">
          <button class="list-btn" type="button" onclick="window.location.href='/mypage/posting_cube'">목록</button>
          <button type="submit">글쓰기</button>
        </div>



      </form>


    </div>


  </div>
</body>

<script>
  const $box = document.querySelector('.upload-box');
  const $input = document.getElementById('img-input');
  $box.onclick = e => {
    $input.click();
  };
</script>

</html>