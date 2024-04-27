const $addFavButtons = document.querySelectorAll('.favorite');

console.log($addFavButtons);
let isAddFav = false;

function clickFav(e) {
  // [...$addFavButtons].forEach( e => { //... 배열화
  //   e.addEventListener('click', function (e) {
  
      console.log('즐겨찾기 클릭 이벤트 발생!');
      console.log('이벤트 발생 타겟: ', e.target);
      const boardNo = e.target.closest('td.favorite').dataset.bno;
      //가까운 bno 호출
      console.log('이벤트 발생 타겟 글번호: ', boardNo);
  
      if (e.target.classList.contains('fa-regular')) {
        console.log('즐겨찾기 추가!');
        e.target.classList.remove('fa-regular');
        e.target.classList.add('fa-solid');
        isAddFav = true;
      } else {
        console.log('즐겨찾기 제거!');
        e.target.classList.remove('fa-solid');
        e.target.classList.add('fa-regular');
        isAddFav = false;
      }
  
      fetch(`/market/list/${boardNo}`, { 
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            'isAddFav': isAddFav
          })
        })
        .then(response => response.text())
        .then(data => {
          if (data === 'success') {
            if (isAddFav) {
              alert('즐겨찾기 추가 완료!');
            } else {
              alert('즐겨찾기 제거 완료!');
            }
          } else {
            alert('즐겨찾기 상태를 업데이트하는데 실패했습니다.');
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert('서버와의 통신에 문제가 발생했습니다.');
        });
  //   });
  
  
  // });

}






      