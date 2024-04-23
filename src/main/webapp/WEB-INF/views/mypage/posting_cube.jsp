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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- font awesome icons (html에서 넣기) -->
    <script src="https://kit.fontawesome.com/482d3485ef.js" crossorigin="anonymous"></script>

</head>

<body>

    <%@ include file="../include/headcss.jsp"%>
    <%@ include file="../include/header.jsp"%>

    <div class="MypostcubeJsp">
        <div class="Frame42">

            <div class="main-title-wrapper">
                <h1 class="main-title">My Posts</h1>
                <c:if test="${login != null}">
                    <a href="/mypage/newposting">
                        <button class="add-btn">글 작성하기</button>
                    </a>
                </c:if>
                <div class="amount">
                    <div><a href="/mypage/posting_cube?pageNo=1&amount=6&type=${s.type}&keyword=${s.keyword}">6</a>
                    </div>
                    <div><a href="/mypage/posting_cube?pageNo=1&amount=18&type=${s.type}&keyword=${s.keyword}">18</a>
                    </div>
                    <div><a href="/mypage/posting_cube?pageNo=1&amount=30&type=${s.type}&keyword=${s.keyword}">30</a>
                    </div>
                </div>
            </div>

            <!----------------------- posting_cube 헤더 끝 ------------------------------->

            <!-- ------------------------메인 게시판 시작------------------------------------- -->

            <div class="post-container">
                <c:forEach var="b" items="${bList}">
                    <div class="post-wrapper">
                        <section class="post" data-bno="${b.bno}">
                            <a href="/home/detail/${b.bno}">
                                <div class="post-photo">
                                    <img src="/assets/img/java_logo.png" alt="게시물 사진">
                                </div>
                            </a>
                            <div class="post-content-wrapper">
                                <div class="post-content">
                                    ${b.title}
                                </div>
                                <div class="time-view-wrapper">
                                    <div id="this-month">${b.regDate}</div>
                                </div>
                                <div class="post-reply">

                                    <div class="like" data-bno="${b.bno}" data-like-cookie="${l}">
                                        <!-- <i class="fa-solid fa-heart"></i> : check 됐을 때 -->
                                        <i class="fa-regular fa-heart"></i>
                                        <label class="like-label" for="flexCheckDefault"
                                            data-like-count="${b.likeCount}">
                                            좋아요 ${b.likeCount}
                                        </label>
                                    </div>

                                    <input type="text" class="reply-rec"></input>
                                    <button class="reply">댓글 쓰기</button>
                                </div>
                            </div>

                        </section>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-------------------------- 게시글 목록 하단 영역 --------------------------->
        <div class="bottom-section">

            <!-- 페이지 버튼 영역 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination pagination-lg pagination-custom">
                    <c:if test="${maker.page.pageNo != 1}">
                        <li class="page-item"><a class="page-link"
                                href="/mypage/posting_cube?=1&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&lt;&lt;</a>
                        </li>
                    </c:if>


                    <c:if test="${maker.prev}">
                        <li class="page-item"><a class="page-link"
                                href="/mypage/posting_cube?pageNo=${maker.begin-1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">prev</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                        <li data-page-num="${i}" class="page-item">
                            <a class="page-link"
                                href="/mypage/posting_cube?pageNo=${i}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${maker.next}">
                        <li class="page-item"><a class="page-link"
                                href="/mypage/posting_cube?pageNo=${maker.end+1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">next</a>
                        </li>
                    </c:if>

                    <c:if test="${maker.page.pageNo != maker.finalPage}">
                        <li class="page-item"><a class="page-link"
                                href="/mypage/posting_cube?pageNo=${maker.finalPage}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&gt;&gt;</a>
                        </li>
                    </c:if>

                </ul>
            </nav>

        </div>
    </div>



</body>

<script>
   

</script>

<script src="/assets/js/mypage.js">
</script>



</html>