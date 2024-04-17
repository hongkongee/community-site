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

    <div class="MydiaryJsp">

        <!-- <a href="#;" class="side-btn">
            <span></span>
            <span></span>
            <span></span>
        </a>

        <div class="Frame40">

            <div class="Menu">
                <button class="close-btn">X</button> <br>
                <a href="">HOME</a><br>
                <a href="">Posting</a><br>
                <a href="">Diary</a><br>
                <a href="">Gallery</a><br>
                <a href="">Chat</a><br>
                <a href="">Market</a>
            </div>
        </div> -->
        <div class="Frame45">

            <div class="Frame46">
                <div class="Diary">Diary</div>
            </div>

            <!-- ---------------------------------캘린더----------------------------------- -->
            <table>
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
                </thead>
                <thead>
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
                <div class="todo">
                    <h2>일정</h2>
                    <div class="date">
                        <div class="list">
                            <form id="event-form">
                                <label for="event-date">날짜:</label>
                                <input type="date" id="event-date" name="event-date">
                                <br>
                                <label for="event-description">일정 내용:</label>
                                <input type="text" id="event-description" name="event-description">
                                <br>
                                <button type="submit">일정 추가</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="whatdo">
                    <h2>일기 쓰기</h2>
                    <div class="story">
                        <textarea type="text" class="story-write"></textarea>
                        <button type="submit">저장</button>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>

</body>

<script>
    // -----------------------------캘린더---------------------------------------
    // 현재 표시된 년도와 월을 저장하는 변수
    let currentYear;
    let currentMonth;

    // 현재 날짜 정보 가져오기
    function getCurrentDate() {
        const now = new Date();
        return {
            year: now.getFullYear(),
            month: now.getMonth(),
            day: now.getDate()
        };
    }

    // 이전 달로 이동하는 함수
    function prevMonth() {
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        }
        renderCalendar();
    }

    // 다음 달로 이동하는 함수
    function nextMonth() {
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        renderCalendar();
    }

    // 캘린더를 렌더링하는 함수
    function renderCalendar() {
        const calendarBody = document.getElementById('calendar-body');
        calendarBody.innerHTML = '';

        const currentDate = getCurrentDate();
        const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
        const firstDayIndex = new Date(currentYear, currentMonth, 1).getDay(); // 달의 첫 번째 날짜가 무슨요일인지

        let date = 1;

        for (let i = 0; i < 6; i++) {
            const row = document.createElement('tr');

            for (let j = 0; j < 7; j++) {
                const cell = document.createElement('td');
                if (i === 0 && j < firstDayIndex) {
                    const emptyCell = document.createTextNode('');
                    cell.appendChild(emptyCell);
                } else if (date > daysInMonth) {
                    break;
                } else {
                    const dateCell = document.createTextNode(date);
                    cell.appendChild(dateCell);
                    date++;
                }
                row.appendChild(cell);
            }

            calendarBody.appendChild(row);
        }

        // 이번 달을 나타내는 요소에 현재 월을 설정
        const currentMonthElement = document.getElementById('this-month');
        currentMonthElement.textContent = currentMonth + 1 + `월`;
    }

    // 이전 달 버튼에 이벤트 리스너 추가
    document.getElementById('prev-month').addEventListener('click', prevMonth);

    // 다음 달 버튼에 이벤트 리스너 추가
    document.getElementById('next-month').addEventListener('click', nextMonth);

    // 페이지 로드 시 캘린더 렌더링
    window.onload = function () {
        const currentDate = getCurrentDate();
        currentYear = currentDate.year;
        currentMonth = currentDate.month;
        renderCalendar();
    };

    // 이벤트 추가 폼 제출 시 실행되는 함수
    document.getElementById('event-form').addEventListener('submit', function (event) {
        event.preventDefault();
        const dateInput = document.getElementById('event-date');
        const descriptionInput = document.getElementById('event-description');

        const date = new Date(dateInput.value);
        const day = date.getDate();
        const month = date.getMonth();
        const year = date.getFullYear();
        const description = descriptionInput.value;

        console.log(`일정 추가: ${year}-${month + 1}-${day}, 내용: ${description}`);

        // 폼 초기화
        dateInput.value = '';
        descriptionInput.value = '';
    });


    // --------------------------사이드바 메뉴---------------------------------

    const sidebar = document.querySelector('.Frame40');

    document.querySelector('.side-btn').addEventListener('click', function () {
        sidebar.style.transform = 'translateX(-100%)';
    });

    document.querySelector('.side-btn').addEventListener('click', function () {
        sidebar.style.transform = 'translateX(0)';
    });

    document.querySelector('.close-btn').addEventListener('click', function () {
        sidebar.setAttribute("style", "transform: translateX(-100%);");
    });
</script>

</html>