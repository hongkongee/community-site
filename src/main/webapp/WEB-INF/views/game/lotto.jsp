<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로또 추첨 게임</title>

    <!-- <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet"> -->
    <link rel="stylesheet" href="/assets/css/header.css">
    <link rel="stylesheet" href="/assets/css/snb.css">
    <link rel="icon" href="/assets/img/favicon.ico">
    <style>
        .container .wrap {
            font-family: 'Orbit', sans-serif;
            margin: 0 auto;
            width: 60%;
            text-align: center;
            padding-top: 200px;
        }

        .container .wrap h2 {
            font-weight: 700;
            font-size: 2em;
            margin-top: 50px;
            margin-bottom: 100px;
        }

        .container .wrap p {
            margin-bottom: 20px;
        }

        .container .wrap input {
            margin-bottom: 40px;
            width: 40px;
        }

        .container .wrap button {
            margin-bottom: 150px;
        }


        .container .wrap .correct_num {
            display: flex;
            justify-content: space-around;

        }

        input[type="number"] {
            border-color: #000080;
            border-width: 0 0 2px;
            background-color: transparent;
        }

        input[type="number"]:focus {
            outline: none;
        }

        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }

        .container .wrap #num_title {
            opacity: 0;
        }

        .container .wrap .correct_num {
            opacity: 0;
        }

        .container .wrap .correct_num p {
            font-size: 80px;
        }


        .container .wrap .correct_num .num {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            font-size: 30px;
            color: white;
            /* background-color: teal; */
            line-height: 80px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
        }

        .gray {
            background-color: #ff8b94;
        }

        .pink {
            background-color: #ffaaa5;
        }

        .yellow {
            background-color: #ffd3b6;
        }

        .green {
            background-color: #dcedc1;
        }

        .blue {
            background-color: #a8e6cf;
        }

        #list-btn {
            margin-top: 10px;
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

        #userpoint {
            display: none;
        }
    </style>


</head>

