<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join</title>
    
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

        .join-card { 
            background: white; 
            border-radius: 20px; 
            box-shadow: 0 10px 30px rgba(136, 176, 75, 0.15); 
            padding: 40px; 
            width: 100%; 
            max-width: 450px; 
            border: 1px solid rgba(136, 176, 75, 0.2); 
        }

        .brand-title { 
            color: #88b04b; 
            font-weight: 700; 
            font-size: 1.8rem; 
            text-align: center; 
            margin-bottom: 10px; 
        }

        .sub-title { 
            text-align: center; 
            color: #666; 
            margin-bottom: 30px; 
            font-size: 0.95rem; 
        }

        .form-label { 
            font-weight: 500; 
            color: #4a4a4a; 
            font-size: 0.9rem; 
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

        .btn-join { 
            background-color: #88b04b; 
            color: white; 
            border: none; 
            border-radius: 10px; 
            padding: 12px; 
            width: 100%; 
            font-weight: 500; 
            font-size: 1.1rem; 
            transition: all 0.3s; 
            margin-top: 20px; 
        }

        .btn-join:hover { 
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

    <div class="join-card">
        <div class="brand-title" onclick="location.href='getDiaryList.do'" style="cursor: pointer;">🌱 성장일기</div>
        <div class="sub-title">나만의 소중한 기록을 시작해 보세요!</div>
        
        <form action="joinProc.do" method="post">
            <div class="mb-3">
                <label class="form-label">아이디</label>
                <input type="text" class="form-control" name="userId" placeholder="영문/숫자 입력" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">비밀번호</label>
                <input type="password" class="form-control" name="password" placeholder="비밀번호 입력" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">닉네임</label>
                <input type="text" class="form-control" name="nickname" placeholder="화면에 표시될 이름 (예: 새싹맘)" required>
            </div>
            
            <button type="submit" class="btn btn-join">가입하기</button>
        </form>

        <div class="links">
            <a href="login.do">이미 계정이 있으신가요? 로그인</a>
        </div>
    </div>

</body>
</html>