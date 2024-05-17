<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
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

td {
	text-align: left;
}
/* tr#th td { */
/*      text-align: center; */
/* } */
.btn.btn-sm.btn-outline-primary:hover {
	background-color: initial !important; /* 마우스 오버 시 색깔이 변하지 않도록 */
	color: #007bff !important;
}
</style>

<!-- 메뉴 옆 오른쪽 구역 시작 -->
<div class="card overflow-hidden chat-application" style="padding: 20px;">
	<div class="w-100">
		<div class="min-width-340">
			<div style="display: flex; align-items: center;">
				<h3 class="fw-semibold mb-8" style="margin-left: 10px; margin-top: 10px"><i class="fa-sharp fa-regular fa-briefcase fa-fw fa"></i>&nbsp;&nbsp;근태현황</h3>
			</div>
			<br />
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
				<button type="button" id="todayBtn" class="btn btn-sm btn-outline-primary">오늘</button>
			</div>
			<!-- < 2024.04 > -->

			<!-- 목록 다운로드 -->
			<table id="example" style="display: none;">
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
				<tbody>
					<c:forEach items="${allDataList}" var="dclzStatus">
						<tr>
							<th>
								<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd(E)" />
							</th>
							<c:choose>
								<c:when test="${empty dclzStatus.attendDt }">
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</c:when>
								<c:otherwise>
									<td>
										<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
									</td>
									<td>
										<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
									</td>
									<td>
										<b>${dclzStatus.defaultTime }</b>
									</td>
									<td>${dclzStatus.defaultTime }</td>
									<td>${dclzStatus.overTime }</td>
									<td>${dclzStatus.nightTime }</td>
									<td>${dclzStatus.dclzNm }</td>
									<td>
										<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td>
										<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
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
				<tr>
					<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: #739ee8;">${thisWeekDefault }</td>
					<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: #739ee8;">${thisWeekOver }</td>
					<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: #739ee8;">${thisNightOver }</td>
					<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: grey;">${thisMonthDefault }</td>
					<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px; color: grey;">${thisMonthOver }</td>
				</tr>
			</table>
			<!-- 이번주 현황 테이블 -->

			<!-- 1주차 ~ 6주차 -->
			<div class="accordion accordion-flush" id="accordionFlushExample" style="margin-bottom: 30px;">
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-heading1">
						<button class="accordion-button collapsed" type="button" id="accordionBtn1" data-bs-toggle="collapse" data-bs-target="#flush-collapse1" aria-expanded="false" aria-controls="flush-collapse1">
							<span style="float: left; font-size: 16px;"><b>1 주차</b></span> <span style="float: right; color: grey;"><b>누적 근무시간 ${weekDefaultList.get(0) }</b> (초과 근무시간 ${weekOverList.get(0) })</span>
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
								<tbody>
									<c:forEach items="${allDataList}" var="dclzStatus" begin="0" end="6" varStatus="stat">
										<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="dsToday" />
										<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd" var="dsDate" />
										<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
										<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
										<tr>
											<c:choose>
												<c:when test="${stat.index == 5}">
													<td style="color: grey;">
												</c:when>
												<c:when test="${stat.index == 6}">
													<td style="color: #ff3838;">
												</c:when>
												<c:otherwise>
													<td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${dsDate eq dsToday}">
													<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;"><fmt:formatDate value="${dclzStatus.date}" pattern="dd E" /></span>
												</c:when>
												<c:otherwise>
													<fmt:formatDate value="${dclzStatus.date}" pattern="dd E" />
												</c:otherwise>
											</c:choose>
											</td>
											<c:choose>
												<c:when test="${empty dclzStatus.attendDt }">
													<td colspan="4"></td>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${dclzStatus.attendDt.hours gt 9 || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes gt 0) || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes eq 0 && dclzStatus.attendDt.seconds gt 0)}">
															<td style="color: #EC5301;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
													</td>
													<c:choose>
														<c:when test="${dclzStatus.lvffcDt.hours lt 18 || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes lt 0) || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes eq 0 && dclzStatus.lvffcDt.seconds lt 0)}">
															<td style="color: #007bff;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
													</td>
													<td>
														<b>${dclzStatus.defaultTime }</b>
													</td>
													<td>
														<c:if test="${not empty dclzStatus.lvffcDt }">
												기본 ${dclzStatus.defaultTime } / 연장 ${dclzStatus.overTime } / 야간 ${dclzStatus.nightTime }
												</c:if>
													</td>
												</c:otherwise>
											</c:choose>
											<td>
												<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }')">${dclzStatus.dclzNm }</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-heading2">
						<button class="accordion-button collapsed" type="button" id="accordionBtn2" data-bs-toggle="collapse" data-bs-target="#flush-collapse2" aria-expanded="false" aria-controls="flush-collapse2">
							<span style="float: left; font-size: 16px;"><b>2 주차</b></span> <span style="float: right; color: grey;"><b>누적 근무시간 ${weekDefaultList.get(1) }</b> (초과 근무시간 ${weekOverList.get(1) })</span>
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
								<tbody>
									<c:forEach items="${allDataList}" var="dclzStatus" begin="7" end="13" varStatus="stat">
										<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="dsToday" />
										<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd" var="dsDate" />
										<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
										<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
										<tr>
											<c:choose>
												<c:when test="${stat.index == 12}">
													<td style="color: grey;">
												</c:when>
												<c:when test="${stat.index == 13}">
													<td style="color: #ff3838;">
												</c:when>
												<c:otherwise>
													<td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${dsDate eq dsToday}">
													<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;"><fmt:formatDate value="${dclzStatus.date}" pattern="dd E" /></span>
												</c:when>
												<c:otherwise>
													<fmt:formatDate value="${dclzStatus.date}" pattern="dd E" />
												</c:otherwise>
											</c:choose>
											</td>
											<c:choose>
												<c:when test="${empty dclzStatus.attendDt }">
													<td colspan="4"></td>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${dclzStatus.attendDt.hours gt 9 || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes gt 0) || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes eq 0 && dclzStatus.attendDt.seconds gt 0)}">
															<td style="color: #EC5301;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
													</td>
													<c:choose>
														<c:when test="${dclzStatus.lvffcDt.hours lt 18 || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes lt 0) || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes eq 0 && dclzStatus.lvffcDt.seconds lt 0)}">
															<td style="color: #007bff;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
													</td>
													<td>
														<b>${dclzStatus.defaultTime }</b>
													</td>
													<td>
														<c:if test="${not empty dclzStatus.lvffcDt }">
												기본 ${dclzStatus.defaultTime } / 연장 ${dclzStatus.overTime } / 야간 ${dclzStatus.nightTime }
												</c:if>
													</td>
												</c:otherwise>
											</c:choose>
											<td>
												<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }')">${dclzStatus.dclzNm }</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-heading3">
						<button class="accordion-button collapsed" type="button" id="accordionBtn3" data-bs-toggle="collapse" data-bs-target="#flush-collapse3" aria-expanded="false" aria-controls="flush-collapse3">
							<span style="float: left; font-size: 16px;"><b>3 주차</b></span> <span style="float: right; color: grey;"><b>누적 근무시간 ${weekDefaultList.get(2) }</b> (초과 근무시간 ${weekOverList.get(2) })</span>
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
								<tbody>
									<c:forEach items="${allDataList}" var="dclzStatus" begin="14" end="20" varStatus="stat">
										<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="dsToday" />
										<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd" var="dsDate" />
										<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
										<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
										<tr>
											<c:choose>
												<c:when test="${stat.index == 19}">
													<td style="color: grey;">
												</c:when>
												<c:when test="${stat.index == 20}">
													<td style="color: #ff3838;">
												</c:when>
												<c:otherwise>
													<td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${dsDate eq dsToday}">
													<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;"><fmt:formatDate value="${dclzStatus.date}" pattern="dd E" /></span>
												</c:when>
												<c:otherwise>
													<fmt:formatDate value="${dclzStatus.date}" pattern="dd E" />
												</c:otherwise>
											</c:choose>
											</td>
											<c:choose>
												<c:when test="${empty dclzStatus.attendDt }">
													<td colspan="4"></td>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${dclzStatus.attendDt.hours gt 9 || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes gt 0) || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes eq 0 && dclzStatus.attendDt.seconds gt 0)}">
															<td style="color: #EC5301;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
													</td>
													<c:choose>
														<c:when test="${dclzStatus.lvffcDt.hours lt 18 || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes lt 0) || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes eq 0 && dclzStatus.lvffcDt.seconds lt 0)}">
															<td style="color: #007bff;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
													</td>
													<td>
														<b>${dclzStatus.defaultTime }</b>
													</td>
													<td>
														<c:if test="${not empty dclzStatus.lvffcDt }">
												기본 ${dclzStatus.defaultTime } / 연장 ${dclzStatus.overTime } / 야간 ${dclzStatus.nightTime }
												</c:if>
													</td>
												</c:otherwise>
											</c:choose>
											<td>
												<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }')">${dclzStatus.dclzNm }</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-heading4">
						<button class="accordion-button collapsed" id="accordionBtn4" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse4" aria-expanded="false" aria-controls="flush-collapse4">
							<span style="float: left; font-size: 16px;"><b>4 주차</b></span> <span style="float: right; color: grey;"><b>누적 근무시간 ${weekDefaultList.get(3) }</b> (초과 근무시간 ${weekOverList.get(3) })</span>
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
								<tbody>
									<c:forEach items="${allDataList}" var="dclzStatus" begin="21" end="27" varStatus="stat">
										<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="dsToday" />
										<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd" var="dsDate" />
										<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
										<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
										<tr>
											<c:choose>
												<c:when test="${stat.index == 26}">
													<td style="color: grey;">
												</c:when>
												<c:when test="${stat.index == 27}">
													<td style="color: #ff3838;">
												</c:when>
												<c:otherwise>
													<td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${dsDate eq dsToday}">
													<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;"><fmt:formatDate value="${dclzStatus.date}" pattern="dd E" /></span>
												</c:when>
												<c:otherwise>
													<fmt:formatDate value="${dclzStatus.date}" pattern="dd E" />
												</c:otherwise>
											</c:choose>
											</td>
											<c:choose>
												<c:when test="${empty dclzStatus.attendDt }">
													<td colspan="4"></td>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${dclzStatus.attendDt.hours gt 9 || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes gt 0) || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes eq 0 && dclzStatus.attendDt.seconds gt 0)}">
															<td style="color: #EC5301;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
													</td>
													<c:choose>
														<c:when test="${dclzStatus.lvffcDt.hours lt 18 || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes lt 0) || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes eq 0 && dclzStatus.lvffcDt.seconds lt 0)}">
															<td style="color: #007bff;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
													</td>
													<td>
														<b>${dclzStatus.defaultTime }</b>
													</td>
													<td>
														<c:if test="${not empty dclzStatus.lvffcDt }">
												기본 ${dclzStatus.defaultTime } / 연장 ${dclzStatus.overTime } / 야간 ${dclzStatus.nightTime }
												</c:if>
													</td>
												</c:otherwise>
											</c:choose>
											<td>
												<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }')">${dclzStatus.dclzNm }</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="flush-heading5">
						<button class="accordion-button collapsed" type="button" id="accordionBtn5" data-bs-toggle="collapse" data-bs-target="#flush-collapse5" aria-expanded="false" aria-controls="flush-collapse5">
							<span style="float: left; font-size: 16px;"><b>5 주차</b></span> <span style="float: right; color: grey;"><b>누적 근무시간 ${weekDefaultList.get(4) }</b> (초과 근무시간 ${weekOverList.get(4) })</span>
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
								<tbody>
									<c:forEach items="${allDataList}" var="dclzStatus" begin="28" end="34" varStatus="stat">
										<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="dsToday" />
										<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd" var="dsDate" />
										<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
										<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
										<tr>
											<c:choose>
												<c:when test="${stat.index == 33}">
													<td style="color: grey;">
												</c:when>
												<c:when test="${stat.index == 34}">
													<td style="color: #ff3838;">
												</c:when>
												<c:otherwise>
													<td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${dsDate eq dsToday}">
													<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;"><fmt:formatDate value="${dclzStatus.date}" pattern="dd E" /></span>
												</c:when>
												<c:otherwise>
													<fmt:formatDate value="${dclzStatus.date}" pattern="dd E" />
												</c:otherwise>
											</c:choose>
											</td>
											<c:choose>
												<c:when test="${empty dclzStatus.attendDt }">
													<td colspan="4"></td>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${dclzStatus.attendDt.hours gt 9 || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes gt 0) || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes eq 0 && dclzStatus.attendDt.seconds gt 0)}">
															<td style="color: #EC5301;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
													</td>
													<c:choose>
														<c:when test="${dclzStatus.lvffcDt.hours lt 18 || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes lt 0) || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes eq 0 && dclzStatus.lvffcDt.seconds lt 0)}">
															<td style="color: #007bff;">
														</c:when>
														<c:otherwise>
															<td>
														</c:otherwise>
													</c:choose>
													<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
													</td>
													<td>
														<b>${dclzStatus.defaultTime }</b>
													</td>
													<td>
														<c:if test="${not empty dclzStatus.lvffcDt }">
												기본 ${dclzStatus.defaultTime } / 연장 ${dclzStatus.overTime } / 야간 ${dclzStatus.nightTime }
												</c:if>
													</td>
												</c:otherwise>
											</c:choose>
											<td>
												<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }')">${dclzStatus.dclzNm }</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<c:if test="${allDataList.size() > 35 }">
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-heading6">
							<button class="accordion-button collapsed" type="button" id="accordionBtn6" data-bs-toggle="collapse" data-bs-target="#flush-collapse6" aria-expanded="false" aria-controls="flush-collapse5">
								<span style="float: left; font-size: 16px;"><b>6 주차</b></span> <span style="float: right; color: grey;"><b>누적 근무시간 ${weekDefaultList.get(5) }</b> (초과 근무시간 ${weekOverList.get(5) })</span>
							</button>
						</h2>
						<div id="flush-collapse6" class="accordion-collapse collapse" aria-labelledby="flush-heading6">
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
									<tbody>
										<c:forEach items="${allDataList}" var="dclzStatus" begin="35" end="41" varStatus="stat">
											<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="dsToday" />
											<fmt:formatDate value="${dclzStatus.date}" pattern="yyyy-MM-dd" var="dsDate" />
											<fmt:formatDate value="${dclzStatus.beginDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsBegin" />
											<fmt:formatDate value="${dclzStatus.endDt}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" var="dsEnd" />
											<tr>
												<c:choose>
													<c:when test="${stat.index == 40}">
														<td style="color: grey;">
													</c:when>
													<c:when test="${stat.index == 41}">
														<td style="color: #ff3838;">
													</c:when>
													<c:otherwise>
														<td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${dsDate eq dsToday}">
														<span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="margin-left: -10px;"><fmt:formatDate value="${dclzStatus.date}" pattern="dd E" /></span>
													</c:when>
													<c:otherwise>
														<fmt:formatDate value="${dclzStatus.date}" pattern="dd E" />
													</c:otherwise>
												</c:choose>
												</td>
												<c:choose>
													<c:when test="${empty dclzStatus.attendDt }">
														<td colspan="4"></td>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${dclzStatus.attendDt.hours gt 9 || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes gt 0) || (dclzStatus.attendDt.hours eq 9 && dclzStatus.attendDt.minutes eq 0 && dclzStatus.attendDt.seconds gt 0)}">
																<td style="color: #EC5301;">
															</c:when>
															<c:otherwise>
																<td>
															</c:otherwise>
														</c:choose>
														<fmt:formatDate value="${dclzStatus.attendDt}" pattern="HH:mm:ss" />
														</td>
														<c:choose>
															<c:when test="${dclzStatus.lvffcDt.hours lt 18 || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes lt 0) || (dclzStatus.lvffcDt.hours eq 18 && dclzStatus.lvffcDt.minutes eq 0 && dclzStatus.lvffcDt.seconds lt 0)}">
																<td style="color: #007bff;">
															</c:when>
															<c:otherwise>
																<td>
															</c:otherwise>
														</c:choose>
														<fmt:formatDate value="${dclzStatus.lvffcDt}" pattern="HH:mm:ss" />
														</td>
														<td>
															<b>${dclzStatus.defaultTime }</b>
														</td>
														<td>
															<c:if test="${not empty dclzStatus.lvffcDt }">
												기본 ${dclzStatus.defaultTime } / 연장 ${dclzStatus.overTime } / 야간 ${dclzStatus.nightTime }
												</c:if>
														</td>
													</c:otherwise>
												</c:choose>
												<td>
													<span class="mb-1 badge rounded-pill  bg-info-subtle text-info" style="cursor: pointer;" onclick="particular('${dclzStatus.dclzNm }','${dsBegin }','${dsEnd }')">${dclzStatus.dclzNm }</span>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
			</div>
			<!-- 1주차~5주차 -->
			<!-- 정상, 지각 -->
			<div style="margin-bottom: 50px;">
				<i class="fa-solid fa-circle fa-sm" style="color: #413e3e;"> 정상</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-circle fa-sm" style="color: #EC5301;"> 지각 </i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-circle fa-sm" style="color: #007bff;"> 조퇴 </i>
			</div>
		</div>
	</div>
