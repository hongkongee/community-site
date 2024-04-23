<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <div class="user-profile-box">
                <c:if test="${empty user.profilePicture}">
                    <img class="user-profile-pic" src="/assets/img/jjanggu.jpg" alt="기본 프사">
                </c:if>

                <c:if test="${not empty user.profilePicture}">
                    <img class="user-profile-pic" src="/display\${following.profilePicture}" alt="프사">
                </c:if>
            </div>

            <div class="user-info">
                <div class="profile-name">
                    ${user.nickname}<br /></div>
                <div class="email">
                    ${user.email}</div>
                <div class="bio">
                    안녕하세요 저는 짱구입니다. <br>저는 맛집 가는걸 좋아해요!</div>
                <div class="points">
                    point : <span class="points-value">200</span></div>

                    <c:if test="${login.accountNumber ne user.accountNumber}">
                        <button class="follow-btn" type="button">팔로우하기</button>
                    </c:if>
            </div>



            <div class="user-friends">
                <div class="friends-category">
                    <div class="followers">
                        <div class="follow-text"><button type="button">팔로워</button></div>
                    </div>
                    <div class="following">
                        <div class="follow-text"><button type="button">팔로잉</button></div>
                    </div>
                </div>

                <!-- 팔로잉 리스트 -->
                <div class="following-list">

                    <c:forEach var="following" items="${followings}">

                    <div class="user-wrapper">

                        <div class="profile-box">
                            <c:if test="${empty following.profilePicture}">
                                <img src="/assets/img/jjanggu.jpg" alt="기본 프사">
                            </c:if>

                            <c:if test="${not empty following.profilePicture}">
                                <img src="/display\${following.profilePicture}" alt="프사">
                            </c:if>
                        </div>
                        
                        <div class="name-box">
                            <a class="friendName" href="/mypage/home/${following.accountNumber}">
                                ${following.nickname}&nbsp;
                            </a>
                        </div>

                        <div class="icon-box">
                            <i class="fa-solid fa-user-plus"></i>
                        </div>

                    </div>
                        
                    

                    </c:forEach>

                
                </div>

                <!-- 팔로워 리스트 -->
                <div class="follower-list">

                    <c:forEach var="follower" items="${followers}">

                        <div class="profile-box">
                            <c:if test="${empty follower.profilePicture}">
                                <img src="/assets/img/jjanggu.jpg" alt="기본 프사">
                            </c:if>

                            <c:if test="${not empty follower.profilePicture}">
                                <img src="/display\${follower.profilePicture}" alt="프사">
                            </c:if>
                        </div>

                        <a class="friendName" href="#">
                            ${follower.nickname}
                        </a>
                        <i class="fa-solid fa-user-plus"></i>
                    

                    </c:forEach>

                
                </div>

            </div>

        </div>


        <div class="body-wrapper2">

            <!-- marketlist -->
            <div class="my-market">

                <div class="user-market">
                    <div class="title-market">${user.nickname}님의 중고 장터</div>
                    <div class="market-image">
                        <img src="#" class="user-market-photo">
                        <img src="#" class="user-market-photo">
                    </div>
                </div>
                <div class="user-game">
                    <div class="title-market">${user.nickname}님에게 게임신청</div>
                    <div class="all-games">
                        <div class="game-name">게임 1 <button class="register-to-game">신청걸기</button></div>
                        <div class="game-name">게임 2 <button class="register-to-game">신청걸기</button></div>
                        <div class="game-name">게임 3 <button class="register-to-game">신청걸기</button></div>
                    </div>
                </div>
            </div>

            <!-- popularlist -->
            <div class="popular-wrapper">

                <!-- searchbar -->
                <div class="search-wrapper">
                    <input type="text" id="search-bar" placeholder="게시물 검색">
                    <button class="search-submit" type="submit">검색</button>
                </div>

                <div class="popular-post">
                    <div class="popular-title">
                        <div class="best-three">${user.nickname} 님의 인기 게시글 BEST3</div>
                    </div>
                    <div class="popular-list">
                        <c:forEach var="following" items="${followings}">

                        </c:forEach>
                        <div class="popular-title-container"><span class="popular-title-list">제목 ㅇㅇㅇㅇㅇ</span>
                            <span class="popular-content">작성날짜</span>
                        </div>
                    </div>
                </div>
            </div>



            <!-- weather wrapper -->
            <div class="weather-wrapper">
                <!-- weather api -->
                <div class="weatherapi-wrapper">
                    <img class="weather-api" src="#">
                    <div class="api"> 날씨 API</div>
                </div>

                <!-- music wrapper -->
                <div class="music-wrapper">
                    <div class="musicborder">
                        <div>재생중인 음악</div>



                    </div>



                </div>


            </div>


        </div>







</body>

</html>