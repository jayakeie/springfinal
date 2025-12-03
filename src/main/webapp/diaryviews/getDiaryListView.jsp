<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>성장일기</title>
    
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css' rel='stylesheet' />
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
    body {
        background-color: #f5f9f0;
    }
    
    /* FullCalendar 날짜 셀 */
    .fc-daygrid-day {
        cursor: pointer;
    }
    
    .fc-daygrid-day:hover {
        background-color: #f1f8e9 !important;
    }
    
    .fc-daygrid-day.fc-day-today {
        background-color: #fff9c4 !important;
    }
    
	/* 선택된 날짜는 hover보다 우선 적용 */
	.fc-daygrid-day.selected-date {
	    background-color: #ffeb3b !important;
	}
	
	.fc-daygrid-day.selected-date:hover {
	    background-color: #ffeb3b !important;  /* hover 시에도 선택 색상 유지 */
	}
    
    /* ⭐ 요일별 색상 - 수정된 방식 */
    .sunday-cell .fc-daygrid-day-number {
        color: #dc3545 !important;  /* 빨강 */
    }
    
    .saturday-cell .fc-daygrid-day-number {
        color: #0d6efd !important;  /* 파랑 */
    }
    
    /* 평일 검은색 추가 */
	.fc-daygrid-day-number {
	    color: #000000 !important;  /* 검은색 */
	}
    
    /* 헤더 요일 색상 */
	.fc-col-header-cell.fc-day-sun a {
	    color: #dc3545 !important;  /* 일요일 빨강 */
	}
	
	.fc-col-header-cell.fc-day-sat a {
	    color: #0d6efd !important;  /* 토요일 파랑 */
	}
	
	/* 평일은 기본 검은색 */
	.fc-col-header-cell a {
	    color: #000000 !important;
	}
    
    /* 일기 점 */
    .diary-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        display: inline-block;
        margin: 0 2px;
    }
    
    .diary-dot.animal { background-color: #66bb6a; }
    .diary-dot.plant { background-color: #ffb74d; }
    .diary-dot.baby { background-color: #ff8a80; }
    
    /* 더보기 버튼 영역 */
    .show-more-container {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
</style>
</head>
<body>
    <div class="container mt-5">
        <!-- 헤더 -->
        <div class="text-center mb-4">
            <h1 class="text-success fw-bold">🌱 성장일기</h1>
        </div>
        
        <!-- 네비게이션 바 -->
        <nav class="navbar navbar-light bg-warning bg-opacity-25 rounded mb-4 p-3 border border-success border-opacity-50">
            <div class="container-fluid">
                <!-- 게시물 추가 버튼 -->
                <button class="btn btn-success" onclick="location.href='insertDiary.do'">
                    ✏️ 게시물 추가
                </button>
                
                <!-- 검색 폼 -->
                <form class="d-flex" action="searchDiaryList.do" method="get">
                    <select class="form-select me-2" name="searchCon" style="width: auto;">
                        <option value="title">글 제목</option>
                        <option value="content">글 내용</option>
                        <option value="date">날짜</option>
                    </select>
                    <input class="form-control me-2" type="search" name="searchKey" placeholder="Search" style="width: 200px;">
                    <button class="btn btn-outline-success" type="submit">🔍</button>
                </form>
            </div>
        </nav>
        
        <!-- 달력 영역 -->
        <div class="bg-warning bg-opacity-10 rounded p-4 mb-4 border border-success border-opacity-25 shadow-sm">
            <div id="calendar"></div>
        </div>
        
        <!-- 일기 목록 영역 -->
        <div class="bg-warning bg-opacity-10 rounded p-4 border border-success border-opacity-25 shadow-sm" style="min-height: 300px;">
            <div id="diary-list">
                <h5 class="text-success mb-3">📅 날짜를 선택하세요</h5>
                <p class="text-success text-opacity-75">달력에서 날짜를 클릭하면 해당 날짜의 일기를 볼 수 있습니다.</p>
            </div>
        </div>
    </div>
    
    <!-- FullCalendar JS -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var diaryListEl = document.getElementById('diary-list');
            
            var diaryData = [];
            
            <c:forEach items="${diaryList}" var="diary">
            diaryData.push({
                id: ${diary.seq},
                title: '${diary.title}',
                date: '${diary.diaryDate}',
                category: '${diary.category}',
                content: '${diary.content}'
            });
            </c:forEach>
            
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,dayGridWeek'
                },
                buttonText: {
                    today: '오늘',
                    month: '월',
                    week: '주'
                },
                height: 'auto',
                fixedWeekCount: false,
                showNonCurrentDates: false,
                
                dateClick: function(info) {
                    // 이미 선택된 날짜를 다시 클릭한 경우
                    if (info.dayEl.classList.contains('selected-date')) {
                        // 선택 해제
                        info.dayEl.classList.remove('selected-date');
                        
                        // 원래 초기 화면으로 복귀
                        diaryListEl.innerHTML = 
                            '<h5 class="text-success mb-3">📅 날짜를 선택하세요</h5>' +
                            '<p class="text-success text-opacity-75">달력에서 날짜를 클릭하면 해당 날짜의 일기를 볼 수 있습니다.</p>';
                        
                        return;  // 함수 종료
                    }
                    
                    // 다른 날짜 선택 시 기존 코드 실행
                    document.querySelectorAll('.fc-daygrid-day').forEach(function(el) {
                        el.classList.remove('selected-date');
                    });
                    
                    info.dayEl.classList.add('selected-date');
                    showDiariesForDate(info.dateStr);
                    
                    document.querySelector('#diary-list').scrollIntoView({ 
                        behavior: 'smooth',
                        block: 'start'
                    });
                },
                
                dayCellDidMount: function(info) {
                    var dayOfWeek = info.date.getDay();
                    if (dayOfWeek === 0) {  // 일요일
                        info.el.classList.add('sunday-cell');
                    } else if (dayOfWeek === 6) {  // 토요일
                        info.el.classList.add('saturday-cell');
                    }
                	
                    var dateStr = info.date.toISOString().split('T')[0];
                    var diariesOnDate = diaryData.filter(function(d) {
                        return d.date === dateStr;
                    });
                    
                    if (diariesOnDate.length > 0) {
                        var dotContainer = document.createElement('div');
                        dotContainer.style.cssText = 'position: absolute; bottom: 2px; left: 50%; transform: translateX(-50%); display: flex; gap: 2px;';
                        
                        diariesOnDate.forEach(function(diary) {
                            var dot = document.createElement('span');
                            dot.className = 'diary-dot ' + diary.category;
                            dotContainer.appendChild(dot);
                        });
                        
                        info.el.style.position = 'relative';
                        info.el.appendChild(dotContainer);
                    }
                }
            });
            
            calendar.render();
            
            function showDiariesForDate(dateStr) {
                var diaries = diaryData.filter(function(d) {
                    return d.date === dateStr;
                });
                
                if (diaries.length === 0) {
                    diaryListEl.innerHTML = 
                        '<h5 class="text-success mb-3">📅 ' + formatDate(dateStr) + '</h5>' +
                        '<p class="text-success text-opacity-75">이 날짜에 작성된 일기가 없습니다.</p>' +
                        '<button class="btn btn-success mt-3" onclick="location.href=\'insertDiary.do?date=' + dateStr + '\'">✏️ 일기 작성하기</button>';
                } else {
                    var html = '<div class="d-flex justify-content-between align-items-center mb-3">' +
                               '<h5 class="text-success mb-0">📅 ' + formatDate(dateStr) + '</h5>' +
                               '<button class="btn btn-success btn-sm" onclick="location.href=\'insertDiary.do?date=' + dateStr + '\'">✏️ 새 일기 작성</button>' +
                               '</div>';
                    
                    html += '<div class="row g-3">';
                    
                    diaries.forEach(function(diary) {
                        var categoryIcon = {
                            'animal': '🐾',
                            'plant': '🌿',
                            'baby': '👶'
                        }[diary.category] || '📝';
                        
                        var categoryName = {
                            'animal': '동물',
                            'plant': '식물',
                            'baby': '아기'
                        }[diary.category] || '기타';
                        
                        html += '<div class="col-md-6 col-lg-4">' +
                                '<div class="card h-100 border-success border-opacity-25 shadow-sm">' +
                                '<div class="card-body">' +
                                '<div class="d-flex justify-content-between align-items-start mb-2">' +
                                '<h6 class="card-title mb-0">' + categoryIcon + ' ' + diary.title + '</h6>' +
                                '<span class="badge bg-success">' + categoryName + '</span>' +
                                '</div>' +
                                '<p class="card-text text-muted small">' + diary.content + '</p>' +
                                '<div class="d-flex gap-2 mt-3">' +
                                '<button class="btn btn-sm btn-outline-primary flex-fill" onclick="location.href=\'getDiary.do?seq=' + diary.id + '\'">자세히</button>' +
                                '<button class="btn btn-sm btn-outline-success flex-fill" onclick="location.href=\'modifyDiary.do?seq=' + diary.id + '\'">수정</button>' +
                                '<button class="btn btn-sm btn-outline-warning flex-fill" onclick="location.href=\'deleteDiary.do?seq=' + diary.id + '\'">삭제</button>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                    });
                    
                    html += '</div>';
                    
                    diaryListEl.innerHTML = html;
                }
            }
            
            function formatDate(dateStr) {
                var date = new Date(dateStr);
                var days = ['일', '월', '화', '수', '목', '금', '토'];
                return date.getFullYear() + '년 ' + (date.getMonth() + 1) + '월 ' + date.getDate() + '일 (' + days[date.getDay()] + ')';
            }
        });
    </script>
</body>
</html>