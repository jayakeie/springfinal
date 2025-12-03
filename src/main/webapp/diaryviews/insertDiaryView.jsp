<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>성장일기 작성</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f5f9f0;
        }
        
        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .category-option {
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .category-option:hover {
            transform: scale(1.05);
        }
        
        .category-option input[type="radio"] {
            display: none;
        }
        
        .category-option .card {
            border: 2px solid #dee2e6;
            transition: all 0.3s;
        }
        
        .category-option input[type="radio"]:checked + .card {
            border: 3px solid #198754;
            background-color: #d1e7dd;
        }
    </style>
</head>
<body>
    <div class="container mt-5 form-container">
        <!-- 헤더 -->
        <div class="text-center mb-4">
            <h1 class="text-success fw-bold">✏️ 성장일기 작성</h1>
        </div>
        
        <!-- 작성 폼 -->
        <div class="bg-warning bg-opacity-10 rounded p-4 border border-success border-opacity-25 shadow-sm">
            <form action="insertDiaryProc.do" method="post">
                <!-- 날짜 (자동 설정) -->
                <div class="mb-4">
                    <label class="form-label text-success fw-bold">📅 날짜</label>
                    <input type="date" class="form-control" name="date" id="dateInput" required readonly>
                </div>
                
                <!-- 카테고리 선택 -->
                <div class="mb-4">
                    <label class="form-label text-success fw-bold">📂 카테고리</label>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="category-option">
                                <input type="radio" name="category" value="animal" required>
                                <div class="card text-center p-3 h-100">
                                    <div class="card-body">
                                        <div style="font-size: 3rem;">🐾</div>
                                        <h5 class="card-title mt-2">동물</h5>
                                        <p class="card-text small text-muted">반려동물의 성장 기록</p>
                                    </div>
                                </div>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label class="category-option">
                                <input type="radio" name="category" value="plant" required>
                                <div class="card text-center p-3 h-100">
                                    <div class="card-body">
                                        <div style="font-size: 3rem;">🌿</div>
                                        <h5 class="card-title mt-2">식물</h5>
                                        <p class="card-text small text-muted">식물의 성장 기록</p>
                                    </div>
                                </div>
                            </label>
                        </div>
                        <div class="col-md-4">
                            <label class="category-option">
                                <input type="radio" name="category" value="baby" required>
                                <div class="card text-center p-3 h-100">
                                    <div class="card-body">
                                        <div style="font-size: 3rem;">👶</div>
                                        <h5 class="card-title mt-2">아기</h5>
                                        <p class="card-text small text-muted">아기의 성장 기록</p>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- 제목 -->
                <div class="mb-4">
                    <label for="title" class="form-label text-success fw-bold">📝 제목</label>
                    <input type="text" class="form-control" id="title" name="title" 
                           placeholder="일기 제목을 입력하세요" required maxlength="100">
                </div>
                
                <!-- 사용자 ID (세션에서 가져올 수도 있지만 일단 입력 필드로) -->
                <div class="mb-4">
                    <label for="userId" class="form-label text-success fw-bold">👤 이름</label>
                    <input type="text" class="form-control" id="userId" name="userId" 
                           placeholder="이름을 입력하세요" required maxlength="50">
                </div>	
                
                <!-- 내용 -->
                <div class="mb-4">
                    <label for="content" class="form-label text-success fw-bold">📄 내용</label>
                    <textarea class="form-control" id="content" name="content" rows="10" 
                              placeholder="오늘의 이야기를 기록해보세요..." required></textarea>
                </div>
                
                <!-- 버튼 -->
                <div class="d-flex gap-2 justify-content-end">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">
                        ↩️ 취소
                    </button>
                    <button type="submit" class="btn btn-success">
                        ✅ 작성 완료
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // URL에서 date 파라미터 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        const dateParam = urlParams.get('date');
        const dateInput = document.getElementById('dateInput');
        
        if (dateParam) {
            // URL에 date가 있으면 그 값 사용
            dateInput.value = dateParam;
        } else {
            // 없으면 오늘 날짜로 설정
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            dateInput.value = `${year}-${month}-${day}`;
        }
    </script>
</body>
</html>