<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
.offcanvas {
	min-width: 100%;
	background: #282828 !important;
}

div.card { -
	-bs-card-box-shadow: none;
}

.txt a {
	color: white !important;
	font-size: 18px;
}

.txt-sub {
	color: #777;
	font-size: 20px;
	margin-left: 10px;
}

.menu-t {
	color: white !important;
	font-size: 24px;
}

.off-title {
	color: #37D2E7 !important;
	margin-bottom: 25px;
}

.menu_column {
	margin-right: 115px;
}

.menu_group {
	margin-left: 10px;
}
.col-lg-2 {
	flex: 0 0 auto;
	width: 12.333333%;
}
</style>

<div class="top-0">
	<div class="py-3" style="background: white;">
		<ul class="header-menu-option">
			<li>
				<a id="toggle-sidebar" href="#">
					<i class="fa-sharp fa-regular fa-bars fa-fw fa-2xl"></i>
				</a>
			</li>
		</ul>
	</div>
	<div class="header-option justify-content-center align-items-center">
		<a class="nav-link pe-0" href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbarDark" aria-controls="offcanvasNavbarDark" aria-label="Toggle navigation">
			<div class="d-flex align-items-center">
				<div class="user-profile-img">
					<img src="/profile/view/${employee.emplProflPhoto }" class="rounded-circle" width="35" height="35" alt="" />
				</div>
			</div>
		</a>
	</div>
</div>

<div class="offcanvas offcanvas-end text-bg-dark" tabindex="-1" id="offcanvasNavbarDark" aria-labelledby="offcanvasNavbarDarkLabel">
	<div class="offcanvas-header">
		<button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<div class="card" style="background: #222;">
			<div class="row">
				<div class="col-lg-3 col-md-2">
					<div class="card-body" style="background: #222; border: #292929; height: 100%;">
						<div class="profile">
							<div class="d-block" style="width: 110px; height: 110px;">
								<img src="/profile/view/${employee.emplProflPhoto }" class="img-fluid rounded-circle round-100 border-3 border-white" alt="">
							</div>
							<div class="ms-2">
								<p class="name fs-6 text-white m-0 mt-3">${employee.emplNm }</p>
								<ul class="login_info text-white">
									<li>
										<i class="fa-sharp fa-solid fa-house"></i>
										<span class="txt">ThinkLink</span>
									</li>
									<li>
										<i class="fa-sharp fa-solid fa-envelope"></i>
										<span class="txt">${employee.emplEmail }</span>
									</li>
								</ul>
								<div class="d-flex justify-content-between align-items-end w-100" style="height: 125px;">
									<div class="d-inline-block text-center">
										<a href="/" class="text-center" id="main">
											<i class="fa-sharp fa-light fa-house fa-xl fa-fw text-white"></i>
										</a>
										<p class="text-white text-center m-0">
											<label>메인 페이지</label>
										</p>
									</div>
									<div class="d-inline-block">
										<form action="/logout" method="post" class="text-center">
											<button type="submit" style="border:0; background-color: transparent;">
												<i class="fa-sharp fa-regular fa-power-off fa-xl fa-fw text-danger" id="logout" style="cursor: pointer;"></i>
											</button>
											<p class="text-danger text-center m-0">
												<label for="logout">로그아웃</label>
											</p>
											<sec:csrfInput />
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-9 col-md-4" style="border-left: 3px dashed #424242;">
					<div class="card-body" style="background: #222; border: #292929;">
						<div class="d-inline-block">
							<h1 class="off-title">관리 목록</h1>
							<div class="menu_column float-start">
								<h3>
									<span class="menu-t">업무 관리</span>
									<span class="txt-sub">3</span>
								</h3>
								<div class="menu_group float-start">
									<ul class="menu_list float-start">
										<li>
											<span class="txt" name="A-b" title="일정관리">
												<a href="#">일정관리</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="결재관리">
												<a href="/admin/approval">결재관리</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-d" title="양식관리">
												<a href="/admin/documents/list">양식관리</a>
											</span>
										</li>
									</ul>
								</div>
							</div>
							<div class="menu_column float-start">
								<h3>
									<span class="menu-t">시설물 관리</span>
									<span class="txt-sub">2</span>
								</h3>
								<div class="menu_group float-start">
									<ul class="menu_list float-start">
										<li class="position-relative">
											<span class="txt" name="A-a" title="승인관리">
												<a href="/admin/rental/approval">승인관리</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-b" title="반납조회">
												<a href="/admin/rental/returnList">반납조회</a>
											</span>
										</li>
									</ul>
								</div>
							</div>
							<div class="menu_column float-start">
								<h3>
									<span class="menu-t">조직 관리</span>
									<span class="txt-sub">2</span>
								</h3>
								<div class="menu_group float-start">
									<ul class="menu_list float-start">
										<li class="position-relative">
											<span class="txt" name="A-a" title="사원관리">
												<a href="/admin/employee/normalManagement">사원관리</a>
											</span>
										</li>
										<li class="position-relative">
											<span class="txt" name="A-a" title="근태관리">
												<a href="/admin/attendance/management">근태관리</a>
											</span>
										</li>
<!-- 										<li> -->
<!-- 											<span class="txt" name="A-b" title="조직도관리"> -->
<!-- 												<a href="#">조직도관리</a> -->
<!-- 											</span> -->
<!-- 										</li> -->
									</ul>
								</div>
							</div>
							<div class="menu_column float-start">
								<h3>
									<span class="menu-t">공지사항 관리</span>
									<span class="txt-sub">2</span>
								</h3>
								<div class="menu_group float-start">
									<ul class="menu_list float-start">
										<li class="position-relative">
											<span class="txt" name="A-a" title="공지사항">
												<a href="/admin/board?bbsNo=1">공지사항 조회</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-a" title="공지사항">
												<a href="/admin/board/form?bbsNo=1">공지사항 등록</a>
											</span>
										</li>
									</ul>
								</div>
							</div>
							<div class="menu_column float-start">
								<h3>
									<span class="menu-t">전체 통계</span>
									<span class="txt-sub">8</span>
								</h3>
								<div class="menu_group float-start">
									<ul class="menu_list float-start">
										<li class="position-relative">
											<span class="txt" name="A-a" title="근태통계">
												<a href="/admin/attendance/statistics">근태통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-b" title="근속통계">
												<a href="/admin/attendance/longevity">근속통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="프로젝트통계">
												<a href="/admin/project/stat">프로젝트통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="결재통계">
												<a href="/admin/approval/stat">결재통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="예약통계">
												<a href="/admin/mail/stat">메일통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="예약통계">
												<a href="/admin/rental/stat">예약통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="양식통계">
												<a href="/admin/documents/stat">양식통계</a>
											</span>
										</li>
										<li>
											<span class="txt" name="A-c" title="게시판통계">
												<a href="/admin/board/stat">게시판통계</a>
											</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>