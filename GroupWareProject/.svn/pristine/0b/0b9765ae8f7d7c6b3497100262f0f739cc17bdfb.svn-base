<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/calendar/form.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/util/textarea_util.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/calendar/calendar_form.js"></script>

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
			<a class="nav-link disabled" id="v-pills-my-tab" data-bs-toggle="pill" href="/schedule" role="tab" aria-controls="v-pills-profile" aria-selected="false"> 내 일정 </a>
			<a class="nav-link disabled" id="v-pills-team-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getDeptCal();" role="tab" aria-controls="v-pills-messages" aria-selected="false"> 부서 일정 </a>
			<a class="nav-link disabled" id="v-pills-project-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getProCal();" role="tab" aria-controls="v-pills-settings" aria-selected="false"> 프로젝트 </a>
			<a class="nav-link disabled" id="v-pills-company-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="getComCal();" role="tab" aria-controls="v-pills-settings" aria-selected="false"> 사내 일정 </a>
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
							<option value="C103" <c:if test="${schedule.schdulTypeCode eq 'C103' }">selected</c:if> >내 캘린더</option>
							<option value="C102" <c:if test="${schedule.schdulTypeCode eq 'C102' }">selected</c:if> >부서 일정</option>
							<option value="C104" <c:if test="${schedule.schdulTypeCode eq 'C104' }">selected</c:if> >프로젝트</option>
						</select>
					</div>
					<div id="select-cal-project-container" class="col-yen-30" <c:if test="${schedule.schdulTypeCode ne 'C104' }">style='display: none;'</c:if> >
						<select <c:if test="${status eq 'u' }">disabled</c:if> id="select-cal-project" name="psitnCode" class="form-control form-select" 
							data-placeholder="Choose a Category" tabindex="1" style="background: none;">
							<c:forEach items="${projectList }" var="project">
								<option value="${project.prjctNo }">${project.prjctNm }</option>
							</c:forEach>
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



				<!-- 참석자 -->
				<div class="input-group align-items-center ui-components gap-3" style="flex-wrap: nowrap;">
					<i class="fa-regular fa-user fs-5 mb-0"></i>
					<div id="attendee-box">
						<c:if test="${status ne 'u' }">
							<span class="atendee-elem mb-1 badge rounded-pill align-items-center" id="attendee-${loginUser.emplNo }"> ${loginUser.emplNm } </span>							
						</c:if>
						<c:if test="${status eq 'u' }">
							<c:forEach var="attendee" items="${schedule.attendeeList }">
								<span onclick="removeAttendee(this)" class="atendee-elem mb-1 badge rounded-pill align-items-center" id="attendee-${attendee.emplNo}"> 
									${attendee.emplNm} - ${attendee.deptNm } 
									<iconify-icon icon="carbon:close-filled"></iconify-icon>
								</span>														
							</c:forEach>
						</c:if>
					</div>
					<button type="button" id="btn-orgtree-att" style="display: none;" class="btn" data-bs-toggle="modal" data-bs-target="#modal-orgtree-att" data-backdrop="false"></button>
					<a href="javascript:openOrgTree()">
						<i class="fa-regular fa-circle-plus"></i>
					</a>
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
								<option value="세미나룸">세미나룸</option>
								<option value="프로젝트룸 1실">프로젝트룸 1실</option>
								<option value="프로젝트룸 2실">프로젝트룸 2실</option>
								<option value="대회의실">대회의실</option>
								<option value="일반 회의실">일반 회의실</option>
							</select>
						</div>
					</c:if>
					<c:if test="${status eq 'u' }">
						<input id="mySchdulPlace" class="form-control" type="text" value="${schedule.schdulPlace }" placeholder="장소를 입력하세요." id="example-text-input">	
					</c:if>
					
				</div>
				<c:if test="${status eq 'u' }">
					<p>회의실 예약 내역 수정은 예약 페이지에서 할 수 있습니다.</p>
				</c:if>
				<!-- 알림 -->
				<div class="input-group align-items-center">
					<i class="fa-regular fa-bell fs-5 mb-0"></i>
					<div class="col-yen-30">
						<select id="schdul-alarm" class="form-control form-select" data-placeholder="Choose a Category" tabindex="1">
							<option value="none">없음</option>
							<option value="10min">10분 전 알림</option>
							<option value="30min">30분 전 알림</option>
							<option value="1hour">1시간 전 알림</option>
							<option value="1day">1일 전 알림</option>
							<option value="2day">2일 전 알림</option>
							<option value="1week">일주일 전 알림</option>
							<option value="custom">직접 입력</option>
						</select>
					</div>
					<div class="col-yen-30" style="display: none;">
						<select class="form-control form-select" data-placeholder="Choose a Category" tabindex="1">
							<option value="before0">당일</option>
							<option value="before1">1일전</option>
							<option value="before2">2일전</option>
							<option value="before3">3일전</option>
							<option value="before4">4일전</option>
							<option value="before5">5일전</option>
							<option value="before6">6일전</option>
							<option value="before7">7일전</option>
						</select>
					</div>
				</div>
				<!-- 내용 -->
				<div class="input-group align-items-center form-text-area">
					<textarea id="schdulCn" name="schdulCn" class="form-control text-area" cols="10" placeholder="내용을 입력하세요." wrap="hard"></textarea>
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
					<p id="alert-notice"></p>
				</div>
			</form>
		</div>
	</div>


	<!-- 참석자 일정 -->
	<!-- 종일 -->
	<div class="attendees attendees-unavailable col-yen-35" data-attendees-schedule-wrapper="">
		<div>
			<div data-attendees-notice-el="" class="attendees_notice" style="">
				<div data-attendees-schedule-show-desc="" class="txt">종일 일정인 경우 참석자의 시간별 일정을 조회하실 수 없습니다.</div>
			</div>
		</div>
	</div>
	<!-- 참석자 시간 -->
	<div class="attendees attendees-available col-yen-35">
		<div>
			<div data-attendees-schedule-content="" class="attendees_contents">
				<div data-attendees-schedule-el="" class="attendees_hd">
					<div class="critical">
						<div class="tit">참석자 일정</div>
						<div class="current_date">
							<span data-attendees-selected-date="" id="selected-date" title="선택된 날짜" data-value="2024-05-17" class="date">05월 17일</span> <span class="prev-btn btn_ic_prev2" onclick="javascript:goPrevDay()" title="이전" data-attendees-route="previous"> <span class="ic ic_prev2"><i class="fa-solid fa-chevron-left"></i></span>
							</span> <span class="next-btn btn_ic_next2" onclick="javascript:goNextDay()" title="다음" data-attendees-route="next"> <span class="ic ic_next2"><i class="fa-solid fa-chevron-right"></i></span>
							</span>
						</div>
					</div>
					<div class="optional">
						<ul class="legend">
							<li><span class="set_time"></span> <span class="txt">설정시간</span></li>
							<li><span class="busy"></span> <span class="txt">일정있음</span></li>
						</ul>
					</div>
				</div>

				<div data-attendees-schedule-el="" class="att_schedule">
					<div class="att_schedule_hd">
						<div class="tit"></div>
						<div class="nav">
							<div class="tb_guide">
								<table>
									<tbody>
										<tr>
											<th>
												<div class="txt">08:00</div>
											</th>
											<th>
												<div class="txt">09:00</div>
											</th>
											<th>
												<div class="txt">10:00</div>
											</th>
											<th>
												<div class="txt">11:00</div>
											</th>
											<th>
												<div class="txt">12:00</div>
											</th>
											<th>
												<div class="txt">13:00</div>
											</th>
											<th>
												<div class="txt">14:00</div>
											</th>
											<th>
												<div class="txt">15:00</div>
											</th>
											<th>
												<div class="txt">16:00</div>
											</th>
											<th>
												<div class="txt">17:00</div>
											</th>
											<th>
												<div class="txt">18:00</div>
											</th>
											<th>
												<div class="txt">19:00</div>
											</th>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="tb_info">
								<table>
									<tbody>
										<tr>
											<th class="">
												<div class="txt">8</div>
											</th>
											<th class="">
												<div class="txt">9</div>
											</th>
											<th class="">
												<div class="txt">10</div>
											</th>
											<th class="">
												<div class="txt">11</div>
											</th>
											<th class="">
												<div class="txt">12</div>
											</th>
											<th class="">
												<div class="txt">13</div>
											</th>
											<th class="">
												<div class="txt">14</div>
											</th>
											<th class="">
												<div class="txt">15</div>
											</th>
											<th class="">
												<div class="txt">16</div>
											</th>
											<th class="">
												<div class="txt">17</div>
											</th>
											<th class="">
												<div class="txt">18</div>
											</th>
											<th class="">
												<div data-untime-19="" class="txt">19</div>
											</th>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div id="wrap_att_schedule_bd" data-attendees-schedule-user-contents="" class="wrap_att_schedule_bd">
						<!-- 설정/추천시간 -->
						<div data-attendees-selected-time="" class="att_schedul_line" style="height: 32px;">
							<!-- 인원 추가시 32px 증가 -->
							<div class="timeline">
								<div class="tb_guide guide_layer">
									<table>
										<tbody>
											<tr>
												<td class="">
													<!-- 선택 시간 -->
													<div data-set-time="" id="set-time" class="set_time" style="left: 400%; right: -400%; height: 0px; display: none;"></div>
													<!-- 추천 시간 -->
													<div class="recm_time" style="display: none">빈 시간</div>
												</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<c:if test="${status ne 'u' }">
							<div id="att_${loginUser.emplNo }" data-empl-no="${loginUser.emplNo }" class="att_schedule_bd">
								<div class="tit">
									<p>
										<span data-user-name="${loginUser.emplNm }" class="txt">${loginUser.emplNm }</span>
									</p>
								</div>
								<div class="timeline">
									<div class="tb_guide grid_layer">
										<!-- 배경 -->
										<table>
											<tbody>
												<tr data-attendees-tr="">
													<td>
														<div class="txt oclock o08">08:00</div>
														<div class="txt halfhour h08">08:30</div>
													</td>
													<td>
														<div class="txt oclock o09">09:00</div>
														<div class="txt halfhour h09">09:30</div>
													</td>
													<td>
														<div class="txt oclock o10">10:00</div>
														<div class="txt halfhour h10">10:30</div>
													</td>
													<td>
														<div class="txt oclock o11">11:00</div>
														<div class="txt halfhour h11">11:30</div>
													</td>
													<td>
														<div class="txt oclock o12 busy">12:00</div>
														<div class="txt halfhour h12 busy">12:30</div>
													</td>
													<td>
														<div class="txt oclock o13">13:00</div>
														<div class="txt halfhour h13">13:30</div>
													</td>
													<td>
														<div class="txt oclock o14">14:00</div>
														<div class="txt halfhour h14">14:30</div>
													</td>
													<td>
														<div class="txt oclock o15">15:00</div>
														<div class="txt halfhour h15">15:30</div>
													</td>
													<td>
														<div class="txt oclock o16 busy">16:00</div>
														<div class="txt halfhour h16 busy">16:30</div>
													</td>
													<td>
														<div class="txt oclock o17 busy">17:00</div>
														<div class="txt halfhour h17 busy">17:30</div>
													</td>
													<td>
														<div class="txt oclock o18">18:00</div>
														<div class="txt halfhour h18">18:30</div>
													</td>
													<td>
														<div class="txt oclock o19">19:00</div>
														<div class="txt halfhour h19">19:30</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>

				<ul data-attendees-schedule-el="" class="desc">
					<li>- 최대 50명까지의 참석자만 확인할 수 있습니다.</li>
					<li>- 상세일정은 확인할 수 없으며, 참석자의 일정 여부만 확인할 수 있습니다.</li>
					<li>- 오늘 이전의 일정은 확인할 수 없습니다.</li>
				</ul>

			</div>

			<div data-attendees-notice-el="" class="attendees_notice" style="display: none">
				<div data-attendees-schedule-show-desc="" class="txt">
					참석자, 설비의 빈 시간을 확인하고 <br>가장 알맞은 시간을 찾으세요.
				</div>
				<a data-attendees-schedule-show-btn="" class="btn_minor" data-role="button" data-bypass="">
					<span class="txt">참석자 일정 조회</span>
				</a>

			</div>
		</div>
	</div>
</div>

<script>
let schdulCn = '${schedule.schdulCn }';

if(schdulCn) {
	$('#schdulCn').val(replaceBrTagToNewLine(schdulCn));
}

</script>