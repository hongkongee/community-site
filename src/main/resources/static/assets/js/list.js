const $body = document.querySelector('body');

// 게시물 상세 조회
$body.addEventListener('click', e => {

  console.log('이벤트 타겟: ', e.target);

  if (e.target.matches('#title a')) { // 게시글 제목을 누르면
    const bno = e.target.dataset.bno;
    console.log('bno: ', bno);
    window.location.href = '/home/detail/' + bno;
  }


});











