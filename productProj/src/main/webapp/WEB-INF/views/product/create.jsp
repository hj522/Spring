<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/validation.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<title>상품 등록하기</title>
<style type="text/css">
   .imgs_wrap{
      width: 150px;
      margin-top: 50px; 
   }
   .imgs_wrap img{
      max_width:50%;
   }
</style>
<script type="text/javascript">
// AddProduct.jsp
$(function() {
	// 이미지 미리보기 시작 /////////////////////////////////////////
	let sel_file = [];
	
	$("#productImage").on("change",handleImgFileSelect);
	// 파라미터 e: onchange 이벤트 객체
	function handleImgFileSelect(e){
		// 이벤트가 발생된 타겟 안 이미지 파일들을 가져와보자 
		let files = e.target.files;
		// 이미지가 여러 개가 있을 수 있으므로 이미지를 분리하여 배열로 만듦
		let fileArr = Array.prototype.slice.call(files);
		// 파일 타입의 배열 반복 f : 파일 배열 안에 들어있는 각각의 이미지 파일 객체
		fileArr.forEach(function(f){
			// 이미지 파일이 아닌 경우 이미지 미리보기 실패로 처리
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다.")
				// 함수를 종료
				return;
			}
			// 이미지 객체를(f) 전역 배열타입 변수(sel_file)에 넣자
			sel_file.push(f);
			// 이미지 객체를 읽을 자바스크립트의 reader 객체 생성
			let reader = new FileReader();
			reader.onload = function(e){
				// e.target: 이미지 객체
// 				e.target.result: reader가 이미지를 다 읽은 결과
				let img_html = "<img src=\"" + e.target.result + "\" />";
				// div 사이에 이미지가 렌더링되어 화면에 보임
				// 객체 append: 누적 , .html: 새로고침, innerHTML: J/S
				$(".imgs_wrap").append(img_html);
			}
			//f: 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화
			reader.readAsDataURL(f);
		});
	}
	// 이미지 미리보기 끝 /////////////////////////////////////////
	
		let header = "${_csrf.headerName}";
		let token  = "${_csrf.token}";
//	    alert("header : " + header + ", token : " + token);

	   //PRODUCT 테이블의 PRODUCT_ID 자동생성
	   //아작났어유..피씨다타써
	   //dataType : 응답타입
	   $.ajax({
	      url:"/getProductId",
	      beforeSend:function(xhr){
	         xhr.setRequestHeader(header,token);
	      },
	      type:"post",
	      dataType:"json",
	      success:function(result){
	         console.log("result : " + JSON.stringify(result));
	         console.log("result.productId : " + result.productId);
	         $("#productId").val(result.productId);
	      }
	   });
});
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<!-- 내용 드루와 -->
		<div class="container">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	<div class="container">
		<form action="/create" class="form-horizontal" method="post" enctype="multipart/form-data">
			<div align="center">
				<div class="form-group row">
					<label class="col-sm-2">상품 코드</label>
					<div class="col-sm-3">
						<input type="text" id="productId" name="productId" class="form-control" readonly="readonly" required/>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">상품명</label>
					<div class="col-sm-3">
						<input type="text" id="pname" name="pname" class="form-control" required/>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">상품 가격</label>
					<div class="col-sm-3">
						<input type="text" id="unitPrice" name="unitPrice" class="form-control" required/>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">상품 설명</label>
					<div class="col-sm-3">
						<input type="textarea" id="description" name="description" class="form-control" required/>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">제조사</label>
					<div class="col-sm-3">
						<input type="text" id="manufacturer" name="manufacturer" class="form-control" required/>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">분류</label>
					<div class="col-sm-3">
						<input type="text" id="category" name="category" class="form-control" required/>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">재고 수</label>
					<div class="col-sm-3">
						<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" required />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">상태</label>
					<div class="col-sm-5">
						<input type="radio" name="condition" value="New" />새 상품
						<input type="radio" name="condition" value="Old" />중고상품
						<input type="radio" name="condition" value="Refurbished" />재생상품
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">상품이미지</label>
					<div class="col-sm-5">
						<input type="file" id="productImage" name="productImage" class="form-control" 
							multiple />
					</div>
				</div>		
				<div class="form-group row">
					<div class="imgs_wrap"></div>
				</div>		
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-success" value="추가&raquo;" />
						<a href="products" class="btn btn-primary">목록&raquo;</a>
					</div>
				</div>
			</div>
		</form>
		<!-- 사용자 정보 -->
<%-- 		<p>principal: <sec:authentication property="principal"/> </p> --%>
<%-- 		<p>memberVO: <sec:authentication property="principal.memberVO"/> </p> --%>
<%-- 		<p>사용자 이름: <sec:authentication property="principal.memberVO.memName"/> </p> --%>
<%-- 		<p>사용자 아이디: <sec:authentication property="principal.memberVO.memId"/> </p> --%>
<%-- 		<p>사용자 권한 리스트: <sec:authentication property="principal.memberVO.memberAuthVOListz"/> </p> --%>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>