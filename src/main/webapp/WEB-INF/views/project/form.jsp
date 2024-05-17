<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/project/form.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/project/project_form.js"></script>

<div class="project-page-box row">
	<div class="col-yen-10 cal-nav">
		<div class="nav flex-column nav-pills mb-4 mb-md-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
				<c:if test="${status eq 'u' }">프로젝트 수정</c:if>
				<c:if test="${status ne 'u' }">
					<i class="fa-solid fa-plus"></i> 
					새 프로젝트
				</c:if>
			</a>
			<br />
			<a class="nav-link" id="v-pills-all-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="moveToMainPage();" role="tab" aria-controls="v-pills-home" aria-selected="false">
				 전체 프로젝트 </a>
		</div>
	</div>
	<div class="card project-input col-yen-50">
		<div class="card-body">
			<form action="/project/register" method="post" name="projectForm" class="form-horizontal row">
				<c:if test="${status eq 'u' }">
					<input type="hidden" id="status" value="u">
					<input type="hidden" id="prjctNo" value="${project.prjctNo }">
				</c:if>
				<c:if test="${status ne 'u' }">
					<input type="hidden" id="status" value="i">
				</c:if>
				<!-- 프로젝트 제목 -->
				<div class="project-input-title input-group align-items-center">
					<span id="btn-select-color" onclick="showColorModal()" class="side-stick yen-${project.prjctColorCode }"></span>
					<input name="prjctNm" id="input-title" value="${project.prjctNm }" type="text" class="form-control form-control-lg fs-8" placeholder="프로젝트 명">
				</div>
				<input type="hidden" id="bgrnColor" name="prjctColor" value="${project.prjctColorCode }">
				<button type="button" id="btn-color-modal" style="display: none;" class="btn" data-bs-toggle="modal" data-bs-target="#modal-project-color"></button>
				<!-- 모달 -->
				<div class="modal fade" id="modal-project-color" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" style="display: none;" aria-hidden="true">
					<div class="modal-dialog modal-select-color">
						<div class="modal-content">
							<div class="modal-header d-flex align-items-center">
								<h4 class="modal-title" id="myLargeModalLabel">색상</h4>
								<button id="btn-close-color-modal" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body row select-color">
								<div id="red" data-color="#FF595E" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-red" onclick="getColor(this)"></div>
								<div id="orange" data-color="#FF924C" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-orange" onclick="getColor(this)"></div>
								<div id="yellow" data-color="#FFCA3A" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-yellow" onclick="getColor(this)"></div>
								<div id="yellowgreen" data-color="#C5CA30" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-yellowgreen" onclick="getColor(this)"></div>
								<div id="green" data-color="#8AC926" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-green" onclick="getColor(this)"></div>
								<div id="bluegreen" data-color="#36949D" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-bluegreen" onclick="getColor(this)"></div>
								<div id="blue" data-color="#1982C4" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-blue" onclick="getColor(this)"></div>
								<div id="darkblue" data-color="#4267AC" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-darkblue" onclick="getColor(this)"></div>
								<div id="navy" data-color="#565AA0" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-navy" onclick="getColor(this)"></div>
								<div id="purple" data-color="#6A4C93" class="d-flex justify-content-center align-items-center color-circle round-40 rounded-circle yen-purple" onclick="getColor(this)"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- 모달 끝 -->

				<!-- 일정 시작 / 끝 -->
				<div id="selectDate" class="input-group align-items-center">
					<i id="project-detail-icon-cal-1" class="fa-regular fa-calendar fs-5 mb-0"></i> 
					<span class="wrap_date"> 
						<input id="bgnde" type="date" onchange="bgndeChanged()" class="form-control" name="schdulBgnde" 
							<c:if test="${status ne 'u' }">value="${now }"</c:if> 
							<c:if test="${status eq 'u' }">value="${bgnDateString }"</c:if> 
							min="${now }">
					</span> 
					<span style="margin-left: 10px; margin-right: 10px;"> - </span> 
					<span class="wrap_date"> 
						<input id="endde" type="date" onchange="enddeChanged()" class="form-control" name="schdulEndde" 
							<c:if test="${status ne 'u' }">value="${now }"</c:if> 
							<c:if test="${status eq 'u' }">value="${endDateString }"</c:if> 
							min="${now }">
					</span>
				</div>

				<!-- 참석자 -->
				<div class="input-group align-items-center ui-components gap-3" style="flex-wrap: nowrap;">
					<i class="fa-regular fa-user fs-5 mb-0"></i>
					<div id="attendee-box">
						<c:if test="${status ne 'u' }">
							<span class="atendee-elem mb-1 badge rounded-pill align-items-center" id="attendee-${loginUser.emplNo }"> ${loginUser.emplNm } </span>
						</c:if>
						<c:if test="${status eq 'u' }">
							<c:forEach var="attendee" items="${schedule.attendeeList }">
								<span onclick="removeAttendee(this)" class="atendee-elem mb-1 badge rounded-pill align-items-center" id="attendee-${attendee.emplNo}"> ${attendee.emplNm} - ${attendee.deptNm } <iconify-icon icon="carbon:close-filled"></iconify-icon>
								</span>
							</c:forEach>
						</c:if>
					</div>
					<button type="button" id="btn-orgtree-att" style="display: none;" class="btn" data-bs-toggle="modal" data-bs-target="#modal-orgtree-att" data-backdrop="false"></button>
					<a href="javascript:openOrgTree()">
						<i class="fa-regular fa-circle-plus"></i>
					</a>
				</div>
				
				


				<!-- 내용 -->
				<div class="input-group align-items-center form-text-area">
					<textarea id="projectCn" name="projectCn" class="form-control text-area" cols="10" placeholder="프로젝트 상세">${project.projectCn }</textarea>
				</div>
				<!-- 버튼 -->
				<div class="button-group align-items-center" style="display: flex;">
					<c:if test="${status ne 'u' }">
						<button id="btn-project-submit" type="button" onclick="check()" class="btn btn-info">등록</button>
					</c:if>
					<c:if test="${status eq 'u' }">
						<button id="btn-sproject-submit" type="button" onclick="check()" class="btn btn-info">수정</button>
					</c:if>
					<button id="btn-project-cancle" type="button" onclick="location.href = '/project'" class="btn btn-outline-info">취소</button>
					<p id="alert-notice"></p>
				</div>
			</form>
		</div>
	</div>


	<!-- 참석자 일정 -->
	<!-- 참석자 시간 -->
	<div class="col-yen-35"></div>
</div>
