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
.description h1 {
	margin-top: 37px;
	font-size: 150px;
	color: #02a0e7;
	letter-spacing: -0.6px;
	font-weight: 700;
}

.description h3 {
	font-size: 1.5rem;
	line-height: 2rem;
	font-weight: 700;
}

.min-vh-90 {
	min-height: 90vh !important;
}
</style>
<div id="main-wrapper" class="container" style="overflow-y: hidden">
	<div class="position-relative overflow-hidden min-vh-90 w-100 d-flex align-items-center justify-content-center">
		<div class="d-flex align-items-center justify-content-center w-100" style="overflow-y: hidden !important">
			<div class="row justify-content-center w-100" style="overflow-y: hidden !important">
				<div class="col-lg-6">
					<div class="text-center description">
						<img class="img-fluid" src="${pageContext.request.contextPath}/resources/vendor/images/backgrounds/500.png" alt="500에러" width="377" height="268">
						<h1 class="fw-bold mb-2">500</h1>
						<h3 class="fw-semibold mt-4 mb-7">헉! 서버오류에요!</h3>
						<p class="fw-semibold mb-7">우리가 잘못했어요! 곧 정리할거에요 조금만 기다려주세요</p>
						<div class="row">
							<div class="col-lg-12">
								<button type="button" class="justify-content-center w-100 btn mb-1 rounded-0 btn-light d-flex align-items-center" id="home">
									<i class="fa-sharp fa-regular fa-house-heart fa-xl fa-fw fa"></i> <span>안전한 페이지로 돌아가기!</span>
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

	home.addEventListener('click', function() {
		location.href = '/';
	})
</script>