<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>상품 상세</title>
<script type="text/javascript">

function addToCart() {
	let result = confirm("해당 도서를 장바구니에 담으시겠습니까?");
	
	if(result) {
		document.addForm.submit();
	} else {
		document.addForm.reset();
	}
}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">도서 상세 정보</h1>
		</div>
	</div>
	<div class="container">
	<div class="row">
		<div class="col-md-5">
 		<img src="resources/images/${data.filename}" style="width:60%;"/>
        </div>
		<div class="col-md-10">
			<h3>${data.name}</h3>
			<p>${data.description}</p>
			<p>
				<b>도서 코드 </b>
				<span class="badge badge-danger">${data.bookId}</span>
			</p>
			<p><b>저자</b>: ${data.author}</p>
			<p><b>출판사</b>: ${data.publisher}</p>
			<p><b>분류</b>: ${data.category}</p>
			<p><b>재고 수</b>: ${data.unitsInStock}</p>
			<p><b>상태</b>: ${data.condition}</p> 
			<p><b>가격</b>: <fmt:formatNumber type="number" maxFractionDigits="3" value="${data.unitPrice}" />원</p>
			<p><b>출판일</b>: ${data.releaseDate}</p>
			<div class="form-group row">
				<form action="/delete" method="post">
					<input type="hidden" name="bookId" value="${bookId}" />
					<input type="submit" value="삭제&raquo;" class="btn btn-danger btn-sm" style="margin-right:3px"/>
				</form>
				<p>
				<!-- /addBook?bookId=P1234 -->
				<form name="addForm" action="/addBook?id=${data.bookId}" method="post">
					<input type="hidden" name="bookId" value="${data.bookId}" />
					<a href="/update?bookId=${bookId}" class="btn btn-warning btn-sm" >수정&raquo;</a>
					<a href="/books" class="btn btn-secondary btn-sm" >목록&raquo;</a>
					<a href="#" class="btn btn-info btn-sm" onclick="addToCart()">주문하기&raquo;</a>
					<a href="/cart" class="btn btn-success btn-sm">장바구니 &raquo;</a>
				</form>
				</p>
			</div>
		</div>
	</div>
</div>
	<jsp:include page="footer.jsp" />
</body>
<!-- method
	1) GET: 데이터를 변경하지 않을 때. 목록/상세보기
	2) POST: 데이터를 변경할 때. 입력/수정/삭제
-->
</html>