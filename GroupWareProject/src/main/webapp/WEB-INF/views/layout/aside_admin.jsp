<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- import css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/layout/aside.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/admin/aside_admin.css" />
<!-- import js -->
<script src="${pageContext.request.contextPath }/resources/project/js/layout/aside.js"></script>

<!-- ---------------------------------- -->
<!-- 사이드바 메뉴 시작 -->
<!-- ---------------------------------- -->
<aside class="left-sidebar with-vertical position-fixed" id="aside-area">
	<div class="flex-shrink-0 p-0">
		<div class="d-flex align-items-center">
			<a href="/admin/main" class="text-nowrap logo-img logo-margin">
				<img src="${pageContext.request.contextPath}/resources/vendor/images/logos/LOGO_WHITE.png" class="logo dark-logo" alt="Logo-Dark" />
			</a>
		</div>
		<div class="d-flex justify-content-center align-items-center mt-2 mb-3">
			<div class="line"></div>
		</div>
		<div class="container">
			<ul class="list-unstyled ps-0">
				<li>
					<div class="menu-header">관리 목록</div>
				</li>
				<li class="mb-1">
					<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#task-collapse" aria-expanded="true" data-menu>업무관리</button>
					<div class="collapse show" id="task-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" data-list>
							<li>
								<a href="/admin/schedule" class="link-body-emphasis d-inline-flex text-decoration-none rounded">일정관리</a>
							</li>
							<li>
								<a href="/admin/approval" class="link-body-emphasis d-inline-flex text-decoration-none rounded">결재관리</a>
							</li>
							<li>
								<a href="/admin/documents/list" class="link-body-emphasis d-inline-flex text-decoration-none rounded">양식관리</a>
							</li>
						</ul>
					</div>
				</li>
				<li class="mb-1">
					<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#organ-collapse" aria-expanded="true" data-menu>조직관리</button>
					<div class="collapse show" id="organ-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" data-list>
							<li>
								<a href="/admin/employee/normalManagement" class="link-body-emphasis d-inline-flex text-decoration-none rounded">사원관리</a>
							</li>
							<li>
								<a href="/admin/attendance/management" class="link-body-emphasis d-inline-flex text-decoration-none rounded">근태관리</a>
							</li>
<!-- 							<li> -->
<!-- 								<a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">조직도관리</a> -->
<!-- 							</li> -->
						</ul>
					</div>
				</li>
				<li class="mb-1">
					<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#board-collapse" aria-expanded="true" data-menu>공지사항관리</button>
					<div class="collapse show" id="board-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" data-list>
							<li>
								<a href="/admin/board?bbsNo=1" class="link-body-emphasis d-inline-flex text-decoration-none rounded">조회</a>
							</li>
						</ul>
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" data-list>
							<li>
								<a href="/admin/board/form?bbsNo=1" class="link-body-emphasis d-inline-flex text-decoration-none rounded">등록</a>
							</li>
						</ul>
					</div>
				</li>
				<li class="mb-1">
					<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#rental-collapse" aria-expanded="true" data-menu>시설물관리</button>
					<div class="collapse show" id="rental-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" data-list>
							<li>
								<a href="/admin/rental/approval" class="link-body-emphasis d-inline-flex text-decoration-none rounded">승인관리</a>
							</li>
							<li>
								<a href="/admin/rental/returnList" class="link-body-emphasis d-inline-flex text-decoration-none rounded">반납조회</a>
							</li>
						</ul>
					</div>
				</li>
				<div class="d-flex justify-content-center align-items-center mt-2 mb-3">
					<div class="line"></div>
				</div>
				<li>
					<div class="menu-header">통계 목록</div>
				</li>
				<li class="mb-1">
					<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#stat-collapse" aria-expanded="true" data-menu>통계</button>
					<div class="collapse show" id="stat-collapse" style="">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" data-list>
							<li>
								<a href="/admin/attendance/statistics" class="link-body-emphasis d-inline-flex text-decoration-none rounded">근태 통계</a>
							</li>
							<li>
								<a href="/admin/attendance/longevity" class="link-body-emphasis d-inline-flex text-decoration-none rounded">근속 통계</a>
							</li>
							<li>
								<a href="/admin/project/stat" class="link-body-emphasis d-inline-flex text-decoration-none rounded">프로젝트 통계</a>
							</li>
							<li>
								<a href="/admin/approval/stat" class="link-body-emphasis d-inline-flex text-decoration-none rounded">결재 통계</a>
							</li>
							<li>
								<a href="/admin/mail/stat" class="link-body-emphasis d-inline-flex text-decoration-none rounded">메일 통계</a>
							</li>
							<li>
								<a href="/admin/documents/stat" class="link-body-emphasis d-inline-flex text-decoration-none rounded">양식 통계</a>
							</li>
							<li>
								<a href="/admin/rental/stat" class="link-body-emphasis d-inline-flex text-decoration-none rounded">예약 통계</a>
							</li>
							<li>
								<a href="/admin/board/stat" class="link-body-emphasis d-inline-flex text-decoration-none rounded">게시판 통계</a>
							</li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</div>
</aside>
<script>
</script>