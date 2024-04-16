<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="/assets/css/mygallery.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

</head>
<body>

  <div class="MygalleryJsp" >
  <div class="mar">
    <div class="background">
    <div class="Rectangle1" >
      <button class="add-photo"><div>+ 사진 추가</div></button>

    <div class="Rectangle70">
    <div class="e20232022">
      <span class="let3" >2024<br/></span>
      <span class="let4">2023<br/></span>
      <span class="let5" >2022<br/></span>
    </div>
    </div>
    <div class="let2">
      <span class="new">최신순</span>
      /
      <span class="abc">가나다순</span>
    </div>

    <button class="Ellipse12">4</button>
    <button class="Ellipse13">8</button>

    <button class="Ellipse14">16</button>

    <div class="Rectangle51" ></div>
    <div class="Frame20" >
      <div class="Gallery">Gallery</div>
    </div>
    <div class="card-container">
      <c:forEach var="b" items="${gList}">
          <div class="card-wrapper">
              <section class="card" data-bno="${b.PhotoNumber}">
                  <div class="card-title-wrapper">
                      <h2 class="card-title">${b.shortTitle}</h2>
                      <div class="time-view-wrapper">
                          <div class="time">
                              <i class="far fa-clock"></i>
                                  ${b.regDate} </div>
                          <div class="view">
                              <i class="fas fa-eye"></i>
                              <span class="view-count">${b.viewCount}</span>
                          </div>
                      </div>
                  </div>
                  <div class="card-content">



                    ${b.shortContent}

                  </div>
              </section>
              
              <c:if test="${login.auth == '관리자회원' || login.account == b.writer}">
                  <div class="card-btn-group">
                      <button class="del-btn" data-href="/board/delete?bno=${b.PhotoNumber}">
                          <i class="fas fa-times"></i>
                      </button>
                  </div>
              </c:if>

          </div>
      </c:forEach>
  </div>
  </div>
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

    //========== 게시물 목록 스크립트 ============//

      function removeDown(e) {
        if (!e.target.matches('.card-container *')) return;
        const $targetCard = e.target.closest('.card-wrapper');
        $targetCard?.removeAttribute('id', 'card-down');
      }

      function removeHover(e) {
        if (!e.target.matches('.card-container *')) return;
        const $targetCard = e.target.closest('.card');
        $targetCard?.classList.remove('card-hover');

        const $delBtn = e.target.closest('.card-wrapper')?.querySelector('.del-btn');
        if ($delBtn) $delBtn.style.opacity = '0';
      }


      $cardContainer.onmouseover = e => {

        if (!e.target.matches('.card-container *')) return;

        const $targetCard = e.target.closest('.card');
        $targetCard?.classList.add('card-hover');

        const $delBtn = e.target.closest('.card-wrapper')?.querySelector('.del-btn');
        if ($delBtn) $delBtn.style.opacity = '1';
      }

      $cardContainer.onmousedown = e => {

        if (e.target.matches('.card-container .card-btn-group *')) return;

        const $targetCard = e.target.closest('.card-wrapper');
        $targetCard?.setAttribute('id', 'card-down');
      };

      $cardContainer.onmouseup = removeDown;

      $cardContainer.addEventListener('mouseout', removeDown);
      $cardContainer.addEventListener('mouseout', removeHover);

      // write button event
      const $addWriteBtn = document.querySelector('.add-btn');
      if ($addWriteBtn) {
        $addWriteBtn.onclick = e => {
        window.location.href = '/wel/write';
      };
      }


</script>



  </div>
  </div>




</body>
</html>