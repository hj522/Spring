<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/adminlte/plugins/sweetalert2/sweetalert2.min.js"></script>
<link rel="stylesheet" href="/resources/adminlte/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<section class="content">
	<div class="row">
		<div class="col-md-6">
			<div class="card card-primary">
				<div class="card-header">
					<h3 class="card-title">도서 정보</h3>
					<input type="text" name="bookId" id="bookId" />
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
							<input type="text" id="title" name="title" class="form-control" readonly />
						</div>
						<div style="width:17%;float:right;">
							<button type="button" class="btn btn-outline-primary btn-block btn-flat"
							 data-toggle="modal" data-target="#modal-lg">
							<i class="fa fa-book"></i> 검색
							</button>
						</div><br>
					</div>
					<div class="form-group">
						<label for="category">카테고리</label>
						<select id="category" name="category" class="form-control custom-select" disabled>
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
						<input type="text" id="price" name="price" class="form-control" readonly/>
					</div>
					<div class="form-group">
						<label for="insertDate">등록일</label>
						<input type="text" id="insertDate" name="insertDate" class="form-control" readonly />
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="4" readonly></textarea>
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
				<!-- 미리보기 이미지 보이기 시작 -->
				<div class="card-body" id="card-images">
				
				<!-- 미리보기 이미지 보이기 끝 -->
					<div class="input-group">
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="uploadFile" id="input_imgs" multiple disabled>
								<label class="custom-file-label" for="exampleInputFile">파일을 선택하세요.</label>
						</div>
						<div class="input-group-append">
							<span class="input-group-text" id="uploadBtn" style="cursor:pointer;">Upload</span>
						</div>
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
<div class="modal fade" id="modal-lg" style="display: none;" aria-hidden="true">
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
								<div class="input-group">
									<input type="text" class="form-control form-control-lg"
										id="textB" placeholder="도서명을 입력하세요.">
									<div class="input-group-append">
										<button type="button" class="btn btn-lg btn-default"
											id="searchB">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
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
				<div class="modal-footer justify-content-flex-right">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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

let bookVOList;

