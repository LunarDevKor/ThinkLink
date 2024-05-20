<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
.important-title a.important-link {
	color: #ff9999;
	font-weight: bold;
}
/* 호버 효과 */
.important-title a.important-link:hover {
	color: blue; /* 링크 텍스트 색상 변경 */
	text-decoration: underline; /* 링크에 밑줄 표시 */
	/* 다른 원하는 스타일 속성들 추가 가능 */
}

.a-menu:hover>span {
	border-bottom: 3px solid #1A66CC;
}
</style>

<div class="card">
	<div class="d-flex">
		<div class="flex-fill p-0">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/board?bbsNo=1">
					<h3 class="fw-semibold mb-4">
						<i class="fa-sharp fa-regular fa-chalkboard fa-fw fa"></i> 공지사항 조회
					</h3>
				</a>
			</div>
			<div class="d-flex justify-content-start align-items-center">
				<form class="input-group input-group-sm flex-fill" method="post" id="searchForm" style="width: 800px;">
					<input type="hidden" name="page" id="page" />
					<div class="input-group display-inline-block rounded-0">
						<select class="form-select rounded-0" name="searchType">
							<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
							<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
						</select>
						<input type="text" name="searchWord" value="${searchWord }" class="form-control float-right" placeholder="Search" style="flex: 9 1 auto !important;">
						<button type="submit" class="btn btn-info rounded-0">
							<i class="fas fa-search"></i> 검색
						</button>
					</div>
					<sec:csrfInput />
				</form>
				<c:if test="${!empty param.bbsNo}">
					<c:choose>
						<c:when test="${param.bbsNo == '1'}">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<div class="ms-auto">
									<button type="button" class="btn btn-dark rounded-0 " id="newBtn">등록</button>
								</div>
							</sec:authorize>
						</c:when>
						<c:otherwise>
							<div class="ms-auto">
								<button type="button" class="btn btn-dark rounded-0 " id="newBtn">등록</button>
							</div>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
			<div class="table-responsive">
				<div class="card-body p-0">
					<table class="table border text-nowrap customize-table mb-0 align-middle">
						<thead class="text-dark fs-4">
							<tr>
								<th>
									<h6 class="fs-4 fw-semibold mb-0">번호</h6>
								</th>
								<th>
									<h6 class="fs-4 fw-semibold mb-0">제목</h6>
								</th>
								<th>
									<h6 class="fs-4 fw-semibold mb-0">작성자</h6>
								</th>
								<th>
									<h6 class="fs-4 fw-semibold mb-0">조회수</h6>
								</th>
								<th>
									<h6 class="fs-4 fw-semibold mb-0">등록일자</h6>
								</th>
							</tr>
						</thead>
						<tbody>
							<c:set value="${pagingVO.dataList }" var="boardList" />
							<c:choose>
								<c:when test="${!empty boardList }">
									<c:forEach items="${boardList }" var="board">
										<c:if test="${board.imprtncYn eq 'Y'}">
											<tr>
												<td width="7%"><span class="fs-4 fw-semibold mb-0"> ${board.bbscttNo } </span></td>
												<td width="50%">
													<p class="mb-0 fw-normal fs-4 important-title">
														<a href="/admin/board/detail?bbscttNo=${board.bbscttNo }" class="important-link">
															<c:if test="${board.bbsNo eq '1'}">
																<i class="fa-solid fa-circle-exclamation me-2"></i>
															</c:if>
															${board.bbscttTitle }
															<c:if test="${board.bbsNo ne '1'}">
																<a href="/admin/board/detail?bbscttNo=${board.bbscttNo }#answerList" class="important-link">
																	<i class="fa-regular fa-comment"></i> [${board.answerCount }]
																</a>
															</c:if>
														</a>
													</p>
												</td>
												<td>
													<div class="d-flex align-items-center">
														<img src="/profile/view/${board.emplProflPhoto}" class="rounded-circle" width="40" height="40" />
														<div class="ms-3">
															<h6 class="fs-4 fw-semibold mb-0">
																<a href="#" class="fw-semibold"> ${board.emplNm } </a>
															</h6>
															<%-- 										<span class="fw-normal">${board.register }</span> --%>
														</div>
													</div>
												</td>
												<td><span class="fs-4 fw-semibold mb-0">${board.bbscttRdcnt }</span></td>
												<td>
													<h6 class="fs-4 fw-semibold mb-0">${board.rgsde }</h6>
												</td>
											</tr>
										</c:if>
									</c:forEach>
									<c:forEach items="${boardList}" var="board">
										<c:if test="${board.imprtncYn eq 'N'}">
											<tr>
												<td width="7%"><span class="fs-4 fw-semibold mb-0"> ${board.bbscttNo } </span></td>
												<td width="50%">
													<p class="mb-0 fw-normal fs-4">
														<a href="/admin/board/detail?bbscttNo=${board.bbscttNo }">
															<c:if test="${board.bbsNo eq '1'}">
																<!-- 																<i class="fa-solid fa-circle-exclamation me-2"></i> -->
															</c:if>
															${board.bbscttTitle }
															<c:if test="${board.bbsNo ne '1'}">
																<a href="/admin/board/detail?bbscttNo=${board.bbscttNo }#answerList">
																	<i class="fa-regular fa-comment"></i> [${board.answerCount }]
																</a>
															</c:if>
														</a>
													</p>
												</td>
												<td>
													<div class="d-flex align-items-center">
														<img src="/profile/view/${board.emplProflPhoto}" class="rounded-circle" width="40" height="40" />
														<div class="ms-3">
															<h6 class="fs-4 fw-semibold mb-0">
																<a href="#" class="fw-semibold"> ${board.emplNm } </a>
															</h6>
															<%-- 										<span class="fw-normal">${board.register }</span> --%>
														</div>
													</div>
												</td>
												<td><span class="fs-4 fw-semibold mb-0">${board.bbscttRdcnt }</span></td>
												<td>
													<h6 class="fs-4 fw-semibold mb-0">${board.rgsde }</h6>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">조회하신 게시글이 존재하지 않습니다</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="card-footer clearfix" id="pagingArea">${pagingVO.pagingHTML }</div>
<script type="text/javascript">
	// var fldrType = 0;
	/* fldrType 변경  시작*/
	var sideArea = $('#sideArea');
	// 	var companyLink = $('#company');
	// 	var departmentLink = $('#department');
	// 	var privateLink = $('#private');
	// 	var fldrInfo = {
	// 	    'company': { index: 0, title: '전사자료실' },
	// 	    'department': { index: 1, title: '부서자료실' },
	// 	    'private': { index: 2, title: '개인자료실' }
	// 	};

	// 	sideArea.on('click', '[data-id]', function() {
	// // 		console.log("hi");
	// 		let id = $(this).data('id');
	// 		fldrType = fldrInfo[id].index;
	// // 		driveItem.fldrType = fldrType;
	// 		$('[data-title]').text(fldrInfo[id].title);

	// // 		getDriveFiles();
	// 	});

	$(function() {
		var newBtn = $("#newBtn");
		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");

		newBtn.on("click", function() {
			location.href = "/admin/board/form?bbsNo=${pagingVO.bbsNo}";
		});

		pagingArea.on("click", "a", function() {
			event.preventDefault();
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
	});

	// 	function creatListHTML(response) {
	// 		let str = '';
	// 		for (var i = 0; i < response.length; i++) {
	// 			str += '';
	// 		}
	// 	}
</script>