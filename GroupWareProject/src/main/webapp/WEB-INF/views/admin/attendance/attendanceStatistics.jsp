<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
td {
	text-align: left;
}

th {
	text-align: left;
}

/* 페이징 버튼의 글꼴 크기 조절 */
.dataTables_paginate .paginate_button {
	font-size: 15px; /* 원하는 크기로 조절 */
	margin: 0 0px; /* 원하는 간격으로 조절 */
	cursor: pointer;
}

#tbl_paginate {
	margin-bottom: 50px; /* 바텀 마진 크기 조절 */
}

#tbl {
	background-color: #CCCCCC !important; /* 회색 */
}

.table-responsive .dataTables_wrapper .dataTables_filter {
	margin-bottom: 0px;
}

.accordion-button {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.accordion-button span {
	flex: 1;
	text-align: center;
}

thead tr:first-child td {
	border-bottom: 1px solid #dee2e6;
}

.accordion-button:focus {
	box-shadow: none !important; /* 기존 속성 덮어쓰기 */
}

#scroll-long-outer-modal .modal-dialog {
	max-width: 75%;
	width: 75%; /* Optional: to set the initial width */
}
</style>

<!-- 메뉴 옆 오른쪽 구역 시작 -->
<div class="w-100">
	<div class="min-width-340">
		<div class="px-9 pt-4 pb-3">
			<a href="/admin/attendance/statistics">
				<h3 class="fw-semibold mb-4">
					<i class="fa-solid fa-user-group fa-fw fa"></i>
					근태 통계
				</h3>
			</a>
		</div>
		<!-- < 2024. 04 > -->
		<div class="position-relative text-center" style="margin-bottom: 30px">
			<h4>
				<a class="text-dark px-2 fs-5 bg-hover-primary nav-icon-hover position-relative" style="cursor: pointer;" onclick="previous()">
					<i class="fa-solid fa-chevron-left fa-xs"></i>
				</a>
				<span class="fw-semibold mb-8" id="baseDate" style="margin: 15px">&nbsp;${year}.${month}</span>
				<a class="text-dark px-2 fs-5 bg-hover-primary nav-icon-hover position-relative" style="cursor: pointer;" onclick="next()">
					<i class="fa-solid fa-chevron-right fa-xs"></i>
				</a>
			</h4>
		</div>
		<!-- < 2024.04 > -->

		<!-- 현황 테이블 -->
		<table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd; margin-top: 15px; margin-bottom: 40px;">
			<tr>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">출근 미체크</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">퇴근 미체크</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">지각</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">조퇴</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">결근</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">출장</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">외근</td>
				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">휴가</td>

			</tr>
			<tr>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${attendanceUnchecked }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${departureUnchecked }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${tardiness }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${earlyDeparture }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${absence }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${businessTrip }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${fieldWork }</td>
				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${vacation }</td>
			</tr>
		</table>
		<!-- 이번주 현황 테이블 -->

		<!-- 목록 다운로드 -->
		<div class="table-responsive border rounded-4">
			<table class="table table-hover text-center align-middle" id="tbl">
				<thead class="border-bottom text-start table-hover">
					<tr>
						<th>사원</th>
						<th>부서</th>
						<th>날짜</th>
						<th>출근</th>
						<th>퇴근</th>
						<th>결근</th>
						<th>특이사항</th>
						<th>연장근무</th>
						<th>야간근무</th>
						<th>휴일근무</th>
					</tr>
				</thead>
				<tbody id="tbody" class="border-bottom text-start table-hover">
					<c:choose>
						<c:when test="${empty allDataList}">
							<tr>
								<td colspan="10" style="text-align: center;">데이터가 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${allDataList}" var="dclzStatus">
								<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
								<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
								<tr id="detail" onclick="detailOpen(${dclzStatus.emplNo},'${dclzStatus.emplNm}','${dclzStatus.clsfNm}','${dclzStatus.deptNm}')" style="cursor: pointer;">
									<td>${dclzStatus.emplNm }&nbsp;&nbsp;${dclzStatus.clsfNm }</td>
									<td>${dclzStatus.deptNm }</td>
									<td>
										<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd(E)" />
									</td>
									<td>
										<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
									</td>
									<td>
										<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
									</td>
									<td>
										<c:choose>
											<c:when test="${empty dclzStatus.attendDt}">
									결근
								</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }', event)">${dclzStatus.dclzNm }</span>
									</td>
									<td>${dclzStatus.overTime }</td>
									<td>${dclzStatus.nightTime }</td>
									<td>${dclzStatus.holidayTime }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<!-- 목록 다운로드 -->
	</div>
</div>
<!-- 메뉴 옆 오른쪽 구역 끝 -->


<!-- 특이사항 모달 시작 -->
<div class="modal fade" id="vertical-center-modal" tabindex="-1" aria-labelledby="vertical-center-modal" data-bs-backdrop="false" aria-hidden="true">
	<div class="modal-dialog modal-dialg-centered">
		<div class="modal-content">
			<div class="modal-header d-flex align-items-center">
				<h4 class="modal-title" id="myLargeModalLabel">근태 특이사항</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body text-center" id="modalArea">
				<!-- newHtml -->
			</div>
			<div class="modal-footer" style="margin-top: -15px;">
				<button type="button" class="btn bg-danger-subtle text-danger  waves-effect text-start" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 모달 끝  -->

<!-- 디테일 모달 시작 -->
<div class="modal fade" id="scroll-long-outer-modal" data-bs-backdrop="false" data-bs-keyboard="false" tabindex="-1" aria-labelledby="scroll-long-outer-modal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg">
		<div class="modal-content">
			<div class="modal-header d-flex align-items-center">
				<h4 class="modal-title" id="myLargeModalLabelName">
					<!-- 라벨구역 -->
				</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 디테일 모달 내용 -->
				<div class="w-100">
					<div class="min-width-340">
						<h4 class="fw-semibold mb-8" style="margin-left: 0px">근태현황</h4>
						<br />
						<!-- < 2024. 04 > -->
						<div class="position-relative text-center" style="margin-bottom: 30px">
							<h4>
<!-- 								<a class="text-dark px-2 fs-5 bg-hover-primary nav-icon-hover position-relative" style="cursor: pointer;" onclick="previous()"> -->
<!-- 									<i class="fa-solid fa-chevron-left fa-xs"></i> -->
<!-- 								</a> -->
								<span class="fw-semibold mb-8" id="baseDate" style="margin: 15px">&nbsp;${year}.${month}</span>
