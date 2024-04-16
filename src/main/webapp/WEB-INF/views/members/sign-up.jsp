<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 가입</title>

    <link rel="stylesheet" href="/assets/css/common.css" >

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

        .container .wrap .input-btn,
        .container .wrap #birth-btn {
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
            content: '♥';
            font-size: 1.8em;

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


    </style>

</head>

<body>


    <div class="container">
        <h2>회원 가입</h2>
        <div class="wrap">
            <form action="/members/sign-up" name="signUp" id="signUpForm" method="post">
                <div class="info">
                    <div id="info_id">
                        <p>아이디를 입력해주세요</p>
                        <input type="text" name="account" id="user_id" class="input-btn"
                        required="required" placeholder="사용하실 아이디를 입력해주세요">
                        <button>중복 확인</button>
                    </div>
                    <div>
                        <p>비밀번호를 입력해주세요 (영문과 특수문자를 포함해서 8자 이상)</p>
                        <input type="password" name="password" id="password" class="input-btn"
                        required="required" placeholder="사용하실 비밀번호를 입력해주세요">
                    </div>
                    <div>
                        <p>비밀번호를 다시 입력해주세요</p>
                        <input type="password" name="pw_check" id="pw_check" class="input-btn"
                        required="required" placeholder="비밀번호를 다시 입력해주세요">
                    </div>
                    <div>
                        <p>이름을 입력해주세요</p>
                        <input type="text" name="name" id="user_name" class="input-btn"
                        required="required" placeholder="한글만 입력가능합니다">
                    </div>
                    <div>
                        <p>사용할 닉네임을 입력해주세요</p>
                        <input type="text" name="nickname" id="user_nickname" class="input-btn" required="required">
                    </div>
                    <div>
                        <p>성별을 선택해주세요</p>
                        <input type="radio" name="gender" value="male">
                        <label for="gender_male">남자</label>
                        <input type="radio" name="gender" value="female">
                        <label for="gender_female">여자</label>
                    </div>
                    <div>
                        <p>이메일을 입력해주세요</p>
                        <input type="email" name="email" id="user_email" class="input-btn"
                        required="required" placeholder="ex) abc123@gmail.com">
                        <button>이메일 인증</button>
                    </div>
                    <div>
                        <p>출생년도를 입력해주세요</p>
                        <p>
                            <input type="number" name="birth_year" id="birth-btn" required="required">
                        </p>
                    </div>
                </div>
                <div class="main-btn">
                    <div class="back-btn"><button>돌아가기</button></div>
                    <div class="submit-btn"><button>회원가입</button></div>
                </div>
            </form>
        </div>
    </div>


</body>

</html>