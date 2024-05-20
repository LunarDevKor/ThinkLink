<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/approval/approval-form.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/dropzone.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/themes/default/style.min.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/documents/docStyle.css"> --%>

<style>
.swal2-container {
	z-index: 20000 !important;
}

input:focus {
	outline: none;
}

textarea:focus {
	outline: none;
}

.jstree-themeicon-custom {
	background-size: contain !important;
	border-radius: 50% !important;
	margin-right: 8px !important;
}
</style>
<div class="card rounded-0 flex-fill">
	<div class="m-3 ms-4">
		<h3 class="m-0">업무 기안</h3>
	</div>
	<div class="d-flex justify-content-start align-items-center border-bottom">
		<div class="ms-4 py-3">
			<a href="#" class="ms-3 fa-active" id="draft">
				<i class="fa-light fa-pen-to-square fa-xl fa-fw fa fw-semibold"></i> <span class="fw-semibold">결재요청</span>
			</a>
			<a href="#" class="ms-3 fa-active" id="info">
				<i class="fa-light fa-circle-info fa-xl fa-fw fa"></i> <span>결재정보</span>
			</a>
			<a href="#" class="ms-3 fa-active" id="tempsave">
				<i class="fa-light fa-arrow-down-to-square fa-xl fa-fw fa"></i> <span>임시저장</span>
			</a>
			<a href="#" class="ms-3 fa-active" id="preview">
				<i class="fa-light fa-eye fa-xl fa-fw fa"></i> <span>미리보기</span>
			</a>
			<a href="#" class="ms-3 fa-active" id="cancel">
				<i class="fa-light fa-circle-xmark fa-xl fa-fw fa"></i> <span>취소</span>
			</a>
		</div>
		<div class="ms-auto me-4">
			<button class="btn rounded-0" style="border: 1px solid #ddd;" id="testBtn">시연용 버튼</button>
		</div>
		<a href="#" class="me-4 fa-active" id="main">
			<i class="fa-light fa-bars fa-xl fa-fw fa"></i> <span>목록</span>
		</a>
	</div>
	<div class="card-body rounded-0 p-0">
		<div class="row">
			<div class="col-lg-9">
				<div class="mx-5 my-4 p-3 border border-4" style="border-color: #999;">
					<div class="approval_import ie9-scroll-fix">
						<!-- 문서 내용 표시 테스트 -->
						<div id="aprovlCn" class="form_doc_editor editor_view" onsubmit="return false;">
							<c:if test="${not empty approvalVO }">
								${approvalVO.aprovlCn }
							</c:if>
							<c:if test="${empty approvalVO }">
								${documentsVO.docCn }
							</c:if>
						</div>
					</div>
					<table class="table table-borderless mt-3">
						<tr>
							<td width=100%>
								<div class="dropzone"></div> <!-- 포스팅 - 이미지/동영상 dropzone 영역 -->
								<ul class="list-unstyled mb-0" id="dropzone-preview">
									<li class="mt-2" id="dropzone-preview-list">
										<div class="border rounded-3">
											<div class="d-flex align-items-center p-2">
												<div class="flex-shrink-0 me-3">
													<div class="width-8 h-auto rounded-3">
														<img data-dz-thumbnail="data-dz-thumbnail" class="w-full h-auto rounded-3 block" src="#" alt="Dropzone-Image" style="width: 120px;" />
													</div>
													<div class="dz-progress">
														<span class="dz-upload" data-dz-uploadprogress></span>
													</div>
												</div>
												<div class="flex-grow-1">
													<div class="pt-1">
														<h6 class="font-semibold mb-1" data-dz-name="data-dz-name">&nbsp;</h6>
														<p class="text-sm text-muted fw-normal" data-dz-size="data-dz-size"></p>
														<strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
													</div>
												</div>
												<div class="shrink-0 ms-3">
													<a href="#" data-dz-remove="data-dz-remove" class="fa-active">
														<i class="fa-sharp fa-regular fa-xmark fa-2xl fa-fw" style="color: #ff2424;"></i>
													</a>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="col-lg-3 ps-0 aside border-start">
				<div class="header" style="z-index: 1">
					<div class="text-center border-bottom border-start px-1 py-2">
						<span class="font-weight-bold">결재선</span>
					</div>
					<div>
						<ul>
							<li class="py-2 px-3 position-relative current"><span class="photo d-inline-block position-absolute"> <a href="#">
										<img alt="" src="/profile/view/${employee.emplProflPhoto }" class="rounded-circle img-fluid w-100 h-100">
									</a>
							</span>
								<div class="wrap position-relative ms-4">
									<div class="info ms-4">
										<a href="#">
											<span class="name d-inline-block text-black font-weight-bold">${employee.emplNm }</span>
										</a>
										<span class="dept d-block overflow-hidden text-truncate text-nowrap">${employee.deptNm }</span>
										<div class="doc">
											<span class="status d-inline-block">기안</span>
										</div>
									</div>
								</div>
								<div class="current-bar position-absolute top-0 start-0 h-100"></div></li>
						</ul>
						<ul id="add-line-area">
							<c:forEach var="sanctioner" items="${approvalVO.sanctionerList }">
								<c:if test="${sanctioner.sanctnerNo ne 0}">
									<li class="py-2 px-3 position-relative <c:if test="${sanctioner.sanctnerSttusCode eq 'G301'}">current</c:if>"><span class="photo d-inline-block position-absolute"> <a href="#">
												<img alt="" src="/profile/view/${sanctioner.emplProflPhoto }" class="rounded-circle img-fluid w-100 h-100">
											</a>
									</span>
										<div class="wrap position-relative ms-4">
											<div class="info ms-4">
												<a href="#">
													<span class="name d-inline-block text-black font-weight-bold">${sanctioner.approverNm }</span>
												</a>
												<span class="dept d-block overflow-hidden text-truncate text-nowrap">${sanctioner.deptNm }</span>
												<div class="doc">
													<span class="status d-inline-block text-gray">결재 예정</span>
												</div>
												<div class="memo"></div>
											</div>
										</div> <c:if test="${sanctioner.sanctnerSttusCode eq 'G301'}">
											<div class="current-bar position-absolute top-0 start-0 h-100"></div>
										</c:if></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="approval-draft-modal" class="interactive-modal" style="z-index: 999;">
	<div class="interactive-modal-content" style="width: 800px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">결재요청</h5>
			<a href="#" class="position-absolute fa-active" data-exit="draft">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="content">
			<nav class="nav nav-underline nav-phils nav-fill mb-3" style="">
				<a href="#" class="nav-link rounded-0 active fw-semibold" id="nav-draft-tab" data-bs-toggle="tab" data-bs-target="#nav-draft" type="button" role="tab" aria-controls="nav-draft" aria-selected="true">결재요청</a>
			</nav>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-draft" role="tabpanel" aria-labelledby="nav-draft-tab" tabindex="0">
					<table class="table table-borderless">
						<tr>
							<th>결재문서명</th>
							<td><span class="font-weight-bold" id="aprovlNm"></span></td>
						</tr>
						<tr>
							<th>기안의견</th>
							<td><textarea rows="3" cols="10" class="form-control rounded-0" placeholder="의견을 작성해 주세요." style="resize: none;" id="aprovlMemo"></textarea></td>
						</tr>
						<tr>
							<th>긴급문서</th>
							<td><span> <input type="checkbox" class="form-check-input" id="isEmergency"> <label for="isEmergency">긴급</label>
									<p class="m-0 text-muted">결재자의 대기문서 가장 상단에 표시됩니다.</p>
							</span></td>
						</tr>
					</table>
				</div>
				<div class="text-end p-0 pt-3">
					<input type="button" class="btn btn-sm btn-secondary rounded-0" value="결재요청" id="confrimDraftBtn"> <input type="button" class="btn btn-sm rounded-0" value="취소" style="border: 1px solid #ddd;" id="cancelDraftModal">
				</div>
			</div>
		</div>
	</div>
</div>

