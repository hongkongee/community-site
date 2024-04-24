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
                    ${user.nickname}<br />
                </div>
                <div class="email">
                    ${user.email}
                </div>
                <div class="bio">
                    <form action="/mypage/intro" id="intro-form" method="post" enctype="multipart/form-data">
                        <textarea rows="4" id="self-intro" name="introduction" class="form-control"
                                            value="${user.introduction}" readOnly></textarea>
                        <button id="fake-btn" type="submit"></button>
                    </form>
                    
                    <c:if test="${login.accountNumber eq user.accountNumber}">
                        <i class="fa-solid fa-pen"></i>
                    </c:if>
                </div>
                <div class="points">
                    point : <span class="points-value">${user.point} P</span></div>

                    <c:if test="${login.accountNumber ne user.accountNumber}">
                        <button class="follow-btn" type="button">팔로우하기</button>
                    </c:if>
            </div>



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
                                        <img src="/display\${following.profilePicture}" alt="프사">
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
                                        <img src="/display\${follower.profilePicture}" alt="프사">
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
                    <div class="title-market">${user.nickname}님의 중고 장터 평점: ${user.rate}</div>
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
                        <div class="best-three">${user.nickname} 님의 인기 게시글</div>
                    </div>
                    <div class="popular-list">
                        <c:forEach var="post" items="${posts}">
                            <div class="popular-title-container"><a href="/home/detail/${post.bno}">제목 ${post.title}</a>
                                <span class="popular-content">${post.regDate}</span>
                            </div>
                        </c:forEach>
                        
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
                        
                        <audio id="myAudio" controls>
                            <source src="/assets/audio/testmusic.mp3" type="audio/mpeg">
                            이 브라우저에서는 음악 기능을 지원하지 않습니다.
                        </audio>



                    </div>



                </div>


            </div>


        </div>




  <!-- 마이페이지 자바스크립트 -->
  <script src="/assets/js/mypagehome.js"></script>




</body>

</html>