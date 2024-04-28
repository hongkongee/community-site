<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>Diary</title>

    <link rel="stylesheet" href="/assets/css/diary.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>

<body>

    <%@ include file="../include/headcss.jsp"%>
    <%@ include file="../include/header.jsp"%>

    <div class="MydiaryJsp">
        <div class="Frame45">

            <div class="Frame46">
                <div class="Diary">Diary</div>
            </div>

            <!-- ---------------------------------캘린더----------------------------------- -->
            <table class="table-wrapper">
                <thead>
                    <tr>
                        <th><button id="prev-month">이전 달</button></th>
                        <th></th>
                        <th></th>
                        <th>
                            <div id="this-month"></div>
                        </th>
                        <th></th>
                        <th></th>
                        <th><button id="next-month">다음 달</button></th>
                    </tr>
                    <tr>
                        <th class="Sun">SUN</th>
                        <th>MON</th>
                        <th>TUE</th>
                        <th>WED</th>
                        <th>THU</th>
                        <th>FRI</th>
                        <th class="Sat">SAT</th>
                    </tr>
                </thead>
                <tbody id="calendar-body">

                </tbody>
            </table>

            <div class="Frame57">
                <form action="" method="post">
                    <div class="todo">
                        <h2>일정</h2>
                        <div class="schedule-input">
                            <textarea type="text" id="schedule-content" placeholder="날짜를 선택해주세요."></textarea>
                            <button id="save-todo" class="leftbtn" type="button">저장</button>
                        </div>
                    </div>


                    <div class="whatdo">
                        <h2>일기 쓰기</h2>
                        <div class="story">
                            <textarea type="text" id="story-write" placeholder="날짜를 선택해주세요."></textarea>
                            <button id="save-diary" class="rightbtn" type="button">저장</button>
                        </div>
                    </div>
                </form>
            </div>


            <div class="saved">

                <div class="todo-saved">
                    <ul>
                        <c:if test=""></c:if>
                    </ul>
                </div>

                <div class="whatdo-saved">
                    <ul> </ul>
                </div>
            </div>

        </div>
    </div>


    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // 초기에 현재 달력 생성
            var currentDate = new Date();
            var currentYear = currentDate.getFullYear();
            var currentMonth = currentDate.getMonth();
            createCalendar(currentDate);

            let previousElement = null;

            // 이전 달, 다음 달 버튼에 대한 클릭 이벤트 핸들러
            document.getElementById('prev-month').addEventListener('click', function () {
                currentYear = currentMonth === 0 ? currentYear - 1 : currentYear;
                currentMonth = currentMonth === 0 ? 11 : currentMonth - 1;
                createCalendar(new Date(currentYear, currentMonth, 1));
            });

            document.getElementById('next-month').addEventListener('click', function () {
                currentYear = currentMonth === 11 ? currentYear + 1 : currentYear;
                currentMonth = currentMonth === 11 ? 0 : currentMonth + 1;
                createCalendar(new Date(currentYear, currentMonth, 1));
            });

            // 달력을 생성하는 함수
            function createCalendar(date) {
                var calendarBody = document.getElementById('calendar-body');
                calendarBody.innerHTML = ''; // 이전에 생성된 달력 내용 제거

                var year = date.getFullYear();
                var month = date.getMonth();
                var daysInMonth = new Date(year, month + 1, 0).getDate(); // 현재 달의 총 일수
                var firstDayOfMonth = new Date(year, month, 1)
                    .getDay(); // 현재 달의 첫째 날의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)

                // 현재 년월 표시
                document.getElementById('this-month').textContent = year + '년 ' + (month + 1) + '월';

                // 달력에 날짜 추가
                var dateCounter = 1;
                for (var i = 0; i < 6; i++) { // 최대 6주까지 표시
                    var row = calendarBody.insertRow(); // 새로운 행 추가
                    for (var j = 0; j < 7; j++) { // 일주일 동안 반복
                        var cell = row.insertCell(); // 새로운 셀(칸) 추가
                        if (i === 0 && j < firstDayOfMonth) { // 첫째 주에서 첫째 날 이전의 빈 칸 표시
                            continue;
                        }
                        if (dateCounter > daysInMonth) { // 마지막 날짜까지 모두 표시했다면 종료
                            break;
                        }
                        cell.textContent = dateCounter; // 날짜 표시
                        dateCounter++;

                        // 날짜 클릭 시 일정 작성 영역을 표시하는 이벤트 등록
                        cell.addEventListener('click', e => {
                            if (previousElement !== null) {
                                previousElement.style.color = '';
                                previousElement.style.background = '';
                            }

                            previousElement = event.target;

                            showScheduleInput(e);
                        });
                    }
                }
            }


            // 날짜 클릭 시 해당 날짜에 저장된 일정을 표시하는 함수
            function showScheduleInput(e) {

                var scheduleInput = document.querySelector('.schedule-input');
                const $diaryInput = document.querySelector('div.story');
                scheduleInput.style.display = 'block';
                e.target.style.color = 'white'
                e.target.style.background = '#1c398d';

                // 클릭한 날짜를 가져와서 표시
                var selectedDate = e.target.textContent;
                console.log('selectedDate: ', selectedDate);
                var selectedMonth = currentMonth + 1; // 클릭한 날짜의 달을 가져옴
                var scheduleContent = document.getElementById('schedule-content');
                var storyWrite = document.getElementById('story-write')
                scheduleContent.placeholder = currentYear + '년 ' + selectedMonth + '월 ' + selectedDate +
                    '일 일정을 작성해주세요';
                storyWrite.placeholder = currentYear + '년 ' + selectedMonth + '월 ' + selectedDate +
                    '일 일기를 작성해주세요';

                scheduleInput.setAttribute('data-reg-date',
                    `\${currentYear}/\${selectedMonth}/\${selectedDate}`)
                $diaryInput.setAttribute('data-reg-date', `\${currentYear}/\${selectedMonth}/\${selectedDate}`)


                let urlDate;
                if (selectedMonth < 10) {
                    if (selectedDate < 10) {
                        urlDate = `\${currentYear}-0\${selectedMonth}-0\${selectedDate}`;
                    } else {
                        urlDate = `\${currentYear}-0\${selectedMonth}-\${selectedDate}`;
                    }

                } else {
                    if (selectedDate < 10) {
                        urlDate = `\${currentYear}-\${selectedMonth}-0\${selectedDate}`;
                    } else {
                        urlDate = `\${currentYear}-\${selectedMonth}-\${selectedDate}`;
                    }
                }

                console.log('urlDate = ', urlDate);
                // window.location.href = '/mypage/diary/' + urlDate;
                fetchGetTodo(urlDate);
                fetchGetWhatdo(urlDate);


            }



            // ////////////// 일정을 DB에 저장하는 함수 /////////////////////
            document.getElementById('save-todo').addEventListener('click', e => {

                console.log('일정 저장 버튼 클릭 이벤트 발생!');

                let date = e.target.closest('div.schedule-input').dataset.regDate;

                const dateArr = date.split('/');

                console.log('날짜: ', dateArr);
                if (dateArr[1].length === 1) {
                    dateArr[1] = '0' + dateArr[1];
                }
                if (dateArr[2].length === 1) {
                    dateArr[2] = '0' + dateArr[2];
                }
                date = dateArr.join('-');



                console.log('정제된 날짜 문자열: ', date);

                const $content = e.target.previousElementSibling;
                console.log('할일 내용: ', $content.value);
                const writer = '${login.accountNumber}';
                console.log('작성자: ', writer);

                if ($content.value !== '') {
                    fetch('/mypage/diary/todo', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                regDate: date,
                                todoText: $content.value,
                            })
                        })
                        .then(res => res.text())
                        .then(data => {
                            console.log(data);
                            $content.value = '';
                            alert(
                                `\${dateArr[0]}년 \${dateArr[1]}월 \${dateArr[2]}일 일정이 등록되었습니다.`
                            );
                            // location.reload();
                            fetchGetTodo(date);
                        });
                }

            });


            // ////////////// 일기를 DB에 저장하는 함수 /////////////////////
            document.getElementById('save-diary').addEventListener('click', e => {

                console.log('일기 저장 버튼 클릭 이벤트 발생!');
                let date = e.target.closest('div.story').dataset.regDate;
                const dateArr = date.split('/');

                console.log('날짜: ', dateArr);
                if (dateArr[1].length === 1) {
                    dateArr[1] = '0' + dateArr[1];
                }
                if (dateArr[2].length === 1) {
                    dateArr[2] = '0' + dateArr[2];
                }
                date = dateArr.join('-');
                console.log('정제된 날짜 문자열: ', date);

                const $content = e.target.previousElementSibling;
                console.log('일기 내용: ', $content.value);
                const writer = '${login.accountNumber}';
                console.log('작성자: ', writer);

                if ($content.value !== '') {
                    fetch('/mypage/diary/whatdo', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                regDate: date,
                                whatdoText: $content.value,
                            })
                        })
                        .then(res => res.text())
                        .then(data => {
                            console.log(data);
                            $content.value = '';
                            alert(
                                `\${dateArr[0]}년 \${dateArr[1]}월 \${dateArr[2]}일 일기가 등록되었습니다.`
                            );
                            // location.reload();
                            fetchGetWhatdo(date);
                        });
                }
            });

            /*
               fetch 이용해서 완성된 날짜를 컨트롤러에 보냄 -> 컨트롤러에서는 전달받은 날짜에 해당하는 일정과 일기를 담아서
               JSON 형태로 리턴 -> 클라이언트에서는 JSON 데이터를 받아서 반복문을 이용해서 div.todo-saved와 div.whatdo-saved 에다가
               li를 문자열 형태로 만들어서 화면에 표현해 주기.

               사용자가 또다른 날짜를 클릭한다면 -> ul안에 모든 li를 다 비우고 다시 fetch 요청 통해서 DB에서 일정과 일기를 가져와서
               또다시 div.todo-saved와 div.whatdo-saved 에다가 li 만들어서 표현.
               */

            // 다이어리 일정 불러오는 함수
            function fetchGetTodo(regDate) {
                const URL = '/mypage/diary/';
                fetch(URL + regDate)
                    .then(res => res.json())
                    .then(todoList => {
                        renderTodos(todoList);
                    });
            }

            function renderTodos(todoList) {
                const $todoWrapper = document.querySelector('.todo-saved')
                let tag = '';
                let regDateTag = '';

                if (todoList !== null && todoList.length > 0) {
                    for (let todo of todoList) {

                        console.log(todo);

                        const {
                            diaryNo,
                            toDo,
                            writer,
                            regDate
                        } = todo;

                        console.log(toDo);

                        regDateTag = '' + regDate + '';
                        if (toDo != null) {
                            tag += `
                                    <li>
                                        \${toDo} <br>
                                    </li>
                                    `
                        }

                    }
                    tag = regDateTag + tag;
                    $todoWrapper.innerHTML = tag;
                }
            }

            // 다이어리 일기 불러오는 함수
            function fetchGetWhatdo(regDate) {
                const URL = '/mypage/diary/';
                fetch(URL + regDate)
                    .then(res => res.json())
                    .then(whatdoList => {
                        renderWhatdos(whatdoList);
                    });
            }

            function renderWhatdos(whatdoList) {
                const $whatdoWrapper = document.querySelector('.whatdo-saved')
                let tag = '';
                let regDateTag = '';

                if (whatdoList !== null && whatdoList.length > 0) {
                    for (let whatdo of whatdoList) {

                        console.log(whatdo);

                        const {
                            diaryNo,
                            whatDo,
                            writer,
                            regDate
                        } = whatdo;

                        console.log(whatDo);

                        regDateTag = '' + regDate + '';
                        if (whatDo != null) {
                            tag += `
                                    <li>
                                        \${whatDo} <br>
                                    </li>
                                    `
                        }
                    }
                    tag = regDateTag + tag;
                    $whatdoWrapper.innerHTML = tag;
                }
            }



        });
    </script>
</body>

</html>