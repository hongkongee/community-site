<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>Insert Your Title</title>

    <link rel="stylesheet" href="/assets/css/mypost_detail.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>

<body>

    <div class="MypostcubeJsp">
        <div class="Frame42">


            <section class="board">
                <div id="wrap" class="form-container">

                    <c:forEach var="b" items="${bList}">

                        <div class="left-region">

                            <h1 id="content">${b.shortContent}</h1>
                            <img src="img/test_photo.png" alt="">
                            <h2 id="date">${b.regDate}</h2>

                            <button class="like">${like_count}</button>
                        </div>


                        <div class="right-region">
                            <!-- 누르면 클립보드에 현재 페이지의 URL이 들어감 -->
                            <h2 id="copy-url"> <a href="#">URL 복사</a> </h2>

                            <!-- 댓글 개수 : 누르면 댓글영역으로 이동-->
                            <h2 id="see-reply"> <a href="#tag1"> 댓글 53 </a></h2>



                        </div>

                </div>
                </c:forEach>






                <hr>



                <!-- <label for="content">내용</label> -->
                <div id="content">${b.content}</div>

                <div class="buttons">
                    <button class="list-btn" type="button" onclick="location.href='/home/all'">
                        목록
                    </button>
                    <button id="modify">수정</button>
                    <button id="delete">삭제</button>
                </div>

            </section>
        </div>
    </div>

</body>

</html>