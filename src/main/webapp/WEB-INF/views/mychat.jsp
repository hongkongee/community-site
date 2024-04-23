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
      <div class="Rectangle6" ></div>
      <div class="Rectangle7" ></div>
      <div class="let1" >최근 채팅 목록</div>
      <div class="let2" >팔로워 목록</div>
      <div class="Rectangle6"></div>
      <div class="Ellipse5" >프사</div>
      <div class="Ellipse6" >프사</div>

      <div class="Ellipse7" >프사</div>

      <div class="let6" >이름</div>
      <div class="let7" >이름</div>
      <div class="let8" >이름</div>
      <div class="Rectangle8" ></div>
      <div class="Ellipse8" >프사</div>
      <div class="Ellipse9" >프사</div>

      <div class="Ellipse10" >프사</div>

      <div class="let12" >최근 내용</div>
      <div class="let13" >최근 내용</div>
      <div class="let14" >최근 내용</div>
      <div class="Ellipse11" ></div>
      <div class="let15" >3</div>
      <div class="Rectangle52" ></div>
    </div>
    <div class="Frame23" >
      <div class="Rectangle57" ></div>
      <div class="Api" >대화창 api</div>
    </div>
    <div class="Frame40">

                <div class="Menu">
                    <button class="close-btn">X</button> <br>
                    <a href="">HOME</a><br>
                    <a href="">Posting</a><br>
                    <a href="">Diary</a><br>
                    <a href="">Gallery</a><br>
                    <a href="">Chat</a><br>
                    <a href="">Market</a>
                </div>

            </div>


    </body>

    <script>

        const sidebar = document.querySelector('.Frame40');

        // document.querySelector('.Frame40').addEventListener('mouseover', function () {
        //     // When the user hovers over the element, change its transform property to translateX(0)
        //     this.style.transform = 'translateX(-100%)';
        // });

        // Add a hover event listener to the Frame40 element
        document.querySelector('.Frame40').addEventListener('mouseover', function () {
            // When the user hovers over the element, change its transform property to translateX(0)
            this.style.transform = 'translateX(0)';
        });


        document.querySelector('.close-btn').addEventListener('click', function () {
            // When the user is not hovering over the element, change its transform property to translateX(-100%)
            sidebar.setAttribute("style", "transform: translateX(-100%);");
        });
    </script>
  </div>

</body>
</html>