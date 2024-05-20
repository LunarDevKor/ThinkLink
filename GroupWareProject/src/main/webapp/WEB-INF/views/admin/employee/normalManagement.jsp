<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="px-9 pt-4 pb-3">
	<a href="/admin/employee/normalManagement">
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
			<button class="nav-link position-relative rounded-0 active d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='normalManagement';" id="pills-normal-tab" data-bs-toggle="pill" data-bs-target="#pills-normal" type="button" role="tab" aria-controls="pills-normal" aria-selected="true">
				<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;정상&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='stopManagement';" id="pills-stop-tab" data-bs-toggle="pill" data-bs-target="#pills-stop" type="button" role="tab" aria-controls="pills-stop" aria-selected="false">
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
			<!-- 정상 탭 구역 시작 -->
			<div class="tab-pane fade show active" id="pills-normal" role="tabpanel" aria-labelledby="pills-normal-tab" tabindex="0">
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
									<th style="text-align: left;">관리자</th>
								</tr>
							</thead>
							<tbody>
								<c:set value="${pagingVO.dataList }" var="normalEmplList" />
								<c:choose>
									<c:when test="${empty normalEmplList }">
										<tr>
											<td colspan="8" style="text-align: center;">사원이 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${normalEmplList }" var="empl">
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
															<a class="mb-0" href="#" onclick="enabled(${empl.emplNo},'${empl.emplNm}','${empl.classOfPositionVO.clsfNm }')">[중지]</a>
														</h6>
													</td>
												</c:if>
												<c:if test="${empl.enabled  eq 0}">
													<td style="text-align: left;">
														<h6 class="text-dark">
															이용중지
															<a class="mb-0" href="#">[해제]</a>
														</h6>
													</td>
												</c:if>
												<c:choose>
													<c:when test="${empl.authList.size() eq 2}">
														<td style="text-align: left;">
															<h6 class="text-dark" id="adminStatus${empl.emplNo}">
																Y
																<a class="mb-0" href="#" onclick="deleteAuth(${empl.emplNo},'${empl.emplNm}','${empl.classOfPositionVO.clsfNm }')"> [삭제]</a>
															</h6>
														</td>
													</c:when>
													<c:otherwise>
														<td style="text-align: left;">
															<h6 class="text-dark" id="adminStatus${empl.emplNo}">
																N
																<a class="mb-0" href="#" onclick="insertAuth(${empl.emplNo},'${empl.emplNm}','${empl.classOfPositionVO.clsfNm }')"> [지정]</a>
															</h6>
														</td>
													</c:otherwise>
												</c:choose>
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
			<!-- 정상 탭 구역 끝 -->
		</div>
	</div>
	<!-- 아래쪽 구역 끝 -->
</div>
<!-- 스크립트시작 -->
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
	
function enabled(emplNo,emplNm,clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"을(를) 이용중지하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/enabledUpdate",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						$('#' + emplNo).remove();
						showToast(emplNm+" 사원의 상태가 변경되었습니다!", 'success');
					}
				}
			});
		}
	});
}

function deleteAuth(emplNo,emplNm,clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"을(를) 관리자에서\n삭제하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/deleteAuth",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						var newHtml = `N <a class='mb-0' href='#' onclick="insertAuth('\${emplNo}','\${emplNm}')"> [지정]</a>`;
						$('#adminStatus'+emplNo).html(newHtml);
						showToast(emplNm+" 사원이 관리자에서 삭제되었습니다!", 'success');
					}
				}
			});
		}
	});
	
}

function insertAuth(emplNo,emplNm,clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"을(를) 관리자로\n지정하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/insertAuth",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						var newHtml = `Y <a class='mb-0' href='#' onclick="deleteAuth('\${emplNo}','\${emplNm}')"> [삭제]</a>`;
						$('#adminStatus'+emplNo).html(newHtml);
						showToast(emplNm+" 사원이 관리자로 지정되었습니다!", 'success');
					}
				}
			});
		}
	});
}
</script>