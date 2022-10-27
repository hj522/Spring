<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
	<!-- --------------------도서 목록 시작-------------------- -->
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
			<br>
			<p>
				<form>
					<input type="text" placeholder="도서명을 입력하세요" name="keyword" value="${param.keyword}" class="form-control d-inline" style="width:300px" />
					 <input type="submit" value="검색" class="btn btn-outline-dark" />
					<br><br><input type="button" class="btn btn-outline-primary" value="도서등록" onclick="javascript:location.href='addBook'" />
				</form>
			</p>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<c:forEach var="book" items="${data}">
			<!-- 열별 처리 -->
			<div class="col-md-4">
				<!-- /images/P1234.jpg -->
 				<img src="/resources/images/${book.filename}"
 				style="width:60%;" alt="${book.name}" title="${book.name}" />
				<h3>${book.name}</h3>
				<p class="badge badge-danger">${book.bookId}</p>
				<p>${book.description}</p>
				<p><b><fmt:formatNumber type="number" maxFractionDigits="3" value="${book.unitPrice}" />원</b></p>	
				<p><a href="detail?bookId=${book.bookId}"
					class="btn btn-secondary" role="button">
					상세정보&raquo;</a></p>			
			</div>
			</c:forEach>
		</div>
	</div>
	<!-- --------------------도서 목록 끝-------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>
