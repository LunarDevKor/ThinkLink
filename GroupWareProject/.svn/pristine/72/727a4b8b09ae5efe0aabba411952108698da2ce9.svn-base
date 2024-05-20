<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/gridstack.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/modal/interactive-modal.css">
<style>
.btn-right {
	border-right: solid 1px white;
	border-radius: 7px 0px 0px 0px;
}

.btn-left {
	border-left: solid 1px white;
	border-radius: 0px 7px 0px 0px;
}

.w-12 {
	width: 12% !important;
}

.font-weight-bold {
	font-weight: 600 !important;
}

#mailTabContent table tr td {
	padding: 10px;
	padding-bottom: 5px;
	padding-top: 5px;
}

.main-news {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#mp-cal .fc .fc-button {
	border-radius: -1px;
	padding: 1px 6px;
	text-transform: capitalize;
	color: white;
	border: none;
}

#mp-cal .fc .fc-btnAllCal-button { -
	-bs-badge-padding-x: 10px; -
	-bs-badge-padding-y: 5px; -
	-bs-badge-font-size: 0.875rem; -
	-bs-badge-font-weight: 400; -
	-bs-badge-color: #fff; -
	-bs-badge-border-radius: 7px;
	display: inline-block;
	padding: var(- -bs-badge-padding-y) var(- -bs-badge-padding-x);
	font-size: var(- -bs-badge-font-size);
	font-weight: var(- -bs-badge-font-weight);
	line-height: 1;
	color: var(- -bs-badge-color);
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	background: #FF595E;
	border: none;
}

#mp-cal .fc .fc-btnComCal-button { -
	-bs-badge-padding-x: 10px; -
	-bs-badge-padding-y: 5px; -
	-bs-badge-font-size: 0.875rem; -
	-bs-badge-font-weight: 400; -
	-bs-badge-color: #fff; -
	-bs-badge-border-radius: 7px;
	display: inline-block;
	padding: var(- -bs-badge-padding-y) var(- -bs-badge-padding-x);
	font-size: var(- -bs-badge-font-size);
	font-weight: var(- -bs-badge-font-weight);
	line-height: 1;
	color: var(- -bs-badge-color);
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	background: #FF924C;
	border: none;
}

#mp-cal .fc .fc-btnDeptCal-button { -
	-bs-badge-padding-x: 10px; -
	-bs-badge-padding-y: 5px; -
	-bs-badge-font-size: 0.875rem; -
	-bs-badge-font-weight: 400; -
	-bs-badge-color: #fff; -
	-bs-badge-border-radius: 7px;
	display: inline-block;
	padding: var(- -bs-badge-padding-y) var(- -bs-badge-padding-x);
	font-size: var(- -bs-badge-font-size);
	font-weight: var(- -bs-badge-font-weight);
	line-height: 1;
	color: var(- -bs-badge-color);
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	background: #FFCA3A;
	border: none;
}

#mp-cal .fc .fc-btnMyCal-button { -
	-bs-badge-padding-x: 10px; -
	-bs-badge-padding-y: 5px; -
	-bs-badge-font-size: 0.875rem; -
	-bs-badge-font-weight: 400; -
	-bs-badge-color: #fff;
	/*     --bs-badge-border-radius: 7px; */
	display: inline-block;
	padding: var(- -bs-badge-padding-y) var(- -bs-badge-padding-x);
	font-size: var(- -bs-badge-font-size);
	font-weight: var(- -bs-badge-font-weight);
	line-height: 1;
	color: var(- -bs-badge-color);
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-top-right-radius: 7px;
	border-top-left-radius: 7px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	background: #C5CA30;
	border: none;
}

.fc-prev-button {
	background-color: var(- -bs-primary) !important;
}

.fc-next-button {
	background-color: var(- -bs-primary) !important;
}

.side-stick {
	width: 3px;
	height: 20px;
	position: absolute;
	margin-right: 10px;
}

.card-body {
	padding: 16px;
}

