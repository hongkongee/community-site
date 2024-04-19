<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>All page</title>

    <%@ include file="../include/static-head.jsp" %>

    <link rel="stylesheet" href="/assets/css/allpage.css" >
    <link rel="stylesheet" href="/assets/css/snb.css" >


</head>
<body>

    <!-- 사이드바 -->
    <%@ include file="../include/snb.jsp" %>


    <!-- center 영역 -->
    <div class="wrapper">

        <section class="all">
          <h2> 전체 게시글</h2>
    
          <div class="list-container">
    
            <table>
              
    
              
              <thead class="head-wrapper"> <!-- 게시판 헤드 -->
                <tr>
                  <th>글번호</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일</th>
                  <th>조회수</th>
                </tr>
              </thead>
              
                
              
    
              <tbody>
    
              <c:forEach var="s" items="${bList}">
                <tr class="post"> <!-- 게시글 하나 -->
                  <td id="bno">${s.boardNo}</td>
                  <td id="textTitle"> <a href="/market/detail/${s.boardNo}"> ${s.textTitle} </a></td>
                  <td id="textWriter">${s.textWriter}</td>
                  <td id="updateDate">${s.updateDate}</td>
                  <td id="viewCount"> ${s.viewCount}</td>
                

                  <!-- <td id="view">100</td> -->
                </tr>
              </c:forEach>  
                
                
                <!-- Add more rows as needed -->
              </tbody>
            </table>
    
          </div>
          
    
        </section>
        
    
     
    
</body>
</html>