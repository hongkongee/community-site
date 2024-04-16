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
                                <p>내용 ex)오늘의 게시물</p>
                            </div>
                            <div class="time-view-wrapper">
                                <div class="time">2024-04-15</div>
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

        <div class="Frame40">

            <div class="Menu">
                <button class="close-btn">X</button> <br>
                <a href="">HOME</a><br>
                <a href="">Posting</a><br>
                <a href="">Diary</a><br>
                <a href="">Gallery</a><br>
                <a href="">Chat</a><br>
                <a href="">Market</a>
            </div>

        </div>


</body>

<script>

    const sidebar = document.querySelector('.Frame40');

    document.querySelector('.Frame40').addEventListener('mouseover', function () {
    // When the user hovers over the element, change its transform property to translateX(0)
    this.style.transform = 'translateX(-100%)';
    });

    // Add a hover event listener to the Frame40 element
    document.querySelector('.Frame40').addEventListener('mouseover', function () {
        // When the user hovers over the element, change its transform property to translateX(0)
        this.style.transform = 'translateX(0)';
    });

    document.querySelector('.close-btn').addEventListener('click', function () {
        // When the user is not hovering over the element, change its transform property to translateX(-100%)
        sidebar.setAttribute("style", "transform: translateX(-100%);");
    });
</script>

</html>