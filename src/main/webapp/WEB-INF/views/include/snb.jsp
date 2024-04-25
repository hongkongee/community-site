<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


  
<!-- ===================== side navigation bar ========================== -->
<aside>
    <nav class="left-snb">
    <!-- 왼쪽 메뉴 사이드바 -->
    <ul>
        <li id="home"><a href="/home/main">Home</a></li>
        <li id="second-hand"><a href="/market/list">중고 장터</a></li>
        <li id="all"><a href="/home/board/all">
        전체 게시판
        <ul>
            <li id="normal">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/home/board/normal">질문 게시판</a></li>
            <li id="game-board">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/home/board/game">코드 공유 게시판</a></li>
            <li id="movie">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/home/board/movie">취업 게시판</a></li>
            <li id="trip">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/home/board/trip">IT 소식 게시판</a></li>
            <li id="market">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/home/board/market">자유 게시판</a></li>
        </ul>
        <li id="game">
        게임
            <li id="rsp">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/game/rps">가위바위보</a></li>
            <li id="lotto">
                <i class="fa-solid fa-arrow-right"></i>&nbsp;
                <a href="/game/lotto">로또</a></li>
        </li>
        
        </a></li>
    </ul>
    </nav>

    <nav class="right-snb">
    <!-- 포인트 : aside>nav.right-snb>.point -->
    <div class="point">
        <i class="fa-solid fa-coins">&nbsp;</i> <span>10000P</span>
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

