
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

// 즉시실행함수
(() => {

  if (r === 1) {
    $popular.classList.remove('active');
    $recent.classList.add('active');
  } else {
    $popular.classList.add('active');
    $recent.classList.remove('active');
  }
  
})();
