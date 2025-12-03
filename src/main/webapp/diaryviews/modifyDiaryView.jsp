<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--부트스트랩 CSS 라이브러리-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<!--부트스트랩 JS 라이브러리-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<title>Document</title>
	<style>
		.form-style {
			max-width: 600px;
			margin-top: 40px;
			padding: 32px;
			background-color: #fff;
			border-radius: 10px;
			box-shadow: 0 8px 20px 0 rgba(0,0,255,0.5);
		}
	</style>
</head>
<body>
       <!--<h2> Welcome Spring MVC </h2>-->
	   <div class="container form-style">
		<p class="fs-2 text-center"> 게시물 수정 </p>
		   <form action="modifyBoardProc.do?seq=${board.seq}">
		     <div class="mb-3">
		       <label for="exampleInputEmail1" class="form-label">글 제목</label>
		       <input type="text" class="form-control" id="exampleInputEmail1" name="title" value="${board.title}" >
		     </div>
			 <div class="mb-3">
 		       <label for="exampleInputEmail1" class="form-label">글쓴이(Writer)</label>
 		       <input type="text" class="form-control" id="exampleInputEmail1" name="writer" value="${board.writer}" readonly>
 		     </div>
			 <div class="mb-3">
 		       <label for="exampleInputEmail1" class="form-label">글 내용(Content)</label>
 		       <input type="text" class="form-control" id="exampleInputEmail1" name="content" value="${board.content}">
 		     </div>
			 <input type="hidden" name="seq" value="${board.seq}">
		     <button type="submit" class="btn btn-primary">저장</button>
			 <button type="reset" class="btn btn-danger">취소</button>
		   </form>
	   </div>
</body>
</html>