/* .gs-id-0 { */
/* 	height: 700px !important; */
/* } */
.important-title {
	color: #ff9999;
	font-weight: bold;
}
/* 호버 효과 */
.important-title:hover {
	color: blue; /* 링크 텍스트 색상 변경 */
	text-decoration: underline; /* 링크에 밑줄 표시 */
	/* 다른 원하는 스타일 속성들 추가 가능 */
}

.card {
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}

.card:hover {
	box-shadow: 0 3px 5px rgba(0, 0, 0, 0.20), 0 4px 4px rgba(0, 0, 0, 0.22);
	transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
}

.fc-next-button {
	background-color: var(--bs-primary) !important;
}
.fc-prev-button {
	background-color: var(--bs-primary) !important;
}

/* .a-menu:hover>span { */
/* 	border-bottom: 3px solid #1A66CC; */
/* } */
/* .fc .fc-toolbar-title { */
/*    	font-size: 1.4em !important; */
/*    } */
/* .gs-id-0 > .grid-stack-item[gs-h="4"] { */
/*     height: 511.667px !important; */
/* } */
/* .gs-id-0 > .grid-stack-item[gs-h="3"] { */
/*     height: 330px !important; */
/* } */
/* .gs-id-0 > .grid-stack-item[gs-y="3"] { */
/*     top: 320px !important; */
/* } */
/* .gs-id-0 > .grid-stack-item[gs-h="4"] { */
/*     height: 410.667px; */
/* } */
/* .gs-id-0 > .grid-stack-item[gs-y="4"] { */
/*     top: 463.667px; */
/* } */
/* .gs-id-0 > .grid-stack-item[gs-h="2"] { */
/*     height: 233.333px !important; */
/* } */
/* .gs-id-0 > .grid-stack-item[gs-y="2"] { */
/*     top: 230.333px !important; */
/* } */
/* .@media (max-width: 1279px) { */
/* } */
</style>
<div class="grid-stack" style="height: 700px;">
	<div class="grid-stack-item" gs-x="0" gs-y="0" gs-w="2" gs-h="3" id="A101">
		<div class="card rounded-2 bg-primary grid-stack-item-content" style="overflow: hidden;">
			<div class="card-body rounded-3 p-3 text-white">
				<div class="d-flex justify-content-between align-items-center">
					<div class="me-2">
						<i class="fa-sharp fa-regular fa-list fa-xl fa-fw" style="cursor: pointer;" id="layoutBtn"></i>
						<p>
							<label for="layoutBtn">목록</label>
						</p>
					</div>
					<div>
						<i class="fa-sharp fa-regular fa-floppy-disk fa-xl fa-fw" style="cursor: pointer;" id="saveBtn"></i>
						<p>
							<label for="saveBtn">저장</label>
						</p>
					</div>
				</div>
				<div class="d-flex flex-fill align-items-center justify-content-center w-100">
					<img class="w-50 tl-profile-img" src="/profile/view/${employee.emplProflPhoto }">
				</div>
				<div class="card-body text-center p-3">
					<div class="d-inline">
						<span class="h3 text-white">${employee.emplNm }</span>
						<span class="ms-2">${employee.clsfNm }</span>
						<p class="m-0">${employee.deptNm }</p>
						<p class="m-0">${employee.emplNo }</p>
					</div>
				</div>
				<div class="">
					<div class="d-flex justify-content-between align-items-center">
						<span>결재 대기 문서</span>
						<a href="/approval/list/all" style="color: white;">
							<span>${approvalList[0].CNT}</span>
						</a>
					</div>
					<div class="d-flex justify-content-between align-items-center">
						<span>예약 및 대여 현황</span>
						<span>0</span>
					</div>
					<div class="d-flex align-items-center">
						<span>안 읽은 메일</span>
						<a href="/mail/noRead" class="ms-auto" style="color: white;">
							<span>${noReadCnt }</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="grid-stack-item" gs-x="0" gs-y="3" gs-w="2" gs-h="2" id="A102">
		<div class="card grid-stack-item-content">
			<!-- 근태 현황 -->
			<div class="card-body">
				<h5 class="card-title fw-semibold">근태 현황</h5>
				<p class="card-subtitle mb-0 mt-1">${todayString }</p>
				<div class="mt-2">
					<div class="d-flex align-items-center justify-content-between">
						<span class="fw-semibold">출근 시간</span>
						<span class="text-center me-3">${attendString }</span>
					</div>
					<div class="d-flex align-items-center justify-content-between">
						<span class="fw-semibold">퇴근 시간</span>
						<span class="text-center me-3">${lvffcString }</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="grid-stack-item" gs-x="2" gs-y="0" gs-w="4" gs-h="2" id="A103">
		<div class="card grid-stack-item-content" style="overflow: hidden;">
			<div class="card-body">
				<h5 class="card-title mb-9 fw-semibold w-100">사내 공지</h5>
				<c:forEach items="${boardList }" var="board">
					<div class="d-flex align-items-center justify-content-start">
						<p class="fw-semibold mb-1" style="font-size: 16px;">
							<iconify-icon icon="solar:chat-round-check-outline" width="1.5rem" height="1.5rem" style="color: #e66060"></iconify-icon>
							<a href="board/detail?bbscttNo=${board.bbscttNo}">
								<c:choose>
									<c:when test="${board.imprtncYn eq 'Y'}">
										<span class="important-title">
											<i class="fa-solid fa-circle-exclamation me-2"></i>${board.bbscttTitle}
										</span>
									</c:when>
									<c:otherwise>
										<span>${board.bbscttTitle}</span>
									</c:otherwise>
								</c:choose>
							</a>
						</p>
					</div>
				</c:forEach>
				<div class="d-flex align-items-center justify-content-end">
					<a href="#">
						<iconify-icon icon="solar:alt-arrow-right-line-duotone" width="1.5rem" height="1.5rem"></iconify-icon>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="grid-stack-item" gs-x="2" gs-y="2" gs-w="4" gs-h="4" id="A104">
		<div class="card grid-stack-item-content" style="overflow: hidden;">
			<div class="card-body">
				<div class="calender-sidebar app-calendar" id="mp-cal">
					<div id="calendar"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- 업무 현황 -->
	<div class="grid-stack-item" gs-x="6" gs-y="0" gs-w="4" gs-h="2" id="A105">
		<div class="card grid-stack-item-content" style="overflow: hidden;">
			<div class="card-body">
				<div class="d-sm-flex d-block align-items-center justify-content-between mb-9 border-bottom">
					<div class="mb-3 mb-sm-0" onclick="fnSelectProject()">
						<c:set var="project" value="${projectList[0] }" />
						<c:set var="prjctNo" value="${project.prjctNo }" />
						<span class="side-stick yen-${project.prjctColorCode }"></span>
						<h4 class="card-title fw-semibold mx-3">${project.prjctNm }</h4>
					</div>
					<ul class="nav nav-underline" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<a class="nav-link active" id="main-task-gantt-tab" data-bs-toggle="tab" href="#main-task-gantt" role="tab" aria-controls="main-task-gantt" aria-expanded="true" aria-selected="true">
								<span>간트차트</span>
							</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="main-task-list-tab" data-bs-toggle="tab" href="#main-task-list" role="tab" aria-controls="main-task-list" aria-selected="false" tabindex="-1">
								<span>리스트</span>
							</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="main-task-cal-tab" data-bs-toggle="tab" href="#main-task-cal" role="tab" aria-controls="main-task-cal" aria-selected="false" tabindex="-1">
								<span>캘린더</span>
							</a>
						</li>
					</ul>
				</div>
				<div role="tabpanel" class="tab-pane fade show active" id="main-task-gantt" aria-labelledby="main-task-gantt-tab">
					<img alt="" class="img-fluid" src="${pageContext.request.contextPath }/resources/project/images/logo/project.PNG">
				</div>
			</div>
		</div>
	</div>
	<!-- /업무 현황 -->

	<!-- 뉴스 시작 (이영주) -->
	<div class="grid-stack-item" gs-x="6" gs-y="2" gs-w="4" gs-h="2" id="A106">
		<div class="card grid-stack-item-content">
			<div class="card-body">
				<div class="col-12">
					<div class="d-flex justify-content-center align-items-center">
						<h5 class="card-title mb-9 fw-semibold" style="flex: 1;">오늘의 뉴스</h5>
						<button id="keywordBtn" class="btn rounded-0 mb-9" style="border: 1px solid #ddd; font-size: 0.8rem;">키워드 설정</button>
					</div>
					<div id="newsDiv">
						<input type="hidden" id="newsEstbsNo" value="${selectEstbsValue.estbsNo }">
						<c:choose>
							<c:when test="${not empty newsItems}">
								<c:forEach var="newsItem" items="${newsItems}" varStatus="status" begin="0" end="4">
									<p class="fw-semibold mb-1 main-news">
										<a href="${newsItem.link }" target="_blank">
											<i class="fa-light fa-newspaper me-1"></i>
											<span class="main-news-title" id="main-news-title">${newsItem.title }</span>
										</a>
									</p>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p class="fw-semibold mb-1 main-news">
									<span class="main-news-title">키워드를 설정해주세요.</span>
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 뉴스 끝 -->

	<!-- 메일 시작 (최소희) -->
	<div class="grid-stack-item" gs-x="6" gs-y="4" gs-w="4" gs-h="2" id="A107">
		<div class="card grid-stack-item-content" style="overflow: hidden;">
			<div class="card-body">
				<div class="col-12">
					<h5 class="card-title fw-semibold">메일함</h5>
					<ul class="nav nav-underline nav-phils nav-justified" id="mailTab" role="tablist">
						<li class="nav-item" role="presentation">
							<a class="nav-link active" id="inbox-tab" data-bs-toggle="tab" href="#inbox-tab-list" role="tab" aria-controls="inbox-tab-list" aria-expanded="true" aria-selected="true">
								<span style="font-size: 13px;">받은메일함</span>
							</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="sent-tab" data-bs-toggle="tab" href="#sent-tab-list" role="tab" aria-controls="sent-tab-list" aria-selected="false" tabindex="-1">
								<span style="font-size: 13px;">보낸메일함</span>
							</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="important-tab" data-bs-toggle="tab" href="#important-tab-list" role="tab" aria-controls="important-tab-list" aria-selected="false" tabindex="-1">
								<span style="font-size: 13px;">중요메일함</span>
							</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="noread-tab" data-bs-toggle="tab" href="#noread-tab-list" role="tab" aria-controls="noread-tab-list" aria-selected="false" tabindex="-1">
								<span style="font-size: 13px;">안읽은메일함</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="table-responsive">
					<div class="tab-content tabcontent-border pt-1 px-3" id="mailTabContent">
						<div role="tabpanel" class="tab-pane fade show active" id="inbox-tab-list" aria-labelledby="inbox-tab">
							<div id="inbox-tab-content">
								<table class="table table-borderless table-hover align-middle">
									<c:choose>
										<c:when test="${empty emailList }">
											<tr>
												<td colspan="4">해당 메일함에 메일이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${emailList}" var="email" varStatus="loop">
												<c:if test="${loop.index < 4}">
													<tr>
														<td>${email.senderNm}</td>
														<td><a href="/mail/detail?emailNo=${email.emailNo}&where=inbox">${email.emailNm}</a></td>
														<td><fmt:formatDate value="${email.emailTrnsmis}" pattern="hh:mm" /></td>
													</tr>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="sent-tab-list" role="tabpanel" aria-labelledby="sent-tab">
							<div id="sent-tab-content">
								<table class="table table-borderless table-hover align-middle">
									<c:choose>
										<c:when test="${empty sentList }">
											<tr>
												<td colspan="4">해당 메일함에 메일이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${sentList}" var="email" varStatus="loop">
												<c:if test="${loop.index < 4}">
													<tr>
														<td>${email.employeeVO.emplNm}</td>
														<td><a href="/mail/detail?emailNo=${email.emailNo}&where=sent">${email.emailNm}</a></td>
														<td><fmt:formatDate value="${email.emailTrnsmis}" pattern="hh:mm" /></td>
													</tr>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="important-tab-list" role="tabpanel" aria-labelledby="important-tab">
							<div id="important-tab-content">
								<table class="table table-borderless table-hover align-middle">
									<c:choose>
										<c:when test="${empty importantList }">
											<tr>
												<td colspan="4">해당 메일함에 메일이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${importantList}" var="email" varStatus="loop">
												<c:if test="${loop.index < 4}">
													<tr>
														<td>${email.employeeVO.emplNm}</td>
														<td><a href="/mail/detail?emailNo=${email.emailNo}&where=important">${email.emailNm}</a></td>
														<td><fmt:formatDate value="${email.emailTrnsmis}" pattern="hh:mm" /></td>
													</tr>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="noread-tab-list" role="tabpanel" aria-labelledby="noread-tab">
							<div id="noread-tab-content">
								<table class="table table-borderless table-hover align-middle">
									<c:choose>
										<c:when test="${empty noReadList }">
											<tr>
												<td colspan="4">해당 메일함에 메일이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${noReadList}" var="email" varStatus="loop">
												<c:if test="${loop.index < 4}">
													<tr>
														<td>${email.senderNm}</td>
														<td><a href="/mail/detail?emailNo=${email.emailNo}&where=noRead">${email.emailNm}</a></td>
														<td><fmt:formatDate value="${email.emailTrnsmis}" pattern="hh:mm" /></td>
													</tr>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 메일 끝 -->

	<!-- 현재 날씨 시작 -->
	<div class="grid-stack-item" gs-x="10" gs-y="0" gs-w="2" gs-h="2" id="A108">
		<div class="card grid-stack-item-content">
			<div class="card-body p-4">
				<div class="mb-9">
					<h5 class="card-title fw-semibold">현재 날씨</h5>
					<p class="card-subtitle">대전 중구 오류동</p>
				</div>
				<div class="d-flex align-items-center justify-content-between">
					<div class="ms-2">
						<span class="display-3">
							<i class="ti ti-sun"></i>
						</span>
					</div>
					<div class="text-center">
						<h1>24°C</h1>
						<p>맑음</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 현재 날씨 끝 -->

	<!-- 예약 및 대여 시작 -->
	<div class="grid-stack-item" gs-x="10" gs-y="2" gs-w="2" gs-h="2" id="A109">
		<div class="card grid-stack-item-content">
			<div class="card-body">
				<h5 class="card-title fw-semibold">시설 및 비품 예약</h5>
				<div class="mt-2">
					<div class="fs-4 fw-semibold">
						<p class="m-0 mt-1 mb-1">회의실 예약</p>
						<p class="m-0 mt-1 mb-1">차량 예약</p>
						<p class="m-0 mt-1 mb-1">기타 기기</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 예약 및 대여 끝 -->

	<!-- 메모 시작 -->
	<div class="grid-stack-item" gs-x="10" gs-y="4" gs-w="2" gs-h="2" id="A110">
		<div class="card grid-stack-item-content" style="overflow: hidden;">
			<div class="card-body p-4">
				<div class="mb-9">
					<h5 class="card-title fw-semibold">메모</h5>
				</div>
				!! 매일매일 할일 !!<br /> - 업무 목록 확인<br /> - 메일 확인<br /> - 결재 목록 확인<br />
			</div>
		</div>
	</div>
	<!-- 메모 끝 -->
