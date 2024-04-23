<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #map-container {
        text-align: center;
    }

    #address-container {
        margin-top: 20px;
    }

    #googleMap {
        display: inline-block;
        /* inline-block으로 변경 */
        width: 500px;
        height: 500px;
    }
</style>

<div id="map-container">
    <div id="googleMap"></div>
</div>

<div id="address-container">
    <input type="text" name="address" id="address" placeholder="주소를 입력하세요">
    <button onclick="searchAddress()">검색</button>
</div>

<script>
    let map;
    let center;


    function myMap() { //Google Maps 초기화
        var mapOptions = { //지도 초기화 정보
            center: new google.maps.LatLng(37.552550, 126.937703),
            zoom: 18
        };

        map = new google.maps.Map(document.getElementById("googleMap"), mapOptions); //mapOptions 사용자 설정 위치 
    }

    function searchAddress() { //입력한 주소를 받아 해당 주소의 위도와 경도를 검색
        var geocoder = new google.maps.Geocoder();//주소 위도/경도 변환
        var address = document.getElementById("address").value; //HTML input요소 값 address에 저장

        geocoder.geocode({ 'address': address }, function(results, status) { //변환할 주소, 콜백함수
            if (status === 'OK') {
                map.setCenter(results[0].geometry.location);
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
            } else {
                alert('주소를 찾을 수 없습니다. 다른 주소를 입력해주세요.');
            }
        });
    }


    ///////////////////////////////////////


</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOCNKI6eODqFYglsYcSTmd0GDwNWUz8FU&callback=myMap">
</script>