<!-- 								<a class="text-dark px-2 fs-5 bg-hover-primary nav-icon-hover position-relative" style="cursor: pointer;" onclick="next()"> -->
<!-- 									<i class="fa-solid fa-chevron-right fa-xs"></i> -->
<!-- 								</a> -->
							</h4>
<!-- 							<button type="button" id="todayBtn" class="btn btn-sm btn-outline-primary">오늘</button> -->
						</div>
						<!-- < 2024.04 > -->

						<!-- 목록 다운로드 -->
						<table id="example" style="display:none;">
							<thead>
								<tr>
									<th>일자</th>
									<th>업무시작</th>
									<th>업무종료</th>
									<th>총 근무시간</th>
									<th>근무시간 상세 : 기본</th>
									<th>근무시간 상세 : 연장</th>
									<th>근무시간 상세 : 야간</th>
									<th>특이사항</th>
									<th>특이사항 시작일시</th>
									<th>특이사항 종료일시</th>
								</tr>
							</thead>
							<tbody id="downloadTbody">
								<!-- 엑셀 다운로드 구역 -->
							</tbody>
						</table>
						<!-- 목록 다운로드 -->

						<!-- 이번주 현황 테이블 -->
						<table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd; margin-top: 15px; margin-bottom: 40px;">
							<tr>
								<td style="padding: 4px; padding-top: 30px; text-align: center; color: black;">이번주 누적</td>
								<td style="padding: 4px; padding-top: 30px; text-align: center; color: black;">이번주 초과</td>
								<td style="padding: 4px; padding-top: 30px; text-align: center; color: black;">이번주 야간</td>
								<td style="padding: 4px; padding-top: 30px; text-align: center; color: grey;">이번달 누적</td>
								<td style="padding: 4px; padding-top: 30px; text-align: center; color: grey;">이번달 연장</td>
							</tr>
							<tr id="thisWeekArea">
								<!-- 이번주 현황 구역 -->
							</tr>
						</table>
						<!-- 이번주 현황 테이블 -->

						<!-- 1주차 ~ 6주차 -->
						<div class="accordion accordion-flush" id="accordionFlushExample" style="margin-bottom: 30px;">
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-heading1">
									<button class="accordion-button collapsed" type="button" id="accordionBtn1" data-bs-toggle="collapse" data-bs-target="#flush-collapse1" aria-expanded="false" aria-controls="flush-collapse1">
										<span style="float: left; font-size: 16px;"><b>1 주차</b></span> <span style="float: right; color: grey;" id="weekWorkTime1"><b>누적 근무시간 ${weekDefaultList.get(0) }</b> (초과 근무시간 ${weekOverList.get(0) })</span>
									</button>
								</h2>
								<div id="flush-collapse1" class="accordion-collapse collapse" aria-labelledby="flush-heading1">
									<div class="accordion-body">
										<table class="table table-borderless table-hover text-center align-middle">
											<thead>
												<tr>
													<td>일자</td>
													<td>출근</td>
													<td>퇴근</td>
													<td>총 근무시간</td>
													<td>근무시간 상세</td>
													<td>특이사항</td>
												</tr>
											</thead>
											<tbody id="modalTbody1">
												<!-- 1주차 구역 -->
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-heading2">
									<button class="accordion-button collapsed" type="button" id="accordionBtn2" data-bs-toggle="collapse" data-bs-target="#flush-collapse2" aria-expanded="false" aria-controls="flush-collapse2">
										<span style="float: left; font-size: 16px;"><b>2 주차</b></span> <span style="float: right; color: grey;" id="weekWorkTime2"><b>누적 근무시간 ${weekDefaultList.get(1) }</b> (초과 근무시간 ${weekOverList.get(1) })</span>
									</button>
								</h2>
								<div id="flush-collapse2" class="accordion-collapse collapse" aria-labelledby="flush-heading2">
									<div class="accordion-body">
										<table class="table table-borderless table-hover text-center align-middle">
											<thead>
												<tr>
													<td>일자</td>
													<td>업무시작</td>
													<td>업무종료</td>
													<td>총 근무시간</td>
													<td>근무시간 상세</td>
													<td>특이사항</td>
												</tr>
											</thead>
											<tbody id="modalTbody2">
												<!-- 2주차 구역 -->
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-heading3">
									<button class="accordion-button collapsed" type="button" id="accordionBtn3" data-bs-toggle="collapse" data-bs-target="#flush-collapse3" aria-expanded="false" aria-controls="flush-collapse3">
										<span style="float: left; font-size: 16px;"><b>3 주차</b></span> <span style="float: right; color: grey;" id="weekWorkTime3"><b>누적 근무시간 ${weekDefaultList.get(2) }</b> (초과 근무시간 ${weekOverList.get(2) })</span>
									</button>
								</h2>
								<div id="flush-collapse3" class="accordion-collapse collapse" aria-labelledby="flush-heading3">
									<div class="accordion-body">
										<table class="table table-borderless table-hover text-center align-middle">
											<thead>
												<tr>
													<td>일자</td>
													<td>업무시작</td>
													<td>업무종료</td>
													<td>총 근무시간</td>
													<td>근무시간 상세</td>
													<td>특이사항</td>
												</tr>
											</thead>
											<tbody id="modalTbody3">
												<!-- 3주차 구역 -->
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-heading4">
									<button class="accordion-button collapsed" id="accordionBtn4" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse4" aria-expanded="false" aria-controls="flush-collapse4">
										<span style="float: left; font-size: 16px;"><b>4 주차</b></span> <span style="float: right; color: grey;" id="weekWorkTime4"><b>누적 근무시간 ${weekDefaultList.get(3) }</b> (초과 근무시간 ${weekOverList.get(3) })</span>
									</button>
								</h2>
								<div id="flush-collapse4" class="accordion-collapse collapse" aria-labelledby="flush-heading4">
									<div class="accordion-body">
										<table class="table table-borderless table-hover text-center align-middle">
											<thead>
												<tr>
													<td>일자</td>
													<td>업무시작</td>
													<td>업무종료</td>
													<td>총 근무시간</td>
													<td>근무시간 상세</td>
													<td>특이사항</td>
												</tr>
											</thead>
											<tbody id="modalTbody4">
												<!-- 4주차 구역 -->
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="accordion-item" id="5th">
								<h2 class="accordion-header" id="flush-heading5">
									<button class="accordion-button collapsed" type="button" id="accordionBtn5" data-bs-toggle="collapse" data-bs-target="#flush-collapse5" aria-expanded="false" aria-controls="flush-collapse5">
										<span style="float: left; font-size: 16px;"><b>5 주차</b></span> <span style="float: right; color: grey;" id="weekWorkTime5"><b>누적 근무시간 ${weekDefaultList.get(4) }</b> (초과 근무시간 ${weekOverList.get(4) })</span>
									</button>
								</h2>
								<div id="flush-collapse5" class="accordion-collapse collapse" aria-labelledby="flush-heading5">
									<div class="accordion-body">
										<table class="table table-borderless table-hover text-center align-middle">
											<thead>
												<tr>
													<td>일자</td>
													<td>업무시작</td>
													<td>업무종료</td>
													<td>총 근무시간</td>
													<td>근무시간 상세</td>
													<td>특이사항</td>
												</tr>
											</thead>
											<tbody id="modalTbody5">
												<!-- 5주차 구역 -->
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- 1주차~6주차 -->
						<!-- 정상, 지각 -->
						<div style="margin-bottom: 50px;">
							<i class="fa-solid fa-circle fa-sm" style="color: #413e3e;"> 정상</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-circle fa-sm" style="color: #EC5301;"> 지각 </i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-circle fa-sm" style="color: #007bff;"> 조퇴 </i>
						</div>
					</div>
				</div>
				<!-- 메뉴 옆 오른쪽 구역 끝 -->

				<!-- 모달 속 모달 시작 -->
				<div class="modal fade" id="vertical-center-modal2" tabindex="-1" aria-labelledby="vertical-center-modal" data-bs-backdrop="false" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" style="width: 600px;">
						<div class="modal-content">
							<div class="modal-header d-flex align-items-center">
								<h4 class="modal-title" id="myLargeModalLabel">근태 특이사항</h4>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body text-center" id="modalArea2">
								<!-- newHtml -->
							</div>
							<div class="modal-footer" style="margin-top: -15px;">
								<button type="button" class="btn bg-danger-subtle text-danger  waves-effect text-start" data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 모달 속 모달 끝  -->
				<!-- 디테일 모달 내용 끝-->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn bg-danger-subtle text-danger  waves-effect text-start" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 디테일 모달 끝 -->

