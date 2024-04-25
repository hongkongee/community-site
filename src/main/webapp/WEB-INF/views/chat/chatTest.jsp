<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채팅</title>
</head>
<body>
    <form action="">
        <div class="wrapper">
            <div class="msgArea"></div>
            <input type="text" placeholder="메시지를 입력하세요." class="content" id="message">
            <button type="button" class="sendBtn">전송</button>
        </div>
    </form>
    <input type="button" id="test" value="테스트">
</body>

<script>

// document.addEventListener("DOMContentLoaded", function() {
//     fetch("http://localhost:8282/ws/chat", {
//         method: "POST",
//         body: JSON.stringify({
//             "type":"ENTER",
//             "roomId":"room8282",
//             "sender":"테스트1",
//             "message":document.getElementById('message').textContent
//         })
//     })
// })

// document.getElementById('test').onclick = e => {
//     fetch("http://localhost:8282/chat?name=test");
//     console.log("클릭이벤트 발새ㅇ");
// }

// API 호출하는 함수
function patchApi(url, method, bodyData) {
    // 요청 옵션 설정
    var options = {
        method: method,
        headers: {
            "Content-Type": "application/json" // JSON 데이터 전송을 위한 헤더 설정
        },
        body: JSON.stringify(bodyData) // JSON 형식의 데이터를 문자열로 변환하여 전송
    };

    // 패치 요청 보내기
    fetch(url, options)
        .then(function(response) {
            if (!response.ok) {
                throw new Error("HTTP error, status = " + response.status);
            }
            return response.json(); // JSON 형식의 응답을 파싱하여 반환
        })
        .then(function(data) {
            console.log("패치 요청 성공:", data);
        })
        .catch(function(error) {
            console.error("패치 요청 실패:", error);
        });
}

// 패치할 데이터
var patchData = {
    key: "value"
};

patchApi("http://localhost:8282/api/endpoint", "POST", patchData);





</script>

</html>