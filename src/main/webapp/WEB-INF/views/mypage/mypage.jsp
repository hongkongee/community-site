<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyPage</title>

    <%@ include file="../include/static-head.jsp" %>

    <link rel="stylesheet" href="/assets/css/mypage.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

</head>

<body>


    <div id="wrapper">

        <div class="page-title">
            <!-- <a href="#" class="moreInfoBtn"> + </a> -->
            <!-- Name of Page -->
            <div class="home">My Page</div>

            <div class="home-icon">
                <a href="/home/main">
                    <i class="fa-solid fa-house"></i>
                </a>
            </div>

        </div>




        <div class="body-wrapper1">

            <!-- profile information -->
            <form action="/mypage/upload/${user.accountNumber}" id="profile-form" method="post"
                enctype="multipart/form-data">
                <div class="user-profile-box">
                    <c:if test="${empty user.profilePicture}">
                        <img class="user-profile-pic" src="/assets/img/jjanggu.jpg" alt="기본 프사">
                    </c:if>


                    <c:if test="${not empty user.profilePicture}">


                        <c:choose>
                            <c:when test="${user.loginMethod == 'COMMON'}">
                                <img class="user-profile-pic" src="/display${user.profilePicture}" alt="프사">
                            </c:when>
                            <c:otherwise>
                                <c:if test="${fn:contains(user.profilePicture, 'https')}">
                                    <img class="user-profile-pic" src="${user.profilePicture}" alt="프사">
                                </c:if>

                                <c:if test="${not fn:contains(user.profilePicture, 'https')}">
                                    <img class="user-profile-pic" src="/display${user.profilePicture}" alt="프사">
                                </c:if>
                                
                            </c:otherwise>
                        </c:choose>

                    </c:if>
                    <input type="file" id="profile-img" style="display: none;" name="profilePicture">
                </div>
                <button class="profile-save">프로필 저장</button>
            </form>

            <div id="loginuser" data-loginaccount="${login.accountNumber}"></div>

            <div class="user-info" data-useraccount="${user.accountNumber}">
                <div class="profile-name">
                    ${user.nickname}<br />
                </div>
                <div class="email">
                    ${user.email}
                </div>
                <div class="bio">
                    <p id="intro-text">${user.introduction}</p>

                    <c:if test="${login.accountNumber eq user.accountNumber}">
                        <i class="fa-solid fa-pen fa-xs"></i>
                    </c:if>
                </div>
                <div class="points">
                    point : <span class="points-value">${user.point} P</span>
                </div>


                <div class="user-following" data-followingid="${user.accountNumber}">
                    <!-- 홈페이지 주인이 나(로그인한 유저)와 다른 사람일 때 -->
                    <c:if test="${login.accountNumber ne user.accountNumber}">


                        <!-- 내(로그인한 유저)가 팔로잉을 이미 한 경우 (myfollowings 안에 user.accountNumber가 포함) -->
                        <c:if test="${fn:contains(myfollowings, user.accountNumber)}">
                            <button class="follow-btn" id="cancel-follow" type="button">팔로우 취소</button>
                        </c:if>

                        <!-- 내(로그인한 유저)가 팔로잉을 아직 안 한 경우 -->
                        <c:if test="${not fn:contains(myfollowings, user.accountNumber)}">
                            <button class="follow-btn" id="register-follow" type="button">팔로우하기</button>
                        </c:if>
                    </c:if>

                </div>

            </div>

            <!-- 모달 버튼 -->
            <button type="button" id="modal-btn" class="btn btn-primary" data-bs-toggle="modal"
                data-bs-target="#exampleModal">
                Launch demo modal
            </button>

            <!-- 수정 영역 모달 -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">자기소개 수정</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/mypage/intro" id="form-intro" method="post">
                                <textarea name="introduction" id="textarea-intro" cols="30" rows="10">
                                ${user.introduction}
                            </textarea>
                            </form>
                        </div>


                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-primary" id="bioModBtn">수정</button>
                        </div>
                    </div>
                </div>
            </div>




            <!-- 팔로우, 팔로워 영역 -->
            <div class="user-friends">



                <div class="ff">

                    <!-- 팔로잉 리스트 -->
                    <div class="following-list">
                        <div class="following">
                            <div class="follow-text"><button type="button">팔로잉</button></div>
                        </div>

                        <c:forEach var="following" items="${followings}">

                            <div class="user-wrapper">

                                <div class="profile-box">
                                    <c:if test="${empty following.profilePicture}">
                                        <img src="/assets/img/jjanggu.jpg" alt="기본 프사">
                                    </c:if>

                                    <c:if test="${not empty following.profilePicture}">
                                        <img src="/display${following.profilePicture}" alt="프사">
                                    </c:if>
                                </div>

                                <div class="name-box">
                                    <a class="friendName" href="/mypage/home/${following.accountNumber}">
                                        ${following.nickname}&nbsp;
                                    </a>
                                </div>


                                <div class="icon-box" data-followingid="${following.accountNumber}">
                                    <!-- 자기 자신이 아닌 경우만 아이콘 표시 -->
                                    <c:if test="${login.accountNumber ne following.accountNumber}">

                                        <!-- 내(로그인한 유저)가 팔로잉을 이미 한 경우 -->
                                        <c:if test="${fn:contains(myfollowings, following.accountNumber)}">
                                            <i class="fa-solid fa-user-minus"></i>
                                        </c:if>

                                        <!-- 내(로그인한 유저)가 팔로잉을 아직 안 한 경우 -->
                                        <c:if test="${not fn:contains(myfollowings, following.accountNumber)}">
                                            <i class="fa-solid fa-user-plus"></i>
                                        </c:if>

                                    </c:if>


                                </div>

                            </div>



                        </c:forEach>


                    </div>

                    <!-- 팔로워 리스트 -->
                    <div class="follower-list">

                        <div class="followers">
                            <div class="follow-text"><button type="button">팔로워</button></div>
                        </div>

                        <c:forEach var="follower" items="${followers}">

                            <div class="user-wrapper">

                                <div class="profile-box">
                                    <c:if test="${empty follower.profilePicture}">
                                        <img src="/assets/img/jjanggu.jpg" alt="기본 프사">
                                    </c:if>

                                    <c:if test="${not empty follower.profilePicture}">
                                        <img src="/display${follower.profilePicture}" alt="프사">
                                    </c:if>
                                </div>

                                <div class="name-box">
                                    <a class="friendName" href="/mypage/home/${follower.accountNumber}">
                                        ${follower.nickname}&nbsp;
                                    </a>
                                </div>

                                <div class="icon-box" data-followingid="${follower.accountNumber}">
                                    <!-- 자기 자신이 아닌 경우만 아이콘 표시 -->
                                    <c:if test="${login.accountNumber ne follower.accountNumber}">

                                        <!-- 내(로그인한 유저)가 팔로잉을 이미 한 경우 -->
                                        <c:if test="${fn:contains(myfollowings, follower.accountNumber)}">
                                            <i class="fa-solid fa-user-minus"></i>
                                        </c:if>

                                        <!-- 내(로그인한 유저)가 팔로잉을 아직 안 한 경우 -->
                                        <c:if test="${not fn:contains(myfollowings, follower.accountNumber)}">
                                            <i class="fa-solid fa-user-plus"></i>
                                        </c:if>

                                    </c:if>


                                </div>

                            </div>


                        </c:forEach>


                    </div>

                </div>



            </div>

        </div>



        <div class="body-wrapper2">

            <!-- marketlist -->
            <div class="my-market">

                <div class="user-market">
                    <div class="title-market">
                        판매자 평점:

                        <c:if test="${user.rate < 0.5}">
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 0.5 and user.rate < 1}">
                            <i class="fa-solid fa-star-half-stroke"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>


                        <c:if test="${user.rate >= 1 and user.rate < 1.4}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 1.5 && user.rate < 2}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star-half-stroke"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 2 && user.rate < 2.5}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 2.5 && user.rate < 3}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star-half-stroke"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 3 && user.rate < 3.5}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 3.5 && user.rate < 4}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star-half-stroke"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 4 && user.rate < 4.5}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                        </c:if>

                        <c:if test="${user.rate >= 4.5 && user.rate < 4.9}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star-half-stroke"></i>
                        </c:if>

                        <c:if test="${user.rate >= 4.9 && user.rate <= 5}">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                        </c:if>




                    </div>
                    <h2> <i class="fa-solid fa-store"></i> 평가 </h2>
                    <div class="market-rates">
                        <c:forEach var="market" items="${markets}">

                            <div class="rate-evaluation">
                                <span class="chooseReason">${market.chooseReason}</span>
                                <span class="message">${market.message}</span>
                                <span class="regDate">${market.regDate}</span>
                            </div>

                        </c:forEach>
                    </div>
                </div>
                <div class="user-game">

                </div>
            </div>

            <!-- popularlist -->
            <div class="popular-wrapper">

                <!-- searchbar -->
                <div class="search-wrapper">
                    <form action="/home/board/all/${user.accountNumber}" method="get">
                        <input type="text" id="search-bar" placeholder="게시물 검색" name="keyword">
                        <button class="search-submit" type="submit">검색</button>
                    </form>
                </div>

                <div class="popular-post">
                    <div class="popular-title">
                        <div class="best-three">${user.nickname} 님의 인기 게시글</div>
                    </div>
                    <div class="popular-list">
                        <c:forEach var="post" items="${posts}">
                            <div class="popular-title-container"><a href="/home/detail/${post.bno}"> ${post.title}</a>
                                <span class="popular-content">${post.regDate}</span>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>



            <!-- weather wrapper -->
            <div class="weather-wrapper">
                <!-- weather api -->
                <c:if test="${login.accountNumber eq user.accountNumber}">
                    <div class="weatherapi-wrapper">

                        <div class="title-market">일일 포인트 지급</div>

                        <div class="all-games">
                            <a href="#" id="today-point" class="btn-3d blue">포인트 받기</a>
                        </div>

                        <div class="all-games">
                            <div class="point-msg" id="positive-point"><span>오늘 받은 포인트는</span> <span
                                    id="point-value"></span>P 입니다.</div>
                            <div class="point-msg" id="zero-point">오늘 받은 포인트는 0P입니다.ㅠㅠ 다음 기회에~~</div>
                            <div class="point-msg" id="already-point">오늘 이미 포인트를 받지 않으셨나요??ㅡㅡ</div>
                        </div>
                    </div>
                </c:if>




            </div>


        </div>

    </div>


    <!-- 마이페이지 자바스크립트 -->
    <script src="/assets/js/mypagehome.js"></script>




</body>

</html>