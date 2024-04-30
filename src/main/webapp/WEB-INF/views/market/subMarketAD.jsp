<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div class="ad">
  <!-- 광고 테스트 -->
  <div class="ad-box">
    <div class="adtitle">광고</div>

    <ul class="add-group">
      <!-- 광고 영역 1, 2, 3, 4 -->
      <li class="ad1">
        <img class=ad-img1 src="" />
        <div class="ad-content1"> # <br /> #원</div>
      </li>

      <li class="ad2">
        <img class=ad-img2 src="" />
        <div class="ad-content2"> # <br /> #원</div>
      </li>

      <li class="ad3">
        <img class=ad-img3 src="" />
        <div class="ad-content3"> # <br /> #원</div>
      </li>

      <li class="ad4">
        <img class=ad-img4 src="" />
        <div class="ad-content4"> # <br /> #원</div>
      </li>
    </ul>


    <!-- 광고 더미리스트 -->
    <div class="adSampleList" style="display:none;">
      <div class="ad">
        <img src="https://shop-phinf.pstatic.net/20230207_95/1675758661014LVotx_JPEG/KakaoTalk_20230207_172735920_02.jpg?type=w860" />
        <div class="ad-content">#흰 셔츠<br />#49,000원</div>
      </div>
      <div class="ad">
        <img src="https://static.lookpin.co.kr/20230211105113-07e7/a75da881ce8b00e52b77abe98f126239.jpg" />
        <div class="ad-content">#브라운 셔츠<br />#50000원</div>
      </div>
      <div class="ad">
        <img
          src="https://shop-phinf.pstatic.net/20210526_75/1622030604426uM1Nz_JPEG/%EB%82%A8%EC%9E%90%EB%82%A8%EC%84%B1%EC%85%94%EC%B8%A0_25.jpg" />
        <div class="ad-content">#그린셔츠<br />#10000원</div>
      </div>
      <div class="ad">
        <img src="https://m.uremind.co.kr/web/product/big/202208/07221d255ebc9781e55b5a1b0c2fb90c.jpg" />
        <div class="ad-content">#스카이셔츠<br />#40000원</div>
      </div>
      <div class="ad">
        <img src="https://m.boom-style.com/web/product/big/202210/12109c0b6d851c1b5a249286528da487.jpg">
        <div class="ad-content">#스카이돌고래셔츠<br />#45000원</div>
      </div>
      <div class="ad">
        <img src="https://cafe24img.poxo.com/meetkmi0/web/product/big/20200430/c80d4d226ae9d8b1ae3b767c2dcc680a.jpg" />
        <div class="ad-content">#네이비셔츠<br />#60000원</div>
      </div>
      <div class="ad">
        <img src="https://image.msscdn.net/images/goods_img/20210215/1793989/1793989_2_500.jpg" />
        <div class="ad-content">#화이트셔츠<br />#70000원</div>
      </div>
      <div class="ad">
        <img src="https://nareum.co.kr/web/product/big/202209/9aaf16bb15f345cc5464a52699f17921.jpg" />
        <div class="ad-content">#체크셔츠<br />#37000원</div>
      </div>
      <div class="ad">
        <img src="https://img.mbn.co.kr/filewww/news/2023/04/25/16824160556447a1b7287b7.png" />
        <div class="ad-content">#게임셔츠<br />#80000원</div>
      </div>
      <div class="ad">
        <img src="https://img.shoppingntmall.com/goods/373/11474373_h.jpg" />
        <div class="ad-content">#고급 청바지<br />#70000원</div>
      </div>
    </div>

  </div>

</div>


<script>
  function adShuffle() {
    const $ads = document.querySelectorAll('.adSampleList .ad');



    // NodeList를 배열로 변환
    const adsArray = Array.from($ads);

    // adsArray.from : 배열을 랜덤하게 섞는 함수
    function shuffle(adsArray) {
      for (let i = adsArray.length - 1; i > 0; i--) {
        // 배열의 끝에서 시작하여 배열의 첫 번째 요소까지 역순으로 반복
        const j = Math.floor(Math.random() * (i + 1));
        //j는 0부터 i 사이의 랜덤한 인덱스 값
        [adsArray[i], adsArray[j]] = [adsArray[j], adsArray[i]];
        //배열의 i 번째 요소와 j 번째 요소를 서로 바꾸기
      }
      return adsArray;
    }

    // 배열을 랜덤하게 섞음
    const shuffledAds = shuffle(adsArray);
    console.log('shuffledAds: ', shuffledAds);

    // ad1, ad2, ad3, ad4에 랜덤하게 배치
    const adContainers = { //객체 리터럴 문법 : key - value
      'ad1': document.querySelector('.add-group .ad1'),
      'ad2': document.querySelector('.add-group .ad2'),
      'ad3': document.querySelector('.add-group .ad3'),
      'ad4': document.querySelector('.add-group .ad4'),
    };

    // 각 컨테이너에 랜덤한 광고 삽입
    for (let i = 0; i < 4; i++) {
      adContainers[`ad\${i + 1}`].innerHTML = ''; //템플릿 리터럴 \
      adContainers[`ad\${i + 1}`].appendChild(shuffledAds[i]);
    }
  }

  // 함수 호출
  adShuffle();
</script>