<body>

    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <%@ include file="../include/snb.jsp" %>

    <div class="container">
        <div class="wrap">

            <h2>★ 로또 추첨 게임 ★</h2>

            <div class="lotto">

                <p id="userpoint">${login.point}</p>
                <p>1부터 45까지의 숫자만 입력 가능합니다</p>
                <p>6개의 숫자를 입력해주세요. </p>
                <div class="input_num">
                    <input type="number" id="number1">
                    <input type="number" id="number2">
                    <input type="number" id="number3">
                    <input type="number" id="number4">
                    <input type="number" id="number5">
                    <input type="number" id="number6">
                </div>
                <button onclick="checkLotto()">추첨 시작</button>
                <button id="list-btn" onclick="checkMain()">돌아가기</button>

            </div>

            <p id="result"></p>

            <h2 id="num_title">당첨 번호</h2>

            <div class="correct_num">

                <div class="num1 num">1</div>
                <div class="num2 num">2</div>
                <div class="num3 num">3</div>
                <div class="num4 num">4</div>
                <div class="num5 num">5</div>
                <div class="num6 num">6</div>
                <p> + </p>
                <div class="bonus_num num">7</div>

            </div>

        </div>
    </div>

    <script>
        function checkLotto() {

            console.log("checkLotto 실행");

            alert("100P 차감됩니다.");

            const userPoint = document.getElementById('userpoint').textContent;
            console.log("userPoint: ", userPoint);

            if (userPoint >= 100) {

                let gamePoint = 0;

                // 사용자가 입력한 숫자를 담을 배열 선언
                var userNumbers = [];

                // 보너스 번호를 담을 변수 선언
                var bonusNum = 0;

                // 안내 텍스트를 보여줄 result 값 가져오기
                var $result = document.getElementById("result");

                // 사용자가 입력한 숫자 가져오기
                for (var i = 1; i <= 6; i++) {
                    var number = parseInt(document.getElementById("number" + i).value);
                    // console.log(number);
                    if (number > 45 || number < 1) {
                        // 1 ~ 45 이 아닌 숫자가 입력되면 리턴
                        alert("1부터 45 사이의 숫자를 입력하세요!")
                        return;
                    }
                    // 동일한 숫자를 입력할 경우 리턴
                    if (userNumbers.includes(number)) {
                        alert("중복된 숫자를 입력했습니다. 다른 숫자를 입력하세요!")
                        return;
                    }

                    // 입력한 숫자를 배열에 담기
                    userNumbers.push(number);
                }
                // console.log(userNumbers);

                // 당첨 번호 생성 (무작위)
                var lottoNum = createLotto();

                // 보너스 번호 생성
                bonusNum = createBonus(lottoNum);

                // 당첨 여부 확인
                var cnt = 0;
                for (var i = 0; i < 6; i++) {
                    if (lottoNum.includes(userNumbers[i])) {
                        cnt++;
                    }
                }

                // 결과 표시
                if (cnt === 6) {
                    $result.innerText = "축하합니다! 1등 당첨입니다! 1000000P 지급"
                    gamePoint += 1000000;
                } else if (cnt === 5) {
                    if (userNumbers.includes(bonusNum)) {
                        $result.textContent = "2등 당첨입니다! 300000P 지급"
                        gamePoint += 300000;
                    } else {
                        $result.textContent = "3등 당첨입니다! 100000P 지급"
                        gamePoint += 100000;
                    }
                } else if (cnt === 4) {
                    $result.textContent = "4등 당첨입니다! 30000P 지급"
                    gamePoint += 30000;
                } else if (cnt === 3) {
                    $result.textContent = "5등 당첨입니다! 5000P 지급"
                    gamePoint += 5000;
                } else {
                    $result.textContent = "꽝입니다!"
                }

                // POST: /game/lotto로 비동기 요청
                fetch("/game/lotto", {
                    method: 'POST',
                    headers: {
                        'Content-type': 'text/plain'
                    },
                    body: gamePoint
                    })
                    .then(res => res.text())
                    .then(data => {
                        console.log("gamePoint: ", data);
                    })

                // 당첨 번호 오름차순으로 정렬
                lottoNum.sort(function (a, b) {
                    return a - b
                });

                // 당첨 번호 공으로 보여주기
                const $ballcontainer = document.querySelector('.correct_num');
                $ballcontainer.style.opacity = "1";

                const $numTitle = document.getElementById('num_title');
                $numTitle.style.opacity = "1";

                const $num1 = document.querySelector(".num1");
                const $num2 = document.querySelector(".num2");
                const $num3 = document.querySelector(".num3");
                const $num4 = document.querySelector(".num4");
                const $num5 = document.querySelector(".num5");
                const $num6 = document.querySelector(".num6");
                const $bonusNum = document.querySelector(".bonus_num");
                $num1.textContent = lottoNum[0];
                $num2.textContent = lottoNum[1];
                $num3.textContent = lottoNum[2];
                $num4.textContent = lottoNum[3];
                $num5.textContent = lottoNum[4];
                $num6.textContent = lottoNum[5];
                $bonusNum.textContent = bonusNum;

                color($num1, 0);
                color($num2, 1);
                color($num3, 2);
                color($num4, 3);
                color($num5, 4);
                color($num6, 5);
                bonusColor($bonusNum, bonusNum);

                // 공에 색 입히기
                function color(a, b) {
                    if (lottoNum[b] < 10) {
                        a.classList.add("gray");
                    } else if (lottoNum[b] < 20) {
                        a.classList.add("pink");
                    } else if (lottoNum[b] < 30) {
                        a.classList.add("yellow");
                    } else if (lottoNum[b] < 40) {
                        a.classList.add("green");
                    } else if (lottoNum[b] < 46) {
                        a.classList.add("blue");
                    }
                }

                function bonusColor(a, b) {
                    if (b < 10) {
                        a.classList.add("gray");
                    } else if (b < 20) {
                        a.classList.add("pink");
                    } else if (b < 30) {
                        a.classList.add("yellow");
                    } else if (b < 40) {
                        a.classList.add("green");
                    } else if (b < 46) {
                        a.classList.add("blue");
                    }
                }
            } else {
                alert('포인트가 부족합니다!');
                return;
            }

        }

        // 로또 추첨기
        function createLotto() {
            var lottoNum = [];
            while (lottoNum.length < 6) {
                var n = Math.floor(Math.random() * 45) + 1;
                if (!lottoNum.includes(n)) {
                    lottoNum.push(n);
                }
                console.log(lottoNum);
            }
            return lottoNum;
        }

        // 보너스 번호 생성기
        function createBonus(lottoNum) {
            var bonus = Math.floor(Math.random() * 45) + 1;
            while (!lottoNum.includes(bonus)) {
                console.log("bonus: ", bonus);
                return bonus;
            }
        }

        // 돌아가기
        function checkMain() {
            console.log('목록으로');
            window.location.href = '/home/main';
        }
    </script>




</body>

</html>