<script src="${pageContext.request.contextPath}/resources/vendor/js/apps/chat.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/js/datatable/datatable-advanced.init.js"></script>
<script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>

//yyyy-MM-dd(E)
function formatDateWithDay(timestamp) {
    var date = new Date(timestamp);
    var year = date.getFullYear();
    var month = ("0" + (date.getMonth() + 1)).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = daysOfWeek[date.getDay()];
    return year + "-" + month + "-" + day + "(" + dayOfWeek + ")";
}

//HH:mm:ss
function formatTime(timestamp) {
    var date = new Date(timestamp);
    var hours = ("0" + date.getHours()).slice(-2);
    var minutes = ("0" + date.getMinutes()).slice(-2);
    var seconds = ("0" + date.getSeconds()).slice(-2);
    return hours + ":" + minutes + ":" + seconds;
}

//yyyy-MM-dd HH:mm:ss
function formatDateTime(timestamp) {
    var date = new Date(timestamp);
    var year = date.getFullYear();
    var month = ("0" + (date.getMonth() + 1)).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    var hours = ("0" + date.getHours()).slice(-2);
    var minutes = ("0" + date.getMinutes()).slice(-2);
    var seconds = ("0" + date.getSeconds()).slice(-2);
    return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
}

//yyyy-MM-dd
function formatDateToYYYYMMDD(timestamp) {
	var date = new Date(timestamp);
    var year = date.getFullYear();
    var month = String(date.getMonth() + 1).padStart(2, '0');
    var day = String(date.getDate()).padStart(2, '0');
    return year + '-' + month + '-' + day;
}

//yyyy년 MM월 dd일 hh시 mm분 ss초
function formatDateToKorean(timestamp) {
	var date = new Date(timestamp);
    var year = date.getFullYear();
    var month = String(date.getMonth() + 1).padStart(2, '0');
    var day = String(date.getDate()).padStart(2, '0');
    var hours = String(date.getHours()).padStart(2, '0');
    var minutes = String(date.getMinutes()).padStart(2, '0');
    var seconds = String(date.getSeconds()).padStart(2, '0');
    return year + '년 ' + month + '월 ' + day + '일 ' + hours + '시 ' + minutes + '분 ' + seconds + '초';
}

//dd E
function formatDateToDayOfWeek(timestamp) {
	var date = new Date(timestamp);
    var dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
    var day = String(date.getDate()).padStart(2, '0');
    var dayIndex = date.getDay();
    var dayOfWeekString = dayOfWeek[dayIndex];
    return day + ' ' + dayOfWeekString;
}

