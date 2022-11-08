<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
$(function(){
	   //전역변수[0][1]..
	   var count=1; //let으로도 많이 씀
	   $('#addFile').on('click', function(){
	      count++;   //2
	      event.preventDefault();
	      var att = $("div#att");
	        
	      att.append('<div class="form-group aa" id="attach'+count+ '"><input id="attachVOList' +count+ '.filename" name="attachVOList[' +count+ '].filename" placeholder="첨부파일" class="form-control form-control-user" type="text"></div>');
	   });
	   
	   $('#delFile').on('click', function(){
	      event.preventDefault();
	      var aa = document.querySelectorAll('.aa');
	      console.log(aa);
	      
	      if(count>1){
	         $('.aa:last').remove();
	         count--;
	      }
	   });
	   
	   $("#userPw").focusout(function(){
			let userPw = $(this).val();
			let userNo = "${param.userNo}";	// 기본키 
			
			console.log("userNo: " + userNo + ", userPw: " + userPw);
			
			let data = {"userNo":userNo,"userPw":userPw};

			// 입력한 비밀번호가 맞는지 체킹
			// 아작났어유 피씨다타써
			$.ajax({
				url:"/previews/detailPwCheck",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				data:JSON.stringify(data),
				type:"post",
				success:function(rslt){
					console.log("rslt: " + JSON.stringify(rslt));
					let cnt = rslt.result;	// 1 or 0
					
					if(cnt>0) {	// 비밀번호 일치
						$("#btnSubmit").removeAttr("disabled");
					} else {	// 비밀번호 불일치
						$("#btnSubmit").attr("disabled","disabled");
					}
				}
			});
		});
		
		$("#edit").on("click",function(){
			$("#spn1").css("display","none");	// 일반 모드는 가림
			$("#spn2").css("display","block");	// 수정 모드 불러오기
			$(".form-control-user").removeAttr("readonly");	// 입력란 활성화
			$("img").remove();
			// submit시 readonly="true"는 데이터가 넘어가고, disabled="disabled"는 데이터가 안 넘어감
			$("#userId").attr("readonly","true");
		});
		
		// 삭제버튼 클릭 => 숙제
		$("#delete").on("click",function(){
			$("#memVO").attr("action","/previews/deletePost");
			
			// true(1) / false(0)
			let result = confirm("삭제하시겠습니까?");
			
			console.log("result: " + result);
			
			if(result>0) {
				$("#memVO").submit();
			} else {
				alert("삭제가 취소되었습니다.")
			}
		});
	});
</script>

<script type="text/javascript">
// onsubmit시 이 함수를 가져와라
function fn_chk() {
	let userPw = document.getElementById("userPw").value;
	let userPwCheck = document.getElementById("userPwCheck").value;
	
	// 비밀번호가 일치하지 않을 경우 알림
	let spanPwCheck = document.getElementById("spanPwCheck");
	
	console.log("userPw: " + userPw + ", userPwCheck : " + userPwCheck);
	
	if(userPw != userPwCheck) {
		spanPwCheck.innerHTML = "비밀번호를 확인해주세요.";
		return false;
	} 
	
	// submit 됨
	return true;
}
</script>

<!-- http://localhost:8081/article/write -->
<div class="container">

	<div class="card o-hidden border-0 shadow-lg my-5">
		<div class="card-body p-0">
			<!-- Nested Row within Card Body -->
			<div class="row">
				<!-- 좌측 대표 이미지 -->
				<div class="col-lg-5 d-none d-lg-block bg-register-image" 
					<c:if test="${memVO.attachVOList[0].filename!=null}">
					style="background-image:url('/resources/upload${memVO.attachVOList[0].filename}');background-size:cover;"
					</c:if>
					></div>
				<div class="col-lg-7">
					<div class="p-5">
							<!-- <form id="memVO" ... -->
							<form:form modelAttribute="memVO" class="user" method="post" action="/previews/updatePost" onsubmit="return fn_chk()">
							<form:hidden path="userNo" />
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
									<!-- path: id&name(userId) -->
										<form:input class="form-control form-control-user" path="userId" placeholder="아이디" readonly="true" />
										<font color="red">
											<form:errors path="userId" />
										</font>
									</div>
									<div class="col-sm-6">
										<form:input class="form-control form-control-user" path="userName" placeholder="이름" readonly="true" />
										<font color="red">
											<form:errors path="userName" />
										</font>
									</div>
								</div>
								<div class="form-group">
									<form:input class="form-control form-control-user" path="userEmail" placeholder="메일 주소" readonly="true" />
									<font color="red">
											<form:errors path="userEmail" />
									</font>
								</div>
								<div class="form-group">
									<form:input class="form-control form-control-user" path="updDate" placeholder="변경 일자(yyyyMMdd)" readonly="true" />
									<font color="red">
											<form:errors path="updDate" />
									</font>
								</div>
								<!------------------------ 일반 모드 on ------------------------------>
								<div id="spn1">
								<div class="form-group aa" id="attach0">
									<c:forEach var="attachVO" items="${memVO.attachVOList}">
										<c:set var="filename" value="${attachVO.filename}" />
										<c:set var="filenameLen" value="${fn:length(filename)}" />
										<img src="/resources/upload${fn:substring(filename,0,12)}s_${fn:substring(filename,12,filenameLen)}" />
									</c:forEach>
								</div>
									<p>
										<button type="button" id="edit" class="btn btn-warning btn-user btn-block"
												style="width:50%;float:left;">수정</button>
									</p>
									<p>
										<button type="button" id="delete" class="btn btn-danger btn-user btn-block"
												style="width:50%;">삭제</button>
									</p>
									<p>
										<a href="/previews/list" class="btn btn-primary btn-user btn-block">목록</a>
									</p>
								</div>
								<!-- ------------------- ★수정모드★ on ------------------->
								<div id="spn2" style="display:none;">
								<!-- 첨부파일 추가 -->
								<div>
								<button type="button" id="addFile" class="btn btn-success btn-circle btn-sm">
								<i class="fas fa-check"></i></button>
								<!-- 첨부파일 제거 -->
								<button type="button" id="delFile" class="btn btn-danger btn-circle btn-sm">
								<i class="fas fa-trash"></i></button>
								</div>
								<div id="att">
								<div class="form-group aa" id="attach0">
									<form:input class="form-control form-control-user" path="attachVOList[0].filename" placeholder="첨부파일" />
									<font color="red">
											<form:errors path="attachVOList[0].filename" />
									</font>
								</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<form:password class="form-control form-control-user" path="userPw" placeholder="비밀번호" />
										<font color="red">
											<form:errors path="userPw" />
										</font>
									</div>
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user" id="userPwCheck" placeholder="비밀번호 확인" />
										<font color="red">
										<span id="spanPwCheck"></span>
										</font>
									</div>
								</div>
									<button type="submit" id="btnSubmit" class="btn btn-primary btn-user btn-block" disabled="disabled">확인</button>
									<a href="/previews/detail?userNo=${param.userNo}" class="btn btn-primary btn-user btn-block">취소</a>
								</div>
								<!-- --------------- 수정모드 off -------------------- -->
							</form:form>
						<p /><p /><p /><p /><p /><p /><br /><br /><br />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
