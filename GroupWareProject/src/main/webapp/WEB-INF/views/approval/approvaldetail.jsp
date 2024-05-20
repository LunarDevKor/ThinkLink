<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/approval/approval-form.css">
<style>
.swal2-container {
	z-index: 20000 !important;
}
</style>
<div class="card rounded-0 flex-fill">
	<div class="m-3 ms-4">
		<h1 class="fw-semibold">
			${approvalVO.aprovlNm }
			<span class="fs-3 text-gray">in ${approvalVO.docNm }</span>
		</h1>
	</div>
	<div class="d-flex justify-content-start align-items-center border-bottom">
		<div class="ms-4 py-3">

			<c:set var="isCanceled" value="true" />
			<c:forEach var="c" items="${approvalVO.sanctionerList }" end="1">
				<c:if test="${c.sanctnerSttusCode eq 'G303'}">
					<c:set var="isCanceled" value="false" />
				</c:if>
			</c:forEach>

			<c:if test="${approvalVO.emplNo eq employee.emplNo }">
				<c:if test="${isCanceled eq true and approvalVO.aprovlSttusCode ne 'G101' and approvalVO.aprovlSttusCode ne 'G104'}">
					<a href="#" class="ms-3 fa-active" id="draft-cancel" data-cancel-no="${approvalVO.aprovlNo}">
						<i class="fa-sharp fa-regular fa-circle-x fa-xl fa-fw fa"></i>
						<span>상신취소</span>
					</a>
				</c:if>
			</c:if>

			<c:if test="${approvalVO.emplNo eq employee.emplNo and approvalVO.aprovlSttusCode eq 'G104' }">
				<a href="#" class="ms-3 fa-active" id="draft-reconfirm" data-aprovl-no="${approvalVO.aprovlNo }">
					<i class="fa-light fa-pen-to-square fa-xl fa-fw fa fw-semibold"></i>
					<span>재기안</span>
				</a>
			</c:if>
			<c:if test="${approvalVO.aprovlSttusCode ne 'G103' or approvalVO.aprovlSttusCode eq 'G104'}">
				<c:set var="nowApproval" value="0" />
				<c:set var="myOrdr" value="0" />

				<c:forEach var="sanc" items="${approvalVO.sanctionerList }">
					<c:if test="${sanc.approverNo eq employee.emplNo}">
						<c:set var="myOrdr" value="${sanc.sanctnerOrdr }" />
					</c:if>
				</c:forEach>

				<c:forEach var="sanctioner" items="${approvalVO.sanctionerList }" varStatus="status">
					<c:choose>
						<c:when test="${status.count eq myOrdr and sanctioner.sanctnerSttusCode eq 'G303'}">
							<a href="#" class="ms-3 fa-active" id="approval-cancel" data-aprovl-no="${approvalVO.aprovlNo }">
								<i class="fa-sharp fa-regular fa-circle-x fa-xl fa-fw fa"></i>
								<span>결재취소</span>
							</a>
						</c:when>
						<c:when test="${status.count eq myOrdr and sanctioner.sanctnerSttusCode eq 'G305'}">
							<a href="#" class="ms-3 fa-active" id="approval-confirm">
								<i class="fa-light fa-pen-to-square fa-xl fa-fw fa fw-semibold"></i>
								<span>결재</span>
							</a>
							<a href="#" class="ms-3 fa-active" id="approval-return">
								<i class="fa-sharp fa-regular fa-arrow-right fa-xl fa-fw fa"></i>
								<span>반려</span>
							</a>
						</c:when>
						<c:when test="${status.count lt myOrdr and sanctioner.sanctnerSttusCode ne 'G303' or status.count le myOrdr and sanctioner.sanctnerSttusCode eq 'G304' }">
							<c:set var="nowApproval" value="${nowApproval + 1 }" />
						</c:when>
						<c:when test="${status.count eq myOrdr}">
							<c:if test="${nowApproval eq 0}">
								<a href="#" class="ms-3 fa-active" id="approval-confirm">
									<i class="fa-light fa-pen-to-square fa-xl fa-fw fa fw-semibold"></i>
									<span>결재</span>
								</a>
								<a href="#" class="ms-3 fa-active" id="approval-return">
									<i class="fa-sharp fa-regular fa-arrow-right fa-xl fa-fw fa"></i>
									<span>반려</span>
								</a>
								<a href="#" class="ms-3 fa-active" id="approval-hold">
									<i class="fa-sharp fa-regular fa-clock fa-xl fa-fw fa"></i>
									<span>보류</span>
								</a>
							</c:if>
						</c:when>
					</c:choose>
				</c:forEach>
			</c:if>
			<a href="#" class="ms-3 fa-active" id="approval-info">
				<i class="fa-sharp fa-regular fa-circle-exclamation fa-xl fa-fw fa"></i>
				<span>결재정보</span>
			</a>
		</div>
		<a href="#" class="ms-auto me-4 fa-active" id="main">
			<i class="fa-light fa-bars fa-xl fa-fw fa"></i>
			<span>목록</span>
		</a>
	</div>
	<div class="card-body rounded-0 p-0">
		<div class="row">
			<div class="col-lg-9">
				<div class="mx-5 my-4 p-3 border border-4" style="border-color: #999;">
					<div class="d-flex justify-content-center align-items-center">
						<div id="aprovlCn" class="form_doc_editor editor_view" onsubmit="return false;">
							<!-- 문서 내용 표시 테스트 -->
							${approvalVO.aprovlCn }
						</div>
					</div>
					<div class="card rounded-0 bg-gray border-gray mt-5">
						<div class="d-inline py-3 px-2">
							<i class="fa-sharp fa-regular fa-paperclip fa-fw"></i>
							<span class="fw-semibold">첨부파일 ${approvalVO.fileCount }개</span>
						</div>
						<div class="card-body rounded-0 bg-light p-0">
							<c:forEach var="atchFile" items="${attachFileGroupVO.attachFileList }">
								<div>
									<c:choose>
										<c:when test="${atchFile.atchFileExtsn eq 'png' or atchFile.atchFileExtsn eq 'jpg' or atchFile.atchFileExtsn eq 'jpeg' or atchFile.atchFileExtsn eq 'gif'}">
											<div class="w-25 text-center p-3">
												<img alt="" src="/display?p=${atchFile.atchFilePath }" class="img-thumbnail img-fluid" />
												<span class="fw-semibold">${atchFile.atchFileOrnlFileNm }</span>
											</div>
										</c:when>
										<c:otherwise>
											<a href="/download?p=${atchFile.atchFilePath }">
												<span class="fw-bold">${atchFile.atchFileOrnlFileNm }
													<font style="color: gray;">(${atchFile.atchFileFancysize })</font>
												</span>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 ps-0 aside border-start">
				<div class="header" style="z-index: 1;">
					<div class="text-center border-bottom border-start px-1 py-2">
						<span class="font-weight-bold">결재선</span>
					</div>
					<div>
						<ul id="add-line-area">
							<li class="py-2 px-3 position-relative"><span class="photo d-inline-block position-absolute">
									<a href="#">
										<img alt="" src="/profile/view/${approvalVO.aprovlProflPhoto }" class="rounded-circle img-fluid w-100 h-100">
									</a>
								</span>
								<div class="wrap position-relative ms-4">
									<div class="info ms-4">
										<a href="#">
											<span class="name d-inline-block text-black font-weight-bold">${approvalVO.emplNm }</span>
										</a>
										<span class="dept d-block overflow-hidden text-truncate text-nowrap">${approvalVO.aprovlDeptNm }</span>
										<div class="doc">
											<span class="status d-inline-block text-gray">기안 상신 | ${approvalVO.submitDtToString }</span>
										</div>
										<div class="memo">
											<c:if test="${approvalVO.aprovlMemo ne null and approvalVO.aprovlMemo ne ''}">
												<span class="alert alert-secondary p-0 px-2 mt-1">
													<i class="fa-sharp fa-light fa-memo fa-fw fa"></i>
													<font class="fw-semibold">${approvalVO.aprovlMemo }</font>
												</span>
											</c:if>
										</div>
									</div>
								</div></li>
							<c:forEach var="sanctioner" items="${approvalVO.sanctionerList }">
								<li class="py-2 px-3 position-relative <c:if test="${sanctioner.sanctnerSttusCode eq 'G301'}">current</c:if>"><span class="photo d-inline-block position-absolute">
										<a href="#">
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
												<c:set var="dt" value="${sanctioner.sanctnerDtToString }" />
												<c:if test="${dt == null }">
													<c:set var="dt" value="" />
												</c:if>
												<span class="status d-inline-block text-gray">${sanctioner.sanctnerSttusNm } | ${dt }</span>
											</div>
											<div class="memo">
												<c:if test="${sanctioner.sanctnerMemo ne null and sanctioner.sanctnerMemo ne ''}">
													<span class="alert alert-secondary p-0 px-2 mt-1">
														<i class="fa-sharp fa-light fa-memo fa-fw fa"></i>
														<font class="fw-semibold">${sanctioner.sanctnerMemo }</font>
													</span>
												</c:if>
											</div>
										</div>
									</div> <c:if test="${sanctioner.sanctnerSttusCode eq 'G301'}">
										<div class="current-bar position-absolute top-0 start-0 h-100"></div>
									</c:if></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="approval-confirm-modal" class="interactive-modal" style="z-index: 999;">
	<div class="interactive-modal-content" style="width: 500px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">결재하기</h5>
			<a href="#" class="position-absolute fa-active" data-exit="confirm">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="content">
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-draft" role="tabpanel" aria-labelledby="nav-draft-tab" tabindex="0">
					<table class="table table-borderless">
						<tr class="align-middle">
							<th>결재문서명</th>
							<td>
								<span class="font-weight-bold" id="aprovlNm">${approvalVO.aprovlNm }</span>
							</td>
						</tr>
						<tr class="align-middle">
							<th>결재의견</th>
							<td>
								<textarea rows="3" cols="10" class="form-control rounded-0" placeholder="의견을 작성해 주세요." style="resize: none;" id="aprovlMemo"></textarea>
							</td>
						</tr>
						<tr class="align-middle">
							<th>결재옵션</th>
							<td>
								<span>
									<input type="checkbox" class="form-check-input" id="isArbitrary">
									<label class="mx-1" for="isArbitrary">전결</label>
									<span class="m-0 text-muted">(체크 시 결재가 종료 됩니다)</span>
								</span>
							</td>
						</tr>
						<tr>
							<td class="text-end" colspan="2">
								<input type="button" class="btn btn-sm btn-secondary rounded-0" value="승인" id="okBtn" data-aprovl-no="${approvalVO.aprovlNo }">
								<input type="button" class="btn btn-sm rounded-0" value="취소" style="border: 1px solid #ddd;" id="cancelBtn" data-cancel="confirm">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="approval-return-modal" class="interactive-modal" style="z-index: 999;">
	<div class="interactive-modal-content" style="width: 500px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">반려하기</h5>
			<a href="#" class="position-absolute fa-active" data-exit="return">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="content">
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-draft" role="tabpanel" aria-labelledby="nav-draft-tab" tabindex="0">
					<table class="table table-borderless">
						<tr class="align-middle">
							<th>결재문서명</th>
							<td>
								<span class="font-weight-bold" id="aprovlNm">${approvalVO.aprovlNm }</span>
							</td>
						</tr>
						<tr class="align-middle">
							<th>결재의견</th>
							<td>
								<textarea rows="3" cols="10" class="form-control rounded-0" placeholder="반려 의견 작성은 필수입니다." style="resize: none;" id="aprovlReturnMemo"></textarea>
							</td>
						</tr>
						<tr>
							<td class="text-end" colspan="2">
								<input type="button" class="btn btn-sm btn-secondary rounded-0" value="반려" id="returnBtn" data-aprovl-no="${approvalVO.aprovlNo }">
								<input type="button" class="btn btn-sm rounded-0" value="취소" style="border: 1px solid #ddd;" id="cancelBtn" data-cancel="return">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="approval-hold-modal" class="interactive-modal" style="z-index: 999;">
	<div class="interactive-modal-content" style="width: 500px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">보류하기</h5>
			<a href="#" class="position-absolute fa-active" data-exit="hold">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="content">
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-draft" role="tabpanel" aria-labelledby="nav-draft-tab" tabindex="0">
					<table class="table table-borderless">
						<tr class="align-middle">
							<th>결재문서명</th>
							<td>
								<span class="font-weight-bold" id="aprovlNm">${approvalVO.aprovlNm }</span>
							</td>
						</tr>
						<tr class="align-middle">
							<th>결재의견</th>
							<td>
								<textarea rows="3" cols="10" class="form-control rounded-0" placeholder="의견을 작성해 주세요." style="resize: none;" id="aprovlHoldMemo"></textarea>
							</td>
						</tr>
						<tr>
							<td class="text-end" colspan="2">
								<input type="button" class="btn btn-sm btn-secondary rounded-0" value="보류" id="holdBtn" data-aprovl-no="${approvalVO.aprovlNo }">
								<input type="button" class="btn btn-sm rounded-0" value="취소" style="border: 1px solid #ddd;" id="cancelBtn" data-cancel="hold">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="approval-info-modal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content" style="width: 800px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">결재정보</h5>
			<a href="#" class="position-absolute fa-active" data-exit="info">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>

		<div class="card-body rounded-0 p-0">
			<nav class="nav nav-underline border-gray">
				<a href="#" class="nav-link rounded-0 active" id="nav-approval-line-tab" data-bs-toggle="tab" data-bs-target="#nav-approval-line" type="button" role="tab" aria-controls="nav-approval-line" aria-selected="true">결재선</a>
				<a href="#" class="nav-link rounded-0" id="nav-references-tab" data-bs-toggle="tab" data-bs-target="#nav-references" type="button" role="tab" aria-controls="nav-references" aria-selected="false">참조자</a>
			</nav>
			<div class="tab-content mt-3" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-approval-line" role="tabpanel" aria-labelledby="nav-draft-tab" tabindex="0">
					<div class="row">
						<div class="col-md-12 p-0" style="border: 1px solid #ddd;">
							<table class="table table-borderless border-gray mb-0">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="40%">
									<col width="20%">
								</colgroup>
								<thead class="text-center align-middle">
									<th>타입</th>
									<th>이름</th>
									<th>부서</th>
									<th>상태</th>
								</thead>
							</table>
							<div class="position-relative border-gray bg-gray p-1">
								<span class="text-muted">신청</span>
							</div>
							<table class="table table-borderless table-hover mb-0">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="40%">
									<col width="20%">
								</colgroup>
								<tbody class="text-center align-middle">
									<tr class="disabled">
										<td>결재</td>
										<td>${approvalVO.emplNm }</td>
										<td>${approvalVO.aprovlDeptNm }</td>
										<td>상신</td>
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
									<col width="40%">
									<col width="20%">
								</colgroup>
								<tbody class="text-center align-middle" id="approval-area">
									<c:forEach var="sanctioner" items="${approvalVO.sanctionerList }">
										<tr class="disabled">
											<td>결재</td>
											<td>${sanctioner.approverNm }</td>
											<td>${sanctioner.deptNm }</td>
											<td>${sanctioner.sanctnerSttusNm }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-references" role="tabpanel" aria-labelledby="nav-references-tab">
					<table class="table table-borderless border-gray mb-0">
						<colgroup>
							<col width="30%">
							<col width="40%">
							<col width="30%">
						</colgroup>
						<thead class="text-center align-middle" style="border: 1px solid #ddd;">
							<th>이름</th>
							<th>부서</th>
							<th>확인시간</th>
						</thead>
						<tbody class="text-center align-middle" style="border-left: 1px solid #ddd; border-right: 1px solid #ddd;">
							<c:if test="${empty approvalVO.rfrncList }">
								<tr>
									<td class="fw-semibold" colspan="3">참조자가 존재하지 않습니다</td>
								</tr>
							</c:if>
							<c:if test="${not empty approvalVO.rfrncList }">
								<c:forEach var="rfrnc" items="${approvalVO.rfrncList }">
									<tr class="disabled">
										<c:set var="isChecked" value="미확인" />
										<c:if test="${rfrnc.rfrncConfirmDt ne null}">
											<c:set var="isChecked" value="${rfrnc.rfrncConfirmDtToString }" />
										</c:if>
										<td>${rfrnc.rfrncerNm }</td>
										<td>${rfrnc.rfrncerDeptNm }</td>
										<td>${isChecked }</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="text-end p-0 pt-3">
			<button class="btn btn-sm rounded-0" style="border: 1px solid #ddd;" id="infoCancleBtn">취소</button>
		</div>
	</div>
