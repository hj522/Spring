<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div style="display:flex; justify-content:center;">
<div class="login-box">
	<div class="card card-outline card-danger">
		<div class="card-header text-center">
			<a href="/book/list" class="h4"><b>🍎사과책방🍎</b></a>
		</div>
		<div class="card-body">
			<p class="login-box-msg">아이디와 비밀번호를 입력해주세요.</p>
			<form action="/login" method="post">
				<div class="input-group mb-3">
					<input type="text" name="username" class="form-control" placeholder="아이디" />
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-envelope text-danger"></span>
						</div>
					</div>
				</div>
				<div class="input-group mb-3">
					<input type="password" name="password" class="form-control" placeholder="비밀번호" />
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-lock text-danger"></span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-8">
						<div class="icheck-danger">
							<input type="checkbox" id="remember" name="remember-me" /> <label
								for="remember">아이디 기억하기</label>
						</div>
					</div>

					<div class="col-4">
						<button type="submit" class="btn btn-warning btn-block">로그인</button>
					</div>
				</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>
</div>