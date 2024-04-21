<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


  
<!-- ===================== side navigation bar ========================== -->
<aside>
    <nav class="left-snb">
    <!-- 왼쪽 메뉴 사이드바 -->
    <ul>
        <li id="home"><a href="/home/main">Home</a></li>
        <li id="game"><a href="/home/rps">게임</a></li>
        <li id="second-hand"><a href="/market/main">중고 장터</a></li>
        <li id="sports"><a href="#">로또</a></li>
        <li id="all"><a href="/home/all">
        전체 게시판
        <ul>
            <li id="game-board"><a href="/home/board/game">게임 게시판</a></li>
            <li id="movie"><a href="/home/board/movie">영화 게시판</a></li>
            <li id="trip"><a href="/home/board/trip">여행 게시판</a></li>
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
            <h2> 팔로우 목록 </h2>

            <div id="followCollapse">
                <div id="followData">
                    <!-- JS로 팔로우 정보 DIV 삽입 -->
                </div>
            </div>
        </div>

     
        

        <div id="follow-information"> <!-- 친구 정보 창 -->
            <!-- JS로 팔로우 디테일 정보 DIV 삽입 -->      
        
        </div>

        

    </div>

    </nav>

    
</aside>

<!-- 사이드바 자바스크립트 -->
<script src="/assets/js/snb.js"></script>

