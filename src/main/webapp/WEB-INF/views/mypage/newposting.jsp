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
        <h1 class="main-title">게시글 작성하기</h1>
      </div>

      <form action="/mypage/posting_cube" method="post">
        <label for="title">제목</label>
        <input type="text" id="title" name="title" required>
        <label for="content">내용</label>
        <textarea id="content" name="content" maxlength="200" required></textarea>
        <div class="buttons">
          <button class="list-btn" type="button" onclick="window.location.href='/mypage/posting_cube'">목록</button>
          <button type="submit">글쓰기</button>
        </div>
      </form>


    </div>


  </div>
</body>

</html>