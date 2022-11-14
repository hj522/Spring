<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="card">
	<div class="card-header">
		<h3 class="card-title">${bodyTitle}</h3>
	</div>

	<div class="card-body">
		<div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="col-sm-12 col-md-6"></div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<table id="example1"
					class="table table-bordered table-striped dataTable dtr-inline"
					aria-describedby="example1_info">
					<thead>
						<tr>
							<th class="sorting sorting_asc" tabindex="0"
								aria-controls="example1" rowspan="1" colspan="1"
								aria-sort="ascending"
								aria-label="Rendering engine: activate to sort column descending">bookId</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">Title</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Platform(s): activate to sort column ascending">Category</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Engine version: activate to sort column ascending">Price</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="CSS grade: activate to sort column ascending">Insert
								Date</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bookVO" items="${bookVOList}" varStatus="stat">
							<c:if test="${stat.count%2!=0}">
								<tr class="odd">
							</c:if>
							<c:if test="${stat.count%2==0}">
								<tr class="even">
							</c:if>
							<td class="dtr-control sorting_1" tabindex="0">${bookVO.bookId}</td>
							<td><a href="/book/detail?bookId=${bookVO.bookId}">${bookVO.title}</a></td>
							<td>${bookVO.category}</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="3"
									value="${bookVO.price}" /></td>
							<td><fmt:formatDate value="${bookVO.insertDate}" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<th rowspan="1" colspan="1">BookId</th>
							<th rowspan="1" colspan="1">Title</th>
							<th rowspan="1" colspan="1">Category</th>
							<th rowspan="1" colspan="1">Price</th>
							<th rowspan="1" colspan="1">Insert Date</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 col-md-5"></div>
			<div class="col-sm-12 col-md-7">
				<div class="dataTables_paginate paging_simple_numbers"
					id="example1_paginate">
					<ul class="pagination">
						<li class="paginate_button page-item previous disabled"
							id="example1_previous"><a href="#" aria-controls="example1"
							data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
						<li class="paginate_button page-item active"><a href="#"
							aria-controls="example1" data-dt-idx="1" tabindex="0"
							class="page-link">1</a></li>
						<li class="paginate_button page-item "><a href="#"
							aria-controls="example1" data-dt-idx="2" tabindex="0"
							class="page-link">2</a></li>
						<li class="paginate_button page-item "><a href="#"
							aria-controls="example1" data-dt-idx="3" tabindex="0"
							class="page-link">3</a></li>
						<li class="paginate_button page-item "><a href="#"
							aria-controls="example1" data-dt-idx="4" tabindex="0"
							class="page-link">4</a></li>
						<li class="paginate_button page-item "><a href="#"
							aria-controls="example1" data-dt-idx="5" tabindex="0"
							class="page-link">5</a></li>
						<li class="paginate_button page-item "><a href="#"
							aria-controls="example1" data-dt-idx="6" tabindex="0"
							class="page-link">6</a></li>
						<li class="paginate_button page-item next" id="example1_next"><a
							href="#" aria-controls="example1" data-dt-idx="7" tabindex="0"
							class="page-link">Next</a></li>
					</ul>
					<input type="button" id="newBook" class="btn btn-primary"
						style="float: right;" value="등록"
						onclick="javascript:location.href='insert'" />
				</div>
			</div>
		</div>
	</div>
</div>
</div>