</div>
<!-- 메뉴 옆 오른쪽 구역 끝 -->


<!-- 모달 시작 -->
<div class="modal fade" id="vertical-center-modal" tabindex="-1" aria-labelledby="vertical-center-modal" data-bs-backdrop="false" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
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
	$(function() {
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
	})
	
function particular(dclzNm, beginDt, endDt) {
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

		location.href = "status?year=" + year + "&month=" + month;
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

		location.href = "status?year=" + year + "&month=" + month;
	}

	var todayBtn = $("#todayBtn");

	// 오늘 버튼
	todayBtn.on("click", function() {

		// 현재 날짜와 시간을 가져오는 Date 객체 생성
		var today = new Date();

		// 날짜 관련 정보 추출
		var year = today.getFullYear(); // 연도
		var month = today.getMonth() + 1; // 월 (0부터 시작하므로 1을 더해줌)
		$.ajax({
			url : "today",
			type : "get",
			success : function(num, status, xhr) {
				if (xhr.status === 200) {
					location.href = "status?year=" + year + "&month=" + month
							+ "&num=" + num;
				}
			}
		});
	});

	// 새 페이지에서 아코디언을 열도록 설정
	$(document).ready(function() {
		var num = new URLSearchParams(window.location.search).get('num');
		if (num) {
			$("#accordionBtn" + num).click();
		}
	});
</script>