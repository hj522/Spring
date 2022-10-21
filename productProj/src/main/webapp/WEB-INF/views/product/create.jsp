<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>상품 등록하기</title>
<script type="text/javascript">
// jQuery 시작! 부릉부릉=33
$(function() {
	$("button").on("click",function(){
		location.href="/list";
	})
});
</script>
</head>
<body>
<h1>상품 등록</h1>
<form action="/create" method="post">
	<p>상품 코드: <input type="text" name="productId" required /></p>
	<p>상품명: <input type="text" name="pname" required /></p>
	<p>상품 가격: <input type="text" name="unitPrice" required /></p>
	<p>상품 설명: <input type="text" name="description" required /></p>
	<p>제조사: <input type="text" name="manufacturer" required /></p>
	<p>분류: <input type="text" name="category" required /></p>
	<p>재고 수: <input type="text" name="unitsInStock" required /></p>
	<p>상태: <input type="text" name="condition" required /></p>
	<p>
		<input type="submit" value="저장" />
		<button type="button">목록</button>
	</p>
</form>
</body>
</html>