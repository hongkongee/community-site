<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>ERROR 500</title>

    <link rel="stylesheet" href="/assets/css/error500.css">
</head>

<body>
    <img src="/assets/img/dog.png" alt="dog" class="dog">
    <!-- <div class="container">
        <h1>500 - 서버 오류 발생</h1>
        <p>죄송합니다, 서버에서 오류가 발생했습니다. 이 문제는 곧 해결될 것입니다.</p>
        <p>이전 링크를 통해 다른 페이지로 이동하거나, <a href="/home/main">홈페이지로 돌아가기</a>를 클릭하세요.</p>
    </div> -->
    <div class="catbox"></div>
    <div class="container">
     <p class="text">I'm Sorry! <br>서버에서 오류가 발생했습니다.<br> 다시 한번 시도해주세요</p>
     <a href="/home/main" class="alink">메인페이지 이동</a>
 </div>

</body>

</html>