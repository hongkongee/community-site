<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 가입</title>

    <%@ include file="../include/headcss.jsp" %>

    <link rel="stylesheet" href="/assets/css/common.css">

    <style>
        body {
            background-color: #7AA2E3;
        }

        .container {
            width: 60%;
            font-family: "Orbit", sans-serif;
            margin: 100px auto;
            color: #7AA2E3;
            background-color: #F8F6E3;
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
            border-color: #7AA2E3;
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


        input[type="radio"]:checked {
            border: none;
        }

        input[type="radio"]:checked::after {
            content: "∨";
            font-size: 1.5em;

        }

        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            width: 300px;
            height: 2em;
            border-color: #7AA2E3;
            border-width: 0 0 2px;
            background-color: transparent;
        }

        button {
            box-sizing: border-box;
            appearance: none;
            background-color: transparent;
            border: 2px solid #7AA2E3;
            border-radius: 0.6em;
            color: #7AA2E3;
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

            background-image: linear-gradient(45deg, #7AA2E3 50%, transparent 50%);
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
        <h2>회원 가입</h2>
        <div class="wrap">
            <form action="/users/sign-up" name="signUp" id="signUpForm" method="post">
                <div class="info">
                    <div id="info_id">
                        <p>아이디를 입력해주세요&nbsp; <span id="idChk"></span></p>
                        <input type="text" name="accountNumber" id="user_id" class="input-btn" required="required"
                            maxlength="14" placeholder="사용하실 아이디를 입력해주세요">
                        <button type="button" id="id_check">중복 확인</button>
                    </div>
                    <div>
                        <p>비밀번호를 입력해주세요&nbsp;<span id="pwChk">(영문과 특수문자를 포함해서 8자 이상)</span></p>
                        <input type="password" name="password" id="password" class="input-btn" required="required"
                            maxlength="20" placeholder="사용하실 비밀번호를 입력해주세요">
                    </div>
                    <div>
                        <p>비밀번호를 다시 입력해주세요&nbsp;<span id="pwChk2"></span></p>
                        <input type="password" name="pw_check" id="pw_check" class="input-btn" required="required"
                            placeholder="비밀번호를 다시 입력해주세요">
                    </div>
                    <div>
                        <p>이름을 입력해주세요&nbsp;<span id="nameChk"></span></p>
                        <input type="text" name="name" id="user_name" class="input-btn" required="required"
                            placeholder="한글만 입력가능합니다">
                    </div>
                    <div>
                        <p>사용할 닉네임을 입력해주세요&nbsp;<span id="nickChk"></span></p>
                        <input type="text" name="nickname" id="user_nickname" class="input-btn" minlength="2"
                            maxlength="8" placeholder="2글자 이상 입력해주세요" required="required">
                    </div>
                    <div id="gender-box">
                        <p>성별을 선택해주세요</p>
                        <label for="gender_male">
                            <input type="radio" name="gender" value="Male">남자</label>
                        <label for="gender_female">
                            <input type="radio" name="gender" value="Female">여자</label>
                    </div>
                    <div>
                        <p>이메일을 입력해주세요&nbsp;<span id="emailChk"></span></p>
                        <input type="email" name="email" id="user_email" class="input-btn" required="required"
                            placeholder="ex) abc123@gmail.com">
                        <button type="button" id="mail-check-btn">이메일 인증</button>
                        <input style="width: 200px; display: none;" type="text" id="mail-check-input" class="input-btn"
                            placeholder="인증번호 6자리를 입력하세요." maxlength="6">

                        <br>
                        <span id="mailCheckMsg"></span>
                    </div>
                    <div>
                        <p>출생년도를 입력해주세요&nbsp;<span id="birthChk"></span></p>
                        <input type="number" name="birthday" id="birthYear" class="input-btn" maxlength="4"
                            required="required">

                    </div>
                </div>
                <div class="main-btn">
                    <div class="back-btn"><button type="button">돌아가기</button></div>
                    <div id="submit-btn"><button type="button">회원가입</button></div>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 이메일 인증버튼 클릭 이벤트

        let code = ''; // 이메일 전송 인증번호 저장을 위한 변수수

        document.getElementById('mail-check-btn').onclick = () => {
            const email = document.getElementById('user_email').value.trim();
            console.log('완성된 이메일: ', email);

            fetch('/users/email', {
                    method: 'post',
                    headers: {
                        'Content-type': 'text/plain'
                    },
                    body: email
                })
                .then(res => res.text())
                .then(data => {
                    console.log('인증번호: ', data);
                    code = data;

                    // 이메일 전송이 완료되면 이메일 입력창 readonly로 막기
                    document.getElementById('user_email').readOnly = true;

                    // 인증번호 입력창 활성화
                    document.getElementById('mail-check-input').disabled = false;
                    alert('인증번호가 전송되었습니다. 확인 후 입력란에 정확히 입력하세요.');
                })
                .catch(error => {
                    console.log(error);
                    alert('이메일 전송에 실패했습니다. 존재하는 이메일인지 확인해주세요.');
                })
        };

        // 인증번호 검증
        // blur -> focus가 빠지는 경우 발생.
        document.getElementById('mail-check-input').onblur = e => {
            console.log('blur 이벤트 발생!');
            const inputCode = e.target.value;
            if (inputCode === code) {
                document.getElementById('mailCheckMsg').textContent = '인증번호가 일치합니다!';
                document.getElementById('mailCheckMsg').style.color = 'skyblue';
                e.target.style.display = 'none';
            } else {
                document.getElementById('mailCheckMsg').textContent = '인증번호를 다시 확인하세요!';
                document.getElementById('mailCheckMsg').style.color = 'red';
                e.target.focus();
            }
        }


        // 회언가입 입력값 검증 처리
        // 입력값 검증 통과 여부 배열
        const checkResultList = [false, false, false, false, false, false, false, false];

        // 회원가입 입력값 검증 처리

        // 아이디 검사 정규표현식
        const accountPattern = /^[a-zA-Z0-9]{4,14}$/;

        const $idInput = document.getElementById('user_id');
        const $idCheck = document.getElementById('id_check');

        // 버튼을 클릭하면 이벤트 발생
        $idCheck.onclick = e => {

            const idValue = $idInput.value;
            console.log('idValue의 값: ' + idValue);

            if (idValue.trim() === '') {
                $idInput.style.borderColor = 'red';
                document.getElementById('idChk').innerHTML = '<b style="color: red;">[아이디는 필수값입니다.]</b>'
                checkResultList[0] = false;
            } else if (!accountPattern.test(idValue)) {

                // 정규표현식의 test 함수를 통해 입력값이 패턴에 유효한지 검증
                $idInput.style.borderColor = 'red';
                document.getElementById('idChk').innerHTML =
                    '<b style="color: red;">[아이디는 4~14글자의 영문, 숫자로 입력하세요.]</b>';
                checkResultList[0] = false;
            } else {
                // 비동기 요청으로 아이디 중복 확인 진행
                fetch('/users/check/account/' + idValue)
                    .then(res => res.json())
                    .then(flag => {
                        if (flag) { // 중복
                            $idInput.style.boarderColor = 'red';
                            document.getElementById('idChk').innerHTML =
                                '<b style="color: red;">[아이디가 중복되었습니다.]</b>';
                            checkResultList[0] = false;

                        } else {
                            $idInput.style.boarderColor = 'skyblue';
                            document.getElementById('idChk').innerHTML =
                                '<b style="color: skyblue;">[사용 가능한 아이디입니다.]</b>';
                            checkResultList[0] = true;
                        }
                    });
            }
        };

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
                checkResultList[1] = false;

            } else if (!passwordPattern.test(pwValue)) {
                $pwInput.style.borderColor = 'red';
                document.getElementById('pwChk').innerHTML = '<b style="color: red;">[특수문자 포함 8자 이상 입력해주세요.]</b>';
                checkResultList[1] = false;

            } else {
                $pwInput.style.borderColor = 'skyblue';
                document.getElementById('pwChk').innerHTML = '<b style="color: skyblue;">[사용가능한 비밀번호입니다.]</b>';
                checkResultList[1] = true;
            }
        };

        // 패스워드 확인란 입력값 검증
        const $pwCheckInput = document.getElementById('pw_check');
        $pwCheckInput.onkeyup = e => {
            const pwCheckValue = $pwCheckInput.value;
            if (pwCheckValue.trim() === '') {
                $pwCheckInput.style.borderColor = 'red';
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">[비밀번호 확인란은 필수값입니다.]</b>';
                checkResultList[2] = false;

            } else if ($pwCheckInput.value !== $pwInput.value) {
                $pwCheckInput.style.borderColor = 'red';
                document.getElementById('pwChk2').innerHTML = '<b style="color: red;">[위와 동일하게 입력해주세요.]</b>';
                checkResultList[2] = false;

            } else {
                $pwCheckInput.style.borderColor = 'skyblue';
                document.getElementById('pwChk2').innerHTML =
                    '<b style="color: skyblue;">[비밀번호와 동일하게 작성되었습니다.]</b>';
                checkResultList[2] = true;
            }

        };

        // 이름 검사 정규표현식
        const namePattern = /^[가-힣]+$/;
        // 이름 입력값 검증
        const $nameInput = document.getElementById('user_name');
        $nameInput.onkeyup = e => {
            const nameValue = $nameInput.value;
            if (nameValue.trim() === '') {
                $nameInput.style.borderColor = 'red';
                document.getElementById('nameChk').innerHTML = '<b style="color: red;">[이름은 필수정보입니다.]</b>';
                checkResultList[3] = false;

            } else if (!namePattern.test(nameValue)) {
                $nameInput.style.borderColor = 'red';
                document.getElementById('nameChk').innerHTML = '<b style="color: red;">[이름은 한글로만 설정가능합니다.]</b>';
                checkResultList[3] = false;

            } else {
                $nameInput.style.borderColor = 'skyblue';
                document.getElementById('nameChk').innerHTML = '<b style="color: skyblue;">[사용가능한 이름입니다.]</b>';
                checkResultList[3] = true;
            }
        };

        // 닉네임 검사 정규표현식
        const nickPattern = /^[가-힣]+$/;
        // 닉네임 입력값 검증
        const $nickInput = document.getElementById('user_nickname');
        $nickInput.onkeyup = e => {
            const nickValue = $nickInput.value;
            if (nickValue.trim() === '') {
                $nickInput.style.borderColor = 'red';
                document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 필수정보입니다.]</b>';
                checkResultList[4] = false;

            } else if (!nickPattern.test(nickValue)) {
                $nickInput.style.borderColor = 'red';
                document.getElementById('nickChk').innerHTML = '<b style="color: red;">[닉네임은 한글로만 설정가능합니다.]</b>';
                checkResultList[4] = false;

            } else {
                $nickInput.style.borderColor = 'skyblue';
                document.getElementById('nickChk').innerHTML = '<b style="color: skyblue;">[사용가능한 닉네임입니다.]</b>';
                checkResultList[4] = true;
            }
        };

        // 성별 유효값 검증
        const $genderInput = document.getElementById('gender-box');
        $genderInput.onclick = e => {
            const $genderValue = document.querySelector('input[type="radio"]:checked').value;
            console.log($genderValue);
            if ($genderValue === "Male" || $genderValue === "Female") {

                checkResultList[5] = true;
            } else {
                checkResultList[5] = false;
            }

        }


        // 이메일 검사 정규표현식
        const emailPattern =
            /^(?:[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$/;

        const $emailInput = document.getElementById('user_email');
        $emailInput.onkeyup = e => {
            const emailValue = $emailInput.value;

            if (emailValue.trim() === '') {
                $emailInput.style.borderColor = 'red';
                document.getElementById('emailChk').innerHTML =
                    '<b style="color: red;">[이메일 필수값입니다.]</b>';
                checkResultList[6] = false;

            } else if (!emailPattern.test(emailValue)) {
                $emailInput.style.borderColor = 'red';
                document.getElementById('emailChk').innerHTML =
                    '<b style="color: red;">[이메일 형식을 지켜주세요.]</b>';
                checkResultList[6] = false;

            } else {
                fetch('/users/check/email/' + emailValue) // 이메일 정보 DB와 연동해서 가져오기!!
                    .then(res => res.json())
                    .then(flag => {
                        if (flag) { // 중복
                            $emailInput.style.borderColor = 'red';
                            document.getElementById('emailChk').innerHTML =
                                '<b style="color: red;">[이메일이 중복되었습니다.]</b>';
                            checkResultList[6] = false;

                        } else {
                            $emailInput.style.borderColor = 'skyblue';
                            document.getElementById('emailChk').innerHTML =
                                '<b style="color: skyblue;">[사용가능한 이메일입니다.]</b>';

                            // 이메일 인증버튼 클릭 이벤트

                            let code = ''; // 이메일 전송 인증번호 저장을 위한 변수

                            document.getElementById('mail-check-btn').onclick = () => {
                                const email = document.getElementById('user_email').value.trim();
                                console.log('완성된 이메일: ', email);

                                // if (email === '') {
                                //     alert('이메일을 입력해주세요.')
                                // }

                                fetch('/users/email', {
                                        method: 'post',
                                        headers: {
                                            'Content-type': 'text/plain'
                                        },
                                        body: email
                                    })
                                    .then(res => res.text())
                                    .then(data => {
                                        console.log('인증번호: ', data);
                                        code = data;

                                        // 이메일 전송이 완료되면 이메일 입력창 readonly로 막기
                                        document.getElementById('user_email').readOnly = true;

                                        // 인증번호 입력창 활성화
                                        document.getElementById('mail-check-input').style.display =
                                            "inline";
                                        alert('인증번호가 전송되었습니다. 확인 후 입력란에 정확히 입력하세요.');
                                    })
                                    .catch(error => {
                                        console.log(error);
                                        alert('이메일 전송에 실패했습니다. 존재하는 이메일인지 확인해주세요.');
                                    })
                            };


                            // 인증번호 검증
                            // blur -> focus가 빠지는 경우 발생.
                            document.getElementById('mail-check-input').onblur = e => {
                                console.log('blur 이벤트 발생!');
                                const inputCode = e.target.value;
                                if (inputCode === code) {
                                    document.getElementById('mailCheckMsg').textContent = '인증번호가 일치합니다!';
                                    document.getElementById('mailCheckMsg').style.color = 'skyblue';
                                    e.target.style.display = 'none';
                                    document.getElementById('mail-check-btn').style.display = 'none';
                                    checkResultList[6] = true;
                                } else {
                                    document.getElementById('mailCheckMsg').textContent = '인증번호를 다시 확인하세요!';
                                    document.getElementById('mailCheckMsg').style.color = 'red';
                                    e.target.focus();
                                    checkResultList[6] = false;
                                }
                            }
                        }
                    });
            }
        };

        // 출생년도 유효값 검증
        const $birthInput = document.getElementById('birthYear');
        $birthInput.onkeyup = e => {

            const birthValue = $birthInput.value.trim();
            if (birthValue === '') {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: red;">[출생년도는 필수값 입니다.]</b>';
                checkResultList[7] = false;
            } else if (birthValue.length !== 4) {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: red;">[출생년도는 4자리로 입력해주세요.]</b>';
                checkResultList[7] = false;
            } else if (birthValue > 2155 || birthValue < 1901) {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: red;">[1901 - 2155 사이의 값을 입력해주세요.]</b>';
                checkResultList[7] = false;
            } else {
                document.getElementById('birthChk').innerHTML =
                    '<b style="color: skyblue;">[사용가능합니다.]</b>';
                checkResultList[7] = true;
            }
        };
        // 회원 가입 버튼 클릭 이벤트
        document.getElementById('submit-btn').onclick = e => {

            // 8개의 입력칸이 모두 통과되었을 경우 폼을 서브밋.
            const $form = document.getElementById('signUpForm');

            if (checkResultList.includes(false)) {
                alert('입력란을 다시 확인하세요.');
                console.log(checkResultList);
                return;
            } else {
                alert('환영합니다.');
                $form.submit();
            }

        };
    </script>


</body>

</html>