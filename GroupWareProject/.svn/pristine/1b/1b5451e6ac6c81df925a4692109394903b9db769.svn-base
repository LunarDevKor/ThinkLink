<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="d-flex justify-content-end mb-3">
	<div class="me-4 text-center">
		<a href="/board?type=album">
			<i class="fa-solid fa-images fa-2xl"></i>
			<p style="margin: 0">앨범</p>
		</a>
	</div>
	<div class="me-2 text-center">
		<a href="/board?type=list">
			<i class="fa-solid fa-list fa-2xl"></i>
			<p style="margin: 0">리스트</p>
		</a>
	</div>
</div>
<div class="row">
<!-- 	<div class="col-lg-2 stlyle="border:1px solid #ddd; border-bottom: none; max-height: 1552px;"> -->
			
			
			<a class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="moveToFormPage();" role="tab" aria-controls="v-pills-home" aria-selected="true">
				<i class="fa-solid fa-plus"></i> 새 카테고리 등록 </a>
				
	<div class="flex-shrink-0" style="border-right: 1px solid #ddd; width: 13%" id="sideArea">
		<div class="px-9 pt-4 pb-3">
			<a href="/board">
				<h3 class="fw-semibold mb-4">새 카테고리 등록</h3>
			</a>
		</div>
		<ul>
			<li class="py-3">
				<a href="/board" class="w-100 d-block a-menu" data-id="company">
					<span class="fs-6 ms-5">공지사항</span>
				</a>
			</li>
			<li class="py-3">
				<a href="/board" class="w-100 d-block a-menu" data-id="department">
					<span class="fs-6 ms-5">전사</span>
				</a>
			</li>
			<li class="py-3">
				<a href="/board" class="w-100 d-block a-menu" data-id="private">
					<span class="fs-6 ms-5">부서</span>
				</a>
			</li>
		</ul>
	</div>
	<div class="col-lg-10 p-0">
		<div class="d-flex justify-content-start align-items-center">
			<form class="input-group input-group-sm" method="post" id="searchForm" style="width: 800px;">
				<input type="hidden" name="page" id="page" />
				<div class="input-group display-inline-block rounded-0">
					<select class="form-select rounded-0" name="searchType">
						<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
						<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
					</select>
					<input type="text" name="searchWord" value="${searchWord }" class="form-control float-right" placeholder="Search" style="flex:9 1 auto !important;">
					<button type="submit" class="btn btn-default rounded-0">
						<i class="fas fa-search"></i>검색
					</button>
				</div>
				<sec:csrfInput />
			</form>
			<div class="ms-auto">
				<button type="button" class="btn btn-dark rounded-0 " id="newBtn">등록</button>
			</div>
		</div>
		

		<div class="table-responsive">



			<div class="card card-body p-0">


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
							<c:when test="${empty boardList }">
								<tr>
									<td colspan="5">조회하신 게시글이 존재하지 않습니다</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${boardList }" var="board">

									<tr>
										<td width="7%">
											<span class="text-bg-secondary text-white fs-6 rounded me-n2 card-hover border border-2 border-white d-flex align-items-center justify-content-center"> ${board.bbscttNo } </span>
										</td>
										<td width="50%">
											<p class="mb-0 fw-normal fs-4">
												<a href="/board/detail?bbscttNo=${board.bbscttNo }"> ${board.bbscttTitle } </a>
											</p>
										</td>
										<td>
											<div class="d-flex align-items-center">
												<img src="${pageContext.request.contextPath}/resources/vendor/images/profile/user-2.jpg" class="rounded-circle" width="40" height="40" />
												<div class="ms-3">
													<h6 class="fs-4 fw-semibold mb-0">
														<a href="#" class="fw-semibold"> ${board.emplNo } </a>
													</h6>
													<%-- 										<span class="fw-normal">${board.register }</span> --%>
												</div>
											</div>
										</td>
										<td>
											<span class="badge rounded-pill bg-success-subtle text-success fw-semibold fs-2">${board.bbscttRdcnt }</span>
										</td>
										<td>
											<h6 class="fs-4 fw-semibold mb-0">${board.rgsde }</h6>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>


					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div class="card-footer clearfix" id="pagingArea">${pagingVO.pagingHTML }</div>
<script type="text/javascript">
// var fldrType = 0;
/* fldrType 변경  시작*/
// 	var sideArea = $('#sideArea');
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
			location.href = "/board/form";
		});

		pagingArea.on("click", "a", function() {
			event.preventDefault();
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
	});
</script>