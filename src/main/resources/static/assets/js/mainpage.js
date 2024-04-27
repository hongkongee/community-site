
const $popular = document.getElementById('popular');
const $recent = document.getElementById('recent');
const r = document.querySelector('.btn-group').dataset.recent;

// 게시물 정렬하기
/*
function sortBoard(option) {
  console.log(option);

  var formData = {
    'option': option
  };

  fetch('/home/main/sort', {
    method: 'POST',
    headers: {
        'content-type': 'application/json'
    },
    body: JSON.stringify(formData)
  })
  .then(response => response.text())
  .then(data => {
      console.log("Form submission successful:", data);
  })
  .catch(error => {
      console.error("Error submitting form:", error);
  });
  

}

*/

// 인기순
$popular.onclick = () => {

  // sortBoard("popular");
  window.location.href = '/home/main';
}


// 최신순
$recent.onclick = () => {
  
  // sortBoard("recent");
  window.location.href = '/home/main/recent';
}

document.querySelector('section.hot .card-container').onclick = e => {
  
  if (!e.target.matches('img')) return;
  const bno = e.target.parentNode.parentNode.dataset.bno;
  // console.log(bno);
  window.location.href = '/home/detail/' + bno;
}


// card 영역 내에 아무거나 클릭해도 이벤트 발생, 마켓 게시글로 이동
document.querySelector('section.market .card-container').onclick = e => {
  console.log(e.target);
  e.preventDefault();

  const $card = e.target.closest('.card');
  console.log('$card = ', $card);

  if ($card) {
    const mno = $card.dataset.mno;
    console.log('mno = ', mno);
    window.location.href = '/market/detail/' + mno;
  }


    
  
}

// 즉시실행함수
(() => {
  console.log('r = ', r);

  if (r === 1) { // 최신순
    $recent.classList.add('active');

  } else { // 인기순
    $popular.classList.add('active');
  }
  
})();
