<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifying diary</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-color: #fdfdf6;
            --primary-green: #88b04b;
            --primary-green-hover: #72963d;
            --soft-yellow: #fff9c4;
            --text-dark: #4a4a4a;
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Noto Sans KR', sans-serif;
            color: var(--text-dark);
        }

        .form-container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(136, 176, 75, 0.1);
            padding: 40px;
            border: 1px solid rgba(136, 176, 75, 0.2);
        }

        .page-title {
            color: var(--primary-green);
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-green);
            margin-bottom: 10px;
        }

        .form-control {
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            padding: 12px;
            background-color: #fafafa;
        }

        .form-control:focus {
            border-color: var(--primary-green);
            background-color: white;
            box-shadow: 0 0 0 0.2rem rgba(136, 176, 75, 0.2);
        }

        .form-control[readonly] {
            background-color: #f0f0f0;
            color: #666;
        }

        .category-option input[type="radio"] {
            display: none;
        }

        .category-option {
            cursor: pointer;
            transition: transform 0.2s;
        }
        .category-option:hover {
            transform: translateY(-5px);
        }

        .category-card {
            border: 2px solid #eee;
            border-radius: 15px;
            padding: 15px;
            text-align: center;
            height: 100%;
            background: #fff;
            transition: all 0.3s;
        }

        .category-emoji {
            font-size: 2.5rem;
            margin-bottom: 5px;
            display: block;
        }
        .category-name {
            font-weight: 600;
            color: #888;
        }

        .category-option input[type="radio"]:checked + .category-card {
            background-color: #f1f8e9;
            border-color: var(--primary-green);
        }
        .category-option input[type="radio"]:checked + .category-card .category-name {
            color: var(--primary-green);
        }

        .image-upload-area {
            border: 2px dashed var(--primary-green);
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            background-color: #fbfbfb;
            cursor: pointer;
            transition: all 0.3s;
        }
        .image-upload-area:hover, .image-upload-area.dragover {
            background-color: #f1f8e9;
            border-color: var(--primary-green-hover);
        }

        .upload-icon {
            font-size: 3rem;
            color: var(--primary-green);
            margin-bottom: 10px;
        }

        .preview-container {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .preview-item {
            position: relative;
            width: 100px;
            height: 100px;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #ddd;
            background: #fff;
        }
        .preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .remove-btn {
            position: absolute;
            top: 2px;
            right: 2px;
            background: rgba(255, 107, 107, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            line-height: 20px;
            padding: 0;
            cursor: pointer;
            z-index: 10;
        }

        .btn-custom {
            background-color: var(--primary-green);
            color: white;
            border: 1px solid var(--primary-green);
            border-radius: 50px;
            padding: 10px 30px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-custom:hover {
            background-color: var(--primary-green-hover);
            border-color: var(--primary-green-hover);
            transform: translateY(-2px);
        }

        .btn-cancel {
            background-color: white;
            color: #888;
            border: 1px solid #ddd;
            border-radius: 50px;
            padding: 10px 30px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-cancel:hover {
            background-color: #f5f5f5;
            color: #666;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h2 class="page-title">✏️ 일기 수정하기</h2>
            
            <form action="modifyDiaryProc.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="diaryId" value="${Diary.diaryId}">

                <div class="mb-4">
                    <label class="form-label">📅 날짜</label>
                    <input type="text" class="form-control" name="date" value="${Diary.date}" readonly>
                </div>

                <div class="mb-4">
                    <label class="form-label">📂 카테고리</label>
                    <div class="row g-3">
                        <div class="col-4">
                            <label class="category-option d-block">
                                <input type="radio" name="category" value="animal" ${Diary.category == 'animal' ? 'checked' : ''}>
                                <div class="category-card">
                                    <span class="category-emoji">🐾</span>
                                    <span class="category-name">동물</span>
                                </div>
                            </label>
                        </div>
                        <div class="col-4">
                            <label class="category-option d-block">
                                <input type="radio" name="category" value="plant" ${Diary.category == 'plant' ? 'checked' : ''}>
                                <div class="category-card">
                                    <span class="category-emoji">🌿</span>
                                    <span class="category-name">식물</span>
                                </div>
                            </label>
                        </div>
                        <div class="col-4">
                            <label class="category-option d-block">
                                <input type="radio" name="category" value="baby" ${Diary.category == 'baby' ? 'checked' : ''}>
                                <div class="category-card">
                                    <span class="category-emoji">👶</span>
                                    <span class="category-name">아기</span>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label" id="nameLabel">🏷️ 이름</label>
                    <input type="text" class="form-control" name="name" id="nameInput" value="${Diary.name}" required maxlength="20">
                    <div class="form-text text-muted ms-1">일기의 주인공 이름을 수정할 수 있습니다.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label">📝 제목</label>
                    <input type="text" class="form-control" name="title" value="${Diary.title}" required maxlength="100">
                </div>

                <div class="mb-4">
                    <label class="form-label">📄 내용</label>
                    <textarea class="form-control" name="content" rows="8" required>${Diary.content}</textarea>
                </div>

                <div class="mb-5">
                    <label class="form-label">📷 사진 편집</label>
                    
                    <div class="image-upload-area" id="uploadArea">
                        <input type="file" id="imageInput" name="uploadFiles" multiple accept="image/*" style="display: none;">
                        <div class="upload-icon">📸</div>
                        <p class="mb-1 fw-bold text-muted">추가할 사진을 클릭하거나 드래그하세요</p>
                    </div>

                    <div class="preview-container" id="previewContainer">
                        <c:forEach items="${imageList}" var="img">
                            <div class="preview-item existing-img">
                                <img src="/uploads/${img.storedName}" alt="image">
                                <button type="button" class="remove-btn" onclick="removeExisting(this, '${img.storedName}')">×</button>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div id="deleteInputs"></div>
                </div>

                <div class="d-flex justify-content-center gap-3">
                    <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-custom">수정 완료</button>
                </div>

            </form>
        </div>
    </div>

    <script>
        //카테고리 선택 시 라벨 변경
        const categoryRadios = document.querySelectorAll('input[name="category"]');
        const nameLabel = document.getElementById('nameLabel');
        const nameInput = document.getElementById('nameInput');
        
        const labelMap = {
            'animal': { label: '🏷️ 반려동물 이름', placeholder: '예: 뽀삐, 초코, 나비' },
            'plant':  { label: '🏷️ 반려식물 애칭', placeholder: '예: 몬스테라, 스투키, 산세베리아' },
            'baby':   { label: '🏷️ 아기 태명/이름', placeholder: '예: 튼튼이, 지아, 도윤' }
        };

        function updateLabel(type) {
            if(labelMap[type]) {
                nameLabel.innerText = labelMap[type].label;
                nameInput.placeholder = labelMap[type].placeholder;
            }
        }

        categoryRadios.forEach(radio => {
            radio.addEventListener('change', function() { updateLabel(this.value); });
        });

        //변경해 선택된 카테고리에 맞춰 라벨 초기화
        document.addEventListener('DOMContentLoaded', function() {
            const checkedRadio = document.querySelector('input[name="category"]:checked');
            if (checkedRadio) updateLabel(checkedRadio.value);
        });

        //기존 이미지 삭제 (Hidden Input)
        function removeExisting(btn, storedName) {
            const item = btn.parentElement;
            item.remove();
            
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'deleteImages';
            input.value = storedName;
            document.getElementById('deleteInputs').appendChild(input);
        }

        //이미지 업로드 및 미리보기
        const uploadArea = document.getElementById('uploadArea');
        const imageInput = document.getElementById('imageInput');
        const previewContainer = document.getElementById('previewContainer');
        const dataTransfer = new DataTransfer();

        //클릭 이벤트
        uploadArea.addEventListener('click', () => imageInput.click());

        //드래그 기본 동작 방지
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) { 
            e.preventDefault(); 
            e.stopPropagation(); 
        }

        //드래그 효과
        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => uploadArea.classList.add('dragover'), false);
        });
        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => uploadArea.classList.remove('dragover'), false);
        });

        //파일 드롭
        uploadArea.addEventListener('drop', handleDrop, false);
        
        //파일 선택
        imageInput.addEventListener('change', function() { 
            handleFiles(this.files); 
        });

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            handleFiles(files);
        }

        function handleFiles(files) {
            files = [...files];
            files.forEach(file => {
                if (file.type.startsWith('image/')) {
                    dataTransfer.items.add(file);
                    previewFile(file);
                }
            });
            //파일 목록 업데이트
            imageInput.files = dataTransfer.files;
        }

        function previewFile(file) {
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function() {
                const div = document.createElement('div');
                div.className = 'preview-item';
                div.innerHTML = `<img src="` + reader.result + `" style="width:100%; height:100%; object-fit:cover;">
                                 <button type="button" class="remove-btn">×</button>`;
                
                // 미리보기 삭제 버튼
                div.querySelector('.remove-btn').onclick = function(e) {
                    e.stopPropagation();
                    div.remove();
                    //insertDiary와 동일하게 화면에서만 제거됨
                };
                previewContainer.appendChild(div);
            }
        }
    </script>
</body>
</html>