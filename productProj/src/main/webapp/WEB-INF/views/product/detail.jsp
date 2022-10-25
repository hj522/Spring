<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 
	BookController로부터 넘어오는 정보 2가지
	1) mav.addObject("data",data); => bookVO 객체
	2) mav.addObject("bookId", data.getBookId()) => 기본키 데이터(int 타입)
 -->
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>책 상세</title>
<script type="text/javascript">
// jQuery 시작! 부릉부릉=33
$(function() {
	$("button").on("click",function(){
		// BookController의 /list URI에 매핑된 메소드를 실행
		location.href="/products";
	})
});
</script>
</head>
<body>
<!-- 
	* JSTL(JSP Standard Tag Library): 개발자가 자주 사용하는 패턴을 모아놓은 집합
	=> BookController에서 보내준 데이터를 View에 표현하도록 도와줌
	JSTL은 maven에서 설정되어 있음 => pom.xml => jstl
-->
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<!-- 내용 드루와 -->
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<div class="container">
	<div class="row">
		<div class="col-md-5">
 		<img src="resources/images/${data.filename}" style="width:70%;"/>
        </div>
		<div class="col-md-10">
			<h3>${data.pname}</h3>
			<p>${data.description}</p>
			<p>
				<b>상품코드: </b>
				<span class="badge badge-danger">${data.productId}</span>
			</p>
			<p><b>제조사</b>: ${data.manufacturer}</p>
			<p><b>분류</b>: ${data.category}</p>
			<p><b>재고 수</b>: ${data.unitsInStock}</p>
			<p><b>가격</b>: <fmt:formatNumber type="number" maxFractionDigits="3" value="${data.unitPrice}" /></p>
			<p><b>상태</b>: ${data.condition}</p> 
			<div class="form-group row">
				<a href="/update?productId=${productId}" class="btn btn-warning" style="margin-right:5px">수정&raquo;</a>
				<form action="/delete" method="post">
					<input type="hidden" name="productId" value="${productId}" />
					<input type="submit" value="삭제&raquo;" class="btn btn-danger" style="margin-right:5px" />
				</form>
				<a href="/products" class="btn btn-primary">목록&raquo;</a>
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