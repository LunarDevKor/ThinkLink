<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="card">
	<ul class="nav nav-pills user-profile-tab" id="pills-tab" role="tablist">
		<li class="nav-item" role="presentation" style="margin-left: 30px;">
			<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/profile/form';" id="pills-account-tab" data-bs-toggle="pill" data-bs-target="#pills-account" type="button" role="tab" aria-controls="pills-account" aria-selected="false">
				<i class="ti ti-user-circle me-2 fs-6"></i> <span class="d-none d-md-block">계정정보</span>
			</button>
		</li>
		<c:if test="${user.clsfCode > 4 }">
		<li class="nav-item" role="presentation" style="margin-left: 20px;">
			<button class="nav-link position-relative rounded-0 active d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/employee/teamManagement';" id="pills-notifications-tab" data-bs-toggle="pill" data-bs-target="#pills-notifications" type="button" role="tab" aria-controls="pills-notifications" aria-selected="true">
				<i class="fa-solid fa-users"></i>&nbsp;&nbsp;&nbsp; <span class="d-none d-md-block">팀원정보</span>
			</button>
		</li>
		</c:if>
	</ul>
		<!-- 탭구역 시작 -->
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-notifications" role="tabpanel" aria-labelledby="pills-notifications-tab" tabindex="0">
				<!-- 아래쪽 구역 시작 -->

				<div class="card-body">
					<h4 class="fw-semibold mb-8" style="margin-left: 20px">
						<i class="fa-duotone fa-circle fa-xs" style="color: #739ee8;"></i> &nbsp;&nbsp;${deptNm }
					</h4>
					</br>
					<form id="searchForm">
						<input type="hidden" name="page" id="page" />
						<div class="col-md-4">
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="searchWord" name="searchWord" value="${searchWord }" placeholder="이름을 입력하세요">
								<button class="btn bg-info-subtle text-info" type="submit">검색</button>
							</div>
						</div>
					</form>
					<!-- 폼시작 -->
					<form action="" method="post" id="" enctype="multipart/form-data">
						<div class="table-responsive border rounded-4">
							<table class="table mb-0">
								<thead class="table-info">
									<tr>
										<th style="text-align: center;">사원번호</th>
										<th style="text-align: center;">이름</th>
										<th style="text-align: center;">부서</th>
										<th style="text-align: center;">직급</th>
										<th style="text-align: center;">ID</th>
										<th style="text-align: center;">휴대폰</th>
									</tr>
								</thead>
								<tbody>
									<c:set value="${pagingVO.dataList }" var="teamList" />
									<c:choose>
										<c:when test="${empty teamList }">
											<tr>
												<td colspan="6" style="text-align: center;">사원이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${teamList }" var="empl">
												<tr id="${empl.emplNo }">
													<td style="text-align: center;">
														<h6 class="text-dark">${empl.emplNo }</h6>
													</td>
													<td style="text-align: center;">
														<h6 class="text-dark">
															<a class="mb-0" href="teamUpdateForm?emplNo=${empl.emplNo }">${empl.emplNm }</a>
														</h6>
													</td>
													<td style="text-align: center;">
														<h6 class="text-dark">${empl.deptNm }</h6>
													</td>
													<td style="text-align: center;">
														<h6 class="text-dark">${empl.classOfPositionVO.clsfNm }</h6>
													</td>
													<td style="text-align: center;">
														<h6 class="text-dark">${empl.emplId }</h6>
													</td>
													<td style="text-align: center;">
														<h6 class="text-dark">${empl.emplTelno }</h6>
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
				<!-- 아래쪽 구역 끝 -->
			</div>
		</div>
		<!-- 탭구역 끝 -->
</div>
<!-- 스크립트시작 -->
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>
	//페이징 처리
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
</script>