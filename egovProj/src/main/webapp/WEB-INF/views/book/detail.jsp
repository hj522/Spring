<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(function() {

		// 수정 버튼 클릭 -> 수정모드로 전환
		$("#editBook").on("click", function() {
			$(".form-control-book").removeAttr("readonly");
			$(".form-control-book").attr("required", true);
			$("#updateBook").css("display", "block");
			$("#cancelBook").css("display", "block");
			$("#editBook").css("display", "none");
			$("#frm").attr("action", "/book/updatePost"); // 업데이트 form action 추가
		});
		
		// 가격 - 숫자만 입력할 수 있게 validation 적용
		$("#price").on("keyup", function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));	// 숫자가 아니면 ""
		});
		
		
	});
</script>

<!-- JSTL format을 이용하여 천 단위 구분 기호를 적용할 수 있음 -->
<!-- JSTL format을 이용하여 날짜 포맷을 적용할 수 있음 -->
<div class="col-md-6" style="width: 100%;">
	<form name="frm" id="frm" method="post">
		<div class="card card-primary" style="width: 100%;">
			<div class="card-header">
				<h3 class="card-title">${bodyTitle}</h3>
			</div>
			<div class="card-body">
				<div class="form=group">
					<label>도서코드</label>
					<div>
						<input type="text" class="form-control" id="bookId" name="bookId"
							value="${data.bookId}" readonly>
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>제목</label>
					<div>
						<input type="text" class="form-control form-control-book"
							id="title" value="${data.title}" name="title" readonly>
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>분류</label>
					<div>
						<input type="text" class="form-control form-control-book"
							id="category" value="${data.category}" name="category" readonly>
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>가격</label>
					<div>
						<input type="text" class="form-control form-control-book"
							id="price" name="price" 
							value='<fmt:formatNumber type="number" maxFractionDigits="3" value="${data.price}" />'
							readonly>
					</div>
					<br>
				</div>
				<div class="form=group">
					<label>내용</label>
					<div>
						<textarea id="content" name="content" class="form-control form-control-book" rows="15" 
						readonly="readonly">${data.content}</textarea>
					</div>
					<br>
				</div>
				<div class="form-group">
					<label>등록일</label>
					<div class="input-group date" id="reservationdate"
						data-target-input="nearest">
						<input type="text" class="form-control"
							data-target="#reservationdate"
							name="insertDate" value='<fmt:formatDate value="${data.insertDate}" pattern="yyyy-MM-dd" />'
							readonly>
						<div class="input-group-append" data-target="#reservationdate"
							data-toggle="datetimepicker">
							<div class="input-group-text">
								<i class="fa fa-calendar"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card-footer">
				<a href="/book/list" class="btn btn-outline-secondary"
					style="float: right;">목록</a>
				<button type="button" id="editBook" class="btn btn-secondary"
					style="float: right; margin-right: 5px;">수정</button>
				<button type="submit" id="updateBook" class="btn btn-primary"
					style="float: right; margin-right: 5px; display: none;">확인</button>
				<a href="/book/detail?bookId=${data.bookId}" id="cancelBook"
					class="btn btn-danger"
					style="float: right; margin-right: 5px; display: none;">취소
					</button>
			</div>
		</div>
	</form>
</div>