<div id="approval-info-modal" class="interactive-modal" style="z-index: 999;">
	<div class="interactive-modal-content" style="width: 800px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">결재정보</h5>
			<a href="#" class="position-absolute fa-active" data-exit="info">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<nav class="nav nav-underline border-gray">
			<a href="#" class="nav-link rounded-0 active" id="nav-approval-line-tab" data-bs-toggle="tab" data-bs-target="#nav-approval-line" type="button" role="tab" aria-controls="nav-approval-line" aria-selected="true">결재선</a>
			<a href="#" class="nav-link rounded-0" id="nav-references-tab" data-bs-toggle="tab" data-bs-target="#nav-references" type="button" role="tab" aria-controls="nav-references" aria-selected="false">참조자</a>
		</nav>
		<div class="my-2 text-end">
			<button class="btn btn-sm btn-muted rounded-0" id="saveLine">개인 결재선으로 저장</button>
			<button class="btn btn-sm btn-muted rounded-0" id="saveGroup">개인 그룹으로 저장</button>
		</div>
		<div class="row">
			<div class="col-md-4 p-0" style="border: 1px solid #ddd; border-right: 0px;">
				<nav class="nav nav-underline nav-phills nav-justified border-gray" id="navTab">
					<a href="#" class="nav-link rounded-0 active" id="nav-organ-tree-tab" data-bs-toggle="tab" data-bs-target="#nav-organ-tree" type="button" role="tab" aria-controls="nav-organ-tree" aria-selected="true">조직도</a>
					<a href="#" class="nav-link rounded-0" id="nav-my-approval-line-tab" data-bs-toggle="tab" data-bs-target="#nav-my-approval-line" type="button" role="tab" aria-controls="nav-my-approval-line" aria-selected="false">나의 결재선</a>
					<a href="#" class="nav-link rounded-0" id="nav-my-refer-line-tab" data-bs-toggle="tab" data-bs-target="#nav-my-references-line" type="button" role="tab" aria-controls="nav-my-references-line" aria-selected="false">개인 그룹</a>
				</nav>
				<div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-organ-tree" role="tabpanel" aria-labelledby="nav-organ-tree-tab" tabindex="0">
						<div class="searchInput input-group">
							<input type="text" id="oragn-search" class="form-control rounded-0" maxlength="20" placeholder="이름/부서/직위" />
							<button type="button" class="btn btn-dark bg-dark rounded-0">
								<i class="fa-light fa-magnifying-glass fa-xl fa-fw"></i>
							</button>
						</div>
						<div id="jsTree" class="overflow-auto" style="height: 300px;"></div>
					</div>
					<div class="tab-pane fade" id="nav-my-approval-line" role="tabpanel" aria-labelledby="nav-my-approval-line-tab">
						<section class="" style="height: 339px;">
							<ul id="line-area">
							</ul>
						</section>
					</div>
					<div class="tab-pane fade" id="nav-my-references-line" role="tabpanel" aria-labelledby="nav-my-refer-line-tab">
						<section class="" style="height: 339px;">
							<ul id="refer-area">
							</ul>
						</section>
					</div>
				</div>
			</div>
			<button class="col-md-1 bg-gray d-flex align-items-center justify-content-center rounded-0" style="border: 1px solid #ddd; border-right: none;" id="addBtn">
				<i class="fa-sharp fa-regular fa-chevrons-right fa-xl fa-fw fa"></i>
			</button>
			<div class="tab-content col-md-7 p-0" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-approval-line" role="tabpanel" aria-labelledby="nav-draft-tab" tabindex="0">
					<div class="" style="border: 1px solid #ddd;">
						<table class="table table-borderless border-gray mb-0">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="30%">
								<col width="20%">
							</colgroup>
							<thead class="text-center align-middle">
								<tr>
									<th>타입</th>
									<th>이름</th>
									<th>부서</th>
									<th>
										<a href="#" id="deleteAll">
											<i class="fa-sharp fa-regular fa-trash fa-xl fa-fw fa fw-semibold"></i>
										</a>
									</th>
								</tr>
							</thead>
						</table>
						<div class="position-relative border-gray bg-gray p-1">
							<span class="text-muted">신청</span>
						</div>
						<table class="table table-borderless table-hover mb-0">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="30%">
								<col width="20%">
							</colgroup>
							<tbody class="text-center align-middle">
								<tr class="disabled">
									<td>결재</td>
									<td>${employee.emplNm }</td>
									<td>${employee.deptNm }</td>
									<td><a href="#">
											<i class="fa-sharp fa-regular fa-trash fa-fw fa"></i>
										</a></td>
								</tr>
							</tbody>
						</table>
						<div class="position-relative border-gray bg-gray p-1">
							<span class="text-muted">승인</span>
						</div>
						<table class="table table-borderless table-hover mb-0">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="30%">
								<col width="20%">
							</colgroup>
							<tbody class="text-center align-middle" id="approval-area">
								<c:forEach var="sanctioner" items="${approvalVO.sanctionerList }">
									<c:if test="${sanctioner.sanctnerNo ne 0}">
										<tr data-no="${sanctioner.approverNo }">
											<td>결재</td>
											<td>${sanctioner.approverNm }</td>
											<td>${sanctioner.deptNm }</td>
											<td><a href="#" data-del-no="${sanctioner.approverNo }">
													<i class="fa-sharp fa-regular fa-trash"></i>
												</a></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-references" role="tabpanel" aria-labelledby="nav-references-tab">
					<table class="table table-borderless border-gray mb-0">
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<thead class="text-center align-middle" style="border: 1px solid #ddd;">
							<tr>
								<th>이름</th>
								<th>부서</th>
								<th>확인시간</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody class="text-center align-middle" style="border-left: 1px solid #ddd; border-right: 1px solid #ddd;" id="references-area">
							<c:if test="${not empty approvalVO.rfrncList }">
								<c:forEach var="rfrnc" items="${approvalVO.rfrncList }">
									<tr data-rfrncer-no="${rfrnc.rfrncerNo }">
										<c:set var="isChecked" value="미확인" />
										<c:if test="${rfrnc.rfrncConfirmDt ne null}">
											<c:set var="isChecked" value="${rfrnc.rfrncConfirmDtToString }" />
										</c:if>
										<td>${rfrnc.rfrncerNm }</td>
										<td>${rfrnc.rfrncerDeptNm }</td>
										<td>${isChecked }</td>
										<td><a href="#" data-del-no="${rfrnc.rfrncerNo }">
												<i class="fa-sharp fa-regular fa-trash"></i>
											</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<div class="d-flex justify-content-end align-items-center">
				<button class="btn btn-sm rounded-0 btn-primary me-3" id="confirmInfoBtn">확인</button>
				<button class="btn btn-sm rounded-0" style="border: 1px solid #ddd;" id="cancelInfoBtn">취소</button>
			</div>
		</div>
	</div>
</div>

<div id="save-line-modal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content" style="width: 300px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">결재선 저장</h5>
			<a href="#" class="position-absolute fa-active" data-exit="saveline">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="card-body rounded-0 p-0">
			<div class="input-group justify-content-center align-items-center">
				<label class="fw-semibold me-3" for="saveLineBtn">결재선 이름</label> <input type="text" class="form-control rounded-0" id="lineName">
			</div>
		</div>
		<div class="card-footer text-end p-0 pt-3">
			<button class="btn btn-sm rounded-0 btn-primary" id="saveLineConfirmBtn">확인</button>
			<button class="btn btn-sm rounded-0" style="border: 1px solid #ddd;" id="saveLineCancelBtn">취소</button>
		</div>
	</div>
</div>

<div id="save-group-modal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content" style="width: 300px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">참조 그룹 저장</h5>
			<a href="#" class="position-absolute fa-active" data-exit="savegroup">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="card-body rounded-0 p-0">
			<div class="input-group justify-content-center align-items-center">
				<label class="fw-semibold me-3" for="saveGroupBtn">그룹 이름</label> <input type="text" class="form-control rounded-0" id="groupName">
			</div>
		</div>
		<div class="card-footer text-end p-0 pt-3">
			<button class="btn btn-sm rounded-0 btn-primary" id="saveGroupConfirmBtn">확인</button>
			<button class="btn btn-sm rounded-0" style="border: 1px solid #ddd;" id="saveGroupCancelBtn">취소</button>
		</div>
	</div>
