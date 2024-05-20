<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
* {
	padding: 0;
	margin: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	overflow: hidden;
}

.wave {
	position: fixed;
	bottom: 0;
	left: 0;
	height: 100%;
	z-index: -1;
}

.part {
	width: 40%;
	position: absolute;
	z-index: -2;
	top: 20%;
	left: 6%;
	opacity: 40%;
}

.container {
	width: 100vw;
	height: 100vh;
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	grid-gap: 7rem;
	padding: 0 2rem;
}

.img {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	margin-right: 10%;
}

.login-content {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	text-align: center;
}

.img img {
	width: 500px;
	margin-right: 20%;
	margin-top: 20%;
}

form {
	width: 360px;
}

.login-content img {
	height: 100px;
}

.login-content h2 {
	margin: 15px 0;
	color: #333;
	text-transform: uppercase;
	font-size: 2.9rem;
}

.login-content .input-div {
	position: relative;
	display: grid;
	grid-template-columns: 7% 93%;
	margin: 25px 0;
	padding: 5px 0;
	border-bottom: 2px solid #d9d9d9;
}

.login-content .input-div.one {
	margin-top: 0;
}

.i {
	color: #d9d9d9;
	display: flex;
	justify-content: center;
	align-items: center;
}

.i i {
	transition: .3s;
}

.input-div>div {
	position: relative;
	height: 45px;
}

.input-div>div>h5 {
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #999;
	font-size: 18px;
	transition: .3s;
}

.input-div:before, .input-div:after {
	content: '';
	position: absolute;
	bottom: -2px;
	width: 0%;
	height: 2px;
	background-color: #133F71;
	transition: .4s;
}

.input-div:before {
	right: 50%;
}

.input-div:after {
	left: 50%;
}

.input-div.focus:before, .input-div.focus:after {
	width: 50%;
}

.input-div.focus>div>h5 {
	top: -5px;
	font-size: 15px;
}

.input-div.focus>.i>i {
	color: #133F71;
}

.input-div>div>input {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	border: none;
	outline: none;
	background: none;
	padding: 0.5rem 0.7rem;
	font-size: 1.2rem;
	color: #555;
	font-family: 'poppins', sans-serif;
}

.input-div.pass {
	margin-bottom: 4px;
}

a {
	display: block;
	text-align: right;
	text-decoration: none;
	color: #999;
	font-size: 0.9rem;
	transition: .3s;
}

a:hover {
	color: #38d39f;
}