function detailOpen(emplNo, emplNm, clsfNm, deptNm) {
	var year = '${year}'; 
	var month = '${month}';
	
	$("#myLargeModalLabelName").text(`\${deptNm} \${emplNm} \${clsfNm}`);
	
	   $.ajax({
	        url: '/admin/attendance/detail', 
	        type: 'POST', 
	        data: JSON.stringify({
	        	year: year,
	        	month: month,
	        	emplNo: emplNo
	        }),
	        contentType : "application/json;charset=utf-8",
	        success: function(res) {
	        console.log(res);
	        
	        // 엑셀 다운로드 테이블
	        var downloadTbodyHTML = "";
	        
	        for(let i = 0; i < res.allDataList.length; i++){
	        	
	        var dclzStatus = res.allDataList[i];
	        var timestamp1 = dclzStatus.date;
	        var timestamp2 = dclzStatus.attendDt;
	        var timestamp3 = dclzStatus.lvffcDt;
	        var timestamp4 = dclzStatus.beginDt;
	        var timestamp5 = dclzStatus.endDt;
	        var date = formatDateWithDay(timestamp1);
	        var attendDt = formatTime(timestamp2);
	        var lvffcDt = formatTime(timestamp3);
	        var beginDt = formatDateTime(timestamp4);
	        var endDt = formatDateTime(timestamp5);
	        
	        downloadTbodyHTML += '<tr>';
	        downloadTbodyHTML += '<th>';
	        downloadTbodyHTML += date;
	        downloadTbodyHTML += '</th>';
	        
	        	if(dclzStatus.attendDt == null || dclzStatus.attendDt =='') {
	        	
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        downloadTbodyHTML += '<td></td>';
		        	
		        }else {
		        	
		        downloadTbodyHTML += '<td>';
		        downloadTbodyHTML += attendDt;
		        downloadTbodyHTML += '</td>';
		        downloadTbodyHTML += '<td>';
		        downloadTbodyHTML += lvffcDt;
		        downloadTbodyHTML += '</td>';
		        downloadTbodyHTML += '<td>';
		        downloadTbodyHTML += '<b>'+ dclzStatus.defaultTime +'</b>';
		        downloadTbodyHTML += '</td>';
		        downloadTbodyHTML += '<td>'+ dclzStatus.defaultTime +'</td>';
		        downloadTbodyHTML += '<td>'+ dclzStatus.overTime +'</td>';
		        downloadTbodyHTML += '<td>'+ dclzStatus.nightTime +'</td>';
		        downloadTbodyHTML += '<td>'+ dclzStatus.dclzNm +'</td>';
		        downloadTbodyHTML += '<td>';
		        downloadTbodyHTML += beginDt;
		        downloadTbodyHTML += '</td>';
		        downloadTbodyHTML += '<td>';
		        downloadTbodyHTML += endDt;
		        downloadTbodyHTML += '</td>';
		        
		        }
	        
	        	downloadTbodyHTML += '</tr>';
	        
	        }

	        $("#downloadTbody").html(downloadTbodyHTML);
	        
	        //이번주 테이블
	        var thisWeekAreaHTML = "";
	        
	        thisWeekAreaHTML += '<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: #739ee8;">'+res.thisWeekDefault+'</td>';
	        thisWeekAreaHTML += '<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: #739ee8;">'+res.thisWeekOver+'</td>';
	        thisWeekAreaHTML += '<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: #739ee8;">'+res.thisNightOver+'</td>';
	        thisWeekAreaHTML += '<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: grey;">'+res.thisMonthDefault+'</td>';
	        thisWeekAreaHTML += '<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: grey;">'+res.thisMonthOver+'</td>';
	        
	        $("#thisWeekArea").html(thisWeekAreaHTML);
	        
	        //누적근무시간
	        var weekWorkTime1HTML ='<b>누적 근무시간 '+res.weekDefaultList[0]+'</b> (초과 근무시간'+ res.weekOverList[0]+')';
	        var weekWorkTime2HTML ='<b>누적 근무시간 '+res.weekDefaultList[1]+'</b> (초과 근무시간'+ res.weekOverList[1]+')';
	        var weekWorkTime3HTML ='<b>누적 근무시간 '+res.weekDefaultList[2]+'</b> (초과 근무시간'+ res.weekOverList[2]+')';
	        var weekWorkTime4HTML ='<b>누적 근무시간 '+res.weekDefaultList[3]+'</b> (초과 근무시간'+ res.weekOverList[3]+')';
	        var weekWorkTime5HTML ='<b>누적 근무시간 '+res.weekDefaultList[4]+'</b> (초과 근무시간'+ res.weekOverList[4]+')';
	        
	        $("#weekWorkTime1").html(weekWorkTime1HTML);
	        $("#weekWorkTime2").html(weekWorkTime2HTML);
	        $("#weekWorkTime3").html(weekWorkTime3HTML);
	        $("#weekWorkTime4").html(weekWorkTime4HTML);
	        $("#weekWorkTime5").html(weekWorkTime5HTML);
	        
	        //1~5주차 구역
			var modalTbody1HTML = "";
			var modalTbody2HTML = "";
			var modalTbody3HTML = "";
			var modalTbody4HTML = "";
			var modalTbody5HTML = "";
	        
			for(let i = 0; i < 7; i++){
				
				var dclzStatus = res.allDataList[i];
		        var timestamp1 = dclzStatus.date;
		        var timestamp2 = dclzStatus.attendDt;
		        var date2 = new Date(timestamp2);
		        var timestamp3 = dclzStatus.lvffcDt;
		        var date3 = new Date(timestamp3);
		        var timestamp4 = dclzStatus.beginDt;
		        var timestamp5 = dclzStatus.endDt;
		        var timestamp6 = res.today;
		        var dsDate = formatDateToYYYYMMDD(timestamp1); // yyyy-mm-dd
		        var date = formatDateToDayOfWeek(timestamp1); //01 월
		        var attendDt = formatTime(timestamp2);
		        var lvffcDt = formatTime(timestamp3);
		        var dsBegin = formatDateToKorean(timestamp4);
		        var dsEnd = formatDateToKorean(timestamp5);
		        var dsToday = formatDateToYYYYMMDD(timestamp6); // yyyy-mm-dd
				
				modalTbody1HTML += '<tr>';
				
				if(i == 5) {
					modalTbody1HTML += '<td style="color: grey;">';
				}else if(i == 6) {
					modalTbody1HTML += '<td style="color: #ff3838;">';
				}else{
					modalTbody1HTML += '<td>';
				}
				
				if(dsDate == dsToday) {
					modalTbody1HTML += '<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;">'+ date +'</span>';
				}else {
					modalTbody1HTML += date;
				}
				
				modalTbody1HTML += '</td>';
				
				if(dclzStatus.attendDt == null || dclzStatus.attendDt ==''){
					modalTbody1HTML += '<td colspan="4"></td>';
				}else {
					if(date2.getHours() >= 9) {
						modalTbody1HTML += '<td style="color: #EC5301;">';
					}else {
						modalTbody1HTML += '<td>';
					}
				
					modalTbody1HTML += attendDt;
					modalTbody1HTML += '</td>';
					
					if(date3.getHours() < 18) {
						modalTbody1HTML += '<td style="color: #007bff;">';
					}else {
						modalTbody1HTML += '<td>';
					}
					
					modalTbody1HTML += lvffcDt;
					modalTbody1HTML += '</td>';
					modalTbody1HTML += '<td>';
					modalTbody1HTML += '<b>'+ dclzStatus.defaultTime +'</b>';
					modalTbody1HTML += '</td>';
					modalTbody1HTML += '<td>기본 '+ dclzStatus.defaultTime +' / 연장 '+ dclzStatus.overTime +' / 야간 '+ dclzStatus.nightTime+ '</td>';
					}
				
				modalTbody1HTML += '<td>';
					if(dclzStatus.dclzNm != null && dclzStatus.dclzNm != '') {
						modalTbody1HTML += '<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular_modal(\'' + dclzStatus.dclzNm + '\', \'' + dsBegin + '\', \'' + dsEnd + '\')">' + dclzStatus.dclzNm + '</span>';
					}
				modalTbody1HTML += '</td>';
				modalTbody1HTML += '</tr>';
				}
			
			for(let i = 7; i < 14; i++){
				
				var dclzStatus = res.allDataList[i];
		        var timestamp1 = dclzStatus.date;
		        var timestamp2 = dclzStatus.attendDt;
		        var date2 = new Date(timestamp2);
		        var timestamp3 = dclzStatus.lvffcDt;
		        var date3 = new Date(timestamp3);
		        var timestamp4 = dclzStatus.beginDt;
		        var timestamp5 = dclzStatus.endDt;
		        var timestamp6 = res.today;
		        var dsDate = formatDateToYYYYMMDD(timestamp1); // yyyy-mm-dd
		        var date = formatDateToDayOfWeek(timestamp1); //01 월
		        var attendDt = formatTime(timestamp2);
		        var lvffcDt = formatTime(timestamp3);
		        var dsBegin = formatDateToKorean(timestamp4);
		        var dsEnd = formatDateToKorean(timestamp5);
		        var dsToday = formatDateToYYYYMMDD(timestamp6); // yyyy-mm-dd
				
				modalTbody2HTML += '<tr>';
				
				if(i == 12) {
					modalTbody2HTML += '<td style="color: grey;">';
				}else if(i == 13) {
					modalTbody2HTML += '<td style="color: #ff3838;">';
				}else{
					modalTbody2HTML += '<td>';
				}
				
				if(dsDate == dsToday) {
					modalTbody2HTML += '<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;">'+ date +'</span>';
				}else {
					modalTbody2HTML += date;
				}
				
				modalTbody2HTML += '</td>';
				
				if(dclzStatus.attendDt == null || dclzStatus.attendDt ==''){
					modalTbody2HTML += '<td colspan="4"></td>';
				}else {
					if(date2.getHours() >= 9) {
						modalTbody2HTML += '<td style="color: #EC5301;">';
					}else {
						modalTbody2HTML += '<td>';
					}
				
					modalTbody2HTML += attendDt;
					modalTbody2HTML += '</td>';
					
					if(date3.getHours() < 18) {
						modalTbody2HTML += '<td style="color: #007bff;">';
					}else {
						modalTbody2HTML += '<td>';
					}
					
					modalTbody2HTML += lvffcDt;
					modalTbody2HTML += '</td>';
					modalTbody2HTML += '<td>';
					modalTbody2HTML += '<b>'+ dclzStatus.defaultTime +'</b>';
					modalTbody2HTML += '</td>';
					modalTbody2HTML += '<td>기본 '+ dclzStatus.defaultTime +' / 연장 '+ dclzStatus.overTime +' / 야간 '+ dclzStatus.nightTime+ '</td>';
					}
				
					modalTbody2HTML += '<td>';
					if(dclzStatus.dclzNm != null && dclzStatus.dclzNm != '') {
						modalTbody2HTML += '<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular_modal(\'' + dclzStatus.dclzNm + '\', \'' + dsBegin + '\', \'' + dsEnd + '\')">' + dclzStatus.dclzNm + '</span>';
					}
					modalTbody2HTML += '</td>';
					modalTbody2HTML += '</tr>';
				}
				
			for(let i = 14; i < 21; i++){
				
				var dclzStatus = res.allDataList[i];
			    var timestamp1 = dclzStatus.date;
			    var timestamp2 = dclzStatus.attendDt;
			    var date2 = new Date(timestamp2);
			    var timestamp3 = dclzStatus.lvffcDt;
			    var date3 = new Date(timestamp3);
			    var timestamp4 = dclzStatus.beginDt;
			    var timestamp5 = dclzStatus.endDt;
			    var timestamp6 = res.today;
			    var dsDate = formatDateToYYYYMMDD(timestamp1); // yyyy-mm-dd
			    var date = formatDateToDayOfWeek(timestamp1); //01 월
			    var attendDt = formatTime(timestamp2);
			    var lvffcDt = formatTime(timestamp3);
			    var dsBegin = formatDateToKorean(timestamp4);
			    var dsEnd = formatDateToKorean(timestamp5);
			    var dsToday = formatDateToYYYYMMDD(timestamp6); // yyyy-mm-dd
				
				modalTbody3HTML += '<tr>';
				
				if(i == 19) {
					modalTbody3HTML += '<td style="color: grey;">';
				}else if(i == 20) {
					modalTbody3HTML += '<td style="color: #ff3838;">';
				}else{
					modalTbody3HTML += '<td>';
				}
				
				if(dsDate == dsToday) {
					modalTbody3HTML += '<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;">'+ date +'</span>';
				}else {
					modalTbody3HTML += date;
				}
				
				modalTbody3HTML += '</td>';
				
				if(dclzStatus.attendDt == null || dclzStatus.attendDt ==''){
					modalTbody3HTML += '<td colspan="4"></td>';
				}else {
					if(date2.getHours() >= 9) {
						modalTbody3HTML += '<td style="color: #EC5301;">';
					}else {
						modalTbody3HTML += '<td>';
					}
				
					modalTbody3HTML += attendDt;
					modalTbody3HTML += '</td>';
					
					if(date3.getHours() < 18) {
						modalTbody3HTML += '<td style="color: #007bff;">';
					}else {
						modalTbody3HTML += '<td>';
					}
					
					modalTbody3HTML += lvffcDt;
					modalTbody3HTML += '</td>';
					modalTbody3HTML += '<td>';
					modalTbody3HTML += '<b>'+ dclzStatus.defaultTime +'</b>';
					modalTbody3HTML += '</td>';
					modalTbody3HTML += '<td>기본 '+ dclzStatus.defaultTime +' / 연장 '+ dclzStatus.overTime +' / 야간 '+ dclzStatus.nightTime+ '</td>';
					}
				
					modalTbody3HTML += '<td>';
					if(dclzStatus.dclzNm != null && dclzStatus.dclzNm != '') {
						modalTbody3HTML += '<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular_modal(\'' + dclzStatus.dclzNm + '\', \'' + dsBegin + '\', \'' + dsEnd + '\')">' + dclzStatus.dclzNm + '</span>';
					}
					modalTbody3HTML += '</td>';
					modalTbody3HTML += '</tr>';
				}
				
			for(let i = 21; i < 28; i++){
				
				var dclzStatus = res.allDataList[i];
			    var timestamp1 = dclzStatus.date;
			    var timestamp2 = dclzStatus.attendDt;
			    var date2 = new Date(timestamp2);
			    var timestamp3 = dclzStatus.lvffcDt;
			    var date3 = new Date(timestamp3);
			    var timestamp4 = dclzStatus.beginDt;
			    var timestamp5 = dclzStatus.endDt;
			    var timestamp6 = res.today;
			    var dsDate = formatDateToYYYYMMDD(timestamp1); // yyyy-mm-dd
			    var date = formatDateToDayOfWeek(timestamp1); //01 월
			    var attendDt = formatTime(timestamp2);
			    var lvffcDt = formatTime(timestamp3);
			    var dsBegin = formatDateToKorean(timestamp4);
			    var dsEnd = formatDateToKorean(timestamp5);
			    var dsToday = formatDateToYYYYMMDD(timestamp6); // yyyy-mm-dd
				
				modalTbody4HTML += '<tr>';
				
				if(i == 26) {
					modalTbody4HTML += '<td style="color: grey;">';
				}else if(i == 27) {
					modalTbody4HTML += '<td style="color: #ff3838;">';
				}else{
					modalTbody4HTML += '<td>';
				}
				
				if(dsDate == dsToday) {
					modalTbody4HTML += '<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;">'+ date +'</span>';
				}else {
					modalTbody4HTML += date;
				}
				
				modalTbody4HTML += '</td>';
				
				if(dclzStatus.attendDt == null || dclzStatus.attendDt ==''){
					modalTbody4HTML += '<td colspan="4"></td>';
				}else {
					if(date2.getHours() >= 9) {
						modalTbody4HTML += '<td style="color: #EC5301;">';
					}else {
						modalTbody4HTML += '<td>';
					}
				
					modalTbody4HTML += attendDt;
					modalTbody4HTML += '</td>';
					
					if(date3.getHours() < 18) {
						modalTbody4HTML += '<td style="color: #007bff;">';
					}else {
						modalTbody4HTML += '<td>';
					}
					
					modalTbody4HTML += lvffcDt;
					modalTbody4HTML += '</td>';
					modalTbody4HTML += '<td>';
					modalTbody4HTML += '<b>'+ dclzStatus.defaultTime +'</b>';
					modalTbody4HTML += '</td>';
					modalTbody4HTML += '<td>기본 '+ dclzStatus.defaultTime +' / 연장 '+ dclzStatus.overTime +' / 야간 '+ dclzStatus.nightTime+ '</td>';
					}
				
				modalTbody4HTML += '<td>';
				if(dclzStatus.dclzNm != null && dclzStatus.dclzNm != '') {
					modalTbody4HTML += '<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular_modal(\'' + dclzStatus.dclzNm + '\', \'' + dsBegin + '\', \'' + dsEnd + '\')">' + dclzStatus.dclzNm + '</span>';
				}
				modalTbody4HTML += '</td>';
				modalTbody4HTML += '</tr>';
			}
				
			for(let i = 28; i < 35; i++){
				
				var dclzStatus = res.allDataList[i];
			    var timestamp1 = dclzStatus.date;
			    var timestamp2 = dclzStatus.attendDt;
			    var date2 = new Date(timestamp2);
			    var timestamp3 = dclzStatus.lvffcDt;
			    var date3 = new Date(timestamp3);
			    var timestamp4 = dclzStatus.beginDt;
			    var timestamp5 = dclzStatus.endDt;
			    var timestamp6 = res.today;
			    var dsDate = formatDateToYYYYMMDD(timestamp1); // yyyy-mm-dd
			    var date = formatDateToDayOfWeek(timestamp1); //01 월
			    var attendDt = formatTime(timestamp2);
			    var lvffcDt = formatTime(timestamp3);
			    var dsBegin = formatDateToKorean(timestamp4);
			    var dsEnd = formatDateToKorean(timestamp5);
			    var dsToday = formatDateToYYYYMMDD(timestamp6); // yyyy-mm-dd
				
				modalTbody5HTML += '<tr>';
				
				if(i == 33) {
					modalTbody5HTML += '<td style="color: grey;">';
				}else if(i == 34) {
					modalTbody5HTML += '<td style="color: #ff3838;">';
				}else{
					modalTbody5HTML += '<td>';
				}
				
				if(dsDate == dsToday) {
					modalTbody5HTML += '<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;">'+ date +'</span>';
				}else {
					modalTbody5HTML += date;
				}
				
				modalTbody5HTML += '</td>';
				
				if(dclzStatus.attendDt == null || dclzStatus.attendDt ==''){
					modalTbody5HTML += '<td colspan="4"></td>';
				}else {
					if(date2.getHours() >= 9) {
						modalTbody5HTML += '<td style="color: #EC5301;">';
					}else {
						modalTbody5HTML += '<td>';
					}
				
					modalTbody5HTML += attendDt;
					modalTbody5HTML += '</td>';
					
					if(date3.getHours() < 18) {
						modalTbody5HTML += '<td style="color: #007bff;">';
					}else {
						modalTbody5HTML += '<td>';
					}
					
					modalTbody5HTML += lvffcDt;
					modalTbody5HTML += '</td>';
					modalTbody5HTML += '<td>';
					modalTbody5HTML += '<b>'+ dclzStatus.defaultTime +'</b>';
					modalTbody5HTML += '</td>';
					modalTbody5HTML += '<td>기본 '+ dclzStatus.defaultTime +' / 연장 '+ dclzStatus.overTime +' / 야간 '+ dclzStatus.nightTime+ '</td>';
					}
				
				modalTbody5HTML += '<td>';
				if(dclzStatus.dclzNm != null && dclzStatus.dclzNm != '') {
					modalTbody5HTML += '<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular_modal(\'' + dclzStatus.dclzNm + '\', \'' + dsBegin + '\', \'' + dsEnd + '\')">' + dclzStatus.dclzNm + '</span>';
				}
				modalTbody5HTML += '</td>';
				modalTbody5HTML += '</tr>';
				}
			
			//6주차
			var sixthHTML = "";
			var modalTbody6HTML = "";
				
			if(res.allDataList.length > 35) {
				
				sixthHTML += '<div class="accordion-item">';
				sixthHTML += '    <h2 class="accordion-header" id="flush-heading6">';
				sixthHTML += '        <button class="accordion-button collapsed" type="button" id="accordionBtn6" data-bs-toggle="collapse" data-bs-target="#flush-collapse6" aria-expanded="false" aria-controls="flush-collapse5">';
				sixthHTML += '			<span style="float: left; font-size: 16px;"><b>6 주차</b></span> <span style="float: right; color: grey;" id="weekWorkTime6"><b>누적 근무시간 '+res.weekDefaultList[5]+'</b> (초과 근무시간'+ res.weekOverList[5]+')</span>';
				sixthHTML += '        </button>';
				sixthHTML += '    </h2>';
				sixthHTML += '    <div id="flush-collapse6" class="accordion-collapse collapse" aria-labelledby="flush-heading6">';
				sixthHTML += '        <div class="accordion-body">';
				sixthHTML += '            <table class="table table-borderless table-hover text-center align-middle">';
				sixthHTML += '                <thead>';
				sixthHTML += '                    <tr>';
				sixthHTML += '                        <td>일자</td>';
				sixthHTML += '                        <td>업무시작</td>';
				sixthHTML += '                        <td>업무종료</td>';
				sixthHTML += '                        <td>총 근무시간</td>';
				sixthHTML += '                        <td>근무시간 상세</td>';
				sixthHTML += '                        <td>특이사항</td>';
				sixthHTML += '                    </tr>';
				sixthHTML += '                </thead>';
				sixthHTML += '                <tbody id="modalTbody6">';
				sixthHTML += '                </tbody>';
				sixthHTML += '            </table>';
				sixthHTML += '        </div>';
				sixthHTML += '    </div>';
				sixthHTML += '</div>';
				
			for(let i = 35; i < 42; i++){
				
				var dclzStatus = res.allDataList[i];
			    var timestamp1 = dclzStatus.date;
			    var timestamp2 = dclzStatus.attendDt;
			    var date2 = new Date(timestamp2);
			    var timestamp3 = dclzStatus.lvffcDt;
			    var date3 = new Date(timestamp3);
			    var timestamp4 = dclzStatus.beginDt;
			    var timestamp5 = dclzStatus.endDt;
			    var timestamp6 = res.today;
			    var dsDate = formatDateToYYYYMMDD(timestamp1); // yyyy-mm-dd
			    var date = formatDateToDayOfWeek(timestamp1); //01 월
			    var attendDt = formatTime(timestamp2);
			    var lvffcDt = formatTime(timestamp3);
			    var dsBegin = formatDateToKorean(timestamp4);
			    var dsEnd = formatDateToKorean(timestamp5);
			    var dsToday = formatDateToYYYYMMDD(timestamp6); // yyyy-mm-dd
				
				modalTbody6HTML += '<tr>';
				
				if(i == 40) {
					modalTbody6HTML += '<td style="color: grey;">';
				}else if(i == 41) {
					modalTbody6HTML += '<td style="color: #ff3838;">';
				}else{
					modalTbody6HTML += '<td>';
				}
				
				if(dsDate == dsToday) {
					modalTbody6HTML += '<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;">'+ date +'</span>';
				}else {
					modalTbody6HTML += date;
				}
				
				modalTbody6HTML += '</td>';
				
				if(dclzStatus.attendDt == null || dclzStatus.attendDt ==''){
					modalTbody6HTML += '<td colspan="4"></td>';
				}else {
					if(date2.getHours() >= 9) {
						modalTbody6HTML += '<td style="color: #EC5301;">';
					}else {
						modalTbody6HTML += '<td>';
					}
				
					modalTbody6HTML += attendDt;
					modalTbody6HTML += '</td>';
					
					if(date3.getHours() < 18) {
						modalTbody6HTML += '<td style="color: #007bff;">';
					}else {
						modalTbody6HTML += '<td>';
					}
					
					modalTbody6HTML += lvffcDt;
					modalTbody6HTML += '</td>';
					modalTbody6HTML += '<td>';
					modalTbody6HTML += '<b>'+ dclzStatus.defaultTime +'</b>';
					modalTbody6HTML += '</td>';
					modalTbody6HTML += '<td>기본 '+ dclzStatus.defaultTime +' / 연장 '+ dclzStatus.overTime +' / 야간 '+ dclzStatus.nightTime+ '</td>';
					}
				
				modalTbody6HTML += '<td>';
				if(dclzStatus.dclzNm != null && dclzStatus.dclzNm != '') {
					modalTbody6HTML += '<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular_modal(\'' + dclzStatus.dclzNm + '\', \'' + dsBegin + '\', \'' + dsEnd + '\')">' + dclzStatus.dclzNm + '</span>';
				}
				modalTbody6HTML += '</td>';
				modalTbody6HTML += '</tr>';
				}
			
		        $('#5th').append(sixthHTML);
		        $("#modalTbody6").html(modalTbody6HTML);
			}
		        
		        $("#modalTbody1").html(modalTbody1HTML);
		        $("#modalTbody2").html(modalTbody2HTML);
		        $("#modalTbody3").html(modalTbody3HTML);
		        $("#modalTbody4").html(modalTbody4HTML);
		        $("#modalTbody5").html(modalTbody5HTML);
				
				$("#scroll-long-outer-modal").modal('show');
		        
	        }
	   });
	
}

