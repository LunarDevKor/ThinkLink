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

.solar--paperclip-linear {
	display: inline-block;
	width: 15px;
	height: 15px;
	background-repeat: no-repeat;
	background-size: 100% 100%;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='none' stroke='%23696969' stroke-linecap='round' stroke-width='1.5' d='m7.918 17.807l7.89-7.553a2.253 2.253 0 0 0 0-3.284a2.503 2.503 0 0 0-3.43 0l-7.834 7.498a4.28 4.28 0 0 0 0 6.24c1.8 1.723 4.718 1.723 6.518 0l7.949-7.608c2.652-2.54 2.652-6.656 0-9.196c-2.653-2.539-6.954-2.539-9.607 0L3 10.034'/%3E%3C/svg%3E");
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
		<div class="w-100">
			<div class="min-width-340">
				<div class="border-end user-chat-box h-100">
					<div class="px-4 pt-9 pb-6 d-none d-lg-block">
						<form id="searchForm">
							<input type="hidden" name="page" id="page" />
							<div class="d-flex align-items-center">
								<div class="col-6">
									<div>
										<span class="fs-5 fw-semibold">
											<i class="ti ti-inbox fs-5"></i> 내게쓴메일함
										</span>
										<span>&nbsp;&nbsp;내게쓴메일 ${pagingVO.totalRecord } / 안읽은메일 ${noRead }</span>
									</div>
								</div>
								<div class="col-6">
									<div class="input-group">
										<input type="text" class="form-control rounded-0" id="searchWord" name="searchWord" value="${searchWord }" placeholder="부서, 직급, 이름, 제목" />
										<!-- 모달 버튼 -->
										<button type="button" class="btn rounded-0 bg-info text-white" data-bs-toggle="modal" data-bs-target="#samedata-modal" data-bs-whatever="@mdo">상세</button>
										<button type="submit" class="btn rounded-0 text-white" style="background: #007bff;">검색</button>
									</div>
								</div>
							</div>
						</form>
					</div>

					<!-- 모달 시작 -->
					<div class="modal fade" id="samedata-modal" tabindex="-1" aria-labelledby="exampleModalLabel1" data-bs-backdrop="false" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header d-flex align-items-center">
									<h4 class="modal-title" id="exampleModalLabel1">전체 검색</h4>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" _mstaria-label="59709"></button>
								</div>
								<div class="modal-body">
									<form id="searchDetailForm" action="/mail/searchDetail" method="get">
										<div class="mb-3 row">
											<label for="recipient-name" class="col-sm-3 col-form-label text-center" style="font-weight: lighter; font-size: 15px;">보낸 사람</label>
											<div class="col-sm-9">
												<input type="text" class="form-control" id="searchSender" name="searchSender">
											</div>
										</div>
										<div class="mb-3 row">
											<label for="recipient-name" class="col-sm-3 col-form-label text-center" style="font-weight: lighter; font-size: 15px;">받는 사람</label>
											<div class="col-sm-9">
												<input type="text" class="form-control" id="searchReceiver" name="searchReceiver">
											</div>
										</div>
										<div class="mb-3 row">
											<label for="recipient-name" class="col-sm-3 col-form-label text-center" style="font-weight: lighter; font-size: 15px;">제목</label>
											<div class="col-sm-9">
												<input type="text" class="form-control" id="searchTitle" name="searchTitle">
											</div>
										</div>
										<div class="mb-3 row">
											<label for="recipient-name" class="col-sm-3 col-form-label text-center" style="font-weight: lighter; font-size: 15px;">내용</label>
											<div class="col-sm-9">
												<input type="text" class="form-control" id="searchContent" name="searchContent">
											</div>
										</div>
										<div class="mb-3 row">
											<label for="recipient-name" class="col-sm-3 col-form-label text-center" style="font-weight: lighter; font-size: 15px;">첨부파일명</label>
											<div class="col-sm-9">
												<input type="text" class="form-control" id="searchAttach" name="searchAttach">
											</div>
										</div>
										<sec:csrfInput />
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
									<button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="searchCancle">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 모달끝 -->

					<nav class="navbar navbar-expand-sm">
						<div class="container-fluid" style="margin-left: 12px;">
							<div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
								<ul class="navbar-nav">
									<li class="nav-item">
										<input type="checkbox" class="form-check-input me-1" name="selectAll" id="selectAll">
										<label for="selectAll">전체선택</label>
									</li>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<li class="nav-item">
										<span id="trash">
											<label for="trash" style="cursor: pointer;"><i class="ti ti-trash fs-5 me-1"></i>삭제 
										</span>
										</label>
									</li>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<li class="nav-item">
										<span id="important">
											<label for="important" style="cursor: pointer;"><i class="ti ti-star fs-5 me-1"></i>중요 
										</span>
										</label>
									</li>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<li class="nav-item">
										<span id="read">
											<label for="read" style="cursor: pointer;"><i class="ti ti-inbox fs-5 me-1"></i>읽음처리 
										</span>
										</label>
									</li>
								</ul>
							</div>
						</div>
					</nav>

					<div class="app-chat overflow-y-auto" style="max-height: 650px; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">
						<ul class="chat-users" style="max-height: 650px;">
							<!-- 메일 목록 시작 -->
							<c:set value="${pagingVO.dataList }" var="emailList" />
							<c:choose>
								<c:when test="${empty emailList }">
									<li>
										<a href="javascript:void(0)" class="px-4 py-3 bg-hover-light-black d-flex align-items-start justify-content-between chat-user" id="chat_user_3" data-user-id="3">
											<div class="form-check mb-0"></div>
											<div class="position-relative w-100 ms-2 text-center">
												<div class="d-flex align-items-center justify-content-between mb-2">
													<h6 class="mb-0"></h6>
												</div>
												<h6 class="text-dark">해당 메일함에 메일이 존재하지 않습니다.</h6>
												<div class="d-flex align-items-center justify-content-between">
													<div class="d-flex align-items-center"></div>
												</div>
											</div>
										</a>
									</li>
								</c:when>
								<c:otherwise>
									<c:forEach items="${emailList }" var="email">
										<li id="${email.emailNo }">
											<a href="javascript:void(0)" class="px-4 py-3 bg-hover-light-black d-flex align-items-start justify-content-between chat-user" id="chat_user_3" data-user-id="3">
												<div class="form-check mb-0">
													<input class="form-check-input" type="checkbox" data-sender-no="${email.senderNo }" value="${email.emailNo }" id="select" name="select" />
													<c:if test="${email.emailReceptionVO.emailRecptnImprtncYn eq 'N'}">
														<span class="material-symbols-light--star-outline" name="imp" id="star${email.emailNo }" onclick="impOne(${email.emailNo },${email.senderNo })"></span>
													</c:if>
													<c:if test="${email.emailReceptionVO.emailRecptnImprtncYn eq 'Y'}">
														<span class="material-symbols-light--star" id="star${email.emailNo }" onclick="impOne(${email.emailNo },${email.senderNo })"></span>
													</c:if>
												</div>
												<div class="position-relative w-100 ms-2">
													<div class="d-flex align-items-center justify-content-between mb-2">
														<h6 class="text-dark">${email.employeeVO.deptCode }&nbsp;${email.employeeVO.emplNm }&nbsp;${email.employeeVO.classOfPositionVO.clsfNm }</h6>
													</div>
													<c:if test="${email.emailReceptionVO.emailRecptnReadYn eq 'N'}">
														<h6 class="mb-0" name="mailNm" style="font-weight: bold;" onclick="location.href='/mail/detail?emailNo=${email.emailNo}&where=${where }'">${email.emailNm}
															<c:if test="${email.atchFileGroupNo ne 0 }">
															&nbsp;<span class="solar--paperclip-linear"></span>
															</c:if>
														</h6>
													</c:if>
													<c:if test="${email.emailReceptionVO.emailRecptnReadYn eq 'Y'}">
														<h6 class="mb-0" onclick="location.href='/mail/detail?emailNo=${email.emailNo}&where=${where }'">${email.emailNm }
															<c:if test="${email.atchFileGroupNo ne 0 }">
															&nbsp;<span class="solar--paperclip-linear"></span>
															</c:if>
														</h6>
													</c:if>
													<div class="d-flex align-items-center justify-content-between">
														<div class="d-flex align-items-center"></div>
														<p class="mb-0 fs-2 text-muted">
															<fmt:formatDate value="${email.emailTrnsmis }" pattern="yyyy.MM.dd a hh:mm" />
														</p>
													</div>
												</div>
											</a>
										</li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<!-- 메일 목록 끝 -->
						</ul>
					</div>
					<div>
						<nav aria-label="Page navigation example" id="pagingArea" style="margin-top: 3px;">${pagingVO.pagingHTML }</nav>
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

var trash = $("#trash"); // 휴지통
var important = $("#important"); // 중요
var read = $("#read"); // 읽음처리

var searchBtn = $("#searchBtn"); // 모달 검색
var searchDetailForm = $("#searchDetailForm"); // 상세검색 폼
var searchCancle = $("#searchCancle"); // 모달 취소

searchBtn.on("click", function() {
	
	var searchSender = $("#searchSender").val(); // 보낸사람
	var searchReceiver = $("#searchReceiver").val(); // 받는사람
	var searchTitle = $("#searchTitle").val(); // 제목
	var searchContent = $("#searchContent").val(); // 내용
	var searchAttach = $("#searchAttach").val(); // 파일첨부명
	
	if((searchSender == null || searchSender == '') 
			&& (searchReceiver == null || searchReceiver == '')
			&& (searchTitle == null || searchTitle == '')
			&& (searchContent == null || searchContent == '')
			&& (searchAttach == null || searchAttach == '')) {
		showToast("검색할 단어를 입력해주세요!", "info");
		return false;
	}
	
	searchDetailForm.submit();
});

//모달이 닫힐 때 텍스트 초기화
$('#samedata-modal').on('hidden.bs.modal', function () {
    $(this).find('input[type=text]').val(''); // 모든 input 태그의 값을 빈 문자열로 설정
});

//emailNo 저장할 배열
var selectedValues = [];
// senderNo 저장할 배열
var selectedSenderNos = [];

//체크된 emailNo 배열로 저장
function getSelectedEmails() {
    selectedValues = [];
    var selectedCheckboxes = $('input[name="select"]:checked'); // 선택된 메일 체크박스
    selectedCheckboxes.each(function() {
        selectedValues.push($(this).val());
    });
    return selectedValues;
}

// 체크된 senderNo 배열로 저장
function getSelectedSenderNos() {
    selectedSenderNos = [];
    var selectedCheckboxes = $('input[name="select"]:checked'); // 선택된 메일 체크박스
    selectedCheckboxes.each(function() {
    	selectedSenderNos.push($(this).data("sender-no"));
    });
    return selectedSenderNos;
}


//휴지통 버튼
trash.on("click", function() { 
	
	getSelectedEmails();
	getSelectedSenderNos();
	 
	if(selectedValues.length == 0){
		showToast("메일을 선택해주세요!", 'info');
		return false;
	}
	
	showConfirm(selectedValues.length+"개의 메일을 삭제하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
		        url: "deleteEmailArray",
		        method: "POST",
		        data: JSON.stringify({
		        	emailArray : selectedValues,
		        	senderArray : selectedSenderNos
				}),
				contentType : "application/json;charset=utf-8",
		        beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
		        success: function(res) {
		        	  $.each(selectedValues, function(index, value) {
		                  $('input[name="select"][value="' + value + '"]').closest('li').remove();
		              });
		        	  showToast(res, 'success');
		        	// 모든 체크박스의 체크를 해제
		        	  $('input[type="checkbox"]').prop('checked', false);
		        },
		        error: function(xhr, status, res) {
		        	if(!res) {
		        		showToast("메일을 선택해주세요!", 'info');
		        	}else {
		        		showToast(res, 'warning');
		        	}
		        }
		    });
		}	
	});
});

