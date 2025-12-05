<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main</title>
    
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css' rel='stylesheet' />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-color: #fdfdf6;
            --primary-green: #88b04b;
            --primary-green-hover: #72963d;
            --soft-yellow: #fff9c4;
            --text-dark: #4a4a4a;
            
            --color-animal: #ffb74d;
            --color-plant: #81c784;
            --color-baby: #ff8a80;
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Noto Sans KR', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
            padding-bottom: 50px;
        }

        .custom-navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            border-bottom: 1px solid rgba(136, 176, 75, 0.2);
            padding: 1rem 0;
        }

        .brand-title {
            color: var(--primary-green);
            font-weight: 700;
            font-size: 1.5rem;
            text-decoration: none;
            cursor: pointer;
        }
        
        .user-text {
            color: var(--text-dark); /* '님의 정원' 글씨색 */
            font-size: 1rem;
        }
        
        .user-nick-link {
            text-decoration: none;
            color: var(--primary-green);
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            border-bottom: 2px solid transparent; /* 평소엔 투명한 밑줄 */
            padding-bottom: 1px;
        }
        
        .user-nick-link:hover {
            color: var(--primary-green-hover);
            border-bottom: 1.5px solid var(--primary-green-hover); /* 호버 시 밑줄 생성 */
        }

        .btn-custom {
            background-color: var(--primary-green);
            color: white;
            border: 1px solid var(--primary-green);
            border-radius: 50px;
            padding: 8px 24px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background-color: var(--primary-green-hover);
            border-color: var(--primary-green-hover);
            color: white;
        }

        .btn-outline-custom {
            background-color: white;
            color: var(--primary-green);
            border: 1px solid var(--primary-green);
            border-radius: 50px;
            padding: 8px 24px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background-color: var(--primary-green);
            color: white;
        }

        .calendar-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.03);
            border: 1px solid rgba(136, 176, 75, 0.1);
            margin-bottom: 30px;
        }

        .fc-daygrid-day { cursor: pointer; transition: background 0.2s; position: relative; }
        .fc-daygrid-day:hover { background-color: #f1f8e9 !important; }
        .fc-daygrid-day.selected-date { background-color: var(--soft-yellow) !important; }
        
        .diary-dots-container { 
            position: absolute; bottom: 5px; left: 0; width: 100%; 
            display: flex; justify-content: center; gap: 3px; 
            pointer-events: none; 
        }
        .diary-dot { width: 6px; height: 6px; border-radius: 50%; }
        .dot-animal { background-color: var(--color-animal); }
        .dot-plant { background-color: var(--color-plant); }
        .dot-baby { background-color: var(--color-baby); }

        .fc-col-header-cell a { color: var(--text-dark); text-decoration: none; }
        .fc-daygrid-day-number { color: var(--text-dark); text-decoration: none; z-index: 10; position: relative; }
        .fc-day-sun .fc-col-header-cell-cushion, .fc-day-sun .fc-daygrid-day-number { color: #e57373 !important; }
        .fc-day-sat .fc-col-header-cell-cushion, .fc-day-sat .fc-daygrid-day-number { color: #64b5f6 !important; }
        .fc-button-primary { background-color: var(--primary-green) !important; border-color: var(--primary-green) !important; }

        .diary-card {
            border: none;
            border-radius: 12px;
            background: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
            height: 100%;
            overflow: hidden;
        }
        .diary-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(136, 176, 75, 0.2); }
        
        .card-category-badge { font-size: 0.8rem; padding: 4px 10px; border-radius: 12px; color: white; font-weight: 500; }
        .bg-animal { background-color: var(--color-animal); }
        .bg-plant { background-color: var(--color-plant); }
        .bg-baby { background-color: var(--color-baby); }
        
        .card-img-area {
            height: 160px; 
            overflow: hidden; 
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid #f0f0f0;
            position: relative;
        }
        .card-img-placeholder { font-size: 2.5rem; opacity: 0.3; }

        .card-date { font-size: 0.85rem; color: #999; margin-bottom: 5px; }
        .card-name { font-weight: 700; color: var(--text-dark); }
        
        .list-header {
            margin-bottom: 20px;
            padding-left: 10px;
            border-left: 5px solid var(--primary-green);
        }

        .search-form-control { border-radius: 8px; border: 1px solid #ddd; padding: 6px 12px; font-size: 0.95rem; background-color: white; }
        .search-form-control:focus { border-color: var(--primary-green); box-shadow: 0 0 0 3px rgba(136, 176, 75, 0.1); outline: none; }
        .search-btn { background-color: white; color: var(--primary-green); border: 1px solid var(--primary-green); border-radius: 8px; width: 38px; height: 38px; display: flex; align-items: center; justify-content: center; transition: all 0.3s; cursor: pointer; }
        .search-btn:hover { background-color: var(--primary-green); color: white; transform: translateY(-2px); }

        .load-more-btn {
            background-color: white; color: #888; border: 1px solid #ddd;
            border-radius: 50px; padding: 10px 40px; margin: 30px auto 0;
            display: block; transition: all 0.3s;
        }
        .load-more-btn:hover { background-color: #f9f9f9; color: var(--primary-green); border-color: var(--primary-green); }

        .guest-welcome-container {
            text-align: center;
            padding: 100px 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin-top: 40px;
        }
        .welcome-emoji { font-size: 4.5rem; margin-bottom: 25px; display: block; animation: float 3s ease-in-out infinite; }
        .welcome-title { color: var(--primary-green); font-weight: 700; margin-bottom: 15px; font-size: 1.8rem; }
        .welcome-desc { color: #666; margin-bottom: 40px; line-height: 1.8; font-size: 1.05rem; }
        
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        .modal-content { border-radius: 25px; border: none; box-shadow: 0 15px 40px rgba(0,0,0,0.15); overflow: hidden; }
        .modal-header { background-color: var(--bg-color); border-bottom: none; padding: 25px 30px 10px; }
        .modal-title-custom { font-family: 'Noto Sans KR', sans-serif; font-weight: 700; color: var(--text-dark); font-size: 1.4rem; }
        .modal-body { padding: 10px 30px 30px; background-color: var(--bg-color); }
        .modal-inner-card { background-color: white; border-radius: 20px; padding: 25px; box-shadow: 0 5px 15px rgba(0,0,0,0.03); border: 1px solid rgba(0,0,0,0.03); }
        .modal-meta-info { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px dashed #f0f0f0; }
        .modal-date-badge { background-color: #f5f5f5; padding: 6px 14px; border-radius: 20px; font-size: 0.85rem; color: #777; font-weight: 500; }
        .modal-content-text { color: #555; line-height: 1.8; font-size: 1rem; min-height: 100px; white-space: pre-line; }
        .modal-footer { background-color: var(--bg-color); border-top: none; padding: 0 30px 30px; justify-content: flex-end; }
        .modal-img-area { width: 100%; border-radius: 15px; overflow: hidden; margin-bottom: 20px; border: 1px solid #eee; position: relative; }
        .modal-img-area img { width: 100%; height: auto; display: block; }

        .dropdown-menu {
            border: 1px solid #eee;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            padding: 10px;
            min-width: 160px;
        }
        .dropdown-item {
            border-radius: 10px;
            padding: 10px 15px;
            font-size: 0.95rem;
            cursor: pointer;
            margin-bottom: 2px;
            transition: all 0.2s;
        }
        .dropdown-item:hover {
            background-color: #f1f8e9;
            color: var(--primary-green);
            transform: translateX(3px);
        }
        .dropdown-toggle::after {
            vertical-align: middle;
        }

        .carousel-item { height: 100%; }
        .carousel-inner { height: 100%; }
        .carousel-control-prev, .carousel-control-next { width: 10%; }
        .card-slide-img { width: 100%; height: 100%; object-fit: cover; }
    </style>
</head>
<body>

    <nav class="custom-navbar sticky-top">
        <div class="container d-flex justify-content-between align-items-center">
            <div onclick="location.href='getDiaryList.do'" class="brand-title">🌱 성장일기</div>
            <div class="d-flex align-items-center gap-3">
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
						<span class="user-text d-none d-md-block">
						    <a href="myPage.do" class="user-nick-link">${sessionScope.userNick}</a>님의 쉼터
						</span>
                        <button class="btn btn-outline-secondary btn-sm rounded-pill px-3" onclick="location.href='logout.do'">로그아웃</button>
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <c:choose>
            <c:when test="${empty sessionScope.userId}">
                <div class="guest-welcome-container">
                    <span class="welcome-emoji">🌿</span>
                    <h2 class="welcome-title">나만의 소중한 기록</h2>
                    <p class="welcome-desc">
                        반려동물, 반려식물, 그리고 사랑스러운 아이까지.<br>
                        하루하루 자라나는 소중한 순간들을 사진과 함께 기록해 보세요.
                    </p>
                    <div class="d-flex justify-content-center gap-3">
                        <button class="btn btn-custom btn-lg px-5" onclick="location.href='login.do'">로그인하기</button>
                        <button class="btn btn-outline-custom btn-lg px-5" onclick="location.href='join.do'">회원가입</button>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="d-flex justify-content-end mb-3">
                     <form action="searchDiaryList.do" method="get" class="d-flex align-items-center gap-2">
                        <select name="searchCon" class="search-form-control" style="width: auto;">
                            <option value="title" ${param.searchCon == 'title' ? 'selected' : ''}>제목</option>
                            <option value="content" ${param.searchCon == 'content' ? 'selected' : ''}>내용</option>
                            <option value="name" ${param.searchCon == 'name' ? 'selected' : ''}>이름</option>
                        </select>
                        <input type="text" name="searchKey" class="search-form-control" placeholder="검색어..." value="${param.searchKey}" style="width: 200px;">
                        <button type="submit" class="search-btn" title="검색">🔍</button>
                    </form>
                </div>

                <div class="calendar-container">
                    <div id="calendar"></div>
                </div>

                <div id="diary-section">
                    <div class="list-header row align-items-center gy-2">
                        <div class="col-md-4 col-12">
                            <h4 class="mb-0 fw-bold" id="listTitle">
                                <c:choose>
                                    <c:when test="${not empty param.searchKey}">🔍 검색 결과</c:when>
                                    <c:otherwise>📝 전체 일기 목록</c:otherwise>
                                </c:choose>
                            </h4>
                        </div>
                        <div class="col-md-8 col-12 d-flex justify-content-md-end justify-content-between align-items-center gap-2">
                            <div class="d-flex gap-2 ms-auto align-items-center">
                                <c:if test="${not empty param.searchKey}">
                                    <button class="btn btn-outline-custom rounded-pill px-3" onclick="location.href='getDiaryList.do'">초기화</button>
                                </c:if>
                                
                                <div class="dropdown d-inline-block">
                                    <button class="btn btn-outline-custom rounded-pill dropdown-toggle px-4" type="button" id="categoryDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        📂 카테고리
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="categoryDropdown">
                                        <li><a class="dropdown-item" onclick="filterCategory('all')">🌈 전체</a></li>
                                        <li><a class="dropdown-item" onclick="filterCategory('animal')">🐾 동물</a></li>
                                        <li><a class="dropdown-item" onclick="filterCategory('plant')">🌿 식물</a></li>
                                        <li><a class="dropdown-item" onclick="filterCategory('baby')">👶 아기</a></li>
                                    </ul>
                                </div>

                                <button class="btn btn-custom px-4" onclick="goToWrite()">✏️ 일기 쓰기</button>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3" id="diary-list-container"></div>
                    <button id="loadMoreBtn" class="load-more-btn d-none" onclick="loadMore()">더 보기</button>
                    
                    <div id="no-data-msg" class="text-center py-5 d-none">
                        <c:choose>
                            <c:when test="${not empty param.searchKey}">
                                <h5 class="text-muted">검색 결과가 없습니다 😢</h5>
                                <p class="small text-muted">다른 키워드로 검색해 보세요.</p>
                                <button class="btn btn-sm btn-outline-custom mt-2 rounded-pill" onclick="location.href='getDiaryList.do'">전체 목록 보기</button>
                            </c:when>
                            <c:otherwise>
                                <h5 class="text-muted">작성된 일기가 없습니다 🍃</h5>
                                <p class="small text-muted">선택한 날짜에 새로운 추억을 기록해 보세요.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty sessionScope.userId}">
        <div class="modal fade" id="diaryDetailModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="d-flex align-items-center gap-2">
                            <span class="fs-4">📖</span>
                            <h5 class="modal-title-custom mb-0" id="modalTitle"></h5>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="modalImgContainer" class="modal-img-area d-none">
                            <div id="modalCarousel" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-inner" id="modalCarouselInner">
                                    </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#modalCarousel" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#modalCarousel" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Next</span>
                                </button>
                            </div>
                        </div>
                        
                        <div class="modal-inner-card">
                            <div class="modal-meta-info">
                                <div class="d-flex align-items-center gap-2">
                                    <span id="modalCategoryBadge" class="card-category-badge"></span>
                                    <span id="modalName" class="fw-bold fs-5 text-success"></span>
                                </div>
                                <span id="modalDate" class="modal-date-badge"></span>
                            </div>
                            <div id="modalContent" class="modal-content-text"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal" style="background: white; border: 1px solid #ddd;">닫기</button>
                        <a href="#" id="modalEditBtn" class="btn btn-custom rounded-pill px-4">수정</a>
                        <a href="#" id="modalDeleteBtn" class="btn btn-outline-danger rounded-pill px-4" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>

    <c:if test="${not empty sessionScope.userId}">
    <script>
        const allDiaries = [
            <c:forEach items="${dList}" var="diary" varStatus="status">
                {
                    diaryId: ${diary.diaryId},
                    title: "${diary.title}",
                    content: "${diary.content}".replace(/"/g, '&quot;').replace(/\n/g, ' '), 
                    date: "${diary.date}",
                    category: "${diary.category}",
                    name: "${diary.name}",
                    images: "${diary.images}"
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        let selectedDate = null;
        let currentFilteredData = [];
        let visibleCount = 6;

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                headerToolbar: { left: 'prev,next today', center: 'title', right: '' },
                height: 'auto',
                fixedWeekCount: false,
                dateClick: function(info) {
                    if (selectedDate === info.dateStr) {
                        resetFilter();
                    } else {
                        document.querySelectorAll('.selected-date').forEach(el => el.classList.remove('selected-date'));
                        info.dayEl.classList.add('selected-date');
                        selectedDate = info.dateStr;
                        filterListByDate(selectedDate);
                        document.getElementById('listTitle').innerText = `📅 \${selectedDate} 일기 목록`;
                    }
                },
                dayCellDidMount: function(info) {
                    var dateStr = info.date.getFullYear() + '-' + 
                                  String(info.date.getMonth() + 1).padStart(2, '0') + '-' + 
                                  String(info.date.getDate()).padStart(2, '0');
                    
                    var diariesOnDate = allDiaries.filter(d => d.date === dateStr);
                    
                    if (diariesOnDate.length > 0) {
                        var dotContainer = document.createElement('div');
                        dotContainer.className = 'diary-dots-container';
                        diariesOnDate.forEach(function(diary) {
                            var dot = document.createElement('span');
                            dot.className = 'diary-dot dot-' + diary.category; 
                            dotContainer.appendChild(dot);
                        });
                        info.el.appendChild(dotContainer);
                    }
                }
            });
            calendar.render();
            currentFilteredData = allDiaries;
            renderCardList();
        });

        function filterCategory(category) {
            selectedDate = null;
            document.querySelectorAll('.selected-date').forEach(el => el.classList.remove('selected-date'));

            if (category === 'all') {
                currentFilteredData = allDiaries;
                document.getElementById('listTitle').innerText = '📝 전체 일기 목록';
            } else {
                currentFilteredData = allDiaries.filter(d => d.category === category);
                let icon = category === 'animal' ? '🐾' : category === 'plant' ? '🌿' : '👶';
                document.getElementById('listTitle').innerText = `\${icon} 모아보기`;
            }
            
            visibleCount = 6;
            renderCardList();
        }

        function renderCardList() {
            const container = document.getElementById('diary-list-container');
            const noDataMsg = document.getElementById('no-data-msg');
            const loadMoreBtn = document.getElementById('loadMoreBtn');
            
            container.innerHTML = ''; 

            if (currentFilteredData.length === 0) {
                noDataMsg.classList.remove('d-none');
                loadMoreBtn.classList.add('d-none');
                return;
            } else {
                noDataMsg.classList.add('d-none');
            }

            const displayData = currentFilteredData.slice(0, visibleCount);

            displayData.forEach(diary => {
                let catName = '기타', bgClass = 'bg-secondary';
                if(diary.category === 'animal') { catName = '🐾 동물'; bgClass = 'bg-animal'; }
                else if(diary.category === 'plant') { catName = '🌿 식물'; bgClass = 'bg-plant'; }
                else if(diary.category === 'baby') { catName = '👶 아기'; bgClass = 'bg-baby'; }

                let imageHtml;
                if (diary.images && diary.images !== '') {
                    const imgList = diary.images.split(',');
                    
                    if (imgList.length > 1) {
                        const carouselId = 'carousel-card-' + diary.diaryId;
                        let innerHtml = '';
                        imgList.forEach((img, idx) => {
                            const activeClass = idx === 0 ? 'active' : '';
                            innerHtml += `
                                <div class="carousel-item \${activeClass}" style="height:100%;">
                                    <img src="/uploads/\${img}" class="card-slide-img" alt="img">
                                </div>`;
                        });
                        
                        imageHtml = `
                            <div id="\${carouselId}" class="carousel slide" data-bs-interval="false" style="width:100%; height:100%;">
                                <div class="carousel-inner" style="height:100%;">
                                    \${innerHtml}
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#\${carouselId}" data-bs-slide="prev" onclick="event.stopPropagation()">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#\${carouselId}" data-bs-slide="next" onclick="event.stopPropagation()">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                </button>
                            </div>
                        `;
                    } else {
                        imageHtml = `<img src="/uploads/\${imgList[0]}" class="card-slide-img" alt="img">`;
                    }
                } else {
                    imageHtml = `<span class="card-img-placeholder">🌱</span>`;
                }

                const cardHtml = `
                    <div class="col-md-6 col-lg-4">
                        <div class="card diary-card" onclick="viewDiaryDetail(\${diary.diaryId})">
                            <div class="card-img-area">
                                \${imageHtml}
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <span class="card-category-badge \${bgClass}">\${catName}</span>
                                    <div class="card-date">\${diary.date}</div>
                                </div>
                                <div class="mb-2">
                                    <span class="card-name text-success">[\${diary.name}]</span>
                                </div>
                                <h6 class="card-title fw-bold mb-2">\${diary.title}</h6>
                                <p class="card-text text-muted small text-truncate">\${diary.content}</p>
                            </div>
                        </div>
                    </div>
                `;
                container.innerHTML += cardHtml;
            });

            if (currentFilteredData.length > visibleCount) loadMoreBtn.classList.remove('d-none');
            else loadMoreBtn.classList.add('d-none');
        }

        function loadMore() {
            visibleCount += 6;
            renderCardList();
        }

        function filterListByDate(dateStr) {
            currentFilteredData = allDiaries.filter(d => d.date === dateStr);
            visibleCount = 6;
            renderCardList();
        }

        function resetFilter() {
            selectedDate = null;
            document.querySelectorAll('.selected-date').forEach(el => el.classList.remove('selected-date'));
            currentFilteredData = allDiaries;
            visibleCount = 6;
            renderCardList();
            document.getElementById('listTitle').innerText = '📝 전체 일기 목록';
        }

        function goToWrite() {
            if (selectedDate) location.href = 'insertDiary.do?date=' + selectedDate;
            else location.href = 'insertDiary.do';
        }

        function viewDiaryDetail(diaryId) {
            fetch('getDiaryDetail.do', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'diaryId=' + diaryId
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('modalTitle').innerText = data.title;
                document.getElementById('modalDate').innerText = '📅 ' + data.date;
                document.getElementById('modalContent').innerText = data.content;
                document.getElementById('modalName').innerText = data.name;

                const imgContainer = document.getElementById('modalImgContainer');
                const carouselInner = document.getElementById('modalCarouselInner');
                
                if (data.images && data.images !== '') {
                    const imgList = data.images.split(',');
                    let innerHtml = '';
                    
                    imgList.forEach((img, idx) => {
                        const activeClass = idx === 0 ? 'active' : '';
                        innerHtml += `
                            <div class="carousel-item \${activeClass}">
                                <img src="/uploads/\${img}" class="d-block w-100" alt="img">
                            </div>`;
                    });
                    
                    carouselInner.innerHTML = innerHtml;
                    imgContainer.classList.remove('d-none');
                } else {
                    imgContainer.classList.add('d-none');
                }

                const badge = document.getElementById('modalCategoryBadge');
                if(data.category === 'animal') { 
                    badge.innerText = '🐾 동물'; 
                    badge.className = 'card-category-badge bg-animal'; 
                } else if(data.category === 'plant') { 
                    badge.innerText = '🌿 식물'; 
                    badge.className = 'card-category-badge bg-plant'; 
                } else if(data.category === 'baby') { 
                    badge.innerText = '👶 아기'; 
                    badge.className = 'card-category-badge bg-baby'; 
                }

                const editBtn = document.getElementById('modalEditBtn');
                const delBtn = document.getElementById('modalDeleteBtn');
                
                editBtn.href = 'modifyDiary.do?diaryId=' + data.diaryId;
                delBtn.href = 'deleteDiary.do?diaryId=' + data.diaryId;

                new bootstrap.Modal(document.getElementById('diaryDetailModal')).show();
            })
            .catch(error => {
                console.error('Error:', error);
                alert('내용을 불러올 수 없습니다.');
            });
        }
    </script>
    </c:if>
</body>
</html>