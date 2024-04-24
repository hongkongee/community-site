
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

document.querySelector('.card-container').onclick = e => {
  if (!e.target.matches('img')) return;
  const bno = e.target.parentNode.parentNode.dataset.bno;
  // console.log(bno);
  window.location.href = '/home/detail/' + bno;
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
