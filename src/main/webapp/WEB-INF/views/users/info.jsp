<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정</title>

    <%@ include file="../include/headcss.jsp" %>

    <link rel="stylesheet" href="/assets/css/common.css">

    <style>
        body {
            background-color: #000080;
        }

        .container {
            width: 60%;
            font-family: "Orbit", sans-serif;
            margin: 100px auto;
            color: #000080;
            background-color: #fff;
            border-radius: 40px;
        }

        .container h2 {
            padding-top: 100px;
            padding-bottom: 100px;
            font-size: 1.5em;
            font-weight: 700;
            text-align: center;
        }

        .container .wrap .info {
            margin-top: 70px auto 80px auto;
            padding-left: 20%;
        }

        .container .wrap .main-btn {
            display: flex;
            justify-content: center;
        }

        .container .wrap p {
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .container .wrap .input-btn {
            width: 300px;
            height: 2em;
            border-color: #000080;
            border-width: 0 0 2px;
            background-color: transparent;
        }

        .container .wrap .input-btn:focus {
            outline: none;
        }

        input[type="radio"] {
            appearance: none;
            width: 1.3em;
            height: 1.3em;
            border: 1px solid #aaaaaa;
            border-radius: 50%;
        }

        input[type="text"].user_info {
            background-color: transparent;
            border: none;
        }

        input[type="text"]:focus {
            outline: none;
        }


        input[type="radio"]:checked {
            border: none;
        }

        input[type="radio"]:checked::after {
            content: "∨";
            font-size: 1.5em;

        }

        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            appearance: none;
            -moz-appearance: none;
            -webkit-appearance: none;
        }

        button {
            box-sizing: border-box;
            appearance: none;
            background-color: transparent;
            border: 2px solid #000080;
            border-radius: 0.6em;
            color: #000080;
            cursor: pointer;
            /* display: flex; */
            align-self: center;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1;
            margin: 20px;
            padding: 0.4em 1em;
            text-decoration: none;
            text-align: center;
            text-transform: uppercase;
            font-family: 'Orbit', sans-serif;

            &:hover,
            &:focus {
                color: #fff;
                outline: 0;
            }

            background-image: linear-gradient(45deg, #000080 50%, transparent 50%);
            background-position: 100%;
            background-size: 400%;


            transition: background 300ms ease-in-out;

            &:hover {
                background-position: 0;
            }
        }
    </style>

</head>

<body>

    <%@ include file="../include/header.jsp" %>

    <div class="container">
        <h2>회원 정보 수정</h2>
        <div class="wrap">
            <form action="/users/info" name="signUp" id="modifyForm" method="post">
                <div class="info">
                    <div id="info_id">
                        <p>아이디&nbsp; <span id="idChk"></span></p>
                        <input type="text" id="user_id" class="user_info" name="accountNumber"
                            value="${login.accountNumber}" readonly></input>
                    </div>
                    <div>
                        <p>비밀번호 재설정&nbsp;<span id="pwChk">(영문, 숫자, 특수문자를 포함해서 8자 이상)</span></p>
                        <input type="password" name="password" id="password" class="input-btn" required="required"
                            maxlength="20" placeholder="사용하실 비밀번호를 입력해주세요">
                    </div>
                    <div>
                        <p>비밀번호 재설정 확인&nbsp;<span id="pwChk2"></span></p>
                        <input type="password" name="pw_check" id="pw_check" class="input-btn" required="required"
                            placeholder="비밀번호를 다시 입력해주세요">
                    </div>
                    <div>
                        <p>이름</p>
                        <input type="text" name="name" class="user_info" value="${login.name}" readonly></input>
                    </div>
                    <div>
                        <p>변경할 닉네임을 입력해주세요&nbsp;<span id="nickChk"></span></p>
                        <input type="text" name="nickname" id="user_nickname" class="input-btn" minlength="2"
                            maxlength="8" required="required">${login.nickname}
                        <button type="button" id="id_check">중복 확인</button>
                    </div>
                    <div id="gender-box">
                        <p>성별을 선택해주세요</p>
                        <label for="gender_male">
                            <input type="radio" name="gender" value="Male">남자</label>
                        <label for="gender_female">
                            <input type="radio" name="gender" value="Female">여자</label>
                    </div>
                    <div>
                        <p>출생년도를 입력해주세요&nbsp;<span id="birthChk"></span></p>
                        <c:if test="${login.birthday!=0}">
                            <input type="number" name="birthday" id="birthYear" class="input-btn" maxlength="4"
                                required="required" placeholder="${login.birthday}" value="${login.birthday}">
                        </c:if>
                        <c:if test="${login.birthday==0}">
                            <input type="number" name="birthday" id="birthYear" class="input-btn" maxlength="4"
                                required="required" placeholder="1901">
                        </c:if>


                    </div>
                </div>
                <div class="main-btn">
                    <div id="modify-btn"><button type="submit">정보수정</button></div>
                    <div id="delete-btn"><button type="button">회원탈퇴</button></div>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 회원정보수정 입력값 검증 처리

        // 입력값 검증 통과 여부 배열
        const checkResultList = [false, false, false, false, false];

        // 아이디 검사 정규표현식
        const accountPattern = /^[a-zA-Z0-9]{4,14}$/;

        const $idInput = document.getElementById('user_id');
        const $idCheck = document.getElementById('id_check');


        // 패스워드 검사 정규표현식
        const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&_~])[A-Za-z\d@$!%*#?&_~]{8,}$/;

        // 패스워드 입력값 검증
        const $pwInput = document.getElementById('password');
        $pwInput.onkeyup = e => {
            const pwValue = $pwInput.value;
            // console.log(pwValue);
            if (pwValue.trim() === '') {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">[비밀번호는 필수값입니다.]</b>';
                checkResultList[0] = false;

            } else if (!passwordPattern.test(pwValue)) {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">[특수문자 포함 8자 이상 입력해주세요.]</b>';
                checkResultList[0] = false;

            } else {
                $pwInput.style.borderColor = 'skyblue';
                document.getElementById('pwChk').innerHTML = '<b style="color: skyblue;">[사용가능한 비밀번호입니다.]</b>';
                checkResultList[0] = true;
            }
        };

        // 패스워드 확인란 입력값 검증
        const $pwCheckInput = document.getElementById('pw_check');
        $pwCheckInput.onkeyup = e => {
            const pwCheckValue = $pwCheckInput.value;
            if (pwCheckValue.trim() === '') {
                $pwCheckInput.style.borderColor = 'red';
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">[비밀번호 확인란은 필수값입니다.]</b>';
                checkResultList[1] = false;

            } else if ($pwCheckInput.value !== $pwInput.value) {
                $pwCheckInput.style.borderColor = 'red';
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">[위와 동일하게 입력해주세요.]</b>';
                checkResultList[1] = false;

            } else {
                $pwCheckInput.style.borderColor = 'skyblue';
                document.getElementById('pwChk2').innerHTML =
                    '<b style="color: skyblue;">[비밀번호와 동일하게 작성되었습니다.]</b>';
                checkResultList[1] = true;
            }

        };

        // 닉네임 검사 정규표현식
        const nickPattern = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;
        // 닉네임 입력값 검증
        const $nickInput = document.getElementById('user_nickname');
        $nickInput.onkeyup = e => {
            const nickValue = $nickInput.value;
            if (nickValue.trim() === '') {
                $nickInput.style.borderColor = 'red';
                document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 필수정보입니다.]</b>';
                checkResultList[2] = false;

            } else if (!nickPattern.test(nickValue)) {
                $nickInput.style.borderColor = 'red';
                document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 한글로만 설정가능합니다.]</b>';
                checkResultList[2] = false;

            } else {
                $nickInput.style.borderColor = 'skyblue';
                document.getElementById('nickChk').innerHTML = '<b style="color: skyblue;">[사용가능한 닉네임입니다.]</b>';
                checkResultList[2] = true;
            }
        };

        // 성별 유효값 검증
        const $genderInput = document.getElementById('gender-box');
        $genderInput.onclick = e => {
            const $genderValue = document.querySelector('input[type="radio"]:checked').value;
            console.log($genderValue);
            if ($genderValue === "Male" || $genderValue === "Female") {

                checkResultList[3] = true;
            } else {
                checkResultList[3] = false;
            }

        }

        // 출생년도 유효값 검증
        const $birthInput = document.getElementById('birthYear');
        $birthInput.onkeyup = e => {

            const birthValue = $birthInput.value.trim();
            if (birthValue === '') {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: red;">[출생년도는 필수값 입니다.]</b>';
                checkResultList[4] = false;
            } else if (birthValue.length !== 4) {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: red;">[출생년도는 4자리로 입력해주세요.]</b>';
                checkResultList[4] = false;
            } else if (birthValue > 2155 || birthValue < 1901) {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: red;">[1901 - 2155 사이의 값을 입력해주세요.]</b>';
                checkResultList[4] = false;
            } else {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: skyblue;">[사용가능합니다.]</b>';
                checkResultList[4] = true;
            }
        };

        // 회원 수정 버튼 클릭 이벤트
        document.getElementById('modify-btn').onclick = e => {

            if (checkResultList.includes(false)) {
                alert('입력란을 다시 확인하세요.');
                console.log(checkResultList);
                return;
            } else {
                alert('수정되었습니다.');
            }
        };

        // 회원 탈퇴 버튼 클릭 이벤트
        document.getElementById('delete-btn').onclick = e => {
            if (confirm("탈퇴하시겠습니까?")) {
                alert("회원 탈퇴 완료");
                fetch("/users/delete", {
                    method: 'GET'
                });
                document.querySelector('.inner-header .logo a').click();
            }
        }
    </script>


</body>

</html>