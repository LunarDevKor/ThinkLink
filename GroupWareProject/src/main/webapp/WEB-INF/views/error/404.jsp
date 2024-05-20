<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 웹 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@450&display=swap" rel="stylesheet">

<!-- 파비콘 아이콘 -->
<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/resources/vendor/images/logos/favicon.png" />

<!-- 폰트 어썸(아이콘) CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/source/fontawesome/all.css" />

<!-- 메인 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/css/styles.css" />
<!-- BootStrap Bundle 자바스크립트 파일 -->
<script src="${pageContext.request.contextPath}/resources/vendor/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>


<style>
#main-wrapper h1 {
	margin-top: 37px;
	font-size: 22px;
	color: #02a0e7;
	letter-spacing: -0.6px;
}

.min-vh-90 {
	min-height: 90vh !important;
}
</style>

<div id="main-wrapper" class="container" style="overflow-y: hidden">
	<div class="position-relative overflow-hidden min-vh-90 w-100 d-flex align-items-center justify-content-center">
		<div class="d-flex align-items-center justify-content-center w-100">
			<div class="row justify-content-center w-100" style="overflow-y: hidden !important">
				<div class="col-lg-6">
					<div class="text-center">
						<img class="img-fluid" src="${pageContext.request.contextPath}/resources/vendor/images/backgrounds/404.png" alt="404에러" width="377" height="268">
						<h1 class="fw-semibold mt-4 mb-7">죄송합니다. 현재 찾을 수 없는 페이지를 요청 하셨습니다.</h1>
						<h4 class="fw-semibold mb-7">
							존재하지 않는 주소를 입력하셨거나,<br />요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.
						</h4>
						<div class="row">
							<div class="col-lg-6">
								<button type="button" class="justify-content-center w-100 btn mb-1 btn-rounded btn-light d-flex align-items-center" id="home">
									<i class="fa-sharp fa-regular fa-house-heart fa-xl fa-fw fa"></i> 메인으로
								</button>
							</div>
							<div class="col-lg-6">
								<button type="button" class="justify-content-center w-100 btn mb-1 btn-rounded btn-light d-flex align-items-center" id="back">
									<i class="fa-sharp fa-regular fa-arrow-left fa-xl fa-fw fa"></i> 이전 페이지
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	let home = document.getElementById('home');
	let back = document.getElementById('back');

	home.addEventListener('click', function() {
		location.href = '/';
	})

	back.addEventListener('click', function() {
		history.go(-1);
	})
</script>