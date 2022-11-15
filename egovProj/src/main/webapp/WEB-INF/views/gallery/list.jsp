<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<div class="col-12">
	<div class="card card-primary">
		<div class="card-header">
			<h3 class="card-title">
				<i class="fas fa-image"></i> Gallery
			</h3><br>
			<!-- 도서 선택 시작 -->
			<!-- ajax를 통해 append -->
			<select class="custom-select">
				<option value="1">하얀 개똥이</option>
				<option value="2">은수저</option>
				<option value="3">7번 방의 개똥이</option>
				<option value="4">정보처리기사 필기</option>
				<option value="5">5번방의 개똥이</option>
				<option value="6">지구에서 한아뿐</option>
			</select>             
		</div>
		<div class="card-body">
			<div class="row">
				<!--
				[모달을 띄우는 방법]
               1. button으로 띄우기 
               <button type="button" class="btn btn-default" 
               data-toggle="modal" data-target="#modal-default">
               Launch Default Modal</button>
               
               2. a태그로 띄우기
               <a data-toggle="modal" href="#modal-default">Open Modal</a>
               
               3. 기타 요소로 띄우기
               <p data-toggle="modal" data-target="#modal-default">Open Modal</p>
            -->
				<!-- bookVO의 attachVOList 멤버변수 접근 -> List<AttachVO> -->
				<c:forEach var="attachVO" items="${bookVO.attachVOList}">
					<div class="col-sm-2">
						<a class="btn btn-modal" data-toggle="modal" href="#modal-default"
							data-id="/resources/upload${attachVO.filename}"
							data-title="${bookVO.title}"> <img
							src="/resources/upload${attachVO.filename}"
							class="img-fluid mb-2" alt="white sample">
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<!-- default modal 시작 -->
<div class="modal fade" id="modal-default" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"></h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<p id="body-content"></p>
			</div>
			<div class="modal-footer justify-content-between">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<!-- 				<button type="button" class="btn btn-primary">Save changes</button> -->
			</div>
		</div>
	</div>
</div>
<!-- default modal 끝 -->
<script type="text/javascript">
$(function(){
	// data-id=".......
	$(".btn-modal").click(function(){
		let data = $(this).data("id");
		let title = $(this).data("title");
		console.log("data: " + data + "title" + title);
		
		$("#body-content").html("<img src='" + data + "' style='width:100%;' />");
		$(".modal-title").html(title);
//		$(".modal-title").text(title);  <- .html()이랑 같음

	let currentBookId = "${param.bookId}";
	let sel = "";
	
	});
	
	// 도서 목록 가져와서 select에 추가하기
	// datatype: 응답 데이터 타입
	// 아작났어유 피씨다탔어
	$.ajax({
		url:"/gallery/bookList",
		datatype:"json",
		type:"get",
		success:function(data){
			// data: List<BookVO>
// 			console.log("data: " + JSON.stringify(data))
			// item: BookVO
			$.each(data,function(index,item){
				console.log("item.bookId : " + item.bookId);
				console.log("item.title : " + item.title);
				
				if(item.bookId == currentBookId) {
					sel = "selected='selected'"
				} else {
					sel = "";
				}
				// option항목 추가
				$(".custom-select").append("<option value='"+item.bookId+"' "+sel+">"+item.title+"</option>");
				
			});
		}
	});
	
	// .custom-select가 바뀌면 이미지 목록을 다시 가져옴
	$(".custom-select").on("change",function(){
		
		// 선택된 option의 value를 가져와보자
		let bookId = $(this).val();
		console.log("bookId: " + bookId);
		
		location.href="/gallery/list?bookId="+bookId;
	});
	
});
</script>