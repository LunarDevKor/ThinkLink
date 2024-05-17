<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/calendar/form.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/admin/calendar/calendar_form.js"></script>

<div class="schedul-page-box row">
	<div class="col-yen-10 cal-nav">
		<div class="nav flex-column nav-pills mb-4 mb-md-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
				<c:if test="${status eq 'u' }">일정 수정</c:if>
				<c:if test="${status ne 'u' }">
					<i class="fa-solid fa-plus"></i> 
					새 일정 등록
				</c:if>
			</a>
			<br />
			<a class="nav-link" id="v-pills-all-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="moveToMainPage();" role="tab" aria-controls="v-pills-home" aria-selected="false"> 전체 일정 보기 </a>
		</div>
	</div>
	<div class="card schdul-input col-yen-50">
		<div class="card-body">
			<form action="/schedule/register" method="post" name="schdulForm" class="form-horizontal row">
			<c:if test="${status eq 'u' }">
				<input type="hidden" id="status" value="u">
				<input type="hidden" id="schdulNo" value="${schedule.schdulNo }">
			</c:if>
			<c:if test="${status ne 'u' }">
				<input type="hidden" id="status" value="i">
			</c:if>
			<!-- 일정 제목 -->
				<div class="schdul-input-title input-group align-items-center">
					<span id="btn-select-color" onclick="showColorModal()" class="side-stick yen-${schedule.schdulBgrnColor }"></span>
					<input name="schdulNm" id="input-title" value="${schedule.schdulNm }" type="text" class="form-control form-control-lg fs-8" placeholder="제목을 입력하세요.">
				</div>
				<input type="hidden" id="bgrnColor" name="schdulBgrnColor" value="${schedule.schdulBgrnColor }">
				<button type="button" id="btn-color-modal" style="display: none;" class="btn" data-bs-toggle="modal" data-bs-target="#modal-schedule-color"></button>
				<!-- 모달 -->
				<div class="modal fade" id="modal-schedule-color" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" style="display: none;" aria-hidden="true">
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
				<!-- 달력 카테고리 -->
				<div class="input-group align-items-center">
					<i class="fa-regular fa-rectangle-list fs-5 mb-0"></i>
					<div class="col-yen-30">
						<select <c:if test="${status eq 'u' }">disabled</c:if> id="select-cal-type" name="schdulTypeCode" onchange="schdulTypeChange()" class="form-control form-select" 
							data-placeholder="Choose a Category" tabindex="1" style="background: none;">
							<option value="C101" <c:if test="${schedule.schdulTypeCode eq 'C101' }">selected</c:if> >사내 일정</option>
						</select>
					</div>
				</div>

				<!-- 일정 시작 / 끝 -->
				<div id="selectDate" class="input-group align-items-center">
					<i id="schedule-detail-icon-cal-1" class="fa-regular fa-calendar fs-5 mb-0"></i> 
					<span class="wrap_date"> 
						<input id="bgnde" type="date" onchange="bgndeChanged()" class="form-control" name="schdulBgnde" 
							<c:if test="${status ne 'u' }">value="${now }"</c:if>
							<c:if test="${status eq 'u' }">value="${bgnDateString }"</c:if>
							 min="${now }">
					</span> 
					<span class="wrap_time"<c:if test="${schedule.alldayYn eq 'Y' }">style='display: none;'</c:if>> 
						<input class="timepicker form-control" name="schdulBgnt" id="bgntime" type="text" value="${bgnTimeString }">
					</span> 
					<span style="margin-left: 10px; margin-right: 10px;"> - </span> 
					<span class="wrap_date"> 
						<input id="endde" type="date" onchange="enddeChanged()" class="form-control" name="schdulEndde" 
							<c:if test="${status ne 'u' }">value="${now }"</c:if>
							<c:if test="${status eq 'u' }">value="${endDateString }"</c:if>
							min="${now }" >
					</span>
					<span class="wrap_time" <c:if test="${schedule.alldayYn eq 'Y' }">style='display: none;'</c:if> > 
						<input class="timepicker form-control" name="schdulEndt" id="endtime" value="${endTimeString }">
					</span>
					<div class="form-check form-check-inline">
						<input id="checkAllday" name="alldayYn" class="form-check-input" type="checkbox" value="allday" <c:if test="${schedule.alldayYn eq 'Y' }">checked="checked"</c:if>>
						<label class="form-check-label" for="inlineCheckbox1">종일</label>
					</div>
				</div>

				<!-- 장소 -->
				<div class="input-group align-items-center">
					<i class="fa-light fa-location-dot fs-5 mb-0"></i>
					<c:if test="${status ne 'u' }">
						<div class="col-yen-30">
							<select id="select-place-type" class="form-control form-select" onchange="placeTypeChange()" data-placeholder="Choose a Category" tabindex="1">
								<option value="text">직접 입력</option>
								<option value="meetingroom">회의실 예약</option>
							</select>
						</div>
						<div id="input-place-text-container" class="col-yen-30">
							<input id="mySchdulPlace" class="form-control" type="text" value="" placeholder="장소를 입력하세요." id="example-text-input">
						</div>
						<div id="select-meeting-room-container" class="col-yen-30" style="display: none;">
							<select id="select-meeting-room" class="form-control form-select" data-placeholder="Choose a Category" tabindex="1">
							</select>
						</div>
					</c:if>
					<c:if test="${status eq 'u' }">
						<input id="mySchdulPlace" class="form-control" type="text" value="${schedule.schdulPlace }" placeholder="장소를 입력하세요." id="example-text-input">	
					</c:if>
					
				</div>
				<!-- 내용 -->
				<div class="input-group align-items-center form-text-area">
					<textarea id="schdulCn" name="schdulCn" class="form-control text-area" cols="10" placeholder="내용을 입력하세요.">${schedule.schdulCn }</textarea>
				</div>
				<!-- 버튼 -->
				<div class="button-group align-items-center" style="display: flex;">
					<c:if test="${status ne 'u' }">
						<button id="btn-schdul-submit" type="button" onclick="check()" class="btn btn-info">등록</button>
					</c:if>
					<c:if test="${status eq 'u' }">
						<button id="btn-schdul-submit" type="button" onclick="check()" class="btn btn-info">수정</button>
					</c:if>
					<button id="btn-schdul-cancle" type="button" onclick="location.href = '/schedule'" class="btn btn-outline-info">취소</button>
					<button id="btn-schdul-cancle" type="button" onclick="setAdminCalDataForPresentation()" class="btn btn-outline-info">시연용 데이터</button>
					<p id="alert-notice"></p>
				</div>
			</form>
		</div>
	</div>

</div>

<script>
function setAdminCalDataForPresentation() {
	
	var data = `2024 워크샵
- 세부 사항은 공지를 확인해주세요.
- 워크샵 참석은 필수이며, 일정 조정이 필요한 경우 사전에 부서장에게 문의 바랍니다.
- 원활한 진행을 위해 사전 등록이 필요하며, 등록 기한은 2024년 5월 31일까지입니다.
- 기타 문의 사항은 인사팀으로 연락 주시기 바랍니다.`;
	
	$('#input-title').val('워크샵');
	$('#checkAllday').attr('checked','checked');
	$('#bgnde').val('2024-06-13');
	$('#endde').val('2024-06-14');
	$('#mySchdulPlace').val('회사 정문 집합 후 이동');
	$('#schdulCn').val(data);
	$('.wrap_time').hide();
}
</script>
