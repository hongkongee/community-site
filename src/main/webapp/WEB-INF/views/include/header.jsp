<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- header start-->

<header>
    <div class="inner-header">
        <h1 class="logo">
            <a href="/home/main">
                <img src="/assets/img/logo2.png" alt="로고이미지">
            </a>
        </h1>
        <div class="profile-box">
            <!-- profilePicture로수정 -->
            <c:if test="${login == null || login.profilePicture == null}">
                <img src="/assets/img/jjanggu.jpg" alt="프사">
            </c:if>
            <!-- profilePicture로수정 -->
            <c:if test="${login != null && login.profilePicture != null}">
                <c:choose>
                    <c:when test="${login.loginMethod == 'COMMON'}">
                        <img src="/display${login.profilePicture}" alt="프사">
                    </c:when>
                    <c:otherwise>
                        <img src="${login.profile}" alt="프사">
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>

        <h2 class="intro-text">
            Welcome ${sessionScope.login == null ? '' : login.name}
        </h2>
        <a href="#" class="menu-open">
            <span class="menu-txt">My Page</span>
            <span class="lnr lnr-menu"></span>
        </a>
    </div>

    <nav class="gnb">
        <a href="#" class="close">
            <button type="button">X</i></button>
        </a>
        <ul>

            <li><a href="/home/main">Home</a></li>

            <c:if test="${sessionScope.login != null}">
                <li><a href="/mypage/home/${login.accountNumber}">My Page</a></li>
                <li><a href="/mypage/posting_cube">My Posts</a></li>
                <li><a href="/mypage/diary">My Diary</a></li>
                <li><a href="/wel/myCode">My Code</a></li>
                <li><a href="/chat/chat">Chat</a></li>
                <li><a href="#">Market</a></li>
                <li><a href="/users/info">My Info</a></li>
            </c:if>

            <c:if test="${sessionScope.login != null}">
                <li><a href="/users/sign-out">Sign Out</a></li>
            </c:if>


            <c:if test="${login == null}">
                <!-- 로그인 안했으면 -->
                <li><a href="/users/sign-up">Sign Up</a></li>
                <li><a href="/users/sign-in">Sign In</a></li>
            </c:if>



        </ul>
    </nav>

</header>
<!-- Header END -->

<script>
    const $profileBox = document.querySelector('.profile-box');
    //profile을 profilePicture로수정

    $profileBox.onclick = e => {
        location.href = '/display/download${login.profilePicture}';
    };

    //버튼의 요소 노드 취득
    const menuBtn = document.querySelector('header .menu-open');
    const closeBtn = document.querySelector('.gnb .close');

    const gnb = document.querySelector('.gnb');

    //클릭 이벤트 생성
    menuBtn.addEventListener('click', () => {
        gnb.classList.add('on');
    });

    closeBtn.addEventListener('click', () => {
        gnb.classList.remove('on');
    });
</script>