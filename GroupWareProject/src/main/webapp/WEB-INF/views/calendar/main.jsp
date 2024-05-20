<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
.nav-pills .nav-link {
    border-radius: 0;
    margin-top: 2px;
    margin-bottom: 2px;
}
</style>

<!-- Import css Files -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/calendar/main.css" />

<div class="schedul-page-box row">
	<div class="col-yen-10 cal-nav mt-0" style="width: 12% !important;">
		<div class="px-2 pt-4 pb-3">
			<a href="/schedule">
				<h3 class="fw-semibold mb-8" style="margin-left: 10px;">
					<i class="fa-sharp fa-regular fa-calendar-week fa-fw fa"></i>&nbsp;&nbsp;일정
				</h3>
			</a>
		</div>
		<div class="nav flex-column nav-pills mb-4 mb-md-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="moveToFormPage();" role="tab" aria-controls="v-pills-home" aria-selected="false">
				<i class="fa-solid fa-plus"></i> 새 일정 등록 </a>
			<br/>
			<a class="nav-link active" id="v-pills-all-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getAllCal();" role="tab" aria-controls="v-pills-home" aria-selected="true">
				 전체 일정 보기 </a>
			<a class="nav-link" id="v-pills-my-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getMyCal();" role="tab" aria-controls="v-pills-profile" aria-selected="false"> 
				내 일정 </a>
			<a class="nav-link" id="v-pills-company-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getComCal();" role="tab" aria-controls="v-pills-settings" aria-selected="false"> 
				사내 일정 </a>
			<a class="nav-link" id="v-pills-team-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getDeptCal();" role="tab" aria-controls="v-pills-messages" aria-selected="false"> 
				부서 일정 </a>
			<c:choose>
				<c:when test="${projectList == null or fn:length(projectList) == 0 }">
					<a class="nav-link disabled" id="v-pills-project-tab" data-bs-toggle="pill" role="tab" aria-controls="v-pills-settings" aria-selected="false"> 
						프로젝트 </a>
				</c:when>
				<c:when test="${projectList != null and fn:length(projectList) > 0}">
					<a class="nav-link" id="v-pills-project-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getProCal();" role="tab" aria-controls="v-pills-settings" aria-selected="false"> 
						프로젝트 </a>
					<div class="nav flex-column nav-pills mb-4 mb-md-0" id="calendar-project-tab" role="tablist" aria-orientation="vertical" style="display: none; margin-left: 15px;">
						<a class="nav-link active" id="v-pills-all-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getProCal();" role="tab" aria-controls="v-pills-home" aria-selected="true">
							 전체</a>
						<c:forEach var="project" items="${projectList }">
							<a class="nav-link" id="v-pills-my-tab" data-prjct-no="${project.prjctNo }" data-bs-toggle="pill" href="javascript:void(0);" onclick="getAProCal(this);" role="tab" aria-controls="v-pills-profile" aria-selected="false"> 
								${project.prjctNm } </a>						
						</c:forEach>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>
	<div class="card col-yen-50" style="max-height: 750px; width: 48% !important;">
		<div>
			<div class="row gx-0">
				<div class="col-lg-12">
					<div class="p-4 calender-sidebar app-calendar">
						<div id="calendar"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 일정 상세 -->
	<div id="schedule-detail-info" class="card-body col-yen-30">
		<!-- 일정 제목 -->
		<div class="schedule-detail-title d-flex flex-row align-items-center">
			<div id="schedule-color-circle" class="round-20 rounded-circle"></div>
			<h2 id="schedule-detail-title-txt" class="fw-semibold my-4"></h2>
		</div>
		<div class="schedule-detail-content col">
			<!-- 일정 타입 -->
			<div class="schedule-detail-info-elem d-flex flex-row align-items-center">
				<i id="schedule-detail-icon-category" class="fa-regular fa-rectangle-list fs-5 mb-0 schedule-detail-icon"></i>
				<h6 id="schedule-detail-category-txt" class="mb-0 fs-4"></h6>
			</div>
			<!-- 일정 날짜 / 시작 시간 -->
			<div class="schedule-detail-info-elem d-flex flex-row align-items-center">
				<i id="schedule-detail-icon-cal-1" class="fa-regular fa-calendar fs-5 mb-0 schedule-detail-icon"></i>
				<h6 id="schedule-detail-time1-txt" class="mb-0 fs-4"></h6>
			</div>
			<!-- 일정 시간 / 끝 시간 -->
			<div class="schedule-detail-info-elem d-flex flex-row align-items-center">
				<i id="schedule-detail-icon-cal-2" class="fa-regular fa-calendar fs-5 mb-0 schedule-detail-icon"></i>
				<i id="schedule-detail-icon-time" class="fa-regular fa-clock fs-5 mb-0 schedule-detail-icon"></i>
				<h6 id="schedule-detail-time2-txt" class="mb-0 fs-4"></h6>
			</div>
			<!-- 일정 장소 -->
			<div class="schedule-detail-info-elem d-flex flex-row align-items-center">
				<i id="schedule-detail-icon-place" class="fa-light fa-location-dot fs-5 mb-0 schedule-detail-icon"></i>
				<h6 id="schedule-detail-place-txt" class="mb-0 fs-4"></h6>
			</div>
			<!-- 일정 참여자 -->
			<div class="schedule-detail-info-elem d-flex flex-row align-items-center">
				<i id="schedule-detail-icon-part" class="fa-regular fa-user fs-5 mb-0 schedule-detail-icon"></i>
				<div id="schedule-detail-attendee"></div>
			</div>
			<!-- 일정 내용 -->
			<div class="schedule-detail-info-elem schedule-detail-description d-flex flex-row" style="height: 375px;">
				<h6 id="schedule-detail-description-txt" class="mb-3 fs-4"></h6>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="button-group align-items-center" style="display: flex;">
			<button id="btn-schdul-mod" type="button" class="btn btn-info rounded-0 btn-cal" style="display: none;">수정</button>
			<button id="btn-schdul-del" type="button" class="btn btn-outline-info rounded-0 btn-cal" style="display: none;">삭제</button>
		</div>
		<form action="/schedule/modify" method="get" id="modForm" >
			<sec:csrfInput/>
			<input id="schdulNo-input" type="hidden" name="schdulNo"/>
		</form>
	</div>
</div>

<!-- Import Js Files -->
<script src="../../../resources/project/js/source/index.global.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/util/textarea_util.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/calendar/calendar_main.js"></script>
