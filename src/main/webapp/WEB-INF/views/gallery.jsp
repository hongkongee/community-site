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
              <section class="card" data-bno="${b.photoNumber}">
                  <div class="card-title-wrapper">
                      <h2 class="card-title">${b.shortTitle}</h2>
                      <div class="time-view-wrapper">
                          <div class="time">
                              <i class="far fa-clock"></i>
                                  ${b.regDate} </div>

                      </div>
                  </div>
                  <div class="card-content">





                  </div>
              </section>
              
              <c:if test="${login.auth == '관리자회원' || login.account == b.writer}">
                  <div class="card-btn-group">
                      <button class="del-btn" data-href="/wel/gallery">
                          <i class="fas fa-times">&times;</i>
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

                <a href=""></a><br>
                <a href=""></a><br>
                <a href=""></a><br>
                <a href=""></a><br>
                <a href=""></a><br>
                <a href=""></a>
            </div>

        </div>

        <div id="myModal" class="modal">
          <div class="modal-detail">
          <button class="close-btn"></button> <br>
            <span class="close">&times;</span>
            <p>모달 내용이 여기에 들어갑니다.</p>
          </div>
        </div>

<div class="modal" id="modal">
    <div class="modal-content">
        <p>정말로 삭제할까요?</p>
        <div class="modal-buttons">
            <button class="confirm" id="confirmDelete"><i class="fas fa-check"></i> 예</button>
            <button class="cancel" id="cancelDelete"><i class="fas fa-times"></i> 아니오</button>
        </div>
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
const $cardContainer = document.querySelector('.card-container');
const $modal = document.getElementById('modal');
const $confirmDelete = document.getElementById('confirmDelete'); 
let $cancelDelete = document.getElementById('cancelDelete'); 


const modal = document.getElementById('myModal');
const closeModal = modal.querySelector('.close');

// $cardContainer.addEventListener('click', e => {

//   if (e.target.matches('.card-container')) return;

//   if (e.target.matches('.card-btn-group *')) {
  
//  $modal.style.display = 'flex';
//  const deleteLocation = e.target.closest('.del-btn').dataset.href;
//  $cancelDelete = e => {
//   console.log('das',e.target);
// location.href = deleteLocation;

// $modal.style.display = 'none';
 

//  }
//  $cancelDelete.onclick = ()  => {
// $modal.style.display = 'none';
//  }

 
// }else{

//   const bno = e.target.closest('section.card').dataset.bno;
//   console.log('bno: ' + bno);



//   // 모달을 활성화
//   modal.style.display = 'block';

//   // 모달 닫기 버튼에 클릭 이벤트 추가
//   closeModal.addEventListener('click', () => {
//     modal.style.display = 'none';
    
//   });
// }
// });


// $cardContainer.addEventListener('click', e=> {

//   console.log('target',e.target);
//   if (e.target.matches('.card-container'))return;
    
  
//   const bno = e.target.closest('section.card').dataset.bno;
//   console.log('bno'+bno);

//   location.href='/wel/';


// })
$cardContainer.addEventListener('click', e => {
  if (e.target.matches('.card-container')) return;

  if (e.target.matches('.card-btn-group *')) {
    $modal.style.display = 'flex';
    const deleteLocation = e.target.closest('.del-btn').dataset.href;
    
    // $cancelDelete 변수를 선언하고 클릭 이벤트 핸들러를 할당합니다.
    const cancelDelete = () => {
      console.log('cancel delete');
      location.href = deleteLocation;
      $modal.style.display = 'none';
    };

    // 삭제 버튼에 클릭 이벤트 핸들러를 할당합니다.
    document.getElementById('cancelDelete').addEventListener('click', cancelDelete);
  } else {
    const bno = e.target.closest('section.card').dataset.bno;
    console.log('bno: ' + bno);

    // 모달을 활성화
    modal.style.display = 'block';

    // 모달 닫기 버튼에 클릭 이벤트 추가
    closeModal.addEventListener('click', () => {
      modal.style.display = 'none';
    });
  }
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