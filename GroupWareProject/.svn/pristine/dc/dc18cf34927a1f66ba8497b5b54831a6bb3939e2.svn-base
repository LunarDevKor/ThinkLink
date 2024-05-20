<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/modal/interactive-modal.css">

<style>
.fa-duotone.fa-triangle-exclamation {
	color: red;
	font-size: 26px;
}
</style>

<div class="px-9 pt-4 pb-3">
	<a href="/admin/employee/stopManagement">
		<h3 class="fw-semibold mb-4">
			<i class="fa-solid fa-user-group fa-fw fa"></i>
			사원 관리
		</h3>
	</a>
</div>

<div class="card mt-3">

	<!-- 탭 부분 시작 -->
	<ul class="nav nav-pills user-profile-tab justify-content-center" id="pills-tab" role="tablist">
		<li class="nav-item" role="presentation" style="margin-left: 30px;">
			<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='normalManagement';" id="pills-normal-tab" data-bs-toggle="pill" data-bs-target="#pills-normal" type="button" role="tab" aria-controls="pills-normal" aria-selected="false">
				<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;정상&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link position-relative rounded-0 active d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='stopManagement';" id="pills-stop-tab" data-bs-toggle="pill" data-bs-target="#pills-stop" type="button" role="tab" aria-controls="pills-stop" aria-selected="true">
				<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;이용중지&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</button>
		</li>
		<li class="nav-item align-self-center ms-auto me-4" role="presentation">
			<button class="btn btn-primary" style="margin-right: 50px; margin-top: 20px;" onclick="window.location.href='form';">사원등록</button>
		</li>
	</ul>
	<!-- 탭 부분 끝 -->

	<!-- 아래쪽 구역 시작 -->
	<div class="card-body">
	<h6 class="item-head mb-0 fs-4 fw-semibold">
			<i class="fa-duotone fa-circle fa-xs" style="color: #739ee8; margin-right: 10px;"></i>현재 재직 중인 사원 수 : ${normalCount } 명
		</h6>
		</br>
		<h6 class="item-head mb-0 fs-4 fw-semibold">
			<i class="fa-duotone fa-circle fa-xs" style="color: #739ee8; margin-right: 10px;"></i>현재까지 퇴사자 수 : ${stopCount } 명
		</h6>
		</br>
		<div class="tab-content" id="pills-tabContent">

			<!-- 이용중지 탭 구역 시작 -->
			<div class="tab-pane fade show active" id="pills-stop" role="tabpanel" aria-labelledby="pills-stop-tab" tabindex="0">
				<form id="searchForm">
					<input type="hidden" name="page" id="page" />
					<div class="col-md-4">
						<div class="input-group mb-3">
							<input type="text" class="form-control" id="searchWord" name="searchWord" value="${searchWord }" placeholder="이름 또는 부서를 입력하세요">
							<button class="btn bg-info-subtle text-info" type="submit">검색</button>
						</div>
					</div>
				</form>
				<!-- 폼시작 -->
				<form action="" method="post" id="" enctype="multipart/form-data">
					<div class="table-responsive border rounded-4">
						<table class="table table-borderless table-hover text-center align-middle">
							<thead class="table-info">
								<tr>
									<th style="text-align: left;">사원번호</th>
									<th style="text-align: left;">이름</th>
									<th style="text-align: left;">부서</th>
									<th style="text-align: left;">직급</th>
									<th style="text-align: left;">ID</th>
									<th style="text-align: left;">휴대폰</th>
									<th style="text-align: left;">상태</th>
									<th style="text-align: left;">삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:set value="${pagingVO.dataList }" var="stopEmplList" />
								<c:choose>
									<c:when test="${empty stopEmplList }">
										<tr>
											<td colspan="8" style="text-align: center;">사원이 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${stopEmplList }" var="empl">
											<tr id="${empl.emplNo }">
												<td style="text-align: left;">
													<h6 class="text-dark">${empl.emplNo }</h6>
												</td>
												<td style="text-align: left;">
													<h6 class="text-dark">
														<a class="mb-0" href="updateForm?emplNo=${empl.emplNo }">${empl.emplNm }</a>
													</h6>
												</td>
												<td style="text-align: left;">
													<h6 class="text-dark">${empl.deptNm }</h6>
												</td>
												<td style="text-align: left;">
													<h6 class="text-dark">${empl.classOfPositionVO.clsfNm }</h6>
												</td>
												<td style="text-align: left;">
													<h6 class="text-dark">${empl.emplId }</h6>
												</td>
												<td style="text-align: left;">
													<h6 class="text-dark">${empl.emplTelno }</h6>
												</td>
												<c:if test="${empl.enabled  eq 1}">
													<td style="text-align: left;">
														<h6 class="text-dark">
															정상
															<a class="mb-0" href="#">[중지]</a>
														</h6>
													</td>
												</c:if>
												<c:if test="${empl.enabled  eq 0}">
													<td style="text-align: left;">
														<h6 class="text-dark">
															이용중지
															<a class="mb-0" href="#" onclick="enabled(${empl.emplNo},'${empl.emplNm}','${empl.classOfPositionVO.clsfNm }')">[해제]</a>
														</h6>
													</td>
												</c:if>
												<td style="text-align: left;">
													<h6 style="color: red;">
														<a class="mb-0" href="#" onclick="openModal(${empl.emplNo},'${empl.emplNm}','${empl.classOfPositionVO.clsfNm }')"> [삭제]</a>
													</h6>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<nav style="margin-top: 20px;" aria-label="Page navigation example" id="pagingArea">${pagingVO.pagingHTML }</nav>
					<sec:csrfInput />
				</form>
				<!-- 폼끝 -->
			</div>
			<!-- 이용중지 탭 구역 끝 -->
		</div>
	</div>
	<!-- 아래쪽 구역 끝 -->