// 중요 버튼
important.on("click", function() {
	
	getSelectedEmails();
	getSelectedSenderNos();
	
	$.ajax({
        url: "importantEmailArray",
        method: "POST",
        data: JSON.stringify({
        	emailArray : selectedValues,
        	senderArray : selectedSenderNos
		}),
		contentType : "application/json;charset=utf-8",
        beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
        success: function(res) {
        	  $.each(selectedValues, function(index, value) {
        		// 요소의 클래스를 변경
        		  $('input[name="select"][value="' + value + '"]').closest('li').find('[name="imp"]').removeClass('material-symbols-light--star-outline').addClass('material-symbols-light--star');
              });
        	  showToast(res, 'success');
        	// 모든 체크박스의 체크를 해제
        	  $('input[type="checkbox"]').prop('checked', false);
        },
        error: function(xhr, status, res) {
        	if(!res) {
        		showToast("메일을 선택해주세요!", 'info');
        	}else {
        		showToast(res, 'warning');
        	}
        }
    });
});

//읽음처리 버튼
read.on("click", function() {
	
	getSelectedEmails();
		
	$.ajax({
        url: "readEmailArray",
        method: "POST",
        data: JSON.stringify({
        	emailArray : selectedValues,
		}),
		contentType : "application/json;charset=utf-8",
        beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
        success: function(res) {
        	  $.each(selectedValues, function(index, value) {
        		  $('input[name="select"][value="' + value + '"]').closest('li').find('[name="mailNm"]').css('font-weight', '');
              });
        	  showToast(res, 'success');
			// 모든 체크박스의 체크를 해제
        	  $('input[type="checkbox"]').prop('checked', false);
        },
        error: function(xhr, status, res) {
        	if(!res) {
        		showToast("메일을 선택해주세요!", 'info');
        	}else {
        		showToast(res, 'warning');
        	}
        }
    });
});