</div>

<div id="layoutModal" class="interactive-modal" style="z-index: 1;">
	<div class="container interactive-modal-content w-12">
		<div class="row">
			<div class="col-md-12" id="">
				<div class="card">
					<div class="card-header bg-dark">
						<div class="text-center">
							<span class="h5 fw-bold text-light">레이아웃 변경</span>
						</div>
					</div>
					<div class="card-body">
						<div class="row" id="checkboxArea"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 뉴스키워드 설정 모달 시작 -->
<div id="keywordModal" class="interactive-modal" style="z-index: 1;">
	<div class="container interactive-modal-content w-12">
		<div class="row">
			<div class="col-md-12" id="">
				<div class="card">
					<div class="card-header bg-dark">
						<div class="text-center">
							<span class="h5 fw-bold text-light">뉴스 키워드 설정</span>
						</div>
					</div>
					<div class="card-body">
						<div class="row" id="">
							<input type="text" class="form-control mb-3" id="keywordInput" placeholder="키워드입력" value="${selectEstbsValue.estbsCn }">
							<c:choose>
								<c:when test="${not empty selectEstbsValue.estbsCn}">
									<button class="btn btn-rounded btn-primary" id="updateNewsBtn">수정하기</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-rounded btn-primary" id="newsSettingBtn">설정하기</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 뉴스키워드 설정 모달 끝 -->

