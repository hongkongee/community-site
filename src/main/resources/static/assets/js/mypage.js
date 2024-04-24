let likeFlag = 0; // 쿠키 존재 여부 (1 이면 좋아요 이미 부여)
// 모든 post를 감싸고 있는 부모 요소
const $postContain = document.querySelector('.post-contain');

// 좋아요 누르면 게시물 좋아요 수 1 증가시키고 취소하면 1 감소시키기
function likeCountUpDown(n, event) {
  console.log('좋아요 수를 변경합니다.');

  console.log('이벤트가 발생한 타겟: ', event.target);

  const bno = event.target.closest('div.like').dataset.bno;
  console.log('이벤트 발생 bno: ', bno);

  var formData = {
    bno: bno, // 게시글 번호
    number: n // likeCount에 더할 값
  };

  fetch("/home/detail/like", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
      console.log("Form submission successful:", data);
    })
    .catch(error => {
      console.error("Error submitting form:", error);
    });

}

// 페이지 진입 부터 좋아요 하트 체크여부 부여 (과거 이미 체크했다면 부여)
function alreadyLike() {

  // 쿠키 존재 (이미 클릭) -> likeFlag = 1
  likeFlag = document.querySelector('.like').dataset.likeCookie;
  likeFlag = Number(likeFlag);
  console.log('이미 좋아요를 눌렀나요?', likeFlag);

  if (likeFlag === 1) { // 과거에 체크를 이미 했다면
    e.target.classList.remove('fa-regular');
    e.target.classList.add('fa-solid'); // 체크 부여

  } else { // 체크를 한 적이 없다면
    e.target.classList.remove('fa-solid');
    e.target.classList.add('fa-regular'); // 체크 해제
  }



}



// 좋아요 누르면 하트 색깔 바뀌기
function clickHeartBtn(e) {
  console.log(likeFlag);
  const $likeLabel = e.target.nextElementSibling;

  if (likeFlag === 0) {
    console.log('하트버튼 클릭!');
    if (e.target.classList.contains('fa-solid')) { // 체크가 된 상태 라면
      likeCountUpDown(-1, e);
      e.target.classList.remove('fa-solid');
      e.target.classList.add('fa-regular'); // 체크 해제
      e.target.nextElementSibling.textContent = '좋아요 ' + e.target.nextElementSibling.dataset.likeCount;

    } else { // 체크가 안 된 상태라면
      likeCountUpDown(1, e);
      e.target.classList.remove('fa-regular');
      e.target.classList.add('fa-solid'); // 체크 부여

      // 클릭할 때마다 likeCount 실시간 반영
      const realTimeLike = Number($likeLabel.dataset.likeCount) + 1
      $likeLabel.textContent = '좋아요 ' + realTimeLike;
    }

  }

  if (likeFlag === 1) {

    if (e.target.classList.contains('fa-solid')) { // 체크가 된 상태 라면
      likeCountUpDown(-1);
      e.target.classList.remove('fa-solid');
      e.target.classList.add('fa-regular'); // 체크 해제
      const realTimeLike = Number($likeLabel.dataset.likeCount) - 1
      $likeLabel.textContent = '좋아요 ' + realTimeLike

    } else { // 체크가 안 된 상태라면
      likeCountUpDown(1);
      e.target.classList.remove('fa-regular');
      e.target.classList.add('fa-solid'); // 체크 부여
      $likeLabel.textContent = '좋아요 ' + $likeLabel.dataset.likeCount;
    }

  }
};


$postContain.onclick = (e) => {
  if(!e.target.matches('i.fa-heart')) return;
  clickHeartBtn(e);
}