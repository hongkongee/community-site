<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>Diary</title>

    <%@ include file="../include/static-head.jsp" %>
    <link rel="stylesheet" href="/assets/css/diary.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        
</head>

<body>

   
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
                            <textarea id="schedule-content" placeholder="일정을 작성해주세요"></textarea>
                        </div>
                    </div>

                    <div class="whatdo">
                        <h2>일기 쓰기</h2>
                        <div class="story">
                            <textarea type="text" class="story-write" placeholder="일기를 작성해주세요"></textarea>
                        </div>
                    </div>
                    <button id="save-diary" type="submit">저장</button>
                </form>
            </div>

            <div class="saved">
                <div class="todo-saved">
                    <form action="/home/write" method="post" enctype="multipart/form-data">





                    </form>
                </div>
                <div class="whatdo-saved"></div>
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
                        cell.addEventListener('click', showScheduleInput);
                    }
                }
            }

            // 날짜 클릭 시 해당 날짜에 저장된 일정을 표시하는 함수
            function showScheduleInput(todoSaved) {
                var scheduleInput = document.querySelector('.schedule-input');
                scheduleInput.style.display = 'block';

                // 클릭한 날짜를 가져와서 표시
                var selectedDate = event.target.textContent;
                var selectedMonth = currentMonth + 1; // 클릭한 날짜의 달을 가져옴
                var scheduleContent = document.getElementById('schedule-content');
                scheduleContent.placeholder = currentYear + '년 ' + selectedMonth + '월 ' + selectedDate +
                    '일 일정을 작성해주세요';

                // 일정 저장 함수
                document.getElementById('save-schedule').addEventListener('click', function () {
                    var scheduleContent = document.getElementById('schedule-content').value;
                    saveSchedule(currentYear, selectedMonth, selectedDate,
                        scheduleContent); // 일정 저장

                    // 저장 후 일정 입력창 초기화
                    document.getElementById('schedule-content').value = '';
                });
            }
        });
    </script>
</body>

</html>