.botton {
	display: block;
	width: 100%;
	height: 50px;
	border-radius: 25px;
	outline: none;
	border: none;
	background-image: linear-gradient(to right, #133F71, #2A527F, #133F71);
	background-size: 200%;
	font-size: 1.2rem;
	color: #fff;
	font-family: 'Poppins', sans-serif;
	text-transform: uppercase;
	margin: 1rem 0;
	cursor: pointer;
	transition: .5s;
}

.botton:hover {
	background-position: right;
}

@media screen and (max-width: 1050px) {
	.container {
		grid-gap: 5rem;
	}
}

@media screen and (max-width: 1000px) {
	form {
		width: 290px;
	}
	.login-content h2 {
		font-size: 2.4rem;
		margin: 8px 0;
	}
	.img img {
		width: 400px;
	}
}

@media screen and (max-width: 900px) {
	.container {
		grid-template-columns: 1fr;
	}
	.img {
		display: none;
	}
	.wave {
		display: none;
	}
	.login-content {
		justify-content: center;
	}
}
</style>
<sec:authorize access="isAuthenticated()">
	<script>
 		location.replace('/');
	</script>
</sec:authorize>

${errors }
<div class="box">
	<img class="wave" src="${pageContext.request.contextPath }/resources/project/images/other/wave.png">
	<img class="part" src="${pageContext.request.contextPath }/resources/project/images/other/part.png">
</div>
<div class="container">
	<div class="img">
		<img src="${pageContext.request.contextPath }/resources/project/images/other/work.png">
	</div>
	<div class="login-content">
		<form action="/login" method="post" id="loginFrm">
			<img src="${pageContext.request.contextPath }/resources/project/images/logo/LOGO_BIG.png">
			<div class="input-div one">
				<div class="i">
					<i class="fa-solid fa-user-tie fa-xl"></i>
				</div>
				<div class="div">
					<h5>아이디</h5>
					<input type="text" class="input" id="emplId" name="username" maxlength="20">
					<span class="error invalid-feedback" style="display: block;">${errors.emplId }</span>
				</div>
			</div>
			<div class="input-div pass">
				<div class="i">
					<i class="fas fa-lock fa-xl"></i>
				</div>
				<div class="div">
					<h5>비밀번호</h5>
					<input type="password" class="input" id="emplPassword" name="password" maxlength="20">
					<span class="error invalid-feedback" style="display: block;">${errors.emplPassword }</span>
				</div>
			</div>
			<div class="input-div">
				<input type="checkbox" id="remember" name="remember-me">
				<label for="remember"> Remember Me </label>
			</div>
			<input type="button" class="botton" value="로그인" id="loginBtn">
			<div id="empLoginArea">
				<div class="row mb-2">
					<div class="col-lg-6">
						<button type="button" class="btn btn-primary" name="empLogin">
							<i class="fa-regular fa-user-tie fa-xl" style="color: black;"></i> 이명문
						</button>
					</div>
					<div class="col-lg-6">
						<button type="button" class="btn btn-primary" name="empLogin">
							<i class="fa-regular fa-user-tie fa-xl" style="color: black;"></i> 이영주
						</button>
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-lg-6">
						<button type="button" class="btn btn-primary" name="empLogin">
							<i class="fa-regular fa-user-tie fa-xl" style="color: black;"></i> 최소희
						</button>
					</div>
					<div class="col-lg-6">
						<button type="button" class="btn btn-primary" name="empLogin">
							<i class="fa-regular fa-user-tie fa-xl" style="color: black;"></i> 최윤서
						</button>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-6">
						<button type="button" class="btn btn-primary" name="empLogin">
							<i class="fa-regular fa-user-tie fa-xl" style="color: black;"></i> 권예은
						</button>
					</div>
					<div class="col-lg-6">
						<button type="button" class="btn btn-primary" name="empLogin">
							<i class="fa-regular fa-user-tie fa-xl" style="color: black;"></i> 민경선
						</button>
					</div>
				</div>
			</div>
			<sec:csrfInput />
		</form>
	</div>
</div>
<script>
	const inputs = document.querySelectorAll(".input");
	const loginBtn = document.getElementById('loginBtn');
	const empLoginArea = $('#empLoginArea');
	const loginFrm = document.getElementById('loginFrm');
	let empId = document.getElementById('emplId');
	let empPw = document.getElementById('emplPassword');
	
	function addcl(){
	  let parent = this.parentNode.parentNode;
	  parent.classList.add("focus");
	}
	
	function remcl(){
	  let parent = this.parentNode.parentNode;
	  if(this.value == ""){
	    parent.classList.remove("focus");
	  }
	}
	
	inputs.forEach(input => {
	  input.addEventListener("focus", addcl);
	  input.addEventListener("blur", remcl);
	});
	
	empPw.addEventListener('keyup', function(e) {
		if(e.keyCode == 13) {
			loginProcess();
		}
	})
	
	loginBtn.addEventListener('click', function() {
		loginProcess();
	});
	
	empLoginArea.on('click', 'button', function() {
		let name = $(this).prop('name');
		if(name === 'empLogin') {
			let target = $(this).text().trim();
			switch(target) {
				case '이명문':
					empId.value = 'mmlee';
					empPw.value = 'mm1234';
					break;
				case '이영주':
					empId.value = 'yjlee';
					empPw.value = 'yj1234';
					break;
				case '최소희':
					empId.value = 'shchoi';
					empPw.value = 'sh1234';	
					break;
				case '최윤서':
					empId.value = 'yschoi';
					empPw.value = 'ys1234';	
					break;
				case '민경선':
					empId.value = 'ksmin';
					empPw.value = 'ks1234';	
					break;
				case '권예은':
					empId.value = 'nogold';
					empPw.value = '1234';	
					break;
			}
		}
		
		loginFrm.submit();
	});
	
	
	function loginProcess() {
		let id = empId.value;
		let pw = empPw.value;
		
		if (id == null || id.trim() == '' ) {
			showToast('아이디를 입력해주세요!', 'warning');
			return false;
		}
		if (pw == null || pw.trim() == '') {
			showToast('비밀번호를 입력해주세요!', 'warning');
			return false;
		}
		
		loginFrm.submit();
	}
</script>