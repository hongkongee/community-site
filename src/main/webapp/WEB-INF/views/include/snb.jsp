<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


  
<!-- ===================== side navigation bar ========================== -->
<aside>
    <nav class="left-snb">
    <!-- 왼쪽 메뉴 사이드바 -->
    <ul>
        <li id="home"><a href="/home/main">Home</a></li>
        <li id="game"><a href="/home/rps">게임</a></li>
        <li id="second-hand"><a href="#">중고 장터</a></li>
        <li id="sports"><a href="#">스포츠 예측</a></li>
        <li id="all"><a href="/home/all">
        전체 게시판
        <ul>
            <li id="game-board"><a href="#">게임 게시판</a></li>
            <li id="movie"><a href="#">영화 게시판</a></li>
            <li id="trip"><a href="#">여행 게시판</a></li>
        </ul>
        </a></li>
    </ul>
    </nav>

    <nav class="right-snb">
    <!-- 포인트 : aside>nav.right-snb>.point -->
    <div class="point">
        <p>10000P</p>
    </div>


    <!-- 날씨 정보 : aside>nav.right-snb>.weather-->
    <div class="weather">
        <h2>weather area</h2>
    </div>



    <!-- 친구 목록 : aside>nav.right-snb>.friends -->
    <div class="friends">
        
        <div class="friends">
        <h2> 친구 목록 </h2>
        <ul>
            <li>
            <div class="profile-box">
                <img src="/assets/img/test.jpg" alt="프로필 사진">
            </div>
            <a class="friend" href="#">asfasgas123</a>
            </li>

            <li>
            <div class="profile-box">
                <img src="#" alt="프로필 사진">
            </div>
            <a class="friend" href="#">fontfont3</a>
            </li>
            <li>
            <div class="profile-box">
                <img src="#" alt="프로필 사진">
            </div>
            <a class="friend" href="#">hello99</a>
            </li>
            <li>
            <div class="profile-box">
                <img src="#" alt="프로필 사진">
            </div>
            <a class="friend" href="#">panda423aa</a>
            </li>
        </ul>
        </div>
        

        <div id="user-information"> <!-- 친구 정보 창 -->
        <p>
            
            sdfa99asdf 님<span id="x-btn"></span>
        </p>
        <ul>
            <li id="my-page"></li>
            <li id="chatting"></li>
            <li id="ban"></li>
        </ul>
        </div>

        <div id="chatting">

        </div>


    </div>

    </nav>

    
</aside>

<!-- 사이드바 자바스크립트 -->
<script src="/assets/js/snb.js"></script>