// var todayBtn = $("#todayBtn");

// // 오늘 버튼
// todayBtn.on("click", function() {

// 	// 현재 날짜와 시간을 가져오는 Date 객체 생성
// 	var today = new Date();

// 	// 날짜 관련 정보 추출
// 	var year = today.getFullYear(); // 연도
// 	var month = today.getMonth() + 1; // 월 (0부터 시작하므로 1을 더해줌)
// 	$.ajax({
// 		url : "today",
// 		type : "get",
// 		success : function(num, status, xhr) {
// 			if (xhr.status === 200) {
// 				location.href = "status?year=" + year + "&month=" + month
// 						+ "&num=" + num;
// 			}
// 		}
// 	});
// });

// // 새 페이지에서 아코디언을 열도록 설정
// $(document).ready(function() {
// 	var num = new URLSearchParams(window.location.search).get('num');
// 	if (num) {
// 		$("#accordionBtn" + num).click();
// 	}
// });

function particular_modal(dclzNm, beginDt, endDt) {
	var modalArea2 = $("#modalArea2");
	var newHtml = `<h5><span class="mb-1 badge rounded-pill  bg-info-subtle text-info">\${dclzNm} 시작일시</span>&nbsp;&nbsp;&nbsp;&nbsp;\${beginDt}</h5>
		<h5><span class="mb-1 badge rounded-pill  bg-info-subtle text-info">\${dclzNm} 종료일시</span>&nbsp;&nbsp;&nbsp;&nbsp;\${endDt}</h5>`;
	modalArea2.html(newHtml);			
	$('#vertical-center-modal2').modal('show');
	
}