$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click","a",function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});

// 체크박스 전체 선택
selectAll.addEventListener('change', function() {
	let select = document.getElementsByName('select');
	for(let i in select) {
		select[i].checked = selectAll.checked;
	}
});

// 체크박스 전체 선택
function isSelectAll() {
	let select = document.getElementsByName('select');
	
	select.forEach(selected => {
		selected.addEventListener('click', function(e) {
			var allChecked = true;
			
			select.forEach(function(checkbox) {
	            if (!checkbox.checked) {
	                allChecked = false;
	            }
	        });
			
	        selectAll.checked = allChecked;
		});
	});
}

//별표시 눌러 중요표시 체크, 해제
function impOne(emailNo, senderNo) {
	
	//emailNo 저장할 배열
	var selectedValues = [];
	selectedValues.push(emailNo);
	// senderNo 저장할 배열
	var selectedSenderNos = [];
	selectedSenderNos.push(senderNo);
	
	var starElement = $("#star"+emailNo);
	var starClass = starElement.hasClass("material-symbols-light--star"); // 중요표시 되어있음

	if(starClass) { // 중요표시 되어있을 때 누르면 중요표시 없애기
		
		$.ajax({
			url:"unimportantEmailArray",
			type:"post",
			data: JSON.stringify({
	        	emailArray : selectedValues,
	        	senderArray : selectedSenderNos
			}),
			contentType : "application/json;charset=utf-8",
	        beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
	        success: function(res, status, xhr) {
				if(xhr.status === 200) {
	        		// 요소의 클래스를 변경
	        		starElement.removeClass('material-symbols-light--star').addClass('material-symbols-light--star-outline');
				}else {
					showToast("중요표시 해제가 실패되었습니다!", 'warning');
				}
			}
		});
	}else { // 중요표시 되어있지 않을 때 누르면 중요표시 하기
		
		$.ajax({
			url:"importantEmailArray",
			type:"post",
			data: JSON.stringify({
	        	emailArray : selectedValues,
	        	senderArray : selectedSenderNos
			}),
			contentType : "application/json;charset=utf-8",
	        beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
	        success: function(res, status, xhr) {
				if(xhr.status === 200) {
	        	// 요소의 클래스를 변경
	        	 	starElement.removeClass('material-symbols-light--star-outline').addClass('material-symbols-light--star');
				}else{
					showToast("중요메일함 추가가 실패되었습니다!", 'warning');
				}
			}
		});
	}
}

</script>