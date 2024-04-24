<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="/assets/css/mychat.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

  
</head>
<body>


  <div class="MychatJsp">
    <div class="Rectangle1"></div>
    <div class="Chat" >Chat</div>
    <div class="Line2" ></div>
    <div class="Frame22" >
       


        <div class="friends">
            <h2> 팔로우 목록 </h2>

            <div id="followCollapse">
                <div id="followData">
                    <!-- JS로 팔로우 정보 DIV 삽입 -->
                </div>
            </div>
        </div>



<!--
        <div class="Rectangle8" >
        <h2> 최근 채팅 목록 </h2>

        </div>
      </div>

-->

     
    </div>
    <div class="Frame23" >
      <div class="Rectangle57" ></div>
      <div class="Api" >대화창 api</div>
    </div>




<script src="/assets/js/snb.js"></script>
  
</body>
</html>