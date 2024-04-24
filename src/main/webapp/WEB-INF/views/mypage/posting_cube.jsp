<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>posting_cube</title>

    <%@ include file="../include/static-head.jsp" %>

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="/assets/css/posting_cube.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>

<body>

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

            <div class="post-contain">
                <c:forEach var="b" items="${bList}">
                    <div class="post-wrapper" data-href="/mypage/delete?bno=${b.bno}">
                        <section class="post" data-bno="${b.bno}">
                            <a href="/mypage/posting_cube/${b.bno}">
                                <div class="post-photo">
                                    <img src="/display${b.postImg}" alt="게시물 사진">
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

                        <c:if test="${login.auth == '관리자' || login.accountNumber == b.writer}">
                            <div class="card-btn-group">
                                <button class="del-btn">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </c:if>

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
    <!-- ----------------------모달창-------------------------- -->
    <div class="modal" id="modal">
        <div class="modal-content">
            <p>정말로 삭제할까요?</p>
            <div class="modal-buttons">
                <button class="confirm" id="confirmDelete"><i class="fas fa-check"></i> 예</button>
                <button class="cancel" id="cancelDelete"><i class="fas fa-times"></i> 아니오</button>
            </div>
        </div>
    </div>



</body>

<script>
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


    // 카드 형태의 게시물들을 감싸고 있는 부모 요소 취득
    const $postContainer = document.querySelector('.post-contain');

    // 삭제에 필요한 요소들을 먼저 얻겠습니다.
    const $modal = document.getElementById('modal'); // 모달창 얻기
    const $confirmDelete = document.getElementById('confirmDelete'); // 모달 삭제 확인버튼
    const $cancelDelete = document.getElementById('cancelDelete'); // 모달 삭제 취소버튼


    $postContainer.addEventListener('click', e => {
        console.log('이벤트 타겟: ', e.target);
        if (e.target.matches('.post-wrapper')) return;

        // 삭제 버튼을 눌렀다면~
        if (e.target.matches('.card-btn-group *')) {
            console.log('삭제 버튼 클릭됨!');
            $modal.style.display = 'flex'; // 숨겨진 모달창을 드러내기.


            // 이벤트가 발생한 타겟에서 가장 가까운 .del-btn이 가지고 있는 data-href를 얻는다.
            const deleteLocation = e.target.closest('.post-wrapper').dataset.href;
            console.log('deleteLocation: ', deleteLocation);

            // 확인 버튼 이벤트
            $confirmDelete.onclick = e => {
                // 삭제 요청을 서버에 보내야 한다.
                console.log('onclick 수락!');
                location.href = deleteLocation;

                // 모달창을 닫아야 한다.
                $modal.style.display = 'none';
            }

            // 삭제 취소 버튼 클릭시 이벤트
            $cancelDelete.onclick = () => {
                console.log('onclick 취소');
                $modal.style.display = 'none';
            }

        } else { // 삭제 버튼을 제외한 부분은 글 상세조회

            // section태그에 붙은 글 번호를 읽어오자
            // 이벤트가 발생한 타겟에서 가장 가까운 section.card를 지목해서 data-bno를 얻어오기.
            const bno = e.target.closest('section.post').dataset.bno;
            console.log('bno: ' + bno);

            // 서버에 요청 보내기
            location.href = '/mypage/detail/'+ bno;
        }



    });
</script>

<script src="/assets/js/mypage.js">
</script>



</html>