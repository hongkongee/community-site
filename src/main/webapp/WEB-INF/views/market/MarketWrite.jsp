<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- reset -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">

  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/market.css">
  <link rel="stylesheet" href="/assets/css/snb.css">

  <!-- ck editor -->
  <!-- 게시판 라이브러리 -->
  <script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
  <!-- <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script> -->
</head>

<body>

  <%@ include file="../include/snb.jsp" %>

  <!-- 가운데 Content -->
  <div class="wrapper">


    <!-- ContentBox 내용 제일 위-->
    <div class="content-box">


      <!-- 게시판 글쓰기 폼 -->
      <div id="wrap" class="form-container">
        <h1>게시판 글쓰기</h1>
        <form action="/market/write" method="post">

          <label for="textTitle">제목</label>
          <input type="text" id="textTitle" name="textTitle" required>

          <label for="textWriter">작성자</label>
          <input type="text" id="textWriter" name="textWriter" required>

          <label for="textContent">내용</label>
          <textarea id="textContent" name="textContent" maxlength="200" required></textarea>

          <div class="buttons">
            <button class="list-btn" type="button" onclick="window.location.href='/market/list'">목록</button>
            <button type="submit">글쓰기</button>
          </div>
        </form>
      </div>

    </div>
  </div>

  <!-- Reply 내용 -->
  <%@ include file="../market/subMarketReply.jsp" %>

  <!-- 광고 영역 -->
  <%@ include file="../market/subMarketAD.jsp" %>

  <script>
    CKEDITOR.replace('textContent');
  </script>

</body>

</html>