<!-- 구글 간트 차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/gridstack-all.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/main/main.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/index.global.min.js"></script>
<script>

const allCalendarList = JSON.parse('${allCalendarListJson}');
const comCalendarList = JSON.parse('${comCalendarListJson}');
const deptCalendarList = JSON.parse('${deptCalendarListJson}');
const emplCalendarList = JSON.parse('${emplCalendarListJson}');
const calendarEl = document.getElementById('calendar');

var selectedProject = `${project}`;
selectedProject = selectedProject.replaceAll(/\n/g, '');
var prjctNo = '${prjctNo}';

document.addEventListener('DOMContentLoaded', function() {
	var option = {
		cellHeight: 50,
		cellWidth: 50,
		disableOneColumnMode: true,
	};
	var grid = GridStack.init(option);
	
	var checkboxArea = $('#checkboxArea');
	var layoutModal = $('#layoutModal');
	var layoutBtn = $('#layoutBtn');
	var saveBtn = $('#saveBtn');
	
	let widgetList = JSON.parse('${widgetList}');
	for(let widget of widgetList) {
		let id = widget.widgCode;
		if(widget.useYn == 'N') {
			$('#'+id).hide();
		}
		let gridItem = document.getElementById(id);
		
		setTimeout(() => {
			grid.update(
				gridItem,
				{
					x : widget.widgX,
					y : widget.widgY,
					w : widget.widgW,
					h : widget.widgH
				}
			);
		}, 100);
	}
	
	layoutBtn.on('click', function() {
		createLayoutModal();
		toggleLayoutModal();
	});
	
	checkboxArea.on('change', 'input[type="checkbox"]', function() {
		let id = $(this).val();
		let obj = {
			emplNo : '${employee.emplNo}',
			widgCode : id,
		}
		
		if(!$(this).is(':checked')) {
			$('#'+id).hide('fast');
			obj.useYn = 'N';
		}else{
			$('#'+id).show('fast');
			obj.useYn = 'Y';
		}
		
		$.post('/widget/update', obj)
		.done(function (res) {});
	});
	
	saveBtn.on('click', function() {
		let objList = [];
		
		for(let widget of widgetList) {
			let widgCode = widget.widgCode;
			let node = getNodeById(widgCode);
			let obj = {
				emplNo : '${employee.emplNo}',
				widgCode : widget.widgCode,
				widgX : node.getAttribute('gs-x'),
				widgY : node.getAttribute('gs-y'),
				widgW : node.getAttribute('gs-w'),
				widgH : node.getAttribute('gs-h')
			}
			
			objList.push(obj);
		}
		
		console.log(objList);
		
		$.ajax({
			url: '/widget/save',
			type: 'post',
			data: JSON.stringify(objList),
			contentType: 'application/json; charset=UTF-8'
		})
		.done(function(res) {
			if(res == 'OK') {
				showToast('성공적으로 저장되었습니다!', 'success');
			}
		});
	});
	
	$(document).on('click', function(e) {
		if($(e.target).is(layoutModal)) {
			toggleLayoutModal();
		}
	})
	
	if (isLoginPage()) {
		location.replace('/');
	}
	
	function toggleLayoutModal() {
		layoutModal.toggleClass('show');
	}
	
	function createLayoutModal() {
		checkboxArea.html('');
		
		$.ajax({
			url: '/widget/read?emplNo=${employee.emplNo}',
			type: 'get',
			async: false,
		})
		.done(function(res) {
			widgetList = res;
		})
		
		for(let widget of widgetList) {
			let id = widget.widgCode;
			let attr = widget.useYn == 'Y' ? 'checked' : '';
			html = '<div class="d-flex justify-content-center align-items-center">';
			html += `<div class="col-lg-12 col-md-6 form-check form-switch py-2">`;
			if(id == 'A101'){
				html += `	<input class="form-check-input" type="checkbox" id="\${widget.widgEngName}" value="\${id}" \${attr} disabled>`;
			}else{
				html += `<input class="form-check-input" type="checkbox" id="\${widget.widgEngName}" value="\${id}" \${attr}>`;
			}
			html += `<label class="form-check-label font-weight-bold" for="\${widget.widgEngName}">\${widget.widgName}</label></div>`;
			html += '</div>';
			
			checkboxArea.append(html);
		}
	}
	
	function getNodeById(id) {
		return grid.getGridItems().find(node => node.id == id);
	}
	
	function isLoginPage() {
		let referrer = document.referrer;
	
		if (referrer.includes('login')) {
			return true;
		} else {
			return false;
		}
	}
	
	/* 04.19 뉴스 추가 이영주*/
	var keywordModal = $('#keywordModal');
	var keywordBtn = $('#keywordBtn');
	var newsSettingBtn = $('#newsSettingBtn');
	var keywordInput = $('#keywordInput');
	var updateNewsBtn = $('#updateNewsBtn');
	
	$(document).on('click', '#keywordBtn', function() {
    	toggleKeywordModal();
	});
	
	
	function toggleKeywordModal() {
		keywordModal.toggleClass('show');
	}
	
	newsSettingBtn.on('click', function() {
		
		var keyword = keywordInput.val().trim();
		if (keyword === '') {
			showToast('키워드를 입력해주세요!', 'error');
	        return;
	    }
		console.log(keyword);
		
		$.ajax({
			url: '/keywordSetting',
			type: 'post',
			data: JSON.stringify({estbsCn: keyword}),
			contentType: 'application/json; charset=UTF-8'
		})
		.done(function(res) {
			if(res == 'OK') {
				showToast('성공적으로 설정되었습니다!', 'success');
				location.reload();
				toggleKeywordModal();
				createNewsDiv();
			}
		});
	});
	
	$(document).on('click', '#updateNewsBtn', function() {
		var newsEstbsNo = $("#newsEstbsNo").val();
		var keyword = keywordInput.val().trim();
		if (keyword === '') {
			showToast('키워드를 입력해주세요!', 'error');
	        return;
	    }
		
		$.ajax({
			url: '/keywordUpdate',
			type: 'post',
			data: JSON.stringify({estbsCn: keyword,
								  estbsNo: newsEstbsNo	}),
			contentType: 'application/json; charset=UTF-8'
		})
		.done(function(res) {
			if(res == 'OK') {
				//showToast('성공적으로 수정되었습니다!', 'success');
				toggleKeywordModal();
				createNewsDiv();
			}
		});
	});
	
	function createNewsDiv(){
		
		var newsDiv = $('#newsDiv');
		newsDiv.html('');
		let html = '';
		$.ajax({
			url: '/createNewsList',
			type: 'get',
			async: false,
		})
		.done(function(res) {
			newsItems = res;
		})
		
		if (newsItems.length > 0) {
	        for (let newsItem of newsItems.slice(0, 5)) {
	            html += '<p class="fw-semibold mb-1 main-news">';
	            html += '    <a href="' + newsItem.link + '" target="_blank">';
	            html += '        <i class="fa-light fa-newspaper me-1"></i> <span class="main-news-title" id="main-news-title">' + newsItem.title + '</span>';
	            html += '    </a>';
	            html += '</p>';
	        }
    	} else {
	        html += '<p class="fw-semibold mb-1 main-news">';
	        html += '    <span class="main-news-title">키워드를 설정해주세요.</span>';
	        html += '</p>';
    	}
		newsDiv.append(html);
	}
	
	
	$(document).on('click', function(e) {
		if($(e.target).is(keywordModal)) {
			toggleKeywordModal();
		}
	})
	 
	/* 이영주 추가 끝 */
	
});


</script>