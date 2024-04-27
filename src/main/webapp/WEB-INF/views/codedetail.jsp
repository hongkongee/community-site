<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 글쓰기</title>

    <%@ include file="/WEB-INF/views/include/static-head.jsp" %>
    <link rel="stylesheet" href="/assets/css/header.css">

    <link rel="stylesheet" href="/assets/css/mainpage.css" >
    <link rel="stylesheet" href="/assets/css/snb.css" >

 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  
    <style>
body{
    background-color: #000080;
}
.form-container {
            width: 70%;
            margin: auto;
            padding: 20px;
        
            background-color: #fff;
           
            border-radius: 60px;
            font-size: 18px;
            padding: 5%;
            position: relative;
    top: 190px;
}
.form-main{
            
            border: 1px solid black;
            border-radius: 60px;
           
            padding: 5%;
                }

        .form-container h1 {
            font-size: 40px;
            font-weight: 700;
            letter-spacing: 10px;
            text-align: center;
            margin-bottom: 20px;
            color: black;
        }
.form-container h1 {
            font-size: 50px;
            font-weight: bold;
            letter-spacing: 10px;
            text-align: center;
            margin-bottom: 20px;
            color: black;
            padding: 40px 0px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-size: 20px;
            color: black;
        }
        #wrap h2{
    
    font-size: 50px;
            font-weight: bold;
            letter-spacing: 10px;
            text-align: center;
            margin-bottom: 20px;
            color: black;
            padding: 40px 0px;

}
        #title, #programming {
            font-size: 18px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid black;
            border-radius: 8px;
            margin-bottom: 10px;
           
        }

        #content {
            height: 400px;
            font-size: 18px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid black;
            border-radius: 8px;
            margin-bottom: 10px;
          
        }

        textarea {
            resize: none;
            height: 200px;
        }

        .buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        button {
            font-size: 20px;
    background: white;
    border: 2px solid #00196b;
        }
       
        button:hover {
            background: #00196b;
            color: #fff;
        }
        button.list-btn:hover {
            background: #00196b;
            color: #fff;
        }
        select{
            font-size: 18px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid black;
            border-radius: 8px;
            margin-bottom: 10px;
       
            
        }
.list-btn{
    margin-right: 10px;
}


        /* 페이지 css */
        /* 페이지 액티브 기능 */
        .pagination .page-item.p-active a {
            background: #333 !important;
            color: #fff !important;
            cursor: default;
            pointer-events: none;
        }

        .pagination .page-item:hover a {
            background: #888 !important;
            color: #fff !important;
        }

       

        
    </style>
   
</head>
<body>

    <%@ include file="/WEB-INF/views/include/header.jsp" %>



<div id="wrap" class="form-container">
    
    <h2>${b.title}</h2>
    <div class="form-main">
    <input type="text" id="programming" name="programming" value="${b.programming}" readonly>

    <div class="form-main">
    <input type="text" id="programming" name="programming" value="${b.programming}" readonly>


    <label for="content">내용</label>
    <div id="content">${b.content}</div>
    <div class="buttons">
        <button class="list-btn" type="button"
                onclick="location.href='/wel/myCode'">
            목록
        </button>
        <button  type="button"
                onclick="location.href='/wel/edit/${b.codeNo}'">
            수정
        </button>
       
    </div>

    </div>




   
    </div>




</div>

    <script>






    </script>



</body>
</html>
