<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My page</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #fdfdf6;
            --primary-green: #88b04b;
            --primary-green-hover: #72963d;
            --text-dark: #4a4a4a;
        }

        body {
            background-color: var(--bg-color);
            font-family: 'Noto Sans KR', sans-serif;
            color: var(--text-dark);
        }

        /* Container & Layout */
        .form-container {
            max-width: 500px;
            margin: 60px auto;
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

        /* Form Controls */
        .form-label {
            font-weight: 600;
            color: var(--primary-green);
            margin-bottom: 8px;
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

        /* Buttons */
        .btn-custom {
            background-color: var(--primary-green);
            color: white;
            border: 1px solid var(--primary-green);
            border-radius: 50px;
            padding: 10px 30px;
            width: 100%;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-custom:hover {
            background-color: var(--primary-green-hover);
            border-color: var(--primary-green-hover);
            transform: translateY(-2px);
            color: white;
        }
        
        /* Links */
        .home-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #888;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .home-link:hover { 
            color: var(--primary-green); 
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h2 class="page-title">🌿 내 정보 관리</h2>
            
            <form action="updateUserProc.do" method="post">
                
                <div class="mb-4">
                    <label class="form-label">아이디</label>
                    <input type="text" class="form-control" value="${user.userId}" readonly>
                    <div class="form-text text-muted ms-1">아이디는 변경할 수 없습니다.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label">닉네임</label>
                    <input type="text" class="form-control" name="nickname" value="${user.nickname}" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label">비밀번호 확인</label>
                    <input type="password" class="form-control" name="password" placeholder="본인 확인을 위해 비밀번호를 입력하세요" required>
                    <div class="form-text text-muted ms-1">정보 수정을 위해 현재 비밀번호를 입력해주세요.</div>
                </div>

                <button type="submit" class="btn btn-custom">정보 수정하기</button>
            </form>
            
            <a href="getDiaryList.do" class="home-link">← 메인으로 돌아가기</a>
        </div>
    </div>

</body>
</html>