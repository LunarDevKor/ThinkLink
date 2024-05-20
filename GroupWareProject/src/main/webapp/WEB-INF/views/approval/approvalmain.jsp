<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="d-flex w-100">
	<div class="w-100">
		<div class="chat-container h-100 w-100">
			<div class="chat-box-inner-part h-100">
				<div class="chatting-box app-email-chatting-box">
					<div class="p-9 py-3 chat-meta-user d-flex align-items-center justify-content-start">
						<c:if test="${empty approvalList }">
							<p class="fw-semibold text-center flex-fill" style="padding: 56px; border-bottom: 1px solid #eee;">결재할 문서가 존재하지 않습니다</p>
							<c:set var="classType" value="" />
						</c:if>
						<c:forEach var="approval" items="${approvalList }">
							<c:choose>
								<c:when test="${approval.aprovlSttusCode eq 'G102' }">
									<c:set var="classType" value="approval-ongoing" />
								</c:when>
								<c:when test="${approval.aprovlSttusCode eq 'G103' }">
									<c:set var="classType" value="approval-finish" />
								</c:when>
								<c:when test="${approval.aprovlSttusCode eq 'G104' }">
									<c:set var="classType" value="approval-return" />
								</c:when>
							</c:choose>
							<div class="card approval-item flex-fill">
								<div class="card-header">
									<div class="status">
										<p class="mb-0 fw-normal fs-4">
											<span class="badge ${classType }">${approval.aprovlSttusNm }</span>
										</p>
									</div>
								</div>
								<div class="card-body">
									<div class="approval-title">
										<a href="/approval/document/${approval.aprovlNo }">
											<span class="font-weight-bold h5">${approval.aprovlNm }</span>
										</a>
									</div>
									<div class="d-table">
										<div class="d-table-row">
											<div class="d-table-cell">기안자 :</div>
											<div class="d-table-cell">${approval.emplNm }</div>
										</div>
										<div class="d-table-row">
											<div class="d-table-cell">기안일 :</div>
											<div class="d-table-cell">${approval.submitDtToString }</div>
										</div>
										<div class="d-table-row">
											<div class="d-table-cell">결재양식 :</div>
											<div class="d-table-cell">${approval.docNm }</div>
										</div>
										<div class="float-left d-table-row">
											<div>
												<div class="d-table-cell">
													<i class="fa-sharp fa-regular fa-paperclip fa-fw"></i> <span class="fw-semibold">${approval.fileCount }</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<a href="/approval/document/${approval.aprovlNo }" class="card-footer text-center approval-action d-block">
									<span class="font-weight-bold">결재하기</span>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="p-9"></div>
				<div class="table-responsive">
					<div class="ms-3 d-flex justify-content-start align-items-center">
						<span class="font-weight-bold fs-6">기안 진행 문서</span>
						<a href="#" role="button" tabindex="0" class="approval-popover" data-bs-toggle="popover" data-bs-trigger="focus" data-bs-placement="top" data-bs-custom-class="custom-popover" data-bs-title="기안 문서 Tip" data-bs-content="현재 진행중인 기안문서 5개를, 최근 등록 순서대로 표시합니다.">
							<i class="fa-light fa-circle-info fa-xl fa-fw ms-2"></i>
						</a>
					</div>
					<div class="p-9 py-3">
						<table class="table table-sm table-hover text-nowrap customize-table mb-0 align-middle text-start" style="overflow: hidden; text-overflow: ellipsis;">
							<colgroup>
								<col style="width: 10%">
								<col style="width: 20%">
								<col style="width: 10%">
								<col style="width: 40%">
								<col style="width: 10%">
								<col style="width: 10%">
							</colgroup>
							<thead class="text-dark fs-4 border table-light">
								<tr>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">기안일</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">결재양식</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">긴급</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">제목</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">첨부</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">결재상태</h6>
									</th>
								</tr>
							</thead>
							<tbody class="">
								<c:if test="${empty inprogressList }">
									<td class="fw-semibold text-center" colspan="6" style="padding: 56px; border-bottom: 1px solid #eee;">결재 진행중인 문서가 존재하지 않습니다</td>
								</c:if>

								<c:forEach var="inprogress" items="${inprogressList }">
									<tr>
										<c:set var="classType" value="" />
										<c:choose>
											<c:when test="${inprogress.aprovlSttusCode eq 'G102' }">
												<c:set var="classType" value="approval-ongoing" />
											</c:when>
											<c:when test="${inprogress.aprovlSttusCode eq 'G103' }">
												<c:set var="classType" value="approval-finish" />
											</c:when>
											<c:when test="${inprogress.aprovlSttusCode eq 'G104' }">
												<c:set var="classType" value="approval-return" />
											</c:when>
										</c:choose>
										<td>
											<p class="mb-0 fw-normal fs-4">${inprogress.submitDtToString }</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">${inprogress.docNm }</p>
										</td>
										<c:set var="emrgncy" value='<i class="fa-solid fa-light-emergency-on fa-xl fa-fw" style="color: #999999;"></i>' />
										<c:if test="${inprogress.emrgncyYn eq 'Y' }">
											<c:set var="emrgncy" value='<i class="fa-solid fa-light-emergency-on fa-fade fa-xl" style="color: #ff0000;"></i>' />
										</c:if>
										<td>
											<p class="mb-0 fw-normal fs-4">
												<span class=""> ${emrgncy } </span>
											</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">
												<a href="/approval/document/${inprogress.aprovlNo }">
													<span>${inprogress.aprovlNm }</span>
												</a>
											</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">
												<span> <i class="fa-sharp fa-regular fa-paperclip fa-fw"></i> <span class="fw-semibold">${inprogress.fileCount }</span>
												</span>
											</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">
												<span class="badge ${classType }">${inprogress.aprovlSttusNm }</span>
											</p>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="p-9"></div>
				<div class="table-responsive">
					<div class="ms-3 d-flex justify-content-start align-items-center">
						<span class="font-weight-bold fs-6">완료 문서</span>
						<a href="#" role="button" tabindex="0" class="approval-popover" data-bs-toggle="popover" data-bs-trigger="focus" data-bs-placement="top" data-bs-custom-class="custom-popover" data-bs-title="완료 문서 Tip" data-bs-content="최근에 결재 완료된 순서대로, 최대 5개의 목록을 표시합니다.">
							<i class="fa-light fa-circle-info fa-xl fa-fw ms-2"></i>
						</a>
					</div>
					<div class="p-9 py-3">

						<table class="table table-sm table-hover text-nowrap customize-table mb-0 align-middle table-responsive text-start" style="overflow: hidden; text-overflow: ellipsis;">
							<colgroup>
								<col style="width: 10%">
								<col style="width: 20%">
								<col style="width: 10%">
								<col style="width: 25%">
								<col style="width: 10%">
								<col style="width: 15%">
								<col style="width: 10%">
							</colgroup>
							<thead class="text-dark fs-4 border table-light">
								<tr>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">기안일</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">결재양식</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">긴급</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">제목</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">첨부</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">문서번호</h6>
									</th>
									<th>
										<h6 class="fs-4 fw-semibold mb-0">결재상태</h6>
									</th>
								</tr>
							</thead>
							<tbody class="">
								<c:if test="${empty completeList }">
									<td class="fw-semibold text-center" colspan="7" style="padding: 56px; border-bottom: 1px solid #eee;">결재 완료한 문서가 존재하지 않습니다</td>
								</c:if>
								<c:forEach var="complete" items="${completeList }">
									<c:set var="classType" value="" />
									<c:choose>
										<c:when test="${complete.aprovlSttusCode eq 'G102' }">
											<c:set var="classType" value="approval-ongoing" />
										</c:when>
										<c:when test="${complete.aprovlSttusCode eq 'G103' }">
											<c:set var="classType" value="approval-finish" />
										</c:when>
										<c:when test="${complete.aprovlSttusCode eq 'G104' }">
											<c:set var="classType" value="approval-return" />
										</c:when>
									</c:choose>
									<c:set var="emrgncy" value='<i class="fa-solid fa-light-emergency-on fa-xl fa-fw" style="color: #999999;"></i>' />
									<c:if test="${complete.emrgncyYn eq 'Y' }">
										<c:set var="emrgncy" value='<i class="fa-solid fa-light-emergency-on fa-fade fa-xl" style="color: #ff0000;"></i>' />
									</c:if>
									<tr>
										<td>
											<p class="mb-0 fw-normal fs-4">${fn:split(complete.submitDtToString, '(')[0] }</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">${complete.docNm }</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">${emrgncy }</p>
										</td>
										<td><a href="/approval/document/${complete.aprovlNo }">
												<p class="mb-0 fw-normal fs-4">${complete.aprovlNm }</p>
											</a></td>
										<td><span>
												<p class="mb-0 fw-normal fs-4">
													<i class="fa-sharp fa-regular fa-paperclip fa-fw"></i> ${complete.fileCount }
												</p>
										</span></td>
										<td>
											<p class="mb-0 fw-normal fs-4">${complete.docCodeNo }</p>
										</td>
										<td>
											<p class="mb-0 fw-normal fs-4">
												<span class="badge ${classType }"> ${complete.aprovlSttusNm } </span>
											</p>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
<script>
	$('.approval-popover').click(function(e) {
		e.preventDefault();
	})
	
	const popover = new bootstrap.Popover('.approval-popover', {
		trigger : 'focus'
	});
</script>