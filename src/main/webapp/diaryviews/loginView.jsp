<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log in</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <style>
        body { 
            background-color: #fdfdf6; 
            font-family: 'Noto Sans KR', sans-serif; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            height: 100vh; 
            margin: 0; 
        }

        .login-card { 
            background: white; 
            border-radius: 20px; 
            box-shadow: 0 10px 30px rgba(136, 176, 75, 0.15); 
            padding: 40px; 
            width: 100%; 
            max-width: 400px; 
            border: 1px solid rgba(136, 176, 75, 0.2); 
        }

        .brand-title { 
            color: #88b04b; 
            font-weight: 700; 
            font-size: 1.8rem; 
            text-align: center; 
            margin-bottom: 30px; 
        }

        .form-control { 
            border-radius: 10px; 
            padding: 12px; 
            border: 1px solid #ddd; 
            background-color: #fafafa; 
        }

        .form-control:focus { 
            border-color: #88b04b; 
            box-shadow: 0 0 0 0.2rem rgba(136, 176, 75, 0.25); 
            background-color: white; 
        }

        .btn-login { 
            background-color: #88b04b; 
            color: white; 
            border: none; 
            border-radius: 10px; 
            padding: 12px; 
            width: 100%; 
            font-weight: 500; 
            font-size: 1.1rem; 
            transition: all 0.3s; 
            margin-top: 10px; 
        }

        .btn-login:hover { 
            background-color: #72963d; 
            transform: translateY(-2px); 
        }

        .links { 
            text-align: center; 
            margin-top: 20px; 
            font-size: 0.9rem; 
        }

        .links a { 
            color: #666; 
            text-decoration: none; 
            margin: 0 10px; 
            transition: color 0.2s; 
        }

        .links a:hover { 
            color: #88b04b; 
            font-weight: 500; 
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="brand-title" onclick="location.href='getDiaryList.do'" style="cursor: pointer;">🌱 성장일기</div>
        
        <form action="loginProc.do" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="userId" placeholder="아이디" required autofocus>
            </div>
            
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
            </div>
            
            <button type="submit" class="btn btn-login">로그인</button>
        </form>

        <div class="links">
            <a href="join.do">회원가입</a> | <a href="getDiaryList.do">메인으로</a>
        </div>
    </div>

</body>
</html>