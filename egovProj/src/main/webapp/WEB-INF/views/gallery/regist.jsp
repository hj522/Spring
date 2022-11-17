<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">도서 정보</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<div style="clear:both;"><label for="title">제목</label></div>
						<div style="width:80%;float:left;">
							<input type="text" id="title" name="title" class="form-control" />
						</div>
						<div style="width:17%;float:right;">
							<button type="button" class="btn btn-outline-primary btn-block btn-flat"
							 data-toggle="modal" data-target="#modal-default">
							<i class="fa fa-book"></i> 검색
							</button>
						</div><br>
					</div>
					<div class="form-group">
						<label for="inputcategoryStatus">카테고리</label>
						<select id="category" name="category" class="form-control custom-select">
							<option value="a0101">국내소설</option>
							<option value="a0102">국외소설</option>
							<option value="a0103">요리</option>
							<option value="a0104">만화</option>
							<option value="a0105">에세이</option>
							<option value="a0106">수험서</option>
						</select>
					</div>
					<div class="form-group">
						<label for="price">가격</label>
						<input type="text" id="price" name="price" class="form-control" />
					</div>
					<div class="form-group">
						<label for="insertDate">등록일</label>
						<input type="text" id="insertDate" name="insertDate" class="form-control" />
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="4"></textarea>
					</div>
				</div>

			</div>

		</div>
		<div class="col-md-6">
			<div class="card card-secondary">
				<div class="card-header">
					<h3 class="card-title">이미지 정보</h3>
					<div class="card-tools">
						<button type="button" class="btn btn-tool"
							data-card-widget="collapse" title="Collapse">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label for="inputEstimatedBudget">Estimated budget</label> <input
							type="number" id="inputEstimatedBudget" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputSpentBudget">Total amount spent</label> <input
							type="number" id="inputSpentBudget" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputEstimatedDuration">Estimated project
							duration</label> <input type="number" id="inputEstimatedDuration"
							class="form-control">
					</div>
				</div>

			</div>

		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<a href="#" class="btn btn-secondary">Cancel</a> <input type="submit"
				value="Create new Project" class="btn btn-success float-right">
		</div>
	</div>
<!-- 검색 모달창 -->
<div class="modal fade" id="modal-default" style="display: none; aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">도서 찾기</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
			<!-- 검색 영역 -->
				<p id="body-content"></p>
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-8 offset-md-2">
								<form action="simple-results.html">
									<div class="input-group">
										<input type="search" class="form-control form-control-lg" id="textB" placeholder="도서명을 입력하세요.">
										<div class="input-group-append">
											<button type="button" class="btn btn-lg btn-default" id="searchB">
												<i class="fa fa-search"></i>
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			<!-- 검색 영역 끝 -->
				<div class="row mt-3">
					<div class="col-md-10 offset-md-1">
						<div class="list-group">
						</div>
					</div>
				</div>
				<div class="modal-footer justify-content-between">
				<div style="float:left;">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
				<div style="float:right;">
					<button type="button" class="btn btn-primary" id="searchOK">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 검색 모달창 -->
</section>
<script type="text/javascript">
CKEDITOR.replace("content");
</script>
<script type="text/javascript">

$(function(){

	// 엔터키 눌러도 검색 먹히도록
	$("#textB").keydown(function(key) {
		if(key.keyCode == 13) {
			$("#searchB").trigger('click');
			return false;
		}
	});
	
	// 도서 검색~
	$("#searchB").on("click", function(){
		let str = $("#textB").val();
		
//		alert(str);
		
		let data = {"title":str};
		console.log("data: " + JSON.stringify(str));
		
		// 아작났어유.. 피씨다타써
		// contentType: 가즈아
		// dataType: 드루와
		$.ajax({
			url:"/gallery/registPost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			type:"post",
			success: function(result) {
//				console.log("result: " + JSON.stringify(result));
				
				$.each(result,function(index,item){
					console.log("bookId:" + item.bookId);
					console.log("title:" + item.title);
					
					// result => List<BookVO>, item => BookVO
					// volist => List<AttachVO> 
					let volist = item.attachVOList;	// 파일리스트 꺼내오기위해
					let filename = "/noimage.jpg";
					
					if(volist.length>0){
						console.log("attachVOList : " + item.attachVOList);
						//volist => List<AttachVO>, item => AttachVO
						$.each(volist,function(index,item){
							//책 이미지가 1 이상이면 이미지 경로를 변수에 대입
							filename = item.filename;
						});
					}
					
					console.log("filename: " + filename);
					
					let dt = new Date(item.insertDate);
					let dtYY = dt.getFullYear();
					let dtMM = dt.getMonth();
					let dtDD = dt.getDate();
					let dtResult = dtYY + "-" + dtMM + "-" + dtDD;
					console.log("insertDate: " + dtResult);

					// 내용이 길어서 50자로 제한
					let cont = item.content + "내용 없음";
					
					let content = "";
					
		               content += "<div class='row'><div class='col-auto'>";
		               content += "<img class='img-fluid' src='/resources/upload"+filename+"' alt='Photo' style='max-height: 100px;'></div>";
		               content += "<div class='col px-4'><div>";
		               content += "<div class='float-right'>"+dtResult+"</div><h4>"+item.title+"</h4>";
		               content += "<p class='mb-0'>"+cont.substring(0,50)+"...</p>";
		               content += "</div></div></div>";
		               
		               $(".list-group").append(content);
					
				});
			}//end success
		});//end ajax
	});//end searchB
	
	$("#")
});//end function

</script>