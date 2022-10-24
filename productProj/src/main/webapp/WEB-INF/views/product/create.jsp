<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>상품 등록하기</title>
<script type="text/javascript">
// AddProduct.jsp
$(function() {
	$("button").on("click",function(){
		location.href="/list";
	})
});
</script>
</head>
<body>
	<div class="jumbotron">
		<!-- 내용 드루와 -->
		<div class="container">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
<form action="/create" class="form-horizontal" method="post">
	<div class="form-group row">
		<label class="col-sm-2">상품 코드</label>
		<div class="col-sm-3">
			<input type="text" id="productId" name="productId" class="form-control" required/>
		</div>
	</div>
	<div class="form-group row">
		<label class="col-sm-2">상품명</label>
		<div class="col-sm-3">
			<input type="text" id="pname" name="pname" class="form-control" required/>
		</div>
	</div>
	<div class="form-group row">
		<label class="col-sm-2">상품 가격</label>
		<div class="col-sm-3">
			<input type="text" id="unitPrice" name="unitPrice" class="form-control" required/>
		</div>
	</div>
	<div class="form-group row">
		<label class="col-sm-2">상품 설명</label>
		<div class="col-sm-3">
			<input type="text" id="description" name="description" class="form-control" required/>
		</div>
	</div>
	<div class="form-group row">
		<label class="col-sm-2">제조사</label>
		<div class="col-sm-3">
			<input type="text" id="manufacturer" name="manufacturer" class="form-control" required/>
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
		<label class="col-sm-2">상태</label>
		<div class="col-sm-5">
			<input type="radio" name="condition" value="New" />새 상품
			<input type="radio" name="condition" value="Old" />중고상품
			<input type="radio" name="condition" value="Refurbished" />재생상품
		</div>
	</div>		
	<div class="form-group row">
		<div class="col-sm-offset-2 col-sm-10">
			<input type="submit" class="btn btn-primary" value="저장" />
			<a href="products" class="btn btn-warn">목록</a>
		</div>
	</div>
</form>
</body>
</html>