$(function() {
	let text = $('#tbody').text();
	if(!text.includes('존재하지')) {
		let table = new DataTable('#tbl', {
			buttons : [
				{
					extend : 'copy',
					text : '<i class="fa-duotone fa-copy"></i>&nbsp;&nbsp;클립보드 복사',
					title : 'ThinkLink ${year}.${month} 근태현황',
					className : 'justify-content-center btn mb-1 btn-outline-primary align-items-center',
					action: function (e, dt, button, config) {
		                showToast('클립보드에 복사가 되었습니다!', 'success');
					}
				},
				{
					extend : 'excel',
					text : '<i class="fa-duotone fa-arrow-down-to-line"></i>&nbsp;&nbsp;EXCEL',
					filename : 'ThinkLink_${year}.${month}_근태현황',
					title : 'ThinkLink ${year}.${month} 근태현황',
					className : 'justify-content-center btn mb-1 btn-outline-primary align-items-center'
				},

				{
					extend : 'print',
					text : '<i class="fa-duotone fa-print"></i>&nbsp;&nbsp;프린트',
					filename : 'ThinkLink ${year}.${month} 근태현황',
					title : 'ThinkLink ${year}.${month} 근태현황',
					className : 'justify-content-center btn mb-1 btn-outline-primary align-items-center'
				} ],
		header: false,		// 헤더 중복 방지
		autoFill: true,		// 자동 완성 활성화
        paging: true,        // 페이징 기능 활성화
        pagingType: 'full_numbers', // 페이지 타입 번호 + 이전/다음 
        searching: true,     // 검색 기능 활성화
        ordering: true,      // 정렬 기능 활성화
        info: false,           // 정보 표시 기능 활성화 (페이지 정보)
        responsive: false,	// 반응형 활성화
        stateSave: false,	// 저장 활성화
        dom: "<'row d-flex justify-content-end align-items-center my-2'<'col-md-8'B><'col-md-3'f><'col-md-1'l>>"+ // f 검색 l 페이지 사이즈 
        "t<'bottom d-flex justify-content-center align-items-center me-2'p>", // p 페이지네이션
        order: [
        	[2, 'desc'] // 날짜
        ],
        columnDefs: [
        	{
        		targets: -1,
        		className: 'order-column'
        	},
        	{ width : "10%", targets : 0},
        	{ width : "10%", targets : 1},
        	{ width : "10%", targets : 2},
        	{ width : "10%", targets : 3},
        	{ width : "10%", targets : 4},
        	{ width : "10%", targets : 5},
        	{ width : "10%", targets : 6},
        	{ width : "10%", targets : 7},
        	{ width : "10%", targets : 8},
        	{ width : "10%", targets : 9},
        ],
        language: {
            "lengthMenu": "_MENU_", // 한 페이지에 보여질 항목 수 변경
            "info": "", // 표시되는 항목 수와 범위 변경
            "infoEmpty": "", // 검색 결과가 없을 때 표시될 텍스트 변경
            "infoFiltered": "", // 검색 결과가 있는 경우 표시될 텍스트 변경
            "zeroRecords": function() {
                return '<div class="text-center fw-semibold">검색결과가 없습니다.</div>';
            },
            "search": '<i class="fa-solid fa-magnifying-glass fa-lg" style="color: #6190ff;"></i>&nbsp;&nbsp;', // 검색 입력란 라벨
            "searchPlaceholder": "검색어를 입력하세요", // 검색 입력란 라벨
            "loadingRecords": "잠시만 기다려주세요", // 로딩중 텍스트
            "paginate": {
                "first": '<i class="fa-sharp fa-regular fa-angles-left fa-fw"></i>', // 첫 페이지 버튼의 텍스트를 변경
                "last": '<i class="fa-sharp fa-regular fa-angles-right fa-fw"></i>', // 마지막 페이지 버튼의 텍스트 변경
                "next": '<i class="fa-sharp fa-regular fa-angle-right fa-fw"></i>', // 다음 페이지 버튼의 텍스트를 변경
                "previous": '<i class="fa-sharp fa-regular fa-angle-left fa-fw"></i>' // 이전 페이지 버튼의 텍스트를 변경
            }
        }
	})
}
	
	
	$('#example')
	.DataTable(
			{
				dom : 'Bfrtip',
				buttons : [
						{
							extend : 'copy',
							text : '<i class="fa-duotone fa-copy"></i>&nbsp;&nbsp;클립보드 복사',
							title : '${user.emplNm} ${year}.${month} 근태현황',
							className : 'justify-content-center btn mb-1 bg-primary-subtle text-primary align-items-center',
							action: function (e, dt, button, config) {
				                showToast('클립보드에 복사가 되었습니다!', 'success');
							}
						},
						{
							extend : 'excel',
							text : '<i class="fa-duotone fa-arrow-down-to-line"></i>&nbsp;&nbsp;EXCEL',
							filename : '${user.emplNm}_${year}.${month}_근태현황',
							title : '${user.emplNm} ${year}.${month} 근태현황',
							className : 'justify-content-center btn mb-1 bg-primary-subtle text-primary align-items-center'
						},

						{
							extend : 'print',
							text : '<i class="fa-duotone fa-print"></i>&nbsp;&nbsp;프린트',
							filename : '${user.emplNm} ${year}.${month} 근태현황',
							title : '${user.emplNm} ${year}.${month} 근태현황',
							className : 'justify-content-center btn mb-1 bg-primary-subtle text-primary align-items-center'
						} ],
				"paging" : false, // 페이지 정보 숨김
				"searching" : false, // 검색 기능 숨김
				"info" : false
			// 페이지 정보 표시 숨김
			});
});

	
function particular(dclzNm, beginDt, endDt, event) {
	event.stopPropagation(); // 부모요소 이벤트 막기
	var modalArea = $("#modalArea");
	var newHtml = `<h5><span class="mb-1 badge rounded-pill  bg-info-subtle text-info">\${dclzNm} 시작일시</span>&nbsp;&nbsp;&nbsp;&nbsp;\${beginDt}</h5>
		<h5><span class="mb-1 badge rounded-pill  bg-info-subtle text-info">\${dclzNm} 종료일시</span>&nbsp;&nbsp;&nbsp;&nbsp;\${endDt}</h5>`;
	modalArea.html(newHtml);			
	$('#vertical-center-modal').modal('show');
	
}

	// 이전달 < 버튼
	function previous() {
		var year = "${year}";
		var month = "${month}";

		year = parseInt(year);
		month = parseInt(month);

		if (month === 1) {
			year--;
			month = 12;
		} else {
			month--;
		}

		location.href = "statistics?year=" + year + "&month=" + month;
	}

	//다음달 > 버튼
	function next() {
		var year = "${year}";
		var month = "${month}";

		year = parseInt(year);
		month = parseInt(month);

		if (month === 12) {
			year++;
			month = 1;
		} else {
			month++;
		}

		location.href = "statistics?year=" + year + "&month=" + month;
	}

</script>