<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>상품 등록하기</title>
<script type="text/javascript">
$(function() {
	$("button").on("click",function(){
		location.href="/books";
	})
});
</script>
</head>
<body>
	<div class="jumbotron">
		<!-- 내용 드루와 -->
		<div class="container">
			<h1 class="display-3">도서 등록</h1>
		</div>
	</div>
	<div class="container">
	<form action="/addBook" class="form-horizontal" method="post">
		<div align="center">
		<div class="form-group row">
			<label class="col-sm-2">도서 코드</label>
			<div class="col-sm-3">
				<input type="text" id="bookId" name="bookId" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">도서 제목</label>
			<div class="col-sm-3">
				<input type="text" id="name" name="name" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">가격</label>
			<div class="col-sm-3">
				<input type="text" id="unitPrice" name="unitPrice" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">저자</label>
			<div class="col-sm-3">
				<input type="text" id="author" name="author" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">도서 설명</label>
			<div class="col-sm-3">
				<input type="text" id="description" name="description" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">출판사</label>
			<div class="col-sm-3">
				<input type="text" id="publisher" name="publisher" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">분류</label>
			<div class="col-sm-3">
				<input type="text" id="category" name="category" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">재고 수</label>
			<div class="col-sm-3">
				<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">총 페이지 수</label>
			<div class="col-sm-3">
				<input type="text" id="totalPages" name="totalPages" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">출판일</label>
			<div class="col-sm-3">
				<input type="date" id="releaseDate" name="releaseDate" class="form-control" required/>(yyyy-mm-dd)
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상태</label>
			<div class="col-sm-5">
				<input type="radio" name="condition" value="New" />새 상품
				<input type="radio" name="condition" value="Old" />중고상품
				<input type="radio" name="condition" value="Refurbished" />재생상품
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">도서 이미지</label>
			<div class="col-sm-5">
				<input type="file" id="filename" name="filename" class="form-control" />
			</div>
		</div>		
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" class="btn btn-success" value="저장&raquo;" />
				<a href="books" class="btn btn-primary">목록&raquo;</a>
			</div>
		</div>
		</div>
	</form>
	</div>
</body>
</html>