</div>
</div>

<script>
	$(function() {
		
		let approvalConfirmBtn = $('#approval-confirm');
		let approvalReturnBtn = $('#approval-return');
		let approvalHoldBtn = $('#approval-hold');
		let approvalInfoBtn = $('#approval-info');
		let approvalCancelBtn = $('#approval-cancel');
		let draftCancelBtn = $('#draft-cancel');
		let reDraftBtn = $('#draft-reconfirm');
		
		var approvalConfirmModal = $('#approval-confirm-modal');
		var approvalInfoModal = $('#approval-info-modal');
		var approvalReturnModal = $('#approval-return-modal');
		var approvalHoldModal = $('#approval-hold-modal');
		
		
		const lookUpTable = {
			approvalConfirmModal: approvalConfirmModal,
		    approvalInfoModal: approvalInfoModal,
		    approvalReturnModal: approvalReturnModal,
		    approvalHoldModal: approvalHoldModal
		}
		
		const toggleModal = {
			approvalConfirmModal: toggleConfirmModal,
			approvalInfoModal: toggleInfoModal,
			approvalReturnModal: toggleReturnModal,
			approvalHoldModal: toggleHoldModal,
		}
		
		const cancelModal = {
			'confirm': toggleConfirmModal,
			'info': toggleInfoModal,
			'return': toggleReturnModal,
			'hold': toggleHoldModal
		}
		
		let okBtn = $('#okBtn');
		let returnBtn = $('#returnBtn');
		let holdBtn = $('#holdBtn');
		let infoCancleBtn = $('#infoCancleBtn');
		let cancelBtn = $('#cancelBtn');
		
		approvalConfirmBtn.on('click', function() {
			toggleConfirmModal();
		});
		
		approvalInfoBtn.on('click', function() {
			toggleInfoModal();
		});
		
		okBtn.on('click', function() {
			
			let approverNo = connectionTest();
			let date = getCurrentDate();
			
			let sign = '${employee.emplSign}';
			if(sign && sign.startsWith("data:")) {
				let signArea = $('[data-approval-line-no="'+approverNo+'"]').find('.sign_wrap');
	 			html = '<span class="sign_stamp"><img src="'+sign+'"></span>';
	 			$('[data-approval-line-no="'+approverNo+'"]').find('.sign_date').text(date);
				signArea.prepend(html);
			}
			
			let data = {
				approverNo : approverNo,
				aprovlNo : $(this).data('aprovlNo'),
				sanctnerMemo : $('#aprovlMemo').val()
			};
			
			if($('#isArbitrary').is(':checked')) {
				data.sanctnerSttusCode = 'G307';
				let target = $('[data-approval-line-no="'+approverNo+'"]').next();
				if(target) {
					let str = '<span class="sign_arbitrary"></span>';
					$('[data-approval-line-no="'+approverNo+'"]').nextAll().find('.sign_wrap').html('').append(str);
				}
				$('[data-approval-line-no="'+approverNo+'"]').find('.sign_date').text(date.substring(5, date.length) + '(전결)')
			}else{
				data.sanctnerSttusCode = 'G303';
			}
			
			data.aprovlCn = $('#aprovlCn').html();
			
			$.ajax({
				url: '/approval/confirm',
				type: 'post',
				contentType: 'application/json; charset=UTF-8',
				data: JSON.stringify(data)
			})
			.done(function(res) {
				if(res == 'OK') {
					showAlert('결재가 완료되었습니다!', '', 'success')
					.then(result => {
						if(result.isConfirmed) {
							window.location.reload();
						}
					})
				}
			})
		});
		
		reDraftBtn.on('click', function() {
			let aprovlNo = $(this).data('aprovlNo');
			let docNo = '${approvalVO.docNo}';
			location.href = `/approval/form?docNo=\${docNo}&aprovlNo=\${aprovlNo}`;
		});
		
		returnBtn.on('click', function(e) {
			let memo = $('#aprovlReturnMemo').val();
			if(memo == null || memo.trim() == '') {
				showToast('반려 의견을 작성해주세요!', 'error');
				return;
			}
			
			let aprovlNo = $(this).data('aprovlNo');
			let emplNo = connectionTest();
			let date = getCurrentDate();
			
			$('[data-approval-line-no="'+emplNo+'"]').find('.sign_date').text(date.substring(5, date.length) + '(반려)');
			$('[data-approval-line-no="'+emplNo+'"]').find('.sign_date').css('color', 'red');
			
			let aprovlCn = $('#aprovlCn').html();	
			
			$.post('/approval/return', {aprovlNo : aprovlNo, aprovlCn: aprovlCn, emplNo : emplNo, sanctnerMemo : memo})
			.done(function(res) {
				if(res == 'OK') {
					showAlert('반려처리가 완료되었습니다!', '', 'success')
					.then(result => {
						if(result.isConfirmed) {
							window.location.reload();
						}
					});
				}
			})
		})
		
		holdBtn.on('click', function(e) {
			let aprovlNo = $(this).data('aprovlNo');
			let ordr = $(this).data('ordr');
			let emplNo = connectionTest();
			
			let memo = $('#aprovlHoldMemo').val();
			
			$.post('/approval/hold', {aprovlNo : aprovlNo, emplNo : emplNo, sanctnerMemo : memo, sanctnerOrdr : ordr})
			.done(function(res) {
				if(res == 'OK') {
					showAlert('보류처리가 완료되었습니다!', '', 'success')
					.then(result =>{
						if(result.isConfirmed) {
							window.location.reload();
						}
					});
				}
			})
		})
		
		draftCancelBtn.on('click', function(e) {
			showConfirm('정말 상신을 취소하시겠습니까?', '' ,'warning')
			.then(result => {
				if(result.isConfirmed) {
					let aprovlNo = $(this).data('cancelNo');
					$.post('/approval/draft/cancel/'+aprovlNo)
					.done(function(res) {
						location.href='/approval/doclist/draft/all';
					})
				}
			});
		})
		
		approvalCancelBtn.on('click', function(e) {
			showConfirm('정말 결재를 취소하시겠습니까?', '', 'warning')
			.then(result => {
				if(result.isConfirmed) {
					let emplNo = connectionTest();
					
					let stamp = $('[data-approval-line-no="'+emplNo+'"]').find('.sign_stamp');
					let date = $('[data-approval-line-no="'+emplNo+'"]').find('.sign_date');
					stamp.remove();
					date.html('');
					
					let obj = {
						aprovlNo : $(this).data('aprovlNo'),
						approverNo : emplNo,
						aprovlCn : $('#aprovlCn').html()
					};
					
					
					$.post('/approval/cancel', obj)
					.done(function(res) {
						showAlert('결재가 성공적으로 취소되었습니다!', '', 'success')
						.then(result => {
							if(result.isConfirmed) {
								window.location.reload();
							}
						});
					})
					
				}
			});
		})
		
		approvalReturnBtn.on('click', function(e) {
			toggleReturnModal();
		})
		
		approvalHoldBtn.on('click', function(e) {
			toggleHoldModal();
		})
		
		$(document).on('click', function(e) {
			Object.keys(lookUpTable).forEach(modal => {
				if($(e.target).is(lookUpTable[modal])) {
					toggleModal[modal]();
				}
			})
		});
		
		$('[data-exit]').on('click', function() {
			let exit = $(this).data('exit');
			cancelModal[exit]();
		})
		
		$('[data-cancel]').on('click', function() {
			let type = $(this).data('cancel');
			cancelModal[type]();
		})
		
		infoCancleBtn.on('click', function() {
			toggleInfoModal();
		})
		
		function toggleConfirmModal() {
			approvalConfirmModal.toggleClass("show");	
		}
		
		function toggleInfoModal() {
			approvalInfoModal.toggleClass("show");
		}
		
		function toggleReturnModal() {
			approvalReturnModal.toggleClass("show");
		}
		
		function toggleHoldModal() {
			approvalHoldModal.toggleClass("show");
		}
		
		function getCurrentDate() {
	        var today = new Date();
	        var year = today.getFullYear();
	        var month = ('0' + (today.getMonth() + 1)).slice(-2); 
	        var day = ('0' + today.getDate()).slice(-2); 
	        
	        return year + '-' + month + '-' + day;
	    }
		
		/* 나의 결재선 불러오기 */
		function selectMyLine() {
			let emplNo = connectionTest();
			$.get('/approval/senctioner/myline',{sanctionerOner : emplNo})
			.done(function(res) {
				createMyLine(res);
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
	});
	
	$('#main').on('click', function(e) {
		e.preventDefault();
		location.href = '/approval';
	});
</script>