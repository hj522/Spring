<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("[name='show']").on("change",function(){
		let val = $(this).val();
		// EL 태그의 값을 자바스크립트 변수로 가져옴
		location.href="<%=request.getContextPath()%>/board/list?currentPage=1&show="+val;
	});
});
</script>
<!DOCTYPE html>
<html>
<head>
<title>회원 게시판 숙제</title>
</head>
<body>
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">HW_MEMBER TABLE</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<form name="frm" id="frm" action="/board/list" method="get">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label>Show
							<select name="show" id="show" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
									<option value="10" <c:if test='${param.show eq 10}'>selected</c:if>>10</option>
									<option value="25" <c:if test='${param.show eq 25}'>selected</c:if>>25</option>
									<option value="50" <c:if test='${param.show eq 50}'>selected</c:if>>50</option>
									<option value="100" <c:if test='${param.show eq 100}'>selected</c:if>>100</option>
							</select> entries
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter">
							<label>
								<input type="search" name="keyword" class="form-control form-control-sm" placeholder="검색어를 입력하세요"
								aria-controls="dataTable" value="${param.keyword}">
							</label>
							<label>
							<button type="submit" class="btn btn-primary btn-icon-split btn-sm">
								<span class="icon text-white-50"> <i class="fas fa-flag"></i></span>
								<span class="text">통합검색</span>
							</label>
						</div>
					</div>
				</div>
				</form>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered dataTable" id="dataTable"
							width="100%" cellspacing="0" role="grid"
							aria-describedby="dataTable_info" style="width: 100%;">
							<thead>
								<tr role="row">
									<th class="sorting sorting_asc" tabindex="0"
										aria-controls="dataTable" rowspan="1" colspan="1"
										aria-sort="ascending"
										aria-label="Name: activate to sort column descending"
										style="width: 50px;">아이디</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Position: activate to sort column ascending"
										style="width: 50px;">이름</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Office: activate to sort column ascending"
										style="width: 50px;">직업</th>
									<th class="sorting" tabindex="0" aria-controls="dataTable"
										rowspan="1" colspan="1"
										aria-label="Age: activate to sort column ascending"
										style="width: 50px;">취미</th>
							</thead>
							<tbody>
							<!-- before => data : List<HwMemberVO> list / mem : HwMemberVO
								페이징 처리 after => data : ArticlePage이므로, data.content를 해야 List<HwMemberVO> list가 나온다.
							-->
							<!-- stat.count: 행 번호(1,2,3,4,5)
								 stat.index: 인덱스 번호(0,1,2,3,4,5...)
							-->
								<c:forEach var="mem" items="${list.content}" varStatus="stat">
									<c:if test="${stat.count%2==0}">
										<tr class="even" style="background-color:#E1EEFF;">
									</c:if>
									<c:if test="${stat.count%2!=0}">
										<tr class="odd">
									</c:if>
										<td class="sorting_1">${mem.memId}</td>
										<td>${mem.memName}</td>
										<td>${mem.memJob}</td>
										<td>${mem.memLike}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-5">
						<div class="dataTables_info" id="dataTable_info" role="status"
							aria-live="polite">
							<!-- /board/list 조정해보자 -->
							<c:if test="${param.show==null}">
								<c:set var="show" value="10" />
							</c:if>
							<c:if test="${param.show!=null}">
								<c:set var="show" value="${param.show}" />
							</c:if>
							<c:if test="${param.currentPage==null}">
								<c:set var="currentPage" value="1" />
							</c:if>
							<c:if test="${param.currentPage!=null}">
								<c:set var="currentPage" value="${param.currentPage}" />
							</c:if>
							<!-- 한 화면에 보여지는 행 수 : show -->
							<c:set var="show" value="${show}" />
							<!-- 종료 행 번호: currentPage * 10행 -->
							<c:set var="endRow" value="${currentPage * show}" />
							<!-- 시작 행 번호: 종료 행 번호 - (10-1) -->
							<c:set var="startRow" value="${endRow-(show-1)}" />
							<c:if test="${endRow > list.total}">
								<c:set var="endRow" value="${list.total}" />
							</c:if>
							Showing ${startRow} to ${endRow} of ${list.total} entries</div>
					</div>
					<a href="/board/insertMem" class="btn btn-outline-primary"> <span
						class="icon text-white-50"> </span> <span class="text">회원등록</span>
					</a>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<li class="paginate_button page-item previous
									<c:if test='${list.startPage lt 6}'>disabled</c:if>" id="dataTable_previous">
									<a href="/board/list?currentPage=${list.startPage-5}&show=${show}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">
									Previous</a></li>
								<c:forEach var="pNo" begin="${list.startPage}" end="${list.endPage}">
									<!-- class="..... active" => 현재 페이지 파란색으로 보임 -->
									<li class="paginate_button page-item <c:if test='${currentPage==pNo}'>active</c:if>">
										<a href="/board/list?currentPage=${pNo}&show=${show}" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a></li>
								</c:forEach>
								<!-- *EL태그 정리
									== : eq(equal)
									!= : ne(not equal)
									< : lt(less than)
									> : gt(greater than)
									<= : le(less equal)
									>= : ge(greater equal)
								-->
								<li class="paginate_button page-item next
									<c:if test='${list.endPage ge list.totalPages}'>disabled</c:if>" id="dataTable_next">
									<a href="/board/list?currentPage=${list.startPage+5}&show=${show}" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">
									Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>