</div>

<!-- 모달 시작 -->
<div id="bs-example-modal-md" class="modal fade" tabindex="-1" aria-labelledby="bs-example-modal-md" data-bs-backdrop="false" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header d-flex align-items-center">
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h4 id="emplNmArea">
				<!-- XXX 사원을 삭제합니다. -->
				</h4>
				</br>
				<p><input type="checkbox" class="form-check-input" name="deleteCheck1" id="deleteCheck1">&nbsp;&nbsp;삭제 시 해당 사원은 더이상 서비스를 이용할 수 없습니다.</p>
				<p><input type="checkbox" class="form-check-input" name="deleteCheck2" id="deleteCheck2">&nbsp;&nbsp;해당 사원이 등록한 모든 게시물 및 파일은 자동으로 삭제되지 않습니다.</p>
				<p style="color: red;">
					<input type="checkbox" class="form-check-input" name="deleteCheck3" id="deleteCheck3">&nbsp;&nbsp;사원 삭제 시 해당 계정은 즉시 삭제 처리되며 복원이 불가함을 확인했습니다.
				</p>
			</div>
			<div class="modal-footer">
				<button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
				<button type="button" class="btn bg-danger-subtle text-danger  waves-effect" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 모달 끝  -->

<!-- 스크립트시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/sweetalert_custom.js"></script>
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>

	// 페이징 처리
	$(function() {
		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
	});
	
var deleteBtn = $("#deleteBtn"); // 모달 내 삭제버튼

// 페이지 내 삭제를 누르면 모달이 열린다	
function openModal(emplNo, emplNm, clsfNm) {
	$('#bs-example-modal-md').modal('show');
	$("#emplNmArea").html(`<i class='fa-duotone fa-triangle-exclamation'></i> \${emplNm } \${clsfNm}을(를) 삭제합니다.`);
	deleteBtn.data('empl-no', emplNo);
	deleteBtn.data('empl-nm', emplNm);
}

// 모달이 닫힐 때
$('#bs-example-modal-md').on('hidden.bs.modal', function () {
    $('#deleteCheck1').prop('checked', false); // 체크박스 초기화
    $('#deleteCheck2').prop('checked', false); // 체크박스 초기화
    $('#deleteCheck3').prop('checked', false); // 체크박스 초기화
});


// 모달 내 삭제 버튼 클릭
deleteBtn.on("click",function() {
	
	var deleteCheck1 = $("#deleteCheck1");
	var deleteCheck2 = $("#deleteCheck2");
	var deleteCheck3 = $("#deleteCheck3");
	var emplNo = $(this).data('empl-no');
	var emplNm = $(this).data('empl-nm');
	
	if(deleteCheck1.prop("checked") && deleteCheck2.prop("checked") && deleteCheck3.prop("checked")) {
		showConfirm(emplNm + " 사원을 정말 삭제하시겠습니까?",'','question').then(result=> {
			if(result.isConfirmed){
				$.ajax({
					url:"/admin/employee/deleteEmployee",
					type:"post",
					data: JSON.stringify({emplNo : emplNo}),
					contentType : "application/json; charset=utf-8",
					success: function(res){
						if(res === "SUCCESS") {
							$('#bs-example-modal-md').modal('hide');
							$('#' + emplNo).remove();
							showToast(emplNm+" 사원이 삭제되었습니다!", 'success');
						}
					}
				});
			}
		});
	}else {
		showToast("확인되지 않은 주의사항이 있습니다!","warning")
	}
	
});

// 이용중지 해제 클릭
function enabled(emplNo, emplNm, clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"의 이용중지를 해제하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/enabledUpdate",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						$('#' + emplNo).remove();
						showToast(emplNm+" "+clsfNm+"의 상태가 변경되었습니다!", 'success');
					}
				}
			});
		}
	});
}
</script>