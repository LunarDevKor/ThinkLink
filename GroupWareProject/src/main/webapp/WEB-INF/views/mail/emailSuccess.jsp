<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
.material-symbols-light--star {
	display: inline-block;
	width: 26px;
	height: 26px;
	background-repeat: no-repeat;
	background-size: 100% 100%;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23f5cc00' d='m7.325 18.923l1.24-5.313l-4.123-3.572l5.431-.47L12 4.557l2.127 5.01l5.43.47l-4.122 3.572l1.24 5.313L12 16.102z'/%3E%3C/svg%3E");
}

.material-symbols-light--star-outline {
	display: inline-block;
	width: 25px;
	height: 25px;
	background-repeat: no-repeat;
	background-size: 100% 100%;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23525252' d='m8.85 16.825l3.15-1.9l3.15 1.925l-.825-3.6l2.775-2.4l-3.65-.325l-1.45-3.4l-1.45 3.375l-3.65.325l2.775 2.425zm-1.525 2.098l1.24-5.313l-4.123-3.572l5.431-.47L12 4.557l2.127 5.01l5.43.47l-4.122 3.572l1.24 5.313L12 16.102zM12 12.25'/%3E%3C/svg%3E");
}

.w-16 {
	width: 16% !important;
}
/* 일반 페이지 버튼 스타일 */
.page-item .page-link {
	color: #333 !important;
	background-color: #fff !important;
	border-color: #ddd !important;
	border-radius: 0 !important;
}

/* 현재 페이지 버튼 스타일 */
.page-item.active .page-link {
	color: #fff !important;
	background-color: #007bff !important;
	border-color: #007bff !important;
	border-radius: 0 !important;
}

.form-check-input {
	border-radius: 0 !important;
}

.btn-primary {
	background-color: #007bff; /* 기본 배경 색상 */
}

.btn-primary:hover {
	background-color: #339cff; /* 마우스를 올렸을 때의 배경 색상 */
}

.btn-primary:active {
	background-color: #0056b3; /* 버튼을 눌렀을 때의 배경 색상 */
}
</style>

<div class="card overflow-hidden chat-application" style="max-height: 800px;">
	<div class="d-flex align-items-center justify-content-between gap-6 m-3 d-lg-none">
		<button class="btn btn-primary d-flex" type="button" data-bs-toggle="offcanvas" data-bs-target="#chat-sidebar" aria-controls="chat-sidebar">
			<i class="ti ti-menu-2 fs-5"></i>
		</button>
		<form class="position-relative w-100">
			<input type="text" class="form-control search-chat py-2 ps-5" id="text-srh" placeholder="Search Contact">
			<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
		</form>
	</div>
	<div class="d-flex w-100">
		<div class="left-part border-end w-16 flex-shrink-0 d-none d-lg-block h-auto">
			<div class="px-9 pt-4 pb-3">
				<a href="/mail/inbox">
					<h3 class="fw-semibold mb-8" style="margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-envelope fa-fw fa"></i>&nbsp;&nbsp;메일
					</h3>
				</a>
				<button class="btn btn-primary fw-semibold rounded-0 py-8 w-100" style="margin-top: 20px;" onclick="location.href='/mail/emailForm'">메일 쓰기</button>
			</div>
			<ul class="list-group">
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/inbox">
						<i class="ti ti-inbox fs-5"></i>받은메일함
						<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${inboxNoRead }</span>
					</a>
				</li>
				<li class="list-group-item border-0 p-0 mx-9">
					<div class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1">
						<a href="/mail/sent">
							<i class="ti ti-brand-telegram fs-5" style="margin-right: 12px;"></i>보낸메일함
						</a>
						<button type="button" class="btn btn-sm bg-primary-subtle text-primary ms-auto" onclick="location.href='/mail/check'">수신확인</button>
					</div>
				</li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/noRead">
						<i class="ti ti-inbox fs-5"></i>안읽은메일함
					</a>
				</li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/importantbox">
						<i class="ti ti-star fs-5"></i>중요메일함
					</a>
				</li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/toMe">
						<i class="ti ti-inbox fs-5"></i>내게쓴메일함
						<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${toMeNoRead }</span>
					</a>
				</li>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/reservation" class="d-block ">
						<i class="ti ti-badge fs-5"></i>예약메일함
						<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${reservation }</span>
					</a>
				</li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/draft">
						<i class="ti ti-file-text fs-5"></i>임시보관함
					</a>
				</li>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9">
					<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/trash">
						<i class="ti ti-trash fs-5"></i>휴지통
						<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${trashNoRead }</span>
					</a>
				</li>
			</ul>
		</div>
		<!-- 메뉴 옆 오른쪽 구역 시작 -->
		<div class="container">
			<div class="row" style="margin-top: 200px;">
				<div class="col-12 text-center">
					<div class="mb-1">
						<span class="fs-5 fw-semibold">
							<i class="ti ti-brand-telegram fs-5"></i> 메일을 성공적으로 보냈습니다.
						</span>
					</div>
					<div class="row justify-content-center">
						<div class="col-6 text-center" style="margin-top: 10px;">
							<button type="button" class="btn bg-primary-subtle text-primary" onclick="location.href='/mail/inbox'">받은 메일함으로 이동</button>
							<button type="button" class="btn bg-primary-subtle text-primary" onclick="location.href='/mail/emailForm'">메일 쓰기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 메뉴 옆 오른쪽 구역 끝 -->
	</div>
</div>



<script src="${pageContext.request.contextPath}/resources/vendor/js/apps/chat.js"></script>
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>
	
</script>