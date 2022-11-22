<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>

<!-- JSTL format을 이용하여 천 단위 구분 기호를 적용할 수 있음 -->
<!-- JSTL format을 이용하여 날짜 포맷을 적용할 수 있음 -->
<div class="col-md-6" style="width: 100%;">
	<form name="frm" id="frm" method="post" action="/book/insertPost">
		<div class="card card-primary" style="width: 100%;">
			<div class="card-header">
				<h3 class="card-title">${bodyTitle}</h3>
			</div>
			<div class="card-body">
				<div class="form=group">
					<label>제목</label>
					<div>
						<input type="text" class="form-control form-control-book"
							id="title" value="" name="title" required />
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>분류</label>
					<div>
						<input type="text" class="form-control form-control-book"
							id="category" value="" name="category" required />
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>가격</label>
					<div>
						<input type="text" class="form-control form-control-book"
							id="price" name="price" value="" required />
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>내용</label>
					<div>
						<textarea id="content" name="content" class="form-control" rows="4"></textarea>
					</div>
					<br>
				</div>
			</div>
			<div class="card-footer">
				<a href="/book/list" class="btn btn-outline-secondary"
					style="float: right;">목록</a>
				<button type="submit" id="insertBook" class="btn btn-primary"
					style="float: right; margin-right: 5px;">등록</button>
			</div>
		</div>
		<sec:csrfInput/>
	</form>
</div>

<script type="text/javascript">
CKEDITOR.replace('content');
</script>