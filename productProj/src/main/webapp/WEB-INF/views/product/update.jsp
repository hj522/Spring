<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>상품 정보 수정하기</title>
<script type="text/javascript">
// jQuery 시작! 부릉부릉=33
$(function() {
	// 취소 버튼 클릭 이벤트
	$("#btnCancel").on("click",function(){
		// EL 태그 데이터를 
		let productId = "${param.productId}";
		// http://localhost/update?bookId=2
		// param => bookId=2
	//	location.href="/detail?bookId=${param.bookId}";
		location.href="/detail?productId=" + productId;
	});
	
	// 목록 버튼 클릭 이벤트
	$("#btnList").on("click",function() {
		location.href="/products";
	});
});
</script>
</head>
<body>
	<div class="jumbotron">
		<!-- 내용 드루와 -->
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>
	<div class="container">
	<form action="/update" class="form-horizontal" method="post">
		<input type="hidden" name="productId" value="${data.productId}" />
		<div class="form-group row">
			<label class="col-sm-2">상품명</label>
			<div class="col-sm-3">
				<input type="text" id="pname" name="pname" value="${data.pname}" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">가격</label>
			<div class="col-sm-3">
				<input type="text" id="unitPrice" name="unitPrice" value="${data.unitPrice}" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품 설명</label>
			<div class="col-sm-3">
				<input type="text" id="description" name="description" value="${data.description}" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">제조사</label>
			<div class="col-sm-3">
				<input type="text" id="manufacturer" name="manufacturer" value="${data.manufacturer}" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">분류</label>
			<div class="col-sm-3">
				<input type="text" id="category" name="category" value="${data.category}" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">재고 수</label>
			<div class="col-sm-3">
				<input type="text" id="unitsInStock" name="unitsInStock" value="${data.unitsInStock}" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상태</label>
			<div class="col-sm-5">
				<input type="radio" id='con1' name="condition" value="New"
					<c:if test="${data.condition=='New'}">checked</c:if> /><label for="con1">새 상품</label>
				<input type="radio" id='con2' name="condition" value="Old"
					<c:if test="${data.condition=='Old'}">checked</c:if> /><label for="con2">중고 상품</label>
				<input type="radio" id='con3' name="condition" value="Refurbished"
					<c:if test="${data.condition=='Refurbished'}">checked</c:if> /><label for="con3">재생 상품</label>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품 이미지</label>
			<div class="col-sm-5">
				<input type="file" id="fileName" name="fileName" class="form-control" />
			</div>
		</div>	
		<div class="form-group row">
            <div class="col-sm-offset-2 col-sm-10">
               <input type="submit" value="저장&raquo;" class="btn btn-outline-success">
               <input type="button" value="취소&raquo;" id="btnCancel" class="btn btn-outline-danger">
               <button type="button" id="btnList" class="btn btn-outline-primary">목록&raquo;</button>
            </div>
         </div>
	</form>
	</div>
</body>
</html>