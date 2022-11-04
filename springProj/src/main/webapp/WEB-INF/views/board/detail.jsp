<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/validation.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
</script>

<div class="card shadow mb-4">
	<!-- Card Header - Accordion -->
	<a href="#collapseCardExample" class="d-block card-header py-3"
		data-toggle="collapse" role="button" aria-expanded="true"
		aria-controls="collapseCardExample">
		<h6 class="m-0 font-weight-bold text-primary">회원 등록</h6>
	</a>
	<!-- Card Content - Collapse -->
	<div class="collapse show" id="collapseCardExample">
		<div class="card-body">
			<!-- ================card body 시작================= -->
			<form id="frm" name="frm" action="insertMem" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">아이디</label>
					<label>
					<input type="text" class="form-control" name="memId" id="memId" style="width: 250px;" value="${hwMemVO.memId}" readonly />
					</label>
<!-- 					<lable> -->
<!-- 						<button type="button" id="btnDup" class="btn btn-primary btn-icon-split btn-sm" /> -->
<!-- 						<span class="icon text-white-50"> <i class="fas fa-flag"></i></span> -->
<!-- 						<span class="text">중복확인</span> -->
<!-- 					</lable> -->
				</div>
				<div class="mb-3">
					<label for="exampleFormControlTextarea1" class="form-label">이름</label>
					<label>
					<input type="text" class="form-control" name="memName" id="memName" value="${hwMemVO.memName}" style="width: 250px;" readonly />
					</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">직업</label>
					<label>
					<input type="text" class="form-control" name="memJob" id="memJob" value="${hwMemVO.memJob}" style="width: 250px;" readonly />
					</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">취미</label>
					<label>
					<input type="text" class="form-control" name="memLike" id="memLike" style="width: 250px;" />
					</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">연락처</label>
					<label>
					<input type="text" class="form-control" name="memHp" id="memHp" style="width: 250px;" />
					</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">증명사진</label>
					<input class="form-control" type="file" name="pictureArray" id="input_imgs" style="width: 300px; dispaly:none;" multiple>
				</div>
				<div class="mb-3">
					<div class="imgs_wrap">
					<!-- hwMemVO 객체의 멤버 변수를 끄집어냄 -->
						<c:forEach var="attachVO" items="${hwMemberVO.attachVOList}">
							<!-- /2022/11/03/08bafecb-2e1e-48b9-a3d9-2c341126243d_photo.jpg -->
							<img src="/resources/upload${attachVO.attachName}" style="width:200px;" />
						</c:forEach>
						<hr />
						<!-- board controller에서 직접 옴 -->
						<c:forEach var="attachVO" items="${attachVOList}">
							<!-- /2022/11/03/08bafecb-2e1e-48b9-a3d9-2c341126243d_photo.jpg -->
							<img src="/resources/upload${attachVO.attachName}" style="width:200px;" />
						</c:forEach>
						
					</div>
				</div>
				<br>
				<div class="mb-3">
					<button type="button" id="btnAble" onclick="checkAddHwMem()" class="btn btn-primary btn-icon-split" disabled>
					<span class="icon text-white-50"> <i class="fas fa-flag"></i></span>
					<span class="text">등록</span>
					</button>
					<a href="/board/list" type="button" id="btnAble" class="btn btn-secondary btn-icon-split">
					<span class="icon text-white-50"> <i class="fas fa-flag"></i></span>
					<span class="text">취소</span>
					</a>
					</button>
				</div>
			</form>
		</div>
	</div>
</div>