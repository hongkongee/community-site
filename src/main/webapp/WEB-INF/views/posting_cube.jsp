<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>posting_cube</title>

    <link rel="stylesheet" href="/assets/css/posting_cube.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>

<body>

    <div class="MypostcubeJsp">
        <div class="Frame42">
            <div class="Frame39">
                <div class="PostingCube">Posting (cube)</div>
                <button class="Cube">cube</button>
                <button class="List">list</button>
            </div>

            <!-- -------------===============================-------------------------- -->

            <div class="post-container">
                <div class="post-wrapper">
                    <section class="post" data-bno="1">
                        <div class="post-photo">
                            <img src="test_photo.png" alt="게시물 사진">
                            <button class="photo-before">◀</button>
                            <button class="photo-next">▶</button>
                        </div>
                        <div class="post-content-wrapper">
                            <div class="post-content">
                                <textarea name="post-content" id="contents" cols="30" rows="5">내용 ex)오늘의 게시물</textarea>
                            </div>
                            <div class="time-view-wrapper">
                                <div id="this-month"></div>
                            </div>
                            <div class="post-reply">
                                <div class="post-like">
                                    <button class="like">♥좋아요</button>
                                </div>
                                <input type="text" class="reply-rec"></input>
                                <button class="reply">댓글 쓰기</button>


                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

        <!-- <div class="Frame40">

            <div class="Menu">
                <button class="close-btn">X</button> <br>
                <a href="">HOME</a><br>
                <a href="">Posting</a><br>
                <a href="">Diary</a><br>
                <a href="">Gallery</a><br>
                <a href="">Chat</a><br>
                <a href="">Market</a>
            </div>

        </div> -->


</body>

<script>
    // -------------------------------게시물 등록 날짜 시작-------------------------------------
    var currentDate = new Date();
    var year = currentDate.getFullYear();
    var month = currentDate.getMonth() + 1;
    var day = currentDate.getDate();
    var formattedDate = year + "년 " + month + "월 " + day + "일";

    var thisMonthElement = document.getElementById("this-month");
    thisMonthElement.textContent = formattedDate;

    // -------------------------------게시물 등록 날짜 끝-------------------------------------

   
</script>

</html>