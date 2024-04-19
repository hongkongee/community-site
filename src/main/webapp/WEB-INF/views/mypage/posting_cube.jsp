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

</head>

<body>

    <%@ include file="../include/headcss.jsp"%>
    <%@ include file="../include/header.jsp"%>

    <div class="MypostcubeJsp">
        <div class="Frame42">

            <div class="main-title-wrapper">
                <h1 class="main-title">My Study</h1>
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
                                    <div class="post-like">
                                        <button class="like">${b.likeCount}<br>좋아요</button>
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
    // -------------------------------게시물 등록 날짜 시작-------------------------------------
    /*
    var currentDate = new Date();
    var year = currentDate.getFullYear();
    var month = currentDate.getMonth() + 1;
    var day = currentDate.getDate();
    var formattedDate = year + "년 " + month + "월 " + day + "일";

    var thisMonthElement = document.getElementById("this-month");
    thisMonthElement.textContent = formattedDate;
    */
    // 사용자가 현재 머물고 있는 페이지 버튼에 active 스타일 부여
    function appendPageActive() {

        // 현재 서버에서 넘겨준 페이지 번호
        const currPage = '${maker.page.pageNo}';

        // li 태그들을 전부 확인해서
        // 현재 페이지 번호와 일치하는 li를 찾은 후 active 클래스 이름 붙이기
        const $ul = document.querySelector('.pagination');
        const $liList = [...$ul.children];

        $liList.forEach($li => {
            if (currPage === $li.dataset.pageNum) {
                $li.classList.add('active');
            }
        });
    }

    // -------------------------------게시물 등록 날짜 끝-------------------------------------
</script>

</html>