$(function(){
	
	// sweetalert2 적용
	var Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
      });

	// 업로드 할 이미지 선택 시 미리보기 띄우기 ///////////////////////////////
	
	let sel_file = [];	// 이미지 객체 담을 배열
	$("#input_imgs").on("change", handleImgFileSelect);
	
	// e: onchange 이벤트 객체
	function handleImgFileSelect(e) {
		// e.target: <input type="file"
		let files = e.target.files;
		// 이미지 오브젝트 배열
		let fileArr = Array.prototype.slice.call(files);
		
		// f: 각각의 이미지 파일을 의미
		fileArr.forEach(function(f){
			// 이미지가 아니면
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다.");
				// 함수 종료
				return;
			}
			
			// 이미지를 배열에 넣음
			sel_file.push(f);
			
			let reader = new FileReader();
			// e: 리더가 이미지 읽을 때 그 이벤트
			reader.onload = function(e) {
				let img_html = "<img src=\"" + e.target.result + "\" style='width:40%;' />";	// e.target: 이미지 객체
				// 객체.append: 누적, .html: 새로고침, innerHTML: JS
				$("#card-images").append(img_html);
			}
			// 다음 이미지 파일(f)을 위해 리더를 초기화
			reader.readAsDataURL(f);
		});
	}
	// 업로드 할 이미지 선택 시 미리보기 끝 ///////////////////////////////
	
	// ajax 파일 업로드 시작 /////////////////////
	$("#uploadBtn").on("click",function(e){
		// 이미지를 가상의 폼 안에 넣기
		let formData = new FormData();
		let inputFile = $("input[name='uploadFile']");
		// 이미지 파일들을 변수에 담음
		let files = inputFile[0].files;
		
		console.log("files: " + files);
		
		// 가상 폼인 formdata에 각각의 이미지를 넣자
		for(let i=0; i<files.length; i++) {
			// uploadFile[]
			formData.append("uploadFile", files[i]);
		}
		
		let bookId = $("#bookId").val();
		console.log("bookId: " + bookId);
		
		
		/*
			ATTACH 테이블의 user_no 컬럼의 데이터에는 bookId가 들어가야 함
			
			<form>
				<input type="file" name="uploadFile"..
				<input type="file" name="uploadFile"..
				<input type="file" name="uploadFile"..
				<input type="text" name="bookId"..
			</form>
		*/
		formData.append("bookId", bookId);
		
		
		// 아작났어유 피씨다탔어
		// dataType: 응답 데이터 타입
		// /upload/uploadAjaxAction 참고
		// ATTACH 테이블의 user_no 컬럼의 데이터에는 bookId가 들어가야 함
		// ATTACH 테이블의 seq		컬럼의 데이터는 1부터 1씩 자동 증가
		$.ajax({
			url:"/gallery/uploadAjaxAction",
			processData:false,
			contentType:false,
			data:formData,
			dataType:"json",
			type:"post",
			success:function(result){
				console.log("result: " + JSON.stringify(result));
				
				console.log("result.bookId: " + result.bookId);
				console.log("result.status: " + result.status);
				
				if(result.status>0) {	// 다중 insert 성공
					Toast.fire({
						  icon: 'success',
						  title: '업로드 성공'
						});
					
					setTimeout(function(){
						location.href = "/gallery/list?bookId="+result.bookId}, 1500);
					
				} else {	// 다중 insert 실패
					Toast.fire({
						  icon: 'error',
						  title: '업로드 실패'
						});
				}
			}
		});
		
	});
	// ajax 파일 업로드 끝 /////////////////////
	
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
		
		
		// 스프링 시큐리티를 위한 토큰 처리(csrf)-> 불토엔 큰 코스로 픽스!
		let header = "${_csrf.headerName}";
		let token = "${_csrf.token}";
		
		console.log("header: " + header + " , token : " + token);
		
		// 아작났어유.. 피씨다타써
		// contentType: 가즈아
		// dataType: 드루와
		$.ajax({
			url:"/gallery/registPost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			type:"post",
			beforeSend: function(xhr){
				xhr.setRequestHeader(header,token);
			},
			success: function(result) {
//				console.log("result: " + JSON.stringify(result));
				
				bookVOList = result;
				
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
					content += "<div class='list-group-item' value='"+item.bookId+"'><div class='row'>";
						content += "<div class='col-auto'><img class='img-fluid' src='/resources/upload"+filename+"' alt='Photo' style='max-height: 160px;'></div>";
						content += "<div class='col px-4'><div>";
						content += "<div class='float-right'>"+dtResult+"</div>";
						content += "<h3><a href='javascript:fn_go("+item.bookId+")'>"+item.title+"</a></h3>";
						content += "<p class='mb-0'>"+cont.substring(0,50)+"</p>";
						content += "</div></div></div></div>";
		               
		               $(".list-group").append(content);
					
				});
			}//end success
		});//end ajax
	});//end searchB
	
});//end function

</script>

<script type="text/javascript">

function fn_getInsertDate(geta) {
	
	let dt = new Date(geta);
	let dtYY = dt.getFullYear();
	let dtMM = dt.getMonth();
	let dtDD = dt.getDate();
	let dtResult = dtYY + "-" + dtMM + "-" + dtDD;
	console.log("insertDate: " + dtResult);
	
	return dtResult;
}

// 검색한 도서 클릭하면 데이터 들어가게
function fn_go(geta){
	
	let str = geta;
	console.log("str : " + str);
	
	$.each(bookVOList,function(index,item){
		let bookId = item.bookId;
		
		if(str==bookId){
// 			console.log("item : " + JSON.stringify(item));
			
			// 책 아이디(bookId)
			$("#bookId").val(item.bookId);
			// 제목(title)
			$("#title").val(item.title);
			// 카테고리(category)
			console.log(item.category);
			$("#category").val(item.category).prop("selected",true);
	//		$("select[name=category] option:selected").val(item.category); 이건 안ㄷㅐ낭,.,.
			// 가격(price)
			$("#price").val(item.price);
			// 입력 일자(insertDate)
			$("#insertDate").val(fn_getInsertDate(item.insertDate));	
			// 책 내용
			CKEDITOR.instances.content.setData(item.content);
			
			// 클릭 후 모달창 자동 닫기
			$("#modal-lg").modal("hide");	// show: 모달창 보임
			
			// 이미지 파일 업로드 버튼 활성화
			$("#input_imgs").removeAttr("disabled");	
			
			return;
		}
	});
}
</script>
