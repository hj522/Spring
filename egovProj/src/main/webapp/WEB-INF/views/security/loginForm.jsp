<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div style="display:flex; justify-content:center;">
<div class="login-box">
	<div class="card card-outline card-danger">
		<div class="card-header text-center">
			<a href="/book/list" class="h4"><b>๐์ฌ๊ณผ์ฑ๋ฐฉ๐</b></a>
		</div>
		<div class="card-body">
			<p class="login-box-msg">์์ด๋์ ๋น๋ฐ๋ฒํธ๋ฅผ ์๋ ฅํด์ฃผ์ธ์.</p>
			<form action="/login" method="post">
				<div class="input-group mb-3">
					<input type="text" name="username" class="form-control" placeholder="์์ด๋" />
					<div class="input-group-append">
						<div class="input-group-text">
							<span class="fas fa-envelope text-danger"></span>
						</div>
					</div>
				</div>
				<div class="input-group mb-3">
					<input type="password" name="password" class="form-control" placeholder="๋น๋ฐ๋ฒํธ" />
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
								for="remember">์์ด๋ ๊ธฐ์ตํ๊ธฐ</label>
						</div>
					</div>

					<div class="col-4">
						<button type="submit" class="btn btn-warning btn-block">๋ก๊ทธ์ธ</button>
					</div>
				</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>
</div>