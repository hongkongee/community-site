
//날씨 정보 가져오기
const API_KEY = '1847692425e883baf8b34c897b074b6a';

document.addEventListener('DOMContentLoaded', () => {
  navigator.geolocation.getCurrentPosition(success);
});

const success = (position) => {
  const latitude = position.coords.latitude;
  const longitude = position.coords.longitude;

  getWeather(latitude, longitude);
};

const button = document.querySelector('.button');
button.addEventListener('click', () => {
  navigator.geolocation.getCurrentPosition(success);
});
const tempSection = document.querySelector('.temperature');
const placeSection = document.querySelector('.place');
const descSection = document.querySelector('.description');
const iconSection = document.querySelector('.icon');
//json으로 변환 데이터 가져오기
const getWeather = (lat, lon) => {
  fetch(
      `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric&lang=kr`
  )
      .then((response) => {
          return response.json();
      })
      //json 데이터 가져오기
      .then((json) => {
          const icon = json.weather[0].icon;
          const iconURL = `http://openweathermap.org/img/wn/${icon}@2x.png`;
          const temperature = json.main.temp;
          const place = json.name;
          const description = json.weather[0].description;

          tempSection.innerText = temperature;
          placeSection.innerText = place;
          descSection.innerText = description;
          iconSection.setAttribute('src', iconURL);
      })
      .catch((error) => {
          alert(error);
      });
};