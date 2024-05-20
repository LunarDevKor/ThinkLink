<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.w-16 {
	width: 16% !important;
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
<div class="card overflow-hidden chat-application">
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
				<h3 class="fw-semibold mb-8" style="margin-left: 10px;"><i class="fa-sharp fa-regular fa-envelope fa-fw fa"></i>&nbsp;&nbsp;메일</h3>
			</a>
				<button class="btn btn-primary rounded-0 fw-semibold py-8 w-100" style="margin-top: 20px;" onclick="location.href='/mail/emailForm'">메일 쓰기</button>
			</div>
			<ul class="list-group mh-n100" data-simplebar>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/inbox">
						<i class="ti ti-inbox fs-5"></i>받은메일함<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${inboxNoRead }</span>
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><div class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1">
						<a href="/mail/sent">
							<i class="ti ti-brand-telegram fs-5" style="margin-right: 12px;"></i>보낸메일함
						</a>
						<button type="button" class="btn btn-sm bg-primary-subtle text-primary ms-auto" onclick="location.href='/mail/check'">수신확인</button>
					</div></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/noRead">
						<i class="ti ti-inbox fs-5"></i>안읽은메일함
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/importantbox">
						<i class="ti ti-star fs-5"></i>중요메일함
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/toMe">
						<i class="ti ti-inbox fs-5"></i>내게쓴메일함<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${toMeNoRead }</span>
					</a></li>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/reservation" class="d-block ">
						<i class="ti ti-badge fs-5"></i>예약메일함<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${reservation }</span>
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/draft">
						<i class="ti ti-file-text fs-5"></i>임시보관함
					</a></li>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/trash">
						<i class="ti ti-trash fs-5"></i>휴지통<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${trashNoRead }</span>
					</a></li>
			</ul>
		</div>
		<!-- 메뉴 옆 오른쪽 구역 시작 -->
		<div class="w-100">
			<div class="chat-container h-100 w-100">
				<div class="chat-box-inner-part h-100">
					<div class="chatting-box app-email-chatting-box">
						<div class="p-9 py-3 border-bottom chat-meta-user">
							<ul class="list-unstyled mb-0 d-flex align-items-center">
								<li class="d-lg-none d-block"><a class="text-dark back-btn px-2 fs-5 bg-hover-primary nav-icon-hover position-relative z-index-5" href="javascript:void(0)">
										<i class="ti ti-arrow-left"></i>
									</a></li>
								<li class="position-relative" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="중요"><a class="text-dark px-2 fs-5 bg-hover-primary nav-icon-hover position-relative z-index-5" href="javascript:void(0)" onclick="important(${email.emailNo },${sender.emplNo })">
										<i class="ti ti-star"></i>
									</a></li>
								<li class="position-relative" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="삭제"><a class="text-dark px-2 fs-5 bg-hover-primary nav-icon-hover position-relative z-index-5" href="javascript:void(0)" onclick="deleteEmail(${email.emailNo },${sender.emplNo })">
										<i class="ti ti-trash"></i>
									</a></li>
							</ul>
						</div>
						<div class="position-relative overflow-hidden">
							<div class="position-relative">
								<div class="chat-box email-box mh-n100 p-9" data-simplebar="init">
									<div class="chat-list chat active-chat" data-user-id="1">
										<div class="hstack align-items-start mb-7 pb-1 align-items-center justify-content-between flex-wrap gap-6">
											<div class="d-flex align-items-center gap-2">
												보낸 사람
												<img src="view/${sender.emplProflPhoto }" alt="${sender.emplProflPhoto }" width="48" height="48" class="rounded-circle">
												<div>
													<h6 class="fw-semibold mb-0">${sender.deptNm }&nbsp;${sender.classOfPositionVO.clsfNm }</h6>
													<h5 class="fw-semibold mb-0">${sender.emplNm }</h5>
													<p class="mb-0">${sender.emplId }@thinklink.net</p>
												</div>
											</div>
										</div>
										<div class="hstack align-items-start mb-7 pb-1 align-items-center justify-content-between flex-wrap gap-6">
											<div class="d-flex align-items-center gap-2">
												받는 사람
												<c:forEach items="${receptionList }" var="receptionVO">
													<c:if test="${receptionVO.emailRecptnRecpTypeCode eq 'E201'}">
														<img src="view/${receptionVO.receiverVO.emplProflPhoto }" alt="${receptionVO.receiverVO.emplProflPhoto }" width="48" height="48" class="rounded-circle">
														<div>
															<h6 class="fw-semibold mb-0">${receptionVO.receiverVO.deptNm }&nbsp;${receptionVO.receiverVO.classOfPositionVO.clsfNm }</h6>
															<h5 class="fw-semibold mb-0">${receptionVO.receiverVO.emplNm }</h5>
															<p class="mb-0">${receptionVO.receiverVO.emplId }@thinklink.net</p>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div class="hstack align-items-start mb-7 pb-1 align-items-center justify-content-between flex-wrap gap-6">
											<div class="d-flex align-items-center gap-2">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;참조&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<c:forEach items="${receptionList }" var="receptionVO">
													<c:if test="${receptionVO.emailRecptnRecpTypeCode eq 'E202'}">
														<img src="view/${receptionVO.receiverVO.emplProflPhoto }" alt="${receptionVO.receiverVO.emplProflPhoto }" width="48" height="48" class="rounded-circle">
														<div>
															<h6 class="fw-semibold mb-0">${receptionVO.receiverVO.deptNm }&nbsp;${receptionVO.receiverVO.classOfPositionVO.clsfNm }</h6>
															<h5 class="fw-semibold mb-0">${receptionVO.receiverVO.emplNm }</h5>
															<p class="mb-0">${receptionVO.receiverVO.emplId }@thinklink.net</p>
														</div>
													</c:if>
												</c:forEach>
											</div>
											<p class="mb-0 fs-2 text-muted">
												<fmt:formatDate value="${email.emailTrnsmis }" pattern="yyyy.MM.dd a hh:mm:ss" />
											</p>
										</div>
									</div>
									<hr>
										<h4 class="fw-semibold text-dark mb-3">${email.emailNm }</h4>
										<p class="mb-3 text-dark">${email.emailCn }</p>
									<c:if test="${not empty attachFileList }">
									<div class="border-bottom pb-7 mb-7">
									</div>
										<div class="mb-3">
											<h6 class="fw-semibold mb-0 text-dark mb-3">첨부파일</h6>
											<div class="d-block d-sm-flex align-items-center gap-4">
												<c:forEach items="${attachFileList }" var="attachFile">
													<a href="/download?p=${attachFile.atchFilePath }" class="hstack gap-3 mb-2 mb-sm-0">
														<div class="d-flex align-items-center gap-3">
															<div class="rounded-1 text-bg-light p-6">
																<i class="fa-solid fa-download"></i>
															</div>
															<div>
																<h6 class="fw-semibold">${attachFile.atchFileOrnlFileNm }</h6>
																<div class="d-flex align-items-center gap-3 fs-2 text-muted">
																	<span>${attachFile.atchFileFancysize}</span>
																</div>
															</div>
														</div>
													</a>
												</c:forEach>
											</div>
										</div>
									</c:if>
								</div>
							</div>
							<div class="px-9 py-3 border-top chat-send-message-footer">
								<div class="d-flex align-items-center justify-content-between">
									<ul class="list-unstyled mb-0 d-flex align-items-center gap-7">
										<li><a class="text-dark bg-hover-primary d-flex align-items-center gap-1" href="/mail/reply?emailNo=${email.emailNo }">
												<i class="ti ti-arrow-back-up fs-5"></i> 답장
											</a></li>
										<li><a class="text-dark bg-hover-primary d-flex align-items-center gap-1" href="/mail/forward?emailNo=${email.emailNo }">
												<i class="ti ti-arrow-forward-up fs-5"></i> 전달
											</a></li>
									</ul>
								</div>
							</div>
						</div>
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
		showToast("${message}", 'warning');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>
function deleteEmail(emailNo,senderNo) {
	console.log(emailNo,senderNo);
	showConfirm("해당 메일을 삭제하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			location.href="/mail/delete?emailNo="+emailNo+"&senderNo="+senderNo+"&where=${where}";
		}	
	});
	
}

function important(emailNo,senderNo) {
	
	//emailNo 저장할 배열
	var selectedValues = [];
	selectedValues.push(emailNo);
	// senderNo 저장할 배열
	var selectedSenderNos = [];
	selectedSenderNos.push(senderNo);
	
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
        success : function(res, status, xhr) {
			if(xhr.status === 200) {
				showToast("메일이 중요메일함에 추가되었습니다!", 'success');
			}else {
				showToast("중요메일함 추가가 실패되었습니다!", 'warning');
			}
        }
	});
}


</script>