</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/dropzone.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/jstree.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/Sortable.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/util/textarea_util.js"></script>
<script>
	Dropzone.autoDiscover = false;
	var nodeArr = [];
	
	
	$('#testBtn').on('click', function() {
		let title = '2024년 하반기 홈페이지 개편 프로젝트 기획 안건';
		let msg = `안녕하십니까 최소희 사장님, 이영주 상무님

우리 회사의 디지털 플랫폼을 한 단계 업그레이드하기 위한 중요한 프로젝트,
"2024년 하반기 홈페이지 개편 프로젝트"의 기획안을 제출합니다.
이번 개편의 핵심 목표는 사용자 경험(UX)의 혁신, 서비스 효율성 향상, 그리고 브랜드 이미지 강화입니다.

프로젝트 관련 세부 사항은 다음과 같습니다.

프로젝트 명: 2024년 하반기 홈페이지 개편 프로젝트
프로젝트 기간: 2024년 7월 1일 ~ 2024년 12월 31일

참여 인원:
개발본부: 권예은 차장
서비스 개발팀: 윤선영 부장, 권오성 대리
디자인팀: 임지훈 차장

주요 목표:
사용자 인터페이스(UI) 및 사용자 경험(UX) 혁신을 통한 접근성 및 이용 편의성 향상
최신 웹 기술 적용을 통한 페이지 로딩 시간 단축 및 서비스 효율성 개선
브랜드 아이덴티티를 반영한 디자인으로 브랜드 이미지 강화

주요 작업 내용:
현황 분석 및 사용자 조사를 통한 개선점 도출
UI/UX 디자인 기획 및 개발
웹 접근성 및 반응형 웹 디자인 적용
콘텐츠 재구성 및 최적화
시스템 통합 및 보안 강화

예상 예산: 약 3억 원
이번 프로젝트는 우리 회사의 디지털 전환(DT) 전략의 핵심 요소 중 하나로,
완성도 높은 결과물을 만들기 위해 여러 부서의 적극적인 협력과 지원이 필요합니다.
프로젝트의 성공적인 수행을 위해 다음 단계로 각 부서별 업무 분담 및 상세 일정 계획을 수립할 예정입니다.

감사합니다.

권예은 차장 드림`;
		
		$('.effective-date').val('2024-05-09');
		$('#subject').val(title);
		$('#innerContent').val(msg);
	});
	
	$(function() {
		/* 문서양식 관련 스크립트 시작*/
			
			/* 기안자에 emplNm 넣어주기 */
			var userValue = '${userValue}'; 
			var userVO = JSON.parse(userValue);
			var userName = userVO.emplNm;
			
			/* 사인 영역 선택을 위한 emplNo 추가 */
			if('${status}' != 'r') {
				$('[data-approval-line-no]').attr('data-approval-line-no', userVO.emplNo);
				$('[data-approval-line-no]').find('.sign_date').attr('id', 'sign_'+userVO.emplNo);
				console.log('data >>', $('[data-approval-line-no]').attr('data-approval-line-no'));
				console.log('sign_date >>', $('[data-approval-line-no]').find('.sign_date').attr('id'));
			}
			
			/* 문서번호 넣어주기 */
			var docCodeNo = "${documentsVO.docCodeNo}";
			var draftDept = userVO.deptNm;
			
			
			/* 신청 부분에 유저 직위, 이름 넣어주기 */
			var signRankElement = document.querySelector('.sign_rank');
			signRankElement.innerText = userVO.clsfNm;
			var signNameElement = document.querySelector('.sign_name');
			signNameElement.innerText = userVO.emplNm;
			/* 사직서 이름, 날짜 */
			var bottomNameElements = document.getElementsByClassName('bottom-name');
			var bottomDateElements = document.getElementsByClassName('bottom-date');
			if (bottomNameElements.length > 0) {
				bottomNameElements[0].innerHTML = "위 본인: " + userVO.emplNm + "&nbsp; &nbsp; &nbsp;";
			}
			if (bottomDateElements.length > 0) {
				bottomDateElements[0].innerText = getCurrentDate2();
			}
			//console.log(docCodeNo);
			/* 년 월 일 형식의 날짜 */
			function getCurrentDate2() {
			    var currentDate = new Date();
	
			    var year = currentDate.getFullYear();
			    var month = currentDate.getMonth() + 1;
			    var day = currentDate.getDate();
	
			    month = (month < 10 ? "0" : "") + month;
			    day = (day < 10 ? "0" : "") + day;
	
			    return year + "년 " + month + "월 " + day + "일";
			}
	
			
			/* 기안일에 현재 날짜 넣어주기 2024-05-01 형식*/
			function getCurrentDate() {
		        var today = new Date();
		        var year = today.getFullYear();
		        var month = ('0' + (today.getMonth() + 1)).slice(-2); 
		        var day = ('0' + today.getDate()).slice(-2); 
		        
		        return year + '-' + month + '-' + day;
		    }
	
	
			if('${status}' != 'r') {
				var draftUserInput = document.getElementById('draftUser');
				var draftDeptInput = document.getElementById('draftDept');
				var draftDocCodeNoInput = document.getElementById('docCodeNo');
			    var draftDateInput = document.getElementById('draftDate');
				draftDocCodeNoInput.value = docCodeNo;
				draftDeptInput.value = draftDept;
				draftUserInput.value = userName;
			    draftDateInput.value = getCurrentDate();
			}
			
		
		/* 문서양식 관련 스크립트 끝 */
		
		let status = '${status}';
		
		if(status == 'r') {
			enableDraggable();
			
			let date = $('#appDate');
			let title = $('#appTitle');
			let content = $('#appContent');
			
			let obj = {
				date: date,
				title: title,
				content: content
			};
			
			for(let key in obj) {
				let value = obj[key].html();
				obj[key].html('');
				
				let tag;
				if(key == 'title'){
					tag = $('<input type="text" id="subject" style="width:99%;">');
				}
				if(key == 'date'){
					tag = $('<input type="date">');
				}
				
				if(key == 'content'){
					value = replaceBrTagToNewLine(value);
					tag = $('<textarea rows="20" style="width:100%; min-width: 200px;">');
					tag.html(value);
					
					$(this).find('.sign_stamp').remove();
					$(this).find('.sign_date').html('');
				}else{
					tag.val(value);
				}
				
				obj[key].append(tag);
			}
		}
		
		let draftModal = $('#approval-draft-modal');
		let infoModal = $('#approval-info-modal');
		let saveLineModal = $('#save-line-modal')
		let saveGroupModal = $('#save-group-modal')
		let draft = $('#draft');
		let info = $('#info');
		let tempsave = $('#tempsave');
		let preview = $('#preview');
		let cancel = $('#cancel');
		let draftModalExit = $('[data-exit]');
		let confrimDraftBtn = $('#confrimDraftBtn');
		let cancelDraftModal = $('#cancelDraftModal');
		let infoTab = $('#nav-info-tab');
		let draftTab = $('#nav-draft-tab');
		let addBtn = $('#addBtn');
		let saveLine = $('#saveLine');
		let saveGroup = $('#saveGroup');
		let deleteAll = $('#deleteAll');
		let myLineTab = $('#nav-my-approval-line-tab');
		let myGroupTab = $('#nav-my-references-line-tab');
		let myReferTab = $('#nav-my-refer-line-tab');
		
		let confirmInfoBtn = $('#confirmInfoBtn');
		let cancelInfoBtn = $('#cancelInfoBtn');
		
		saveGroup.hide();
		myGroupTab.hide();
		
		let lTab = $('#nav-approval-line-tab');
		let refTab = $('#nav-references-tab');
		let lineTab = $('#nav-my-approval-line-tab');
		let refGroupTab = $('#nav-my-references-line');
		
		myReferTab.hide();
		
		refTab.on('click', function(e) {
			lineTab.hide();
			myReferTab.show();
			saveLine.hide();
			saveGroup.show();
		});
		
		lTab.on('click', function(e) {
			myReferTab.hide();
			lineTab.show();
			saveGroup.hide();
			saveLine.show();
		})
		
		/* 결재 정보 불러오기 시작 */
		
		function getApporvalInfo() {
			let folderTree;
			let empList;
			$.ajax({
				url: '/approval/organtree',
				type: 'get',
				async: false
			})
			.done(function(res) {
				folderTree = res;
			});
			
			$.ajax({
				url: '/approval/emplist',
				type: 'get',
				async: false
			})
			.done(function(res) {
				empList = res;
			})
			
			createOrganTree(folderTree, empList);
		};
		
		/* 결재 정보 불러오기 끝 */
		
		/* 탭 토글 이벤트 */
		draftTab.on('click', toggleTitle);
		
		/* 조직도에서 결재선 추가 버튼 이벤트 시작  */
		
		addBtn.on('mouseenter mouseleave', function() {
			let icon = $(this).find('.fa');
			icon.toggleClass('fa-beat icon-active');
		});
		
		addBtn.on('click', function() {
			
			let isRefer = $('#nav-references').hasClass('active');
			
			let selecetdNodes = $('#jsTree').jstree('get_selected', true);
			
			let msg = '결재자가 선택되지 않았습니다!';
			let dupMsg = '중복된 결재자가 있습니다!';
			let dataAttr = 'data-no';
			
			if(isRefer) {
				msg = '참조자가 선택되지 않았습니다!';
				dupMsg = '중복된 참조자가 있습니다!';
				dataAttr = 'data-rfrncer-no'
			}
			
			if(selecetdNodes.length == 0) {
				showToast(msg, 'error');
				return;
			}
			
			let html = '';
			let lineHTML = '';
			
			for(let node of selecetdNodes) {
				if(node.id.startsWith("D")) {
					showToast('부서는 추가할 수 없습니다!', 'error');
					return;
				}
				
				let areaItem;
				
				if(isRefer) {
					areaItem = $('#references-area').text();					
				}
				else {
					areaItem = $('#approval-area').text();
				}
				
				if(areaItem.includes(node.original.emplNm)) {
					showToast(dupMsg, 'error');
					return;
				}
				if(isRefer) {
					html += `
						<tr \${dataAttr}="\${node.original.emplNo}" data-profile="/profile/view/\${node.original.emplProflPhoto}" data-empl-nm="\${node.original.emplNm}" data-dept-nm="\${node.original.deptNm}" draggable="true" class="dragitem">
							<td>\${node.original.emplNm}</td>
							<td>\${node.original.deptNm}</td>
							<td>미확인</td>
							<td>
								<a href="#" data-del-no="\${node.original.emplNo}">
									<i class="fa-sharp fa-regular fa-trash"></i>
								</a>
							</td>
						</tr>`;
				}else{
					html += `
						<tr \${dataAttr}="\${node.original.emplNo}" data-profile="/profile/view/\${node.original.emplProflPhoto}" data-empl-nm="\${node.original.emplNm}" data-dept-nm="\${node.original.deptNm}" draggable="true" class="dragitem">
							<td>결재</td>
							<td>\${node.original.emplNm}</td>
							<td>\${node.original.deptNm}</td>
							<td>
								<a href="#" data-del-no="\${node.original.emplNo}">
									<i class="fa-sharp fa-regular fa-trash"></i>
								</a>
							</td>
						</tr>`;
				}
					
				lineHTML += `
					<li class="py-2 px-3 position-relative text-gray" data-no="\${node.original.emplNo}">
						<span class="photo d-inline-block position-absolute"> <a href="#">
								<img alt="" src="/profile/view/\${node.original.emplProflPhoto }" class="rounded-circle img-fluid w-100 h-100">
							</a>
						</span>
						<div class="wrap position-relative ms-4">
							<div class="info ms-4">
								<a href="#">
									<span class="name d-inline-block text-black font-weight-bold">\${node.original.emplNm }</span>
								</a>
								<span class="dept d-block overflow-hidden text-truncate text-nowrap">\${node.original.deptNm }</span>
								<div class="doc">
									<span class="status d-inline-block">결재예정</span>
								</div>
							</div>
						</div>
					</li>`;
					
					
				if(!isRefer) {
					let html = createSignGroupHTML(node);
					console.log('HTML >>>', html);
					$('#appLine').append(html);
				}
			}
			
			if(!isRefer) {
				$('#approval-area').css('display', 'table-row-group');
				$('#approval-area').append(html);
				$('#add-line-area').append(lineHTML);
			}else{
				$('#references-area').css('display', 'table-row-group');
				$('#references-area').append(html);
			}
		
			$('#jsTree').jstree('deselect_all', true);
			
			enableDraggable();
		});
		
		function createSignGroupHTML(node) {
			console.log(node);
			let html = '';
			
			html+='	<span class="sign_type1_inline" data-group-seq="0" data-group-name="승인" data-approval-line-no="'+node.original.emplNo+'">';
			html+='		<span class="sign_tit_wrap">';
			html+='			<span class="sign_tit">';
			html+='				<strong>승인</strong>';
			html+='			</span>';
			html+='		</span>';
			html+='		<span class="sign_member_wrap" id="activity_16557">';
			html+='			<span class="sign_member">';
			html+='				<span class="sign_rank_wrap">';
			html+='					<span class="sign_rank">'+node.original.text.split(' ')[1]+'</span>';
			html+='				</span>';
			html+='				<span class="sign_wrap">';
			html+='					<span class="sign_name">'+node.original.emplNm+'</span>';
			html+='				</span>';
			html+='				<span class="sign_date_wrap">';
			html+='					<span class="sign_date " id="sign_'+node.original.emplNo+'"></span>';
			html+='				</span>';
			html+='			</span>';
			html+='		</span>';
			html+='	</span>';
			
			return html;
		}
		
		$('#jsTree').on('dblclick.jstree', function (e, data) {
			
			let isRefer = $('#nav-references').hasClass('active');
			
			let msg = '결재자가 선택되지 않았습니다!';
			let dupMsg = '중복된 결재자가 있습니다!';
			let dataAttr = 'data-no';
			
			if(isRefer) {
				msg = '참조자가 선택되지 않았습니다!';
				dupMsg = '중복된 참조자가 있습니다!';
				dataAttr = 'data-rfrncer-no'
			}
			
			if(e.target.id.startsWith('D')) {
				return;
			}
			
			let node = $('#jsTree').jstree('get_selected', true)[0];
			let html = '';
			let lineHTML = '';
			
			let areaItem;
			if(isRefer) {
				areaItem = $('#references-area').text();					
			}
			else {
				areaItem = $('#approval-area').text();
			}
			
			if(areaItem.includes(node.original.emplNm)) {
				showToast(dupMsg, 'error');
				return;
			}
			
			if(isRefer) {
				html += `
					<tr \${dataAttr}="\${node.original.emplNo}" data-profile="/profile/view/\${node.original.emplProflPhoto}" data-empl-nm="\${node.original.emplNm}" data-dept-nm="\${node.original.deptNm}" draggable="true" class="dragitem">
						<td>\${node.original.emplNm}</td>
						<td>\${node.original.deptNm}</td>
						<td>미확인</td>
						<td>
							<a href="#" data-del-no="\${node.original.emplNo}">
								<i class="fa-sharp fa-regular fa-trash"></i>
							</a>
						</td>
					</tr>`;
			}else{
				html += `
					<tr \${dataAttr}="\${node.original.emplNo}" data-profile="/profile/view/\${node.original.emplProflPhoto}" data-empl-nm="\${node.original.emplNm}" data-dept-nm="\${node.original.deptNm}" draggable="true" class="dragitem">
						<td>결재</td>
						<td>\${node.original.emplNm}</td>
						<td>\${node.original.deptNm}</td>
						<td>
							<a href="#" data-del-no="\${node.original.emplNo}">
								<i class="fa-sharp fa-regular fa-trash"></i>
							</a>
						</td>
					</tr>`;
			}
				
			lineHTML += `
				<li class="py-2 px-3 position-relative text-gray" data-no="\${node.original.emplNo}">
					<span class="photo d-inline-block position-absolute"> <a href="#">
							<img alt="" src="/profile/view/\${node.original.emplProflPhoto }" class="rounded-circle img-fluid w-100 h-100">
						</a>
					</span>
					<div class="wrap position-relative ms-4">
						<div class="info ms-4">
							<a href="#">
								<span class="name d-inline-block text-black font-weight-bold">\${node.original.emplNm }</span>
							</a>
							<span class="dept d-block overflow-hidden text-truncate text-nowrap">\${node.original.deptNm }</span>
							<div class="doc">
								<span class="status d-inline-block">결재예정</span>
							</div>
						</div>
					</div>
				</li>`;
				
			if(!isRefer) {
				$('#approval-area').css('display', 'table-row-group');
				$('#approval-area').append(html);
				$('#add-line-area').append(lineHTML);
			}else{
				$('#references-area').css('display', 'table-row-group');
				$('#references-area').append(html);
			}
			
			if(!isRefer) {
				let html = createSignGroupHTML(node);
				console.log('dbclick HTML >>', html);
				$('#appLine').append(html);
			}
			
			$('#jsTree').jstree('deselect_all', true);
			
			enableDraggable();
		});
		
		/* 조직도에서 결재선 추가 버튼 이벤트 끝  */
		
		/* 개인 결재선 저장 이벤트 시작 */
		
		saveLine.on('click', function(e) {
			let saveItems = $('#approval-area').children();
			if(saveItems.length == 0) {
				showToast('저장할 결재자가 존재하지 않습니다!', 'error');
				return;
			}
			
			toggleSaveLineModal();
		});
		
		saveGroup.on('click', function(e) {
			let saveItems = $('#references-area').children();
			if(saveItems.length == 0) {
				showToast('저장할 참조자가 존재하지 않습니다!', 'error');
				return;
			}
			toggleSaveGroupModal();
		})
		
		$('#saveLineConfirmBtn').on('click', fnSaveLine);
		$('#saveGroupConfirmBtn').on('click', fnSaveGroup);
		
		function fnSaveLine() {
			let lineName = $('#lineName').val();
			let groupNo;
			
			if(lineName == null || lineName.trim() == '') {
				showToast('저장할 결재선 이름을 입력해주세요!', 'error');
				return;
			}
			
			let emplNo = connectionTest();
			
			$.ajax({
				url: '/approval/sanctioner/insertgroup',
				type: 'post',
				async: false,
				contentType: 'application/json; charset=UTF-8',
				data: JSON.stringify({
					sanctionerOner : emplNo,
					sanctnerBkmkNm : lineName,
					sanctionerType : '0'
				}),
				dataType: 'text'
			})
			.done(function(res) {
				groupNo = res;
			})
			
			if(groupNo <= 0) {
				showAlert('서버 오류가 발생하였습니다!', '잠시 후 다시 시도해주세요', 'error');
				return;	
			}
			
			let items = $('#approval-area [data-no]');
			let data = [];
			for(let item of items){
				let no = item.dataset.no;
				if(emplNo == null || emplNo == undefined) {
					break;
				}
				
				let obj = {
					sanctnerBkmkNo : groupNo,
					emplNo : no,
					sanctnerBkmkOrdr : data.length + 1
				}
				
				data.push(obj);
			}
			
			$.ajax({
				url: '/approval/sanctioner/insert',
				type: 'post',
				contentType: 'application/json; charset=UTF-8',
				data: JSON.stringify(data)
			})
			.done(function(res) {
				$('#save-line-modal').removeClass('show');
				showToast('결재선이 성공적으로 저장되었습니다!', 'success');
			})
		}
		
		function fnSaveGroup() {
			let groupName = $('#groupName').val();
			let groupNo;
			
			if(groupName == null || groupName.trim() == '') {
				showToast('저장할 그룹 이름을 입력해주세요!', 'error');
				return;
			}
			
			let emplNo = connectionTest();
			
			$.ajax({
				url: '/approval/sanctioner/insertgroup',
				type: 'post',
				async: false,
				contentType: 'application/json; charset=UTF-8',
				data: JSON.stringify({
					sanctionerOner : emplNo,
					sanctnerBkmkNm : groupName,
					sanctionerType : '1'
				}),
				dataType: 'text'
			})
			.done(function(res) {
				groupNo = res;
			})
			
			if(groupNo <= 0) {
				showAlert('서버 오류가 발생하였습니다!', '잠시 후 다시 시도해주세요', 'error');
				return;	
			}
			
			let items = document.querySelectorAll('[data-rfrncer-no]')
			let data = [];
			for(let item of items){
				let rfrncerNo = item.dataset.rfrncerNo;
				if(emplNo == null || emplNo == undefined) {
					break;
				}
				
				let obj = {
					sanctnerBkmkNo : groupNo,
					refNo : rfrncerNo,
				}
				
				data.push(obj);
			}
			
			$.ajax({
				url: '/approval/sanctioner/refinsert',
				type: 'post',
				contentType: 'application/json; charset=UTF-8',
				data: JSON.stringify(data)
			})
			.done(function(res) {
				$('#save-group-modal').removeClass('show');
				showToast('참조그룹이 성공적으로 저장되었습니다!', 'success');
			})
			
		}
		
		/* 개인 결재선 저장 이벤트 끝 */
		
		$('#saveLineCancelBtn').on('click', toggleSaveLineModal);
		$('#saveGroupCancelBtn').on('click', toggleSaveGroupModal);
		
		/* 결재선 삭제 이벤트 시작 */
		
		$('#approval-area').on('click', '[data-del-no]', function(e) {
			let delNo =	$(this).data('delNo');
			let isRefer = $('#nav-references').hasClass('show');
			
			if(isRefer) {
				$('[data-rfrncer-no="'+delNo+'"]').fadeOut(500, function() {
					$('[data-rfrncer-no="'+delNo+'"]').remove();
				});
			}else{
				$('[data-no="'+delNo+'"]').fadeOut(500, function() {
					$('[data-no="'+delNo+'"]').remove();
					$('[data-approval-line-no="'+delNo+'"]').remove();
				});
			}
		})
		
		/* 결재선 삭제 이벤트 끝 */
		
		/* 결재선 전체 삭제 이벤트 시작 */
		
		$('#deleteAll').on('click', function() {
			$(this).find('i').addClass("fa-shake");
			let delItems = $('#approval-area').children();
			let delLines = $('#add-line-area').children();
			
			if(delItems.length == 0) {
				showToast('삭제할 항목이 존재하지 않습니다!', 'error');
				return;
			}
			
			$('#approval-area').fadeOut(500, function(){ 
				delItems.remove();
				delLines.remove();
	        });
			
			setTimeout(() => {
				$(this).find('i').removeClass("fa-shake");
			}, 900);
		});
		
		/* 결재선 전체 삭제 이벤트 끝 */
		
		/* 나의 결재선 관련 스크립트 시작  */
		myLineTab.on('click', selectMyLine);
		myReferTab.on('click', selectMyGroup);
		
		/* 나의 결재선 불러오기 */
		function selectMyLine() {
			let emplNo = connectionTest();
			
			$.get('/approval/senctioner/myline',{sanctionerOner : emplNo})
			.done(function(res) {
				createMyLine(res);
			})
		}
		
		function selectMyGroup() {
			let emplNo = connectionTest();
			
			$.get('/approval/senctioner/mygroup',{sanctionerOner : emplNo})
			.done(function(res) {
				createMyGroup(res);
			})
		}
		
		/* 나의 결재선 그려주기 */
		function createMyLine(lines) {
			$('#line-area').html('');
			
			let html = '';
			if(lines.length == 0) {
				html = '<p class="py-3 px-1 text-center align-middle">개인 결재선이 없습니다</p>'
				$('#line-area').append(html);
				return;
			}
			
			for(let line of lines) {
				html += '<li class="position-relative" data-line-id="'+line.sanctnerBkmkNo+'">';
				html += '	<p class="m-0 position-relative align-middle p-2">';
				html += '		<a href="#" class="" data-line-no="'+line.sanctnerBkmkNo+'">'+line.sanctnerBkmkNm+'<span class="">('+line.sanctionerBookmarkList.length+')</span></a>';
				html += '		<a href="#" class="position-absolute fa-active" style="right: 0;" data-del-line="'+line.sanctnerBkmkNo+'">';
				html += '			<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>';
				html += '		</a>';
				html += '	</p>';
				html += '</li>';
			}
			
			$('#line-area').append(html);
		}
		
		/* 나의 참조 그룹 그려주기 */
		function createMyGroup(groups) {
			$('#refer-area').html('');
			
			let html = '';
			if(groups.length == 0) {
				html = '<p class="py-3 px-1 text-center align-middle">개인 그룹이 없습니다</p>'
				$('#refer-area').append(html);
				return;
			}
			
			for(let group of groups) {
				html += '<li class="position-relative" data-line-id="'+group.sanctnerBkmkNo+'">';
				html += '	<p class="m-0 position-relative align-middle p-2">';
				html += '		<a href="#" class="" data-line-no="'+group.sanctnerBkmkNo+'">'+group.sanctnerBkmkNm+'<span class="">('+group.sanctionerBookmarkRefList.length+')</span></a>';
				html += '		<a href="#" class="position-absolute fa-active" style="right: 0;" data-del-line="'+group.sanctnerBkmkNo+'">';
				html += '			<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>';
				html += '		</a>';
				html += '	</p>';
				html += '</li>';
			}
			
			$('#refer-area').append(html);
			console.log($('#refer-area'));
		}
		
		/* 나의 결재선 선택하기 */
		$('#line-area').on('click', '[data-line-no]', function() {
			let emplNo = connectionTest();
			let lineNo = $(this).data('lineNo');
			$.get('/approval/senctioner/myline',{sanctionerOner : emplNo, sanctnerBkmkNo : lineNo})
			.done(function(res) {
				
				console.log(res);
				
				let html = '';
				let lineHTML = '';
				
				for(let line of res) {
					for(let data of line.sanctionerBookmarkList) {
						html += '<tr data-no="'+data.emplNo+'" data-profile="/profile/view/'+data.emplProflPhoto+'" data-empl-nm="'+data.emplNm+'" data-dept-nm="'+data.deptNm+'" draggable="true" class="dragitem">';
						html +=	'	<td>결재</td>';
						html +=	'	<td>'+data.emplNm+'</td>';
						html +=	'	<td>'+data.deptNm+'</td>';
						html +=	'	<td>';
						html += '		<a href="#" data-del-no="'+data.emplNo+'">';
						html += '			<i class="fa-sharp fa-regular fa-trash"></i>';
						html += '		</a>';
						html += '	</td>';
						html += '</tr>';
						
						
						lineHTML += `
							<li class="py-2 px-3 position-relative text-gray" data-no="\${data.emplNo}">
								<span class="photo d-inline-block position-absolute"> <a href="#">
										<img alt="" src="/profile/view/\${data.emplProflPhoto }" class="rounded-circle img-fluid w-100 h-100">
									</a>
								</span>
								<div class="wrap position-relative ms-4">
									<div class="info ms-4">
										<a href="#">
											<span class="name d-inline-block text-black font-weight-bold">\${data.emplNm }</span>
										</a>
										<span class="dept d-block overflow-hidden text-truncate text-nowrap">\${data.deptNm }</span>
										<div class="doc">
											<span class="status d-inline-block">결재예정</span>
										</div>
									</div>
								</div>
							</li>`;
					}
				}
				
				$('#approval-area').css('display', 'table-row-group');
				$('#approval-area').html('');
				$('#add-line-area').html('');
				
				$('#approval-area').append(html);
				$('#add-line-area').append(lineHTML);
				
				enableDraggable();
			})
		});
		
		/* 나의그룹 선택 하기*/
		
		$('#refer-area').on('click', '[data-line-no]', function() {
			let emplNo = connectionTest();
			let lineNo = $(this).data('lineNo');
			$.get('/approval/senctioner/mygroup',{sanctionerOner : emplNo, sanctnerBkmkNo : lineNo})
			.done(function(res) {
				console.log(res);
				
				let html = '';
				let lineHTML = '';
				
				for(let line of res) {
					for(let data of line.sanctionerBookmarkRefList) {
						html += '<tr data-rfrncer-no="'+data.refNo+'" draggable="true" class="dragitem">';
						html +=	'	<td>'+data.emplNm+'</td>';
						html +=	'	<td>'+data.deptNm+'</td>';
						html +=	'	<td>미확인</td>';
						html +=	'	<td>';
						html += '		<a href="#" data-del-no="'+data.refNo+'">';
						html += '			<i class="fa-sharp fa-regular fa-trash"></i>';
						html += '		</a>';
						html += '	</td>';
						html += '</tr>';
					}
				}
				
				$('#references-area').css('display', 'table-row-group');
				$('#references-area').html('');
				$('#references-area').append(html);
				
				enableDraggable();
			});
		});
		
		/* 나의 결재선 삭제하기 */
		$('#line-area').on('click', '[data-del-line]', function() {
			let delNo = $(this).data('delLine');
			if(delNo == 0) {
				return;
			}
			showConfirm('결재선 삭제', '해당 결재선을 정말 삭제하시겠습니까?', 'warning')
			.then(result => {
				if(result.isConfirmed) {
					$.ajax({
						url: '/approval/senctioner/delete',
						type: 'post',
						contentType: 'application/json; charset=UTF-8',
						data: JSON.stringify({
							sanctnerBkmkNo : delNo
						})
					})
					.done(function (res) {
						console.log(res);
						if(res == 'OK') {
							$('[data-line-id="'+delNo+'"]').fadeOut(500, function() {
								$('[data-line-id="'+delNo+'"]').remove();
							})
							$('#approval-area').html('');
							showToast('결재선이 성공적으로 삭제되었습니다!', 'success');
						}
					})
				}
			})
		});
		
		/* 나의 그룹 삭제하기 */
		$('#refer-area').on('click', '[data-del-line]', function() {
			let delNo = $(this).data('delLine');
			if(delNo == 0) {
				return;
			}
			showConfirm('결재선 삭제', '해당 결재선을 정말 삭제하시겠습니까?', 'warning')
			.then(result => {
				if(result.isConfirmed) {
					$.ajax({
						url: '/approval/senctioner/refdelete',
						type: 'post',
						contentType: 'application/json; charset=UTF-8',
						data: JSON.stringify({
							sanctnerBkmkNo : delNo
						})
					})
					.done(function (res) {
						console.log(res);
						if(res == 'OK') {
							$('[data-line-id="'+delNo+'"]').fadeOut(500, function() {
								$('[data-line-id="'+delNo+'"]').remove();
							})
							$('#references-area').html('');
							showToast('결재선이 성공적으로 삭제되었습니다!', 'success');
						}
					})
				}
			})
		});
		
		/* 나의 결재선 관련 스크립트 끝  */
		
		/* 결재 요청 관련  시작 */
		confrimDraftBtn.on('click', function() {
			let formData = getInsertData(); 	
			
			$.ajax({
				url: '/approval/insert',
				type: 'post',
				data: formData,
				processData: false,
				contentType: false,
			})
			.done(function(res) {
				if(res != '0') {
					showAlert('결재 상신이 완료되었습니다!', '', 'success')
					.then(result => {
						if(result.isConfirmed) {
							location.href="/approval";
						}
					});
				}
			})
		});
		
		function getInsertData(type) {
			
			let sanctionerList = $('#approval-area').children();
			let rfrncList = $('#references-area').children();
			
			if(type != 'temp'){
				if(sanctionerList.length == 0) {
					showToast('결재자가 추가 되지 않았습니다!', 'error');
					return;
				}
				
			}
			let emplNo = connectionTest();
			
			let sign = '${employee.emplSign}';
			console.log('sign >> ', sign);
			if(sign && sign.startsWith("data:")) {
				console.log('## if true');
				let signArea = $('[data-approval-line-no="'+emplNo+'"]').find('.sign_wrap');
	 			html = '<span class="sign_stamp"><img src="'+sign+'"></span>';
	 			$('[data-approval-line-no="'+emplNo+'"]').find('.sign_date').text(getCurrentDate());
	 			console.log('sign true >> ', html);
				signArea.prepend(html);
			}
			
			fnChangeInputToTd();
			
			let obj = {
				emplNo : emplNo,
				docNo : '${docNo}',
				aprovlNm : $('#aprovlNm').text(),
				aprovlCn : $('#aprovlCn').html(),
				aprovlMemo : $('#aprovlMemo').val(),
				aprovlTypeCode : 'G201',
				aprovlSttusCode : 'G102',
				emrgncyYn : $('#isEmergency').is(':checked') ? 'Y' : 'N',
			}
			
			let formData = new FormData();
			$.each(obj, function(key, value) {
				formData.append(key, value);
			});
			
			dropzone.files.forEach(function(file) {
				formData.append("files", file);
			})
			
			console.log(sanctionerList);
			
			let cnt = 0;
			for (let item of sanctionerList) {
				if(!$(item).text().includes('존재하지')) {
					formData.append('sanctionerList[' + cnt + '].approverNo', $(item).data('no'));
					formData.append('sanctionerList[' + cnt + '].sanctnerOrdr', cnt+1);
					if(cnt == 0) {
						formData.append('sanctionerList[' + cnt + '].sanctnerSttusCode', 'G301');
					}else{
						formData.append('sanctionerList[' + cnt + '].sanctnerSttusCode', 'G302');
					}
					cnt++;
				}
			}
			
			if(rfrncList.length > 0) {
				cnt = 0;
				
				for (let item of rfrncList) {
					formData.append('rfrncList[' + cnt + '].rfrncerNo', $(item).data('rfrncerNo'));
					cnt++;
				}
			}
			
			let status = '${status}';
			if(status != null && status.trim() != '') {
				formData.append('aprovlNo', '${approvalVO.aprovlNo}');
				formData.append('type', 'r');
			}
			
			return formData;
		}
		
		function fnChangeInputToTd() {
			$('#aprovlCn input').each(function() {
				let value = $(this).val();
				let p = $(this).parent();
				$(this).remove();
				p.text(value);
			})
			
			let innerContent = $('#innerContent'); 
			if(!innerContent.val()) {
				innerContent = $('#appContent textarea');
			}
			
			let textContent = replaceNewLineToBrTag(innerContent.val());
			let parent = innerContent.parent();
			innerContent.remove();
			
			parent.html(textContent);
		}
		
		/* 결재 요청 관련  끝 */
		
		/* 드래그 기능 활성화 함수 */
		function enableDraggable() {
			let items = document.querySelectorAll('#approval-area');
			let references = document.querySelectorAll("#references-area");
			
			items.forEach(item => {
				new Sortable(item, {
					group: 'items',
					swapThreshold: 0.20,
					animation: 400,
					ghostClass: "dragging",
					onEnd: function(e) {
						let movedItems = e.to.children;
						
						$('#add-line-area').html('');
						$('#appLine').children().not(':first').remove();
						for(let i = 0; i<movedItems.length; i++) {
							let el = $(movedItems[i]);
							
							let lineHTML = ''; 
							
							lineHTML += `
								<li class="py-2 px-3 position-relative text-gray" data-no="\${el.data('no')}">
									<span class="photo d-inline-block position-absolute"> <a href="#">
											<img alt="" src="\${el.data('profile') }" class="rounded-circle img-fluid w-100 h-100">
										</a>
									</span>
									<div class="wrap position-relative ms-4">
										<div class="info ms-4">
											<a href="#">
												<span class="name d-inline-block text-black font-weight-bold">\${el.data('emplNm') }</span>
											</a>
											<span class="dept d-block overflow-hidden text-truncate text-nowrap">\${el.data('deptNm') }</span>
											<div class="doc">
												<span class="status d-inline-block">결재예정</span>
											</div>
										</div>
									</div>
								</li>`;
								
							let html = '';
							
							html+='	<span class="sign_type1_inline" data-group-seq="0" data-group-name="승인" data-approval-line-no="'+el.data('no')+'">';
							html+='		<span class="sign_tit_wrap">';
							html+='			<span class="sign_tit">';
							html+='				<strong>승인</strong>';
							html+='			</span>';
							html+='		</span>';
							html+='		<span class="sign_member_wrap" id="activity_16557">';
							html+='			<span class="sign_member">';
							html+='				<span class="sign_rank_wrap">';
							html+='					<span class="sign_rank">'+el.data('deptNm')+'</span>';
							html+='				</span>';
							html+='				<span class="sign_wrap">';
							html+='					<span class="sign_name">'+el.data('emplNm')+'</span>';
							html+='				</span>';
							html+='				<span class="sign_date_wrap">';
							html+='					<span class="sign_date " id="sign_'+el.data('no')+'"></span>';
							html+='				</span>';
							html+='			</span>';
							html+='		</span>';
							html+='	</span>';
								
							$('#add-line-area').append(lineHTML);
							$('#appLine').append(html);
						}
					}
				});
			});
			
			references.forEach(item => {
				new Sortable(item, {
					group: 'items',
					swapThreshold: 0.20,
					animation: 400,
					ghostClass: "dragging",
				});
			});
		}
		
		/* 모달 제목 변경 토글 */
		function toggleTitle(e) {
			let isSelected = e.target.getAttribute('aria-selected');
			if (isSelected) {
				$('[data-title]').text($(e.target).text());
			}
		}
		
		tempsave.on('click', function(e) {
			e.preventDefault();
			
			showConfirm('임시저장 하시겠습니까?', '', 'question')
			.then(result => {
				if(result.isConfirmed) {
					let formData = getInsertData('temp');
					formData.delete('aprovlSttusCode');
					formData.delete('aprovlNm');
					formData.delete('aprovlMemo');
					
					formData.append('aprovlNm', $('#subject').val());
					formData.append('aprovlSttusCode', 'G101');
					
					let isExist = location.href.split('=')[1].replace('#', '');
					
					if(isExist) {
						formData.append('aprovlNo', isExist);
					}
					
					$.ajax({
						url: '/approval/insert',
						type: 'post',
						data: formData,
						processData: false,
						contentType: false,
					})
					.done(function(res) {
						if(res != '0') {
							showAlert('임시저장되었습니다!', '', 'success')
							.then(result => {
								if(result.isConfirmed) {
									location.href = '/approval/form?docNo=${docNo}&aprovlNo='+res;
								}
							})
						}
					})
				}
			})
		});
		
		preview.on('click', function(e) {
			let aprovlCnHTML = $('#aprovlCn').html();
			let title = $('#subject').val();
			let content = $('#innerContent').val();
			let date = $('#appDate .effective-date').val();
			
			if('${status}' == 'r') {
				content = replaceNewLineToBrTag($('#appContent textarea').val());
				date = $('#appDate input').val();
			}
			
			let modifiedTitle = '<span id="subjectPopup">'+title+'</span>';
			let modifiedContent = '<span id="innerContentPopup">'+content+'</span>';
			let modifiedDate = '<span id="datePopup">'+date+'</span>'
			let rankText = '<span id="signRankPopup" class="sign_rank">'+userVO.clsfNm+'</span>'
			let nameText = '<span id="signNamePopup">'+userVO.emplNm+'</span>'
			let userText = '<span id="darftUserPopup">'+userVO.emplNm+'</span>'
			let deptText = '<span id="darftDeptPopup">'+userVO.deptNm+'</span>'
			let dateText = '<span id="darftDatePopup">'+getCurrentDate()+'</span>'
			let codeNo = '<span id="docCodeNoPopup">${documentsVO.docCodeNo}</span>'
			
			let changedHTML = $('<div>').html(aprovlCnHTML); // 새로운 jQuery 객체를 생성하여 HTML을 래핑합니다.

			changedHTML.find('#subject').replaceWith(modifiedTitle);
			changedHTML.find('#innerContent').remove();
			changedHTML.find('#appContent').html(modifiedContent);
			changedHTML.find('#appDate').html(modifiedDate);
			changedHTML.find('.sign_rank').parent().html(rankText);
			changedHTML.find('.sign_name').parent().html(nameText);
			changedHTML.find('#draftUser').parent().html(userText);
			changedHTML.find('#draftDept').parent().html(deptText);
			changedHTML.find('#draftDate').parent().html(dateText);
			changedHTML.find('#docCodeNo').parent().html(codeNo);

			changedHTML = changedHTML.html(); // 최종 변경된 HTML을 문자열로 가져옵니다.
			
		    /* 
		    	draftDocCodeNoInput.value = docCodeNo;
				draftDeptInput.value = draftDept;
				draftUserInput.value = userName;
		    */
		    
			let html = `
		        <!DOCTYPE html>
		        <html lang="kr">
		        <head>
		            <meta charset="UTF-8">
		            <meta name="viewport" content="width=device-width, initial-scale=1.0">
		            <title>미리보기</title>
		            <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/approval/approval-form.css">
		        </head>
		        <body>
		    `;
		    
			let popup = window.open('', '미리보기', 'width=850, height=890');
			
			popup.document.write(html);
			popup.document.write(changedHTML);
			popup.document.write('</body></html>');
		})
		
		cancel.on('click', function() {
			location.href = '/approval/list/all';
		})

		draft.on('click', toggleDraftModal);
		draftModalExit.on('click', function() {
			if ($(this).data('exit') == 'draft')
				toggleDraftModal();
			else if($(this).data('exit') == 'saveline')
				toggleSaveLineModal()
			else if($(this).data('exit') == 'info')
				toggleInfoModal()
		});
		cancelDraftModal.on('click', toggleDraftModal);

		function toggleDraftModal() {
			if (!draftModal.hasClass('show')) {
				let subject = $('#subject').val();
				
				if (subject == null || subject.trim() == '') {
					showToast('제목을 입력해주세요!', 'warning');
					return;
				}

				$('#aprovlNm').text(subject);
			}

			draftModal.toggleClass('show');
		}
		
		info.on('click', function() {
			getApporvalInfo();
			toggleInfoModal();
		})
		
		function toggleInfoModal() {
			infoModal.toggleClass('show');
		}
		
		confirmInfoBtn.on('click', function() {
			toggleInfoModal();
		});
		
		cancelInfoBtn.on('click', function() {
			$('#add-line-area').html('');
			$('#appLine').children().not(':first').remove();
			$('#approval-area').children().remove();
			toggleInfoModal();
		});
		
		function toggleSaveLineModal() {
			$('#lineName').val('');
			saveLineModal.toggleClass('show');
		}
		
		function toggleSaveGroupModal() {
			$('#groupName').val('');
			saveGroupModal.toggleClass('show');
		}

		$(document).on('click', function(e) {
			if ($(e.target).is(draftModal)) {
				toggleDraftModal();
			}else if($(e.target).is(infoModal)) {
				toggleInfoModal();
			}
		});

		$('#main').on('click', function(e) {
			e.preventDefault();
			location.href = '/approval';
		});
		
		/* 조직도 렌더링 및 결재 정보 이벤트 처리 시작 */
		
		$('#oragn-search').on('propertychange change keyup paste input', function() {
			$('#jsTree').jstree(true).search($(this).val());
		})
		
		function createOrganTree(folderTree, empList) {
	        $("#jsTree").jstree({
	            "plugins": ["search", "wholerow", "sort"],
	            "search": {
	                "show_only_matches" : true,
	                "show_only_matches_children" : true,
	            },
	            "sort": function(a, b){
	            	let lvl1 = this.get_node(a).original.clsfCode;
	            	let lvl2 = this.get_node(b).original.clsfCode;
	            	
	                if (lvl1 > lvl2) {
	                    return -1;
	                } else if (lvl1 < lvl2) {
	                    return 1;
	                } else {
	                    return 0;
	                }
	            },
	            'core': {
	            	'themes': {
	            		'variant' : 'large'
	            	},
	                'data': folderTree,
	                "check_callback": true,
	            }
	        });
	        
	        $("#jsTree").jstree('open_all');
	        
	        $("#jsTree").on('loaded.jstree', function(e, data) {
				for(let emp of empList) {
					let node = {
						id : emp.emplNo,
						text : emp.emplNm + ' ' + emp.clsfNm,
						icon : '/profile/view/'+emp.emplProflPhoto,
						emplNo : emp.emplNo,
						emplNm : emp.emplNm,
						deptNm : emp.deptNm,
						clsfCode : emp.clsfCode,
						emplProflPhoto : emp.emplProflPhoto
					}
					let position = 'last';
					
					if(emp.deptCode.startsWith('D1') || emp.deptCode.startsWith('D3')){
						position = 'first';
					}
					
					$('#jsTree').jstree(true).create_node(emp.deptCode, node, position);
				}
	        });
		}
		
		/* 조직도 렌더링 및 결재 정보 이벤트 처리 끝 */
		
		
		/* DROP ZONE 시작 */
		
		var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
		dropzonePreviewNode.id = '';
		var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
		dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
		
		let thumbnail = {
			'pdf' : '${pageContext.request.contextPath}/resources/project/images/file/pdf.png',	
			'xls' : '${pageContext.request.contextPath}/resources/project/images/file/xlsx.png',	
			'xlsx' : '${pageContext.request.contextPath}/resources/project/images/file/xlsx.png',	
			'csv' : '${pageContext.request.contextPath}/resources/project/images/file/csv.png',	
			'doc' : '${pageContext.request.contextPath}/resources/project/images/file/docx.png',	
			'docx' : '${pageContext.request.contextPath}/resources/project/images/file/docx.png',	
			'hwp' : '${pageContext.request.contextPath}/resources/project/images/file/hwp.png',	
			'hwpx' : '${pageContext.request.contextPath}/resources/project/images/file/hwp.png',	
			'exe' : '${pageContext.request.contextPath}/resources/project/images/file/exe.png',	
			'zip' : '${pageContext.request.contextPath}/resources/project/images/file/zip.png',	
			'css' : '${pageContext.request.contextPath}/resources/project/images/file/css.png',	
			'js' : '${pageContext.request.contextPath}/resources/project/images/file/js.png',	
			'other' : '${pageContext.request.contextPath}/resources/project/images/file/file.png'	
		};
		
		//이미지 파일인지 체크
		function isImageFile(file) {
			var ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져온다.
			return ($.inArray(ext, [ "jpg", "jpeg", "png", "gif" ]) === -1) ? false
					: true;
		}

		const dropzone = new Dropzone('.dropzone', {
			url : '/approval/insert',
			method : 'post',
			headers : {
				header : token
			},

			previewTemplate : previewTemplate,
			previewsContainer : '#dropzone-preview',

			autoProcessQueue : false,
			clickable : true,
			autoQueue : false,
			createImageThumbnails : true,

			thumbnailHeight : 120,
			thumbnailWidth : 120,

			paramName : 'files',
			uploadMultiple : true,
			parallelUploads : 100,
			maxFiles: 100,
			maxFilesize : 100,

			dictDefaultMessage : '이 곳에 파일을 드래그 하세요. 또는 파일 선택',
			dictMaxFilesExceeded : '최대 파일 수를 초과했습니다',
			dictFileTooBig : '파일 최대 크기 범위를 초과했습니다',

			init : function() {

				let drop = this;

				if (drop.getRejectedFiles().length > 0) {
					let files = dropzone.getRejectedFiles();
					console.log('거부된 파일이 있습니다.', files);
					return;
				}
				
				drop.on('addedfile', function(file) {
					
					if(this.files.length) {
						
						var hasFile = false;
						
						for(let i = 0; i < this.files.length - 1; i++) {
							if(
								this.files[i].name === file.name &&
								this.files[i].size === file.size &&
								this.files[i].lastModifiedDate.toString() === file.lastModifiedDate.toString()
							) {
								this.removeFile(file);
								alert('동일한 파일입니다!');
							}
						}
					}
					
					if(!isImageFile(file)) {
						var ext = file.name.split('.').pop().toLowerCase();
						if(thumbnail[ext]) {
							this.emit('thumbnail', file, thumbnail[ext]);
						}else{
							this.emit('thumbnail', file, thumbnail['other']);
						}
					}
				});
			}
		});
		/* DROP ZONE 끝 */
	});
</script>