<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

/* 모달 컨테이너 */
/* * / */
/* .modal-container { */
/* 	position: relative; */
/* } */
.setting-modal {
	position: absolute;
	left: 40%;
	top: 80%;
	transform: translate(-50%, -50%);
}

.share-modal {
	position: absolute;
	left: 20%;
	top: 50%;
	transform: translate(-50%, -50%);
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

.w-15 {
	width: 15% !important;
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
.icon-container {
  display: inline-block;
  position: relative;
}
.icon-container .ti {
  position: absolute;
  top: 8px;
  left: 0px;
}
#btnWrapperDiv .col-auto {
    margin-right: 8px; 
}

#btnWrapperDiv .col-auto:last-child {
    margin-right: 0;
}
</style>
<div class="container-fluid" style="min-height:800px; max-height:800px;">
	<div class="card w-100">
		<div class="d-flex">
			<div class="left-part border-end w-15 flex-shrink-0 d-none d-lg-block" style="border-radius: 10px 0px 0px 10px;">
				<div class="px-9 pt-4 pb-3">
					<a href="/address/addresstable">
						<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
							<i class="fa-sharp fa-regular fa-address-book fa-fw fa"></i> 주소록
						</h3>
					</a>
					<a href="javascript:void(0)" id="btn-add-contact" class="btn btn-primary rounded-0 fw-semibold py-8 w-100">
						<i class="ti ti-users text-white me-1 fs-5"></i> 연락처 추가
					</a>
				</div>

				<ul class="list-group mh-n100" data-simplebar>
					<!-- 개인 주소록 -->
					<li class="fw-semibold text-dark text-uppercase mx-9 my-2 px-3 fs-3" id="pslGrpList">
						개인 주소록
						<a class="align-items-center text-dark py-3 mb-1 rounded-1" href="javascript:void(0)" id="settingBtn">
							<i class="fa-duotone fa-gear fs-5 px-2 rounded-1"></i>
						</a>
					</li>
					<!-- 주소록 그룹을 반복해서 표시 -->
					<c:choose>
						<c:when test="${not empty addressGrpList}">
							<c:forEach var="group" items="${addressGrpList}" varStatus="loop">
								<input type="hidden" class="group-id" value="${group.adbkGroupNo}" id="adbkGroupNo-${group.adbkGroupNo}">
								<!-- 그룹 이름과 함께 그룹 링크 생성 -->
								<li class="list-group-item border-0 p-0 mx-9 ps-3">
									<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-0 group-link" href="javascript:void(0)" data-group-id="adbkGroupNo-${group.adbkGroupNo}" id="group-link-${group.adbkGroupNo}">
										<i class="fa-solid fa-folder fs-4 text-primary" style="color: #FFD43B;"></i>
										<span class="folder-name">${group.adbkGrpNm}</span>
									</a>
								</li>

							</c:forEach>
						</c:when>
						<c:otherwise>

						</c:otherwise>
					</c:choose>

					<!-- 폴더 생성 버튼 -->
					<li class="list-group-item border-0 p-0 mx-9" id="create-folder-btn-wrapper">
						<a class="d-flex align-items-center gap-6 text-dark px-2 py-3 mb-1 rounded-0" href="javascript:void(0)" id="createFolderBtn">

							<button type="button" class="justify-content-center w-50 btn mb-1 flex-fill btn-info rounded-0">
								<i class="fas fa-folder-plus fs-5 me-2" style="color: #efd44d"></i> 폴더 생성
							</button>
						</a>
					</li>

					<li class="fw-semibold text-dark text-uppercase mx-9 my-2 px-3 fs-3">부서 주소록</li>
					<li class="list-group-item border-0 p-0 mx-9 px-3">
						<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-0" href="javascript:void(0)" onclick="loadDeptAddressBook()">
							<i class="fa-regular fa-address-book fs-4" style="color: #3e6df9;"></i> </i> 전체 주소록
						</a>
					</li>
					<li class="fw-semibold text-dark text-uppercase mx-9 my-2 px-3 fs-3">사내 주소록</li>
					<li class="list-group-item border-0 p-0 mx-9 px-3" id="company_addressbook">
						<a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="${pageContext.request.contextPath}/address/employeeAddressList">
							<i class="fa-regular fa-address-book fs-4" style="color: #3e6df9;"></i> </i> 전체 주소록

						</a>
					</li>

				</ul>
			</div>
			<div class="widget-content searchable-container list">

				<!-- 			<div class="card card-body"> -->
				<!-- 				<div class="row"> -->

				<!-- 					<div class="col-md-4 col-xl-3"> -->
				<!-- 						<span>전체주소록 총 0건</span> -->
				<!-- 						<form class="position-relative"> -->
				<!-- 							<input type="text" class="form-control product-search ps-5" id="input-search" placeholder="Search Contacts..." /> -->
				<!-- 							<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i> -->
				<!-- 						</form> -->
				<!-- 					</div> -->
				<!-- 					<div class="col-md-8 col-xl-9 text-end d-flex justify-content-md-end justify-content-center mt-3 mt-md-0"> -->
				<!-- 						<div class="action-btn show-btn"> -->
				<!-- 							<a href="javascript:void(0)" class="delete-multiple bg-danger-subtle btn me-2 text-danger d-flex align-items-center "> -->
				<!-- 								<i class="ti ti-trash text-danger me-1 fs-5"></i> Delete All Row -->
				<!-- 							</a> -->
				<!-- 						</div> -->
				<!-- 					</div> -->
				<!-- 				</div> -->
			</div>
			<!-- Setting Modal -->
			<!-- 세팅모달 -->
			<div class="setting-modal-container">
				<div class="modal fade setting-modal" id="smallModal" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-sm">
						<div class="modal-content">
							<div class="modal-header d-flex align-items-center">
								<h4 class="modal-title" id="myModalLabel">폴더명 변경/삭제</h4>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body" id="modal-folderBody">
								<!-- 모달 내용 -->

							</div>
							<div class="modal-footer" id="modal-folderFooter">
								<button type="button" class="btn btn-primary" id="folderMod">수정</button>
								<button type="button" class="btn btn-danger" id="folderDel">삭제</button>
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->

				</div>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="addContactModal" tabindex="-1" role="dialog" aria-labelledby="addContactModalTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header card-header rounded-0 d-flex align-items-center" style="background: #7e858a;">
							<h5 class="modal-title text-white" id="addContactTitle">외부사원 주소록 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="add-contact-box">
								<div class="add-contact-content">
									<form id="contactForm" method="post">
										<div class="form-group input-group align-items-center">
											<label for="c-grpNm" class="me-3">그룹명</label> <br /> <select id="grpNmSelect" class="form-select rounded-0">
												<c:choose>
													<c:when test="${not empty addressGrpList}">
														<c:forEach var="group" items="${addressGrpList}">
															<option value="${group.adbkGroupNo}" data-grpNm="${group.adbkGrpNm}">${group.adbkGrpNm}</option>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<option>개인주소록 그룹을 생성해주세요.</option>
													</c:otherwise>
												</c:choose>
											</select>
										</div>
										<br />
										<hr />
										<div class="form-group align-items-center input-group">
											<input type="hidden" id="emplNo" name="emplNo">
											<label for="c-name" class="me-3">이름</label>
											<input type="text" class="form-control rounded-0" id="c-name" name="c-name">
											<span class="validation-text text-danger"></span>
										</div>
										<div class="form-group align-items-center input-group my-3">
											<label for="c-company" class="me-3">회사</label>
											<input type="text" class="form-control rounded-0" id="c-company" name="c-company">

										</div>
										<div class="form-group align-items-center input-group">
											<label for="c-department" class="me-3">부서</label>
											<input type="text" class="form-control rounded-0" id="c-department" name="c-department">
										</div>
										<div class="form-group align-items-center input-group my-3">
											<label for="c-position" class="me-3">직위</label>
											<input type="text" class="form-control rounded-0" id="c-position" name="c-position">
										</div>
										<div class="form-group align-items-center input-group">
											<label for="c-email" class="me-1">이메일</label>
											<input type="email" class="form-control rounded-0" id="c-email" name="c-email">
											<span class="validation-text text-danger"></span>
										</div>
										<div class="form-group align-items-center input-group my-3">
											<label for="c-phone" class="me-1">휴대폰</label>
											<input type="text" class="form-control rounded-0" id="c-phone" name="c-phone">
											<span class="validation-text text-danger"></span>
										</div>
										<div class="form-group align-items-center input-group">
											<label for="c-memo" class="me-3">메모</label>
											<textarea class="form-control rounded-0" id="c-memo" name="c-memo" rows="5" style="resize: none;"></textarea>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<div class="d-flex gap-6 m-0">
								<button id="btn-siyeon" class="btn btn-warning rounded-0">시연용 버튼</button>
								<button id="btn-add" class="btn btn-info rounded-0">등록</button>
								<button id="btn-edit" class="btn btn-success rounded-0">수정</button>
								<button class="btn btn-danger rounded-0" data-bs-dismiss="modal">취소</button>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="card-body m-0 rounded-0" style="min-height:800px; max-height:800px;">
				<div class="row">
					<div id="pslGrpDiv">
						<h3>사내 주소록</h3>
						<div class="col-md-4 col-xl-3">
							<span id="adbkGrpNm">전체 주소록 총 ${pagingVO.totalRecord }건</span>
<!-- 							<form class="position-absolute" style="right: 30px;"> -->
<!-- 								<input type="text" class="form-control product-search ps-5 rounded-0" id="input-search" placeholder="검색" /> -->
<!-- 								<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i> -->
<!-- 							</form> -->
							<!-- searchForm -->
							<form id="searchForm" hidden="true">
								<input type="hidden" name="page" id="page" />
								<div class="row align-items-center">
									<div class="col-md-6">
										<div class="input-group">
											<input type="text" class="form-control" id="searchWord" name="searchWord" value="${searchWord }" placeholder="이름, 회사, 이메일 등" />
											<button type="submit" class="btn bg-primary-subtle text-primary">검색</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				<br />
				<!-- Share Modal -->
				<!-- 공유버튼 모달 -->
				<div class="modal-container">
					<div class="modal fade share-modal" id="shareModal" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header d-flex align-items-center">
									<h4 class="modal-title" id="myShareModalLabel">공유하기</h4>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body" id="modal-shareBody">
									<div class="row">
										<div class="col-md-3">
											<a id="kakaotalk-sharing-btn" href="javascript:;">
												<img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png" alt="카카오톡 공유 보내기 버튼" />
											</a>
										</div>
										<div class="col">
											<button type="button" class="btn btn-primary btn-block" id="shareChatBtn">채팅 공유</button>
										</div>
									</div>
								</div>
								<div class="modal-footer" id="modal-shareFooter">
									<div class="row">
										<div class="col-auto">
											<button type="button" class="btn btn-secondary btn-block" data-bs-dismiss="modal" hidden="true">취소</button>
										</div>
									</div>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->

					</div>
				</div>
				<!-- Share Modal End -->
				<div class="d-flex justify-content-start align-items-center gx-2" id="btnWrapperDiv">
					<div class="col-auto">
						<button type="button" class="btn rounded-0 btn-indigo" id="shareBtn">채팅방 공유</button>
					</div>
					<div class="col-auto">
						<button type="button" class="btn rounded-0" id="empl-modifyBtn" style="border: 1px solid #ddd;">수정</button>
					</div>
					<div class="col-auto">
						<button type="button" class="btn rounded-0" id="copyBtn" style="border: 1px solid #ddd;">주소록 복사</button>
					</div>
					<form class="ms-auto">
						<div class="icon-container">
							<input type="text" class="form-control product-search ps-5" id="input-search" placeholder="검색">
							<i class="ti ti-search start-0 fs-6 text-dark ms-3"></i>
						</div>
					</form>
				</div>
				<br />
				<div>
					<!-- 				<form action="" method="post"> -->
					<!-- 					<input type="text" style="margin-right: 10px;" placeholder="이름" id="quick-nm"> -->
					<!-- 					<input type="text" style="margin-right: 10px;" placeholder="이메일" id="quick-email"> -->
					<!-- 					<input type="text" style="margin-right: 10px;" placeholder="휴대폰" id="quick-phone"> -->
					<!-- 					<button type="button" class="btn btn-outline-primary" id="">빠른추가</button> -->
					<!-- 				</form> -->
				</div>
				<!-- 			<div class="col-md-8 col-xl-9 text-end d-flex justify-content-md-start justify-content-center mt-3 mt-md-0"> -->
				<!-- 				<div class="action-btn show-btn"> -->
				<!-- 					<a href="javascript:void(0)" class="delete-multiple bg-danger-subtle btn me-2 text-danger d-flex align-items-center "> -->
				<!-- 						<i class="ti ti-trash text-danger me-1 fs-5"></i> Delete All Row -->
				<!-- 					</a> -->
				<!-- 				</div> -->
				<!-- 			</div> -->
				<br />
				<div class="overflow-auto" style="max-height: 525px;">
					<table class="table search-table align-middle text-nowrap">
						<thead class="header-item">
							<tr>
								<th>
									<div class="n-chk align-self-center text-center">
										<div class="form-check">
											<input type="checkbox" class="form-check-input primary" id="contact-check-all" />
											<label class="form-check-label" for="contact-check-all"></label>
											<span class="new-control-indicator"></span>
										</div>
									</div>
								</th>
								<th>이름</th>
								<th>회사</th>
								<th>부서</th>
								<th>직위</th>
								<th>이메일</th>
								<th>휴대폰</th>
								<th>메모</th>
							<!--위로 옮겨야됨..쓰레기통 모양  -->
							<!-- 						<th>Action</th> -->
							<tr>
						</thead>
						<tbody id="tbody" style="overflow: auto;">
							<!-- start row -->
							<c:set value="${pagingVO.dataList }" var="employeeAdList" />
							<c:choose>
								<c:when test="${empty employeeAdList}">
									<tr>
										<td colspan="7">조회하실 데이터가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<!-- 데이터가 있을 때 테이블의 내용을 표시하는 부분 -->
									<c:forEach items="${employeeAdList}" var="emplAdList" varStatus="loop">
										<tr class="search-items">
											<td>
												<div class="n-chk align-self-center text-center">
													<div class="form-check">
														<input type="checkbox" class="form-check-input contact-chkbox primary" id="checkbox${loop.index}" />
														<label class="form-check-label" for="checkbox${loop.index}"></label>
													</div>
												</div>
											</td>
											<td>
												<div class="d-flex align-items-center">
													<c:choose>
														<c:when test="${empty emplAdList.emplProflPhoto}">
															<img src="${pageContext.request.contextPath}/resources/vendor/images/profile/user-2.jpg" alt="avatar" class="rounded-circle" width="35" />
														</c:when>
														<c:otherwise>
															<img src="/profile/view/${emplAdList.emplProflPhoto}" alt="avatar" class="rounded-circle" width="35" />
														</c:otherwise>
													</c:choose>
													<div class="ms-3">
														<div class="user-meta-info">
															<!-- adbkNo값 hidden요소로 넣어주기 -->
															<input type="hidden" id="adbkNo${loop.index}" value="${emplAdList.adbkNo}" />
															<h6 class="user-name mb-0" data-name="${emplAdList.adbkNm}">${emplAdList.adbkNm}</h6>
														</div>
													</div>
												</div>
											</td>
											<td><span class="usr-company" data-company="${emplAdList.adbkCmpny}">${emplAdList.adbkCmpny}</span></td>
											<td><span class="usr-department" data-dept="${emplAdList.adbkDept}">${emplAdList.adbkDept}</span></td>
											<td><span class="usr-position" data-position="${emplAdList.adbkClsf}">${emplAdList.adbkClsf}</span></td>
											<td><span class="usr-email-addr" data-email="${emplAdList.adbkEmail}">${emplAdList.adbkEmail}</span></td>
											<td><span class="usr-ph-no" data-phone="${emplAdList.adbkTelno}">${emplAdList.adbkTelno}</span></td>
											<td><span class="usr-memo" data-memo="${emplAdList.adbkMemo}">${emplAdList.adbkMemo}</span></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
						<!-- 								<td> -->
						<!-- 									<div class="action-btn"> -->
						<!-- 										<a href="javascript:void(0)" class="text-primary edit"> -->
						<!-- 											<i class="ti ti-eye fs-5"></i> -->
						<!-- 										</a> -->
						<!-- 										<a href="javascript:void(0)" class="text-dark delete ms-2"> -->
						<!-- 											<i class="ti ti-trash fs-5"></i> -->
						<!-- 										</a> -->
						<!-- 									</div> -->
						<!-- 								</td> -->
						<!-- end row -->
					</table>
					<!-- 페이징 -->
					<!-- 				<nav aria-label="..."> -->
					<!-- 					<ul class="pagination justify-content-center mb-0 mt-4"> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 d-flex align-items-center justify-content-center" href="#"> -->
					<!-- 								<i class="ti ti-chevron-left"></i> -->
					<!-- 							</a></li> -->
					<!-- 						<li class="page-item active" aria-current="page"><a class="page-link border-0 rounded-circle round-32 mx-1 d-flex align-items-center justify-content-center" href="#">1</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 mx-1 d-flex align-items-center justify-content-center" href="#">2</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 mx-1 d-flex align-items-center justify-content-center" href="#">3</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 mx-1 d-flex align-items-center justify-content-center" href="#">4</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 mx-1 d-flex align-items-center justify-content-center" href="#">5</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 mx-1 d-flex align-items-center justify-content-center" href="#">...</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 mx-1 d-flex align-items-center justify-content-center" href="#">10</a></li> -->
					<!-- 						<li class="page-item"><a class="page-link border-0 rounded-circle text-dark round-32 d-flex align-items-center justify-content-center" href="#"> -->
					<!-- 								<i class="ti ti-chevron-right"></i> -->
					<!-- 							</a></li> -->
					<!-- 					</ul> -->
					<!-- 				</nav> -->
				</div>
				<nav aria-label="Page navigation example" id="pagingArea">${pagingVO.pagingHTML }</nav>
			</div>
		</div>
	</div>
</div>
</div>
<script src="${pageContext.request.contextPath}/resources/project/js/contact_custom.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/project/js/ajax_custom.js"></script> --%>


<script type="text/javascript">
	const adbkGrpNm = $('#adbkGrpNm').text().trim();
	var adbkGroupNo;
	var groupName;
	var folderMod = $('#folderMod');
	var folderDel = $('#folderDel');
	var originalFolderTitle = '';
	var modalFolderFooter = $('#modal-folderFooter');
	var adbkEmplValue;
	var addContactTitle = $('#addContactTitle');
	var originalTitle = $('#addContactTitle').text();
	var isEditMode = false;
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

	$('#btn-add').on('click', function() {
		// 폼 데이터를 가져옴
		var formData = {
			adbkNm : $('#c-name').val(),
			adbkCmpny : $('#c-company').val(),
			adbkDept : $('#c-department').val(),
			adbkClsf : $('#c-position').val(),
			adbkEmail : $('#c-email').val(),
			adbkTelno : $('#c-phone').val(),
			adbkMemo : $('#c-memo').val(),
			adbkGroupNo : $('#grpNmSelect').val() // 선택한 그룹의 ID 추가
		};

		// AJAX를 통해 서버로 폼 데이터 전송
		$.ajax({
			type : 'POST',
			url : '/address/insertAddress',
			data : JSON.stringify(formData),
			contentType : 'application/json;charset=utf-8',
			success : function(response) {
				Swal.fire('성공', '주소록이 성공적으로 추가되었습니다!', 'success');
				console.log("인서트된 주소록",response);
			},
			error : function(xhr, status, error) {
				console.error("실패..");
			}
		});
	});

	// 체크박스 클릭 이벤트 처리
	
	$(document).on('click', '.contact-chkbox', function() {
		// 체크된 체크박스의 adbkNo 값을 가져옴 (이렇게 가져오면 adbkNo가 맨위에 있어야 가져와짐..) 수정바람 
		var adbkNo = $(this).closest('tr').find('input[type="hidden"]').val();

		// 가져온 adbkNo 값을 콘솔에 출력
		//console.log('선택된 adbkNo 값: ', adbkNo);
		
		// 클릭된 체크박스의 부모 <tr> 요소를 찾음
	    var trElement = $(this).closest('tr');
	    adbkEmplValue = trElement.find('.form-control').data('adbkempl');
	    
	    // 가져온 adbkEmplValue 값을 콘솔에 출력
	    console.log('선택된 adbkEmpl 값: ', adbkEmplValue);
	});
	
	

	$('#empl-modifyBtn').on('click', function() {
		modifyAddress();
	});

	/* contact_custom.js modifyAddress() 로... */

	// 함수 호출
	setupEmplModalEvents();

	// 체크박스 클릭 이벤트 처리
	$('.contact-chkbox').on('click', function() {
		// 체크된 체크박스의 adbkNo 값을 가져옴
		var adbkNo = $(this).closest('tr').find('input[type="hidden"]').val();

		// 가져온 adbkNo 값을 콘솔에 출력
		console.log('선택된 adbkNo 값: ', adbkNo);
	});

	/* contact_custom.js로.. */
	$('#btn-edit').on('click', function() {
		EmplEditAjax()
	});

	function loadDeptAddressBook() {
	    // AJAX를 통해 서버로 요청을 보냅니다.
	    $.ajax({
	    	
	        type: 'GET', 
	        url: '/address/deptAddressBook', 
	        success: function(response) {
	            console.log(response);
	            let tbody = $("#tbody");
	            tbody.html('');
	            let pslGrpDiv = $("#pslGrpDiv");
	            pslGrpDiv.html('');
	            let quickAddWrapper = $("#quickAddWrapper");
	            quickAddWrapper.html('');
            	let html = '';
            	html += '<h3>부서 주소록</h3>';
            	html += '				<div class="col-md-4 col-xl-3">';
            	html += '					<span id="adbkGrpNm">전체 주소록';
            	html += '					</span> 총 '+response.deptListCnt+'건';
//             	html += '					<form class="position-absolute" style="right: 30px;">';
//             	html += '						<input type="text" class="form-control product-search ps-5" id="input-search" placeholder="검색" />';
//             	html += '						<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>';
//             	html += '					</form>';
            	html += '				</div>';
            	
            	pslGrpDiv.append(html);
	            
	            for(let i = 0; i < response.selectDeptList.length; i++){
	            	let addr = response.selectDeptList[i];
	            	let html ='';
	            	html += '<tr class="search-items">';
	            	html += '	<td>';
	            	html += '		<div class="n-chk align-self-center text-center">';
	            	html += '			<div class="form-check">';
	            	html += '				<input type="checkbox" class="form-check-input contact-chkbox primary" id="checkbox'+i+'" />';
	            	html += '				<label class="form-check-label" for="checkbox'+i+'"></label>';
	            	html += '			</div>';
	            	html += '		</div>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<div class="d-flex align-items-center">';
	            	html += '			<img src="/profile/view/'+addr.emplProflPhoto+'" alt="avatar" class="rounded-circle" width="35" />';
	            	html += '			<div class="ms-3">';
	            	html += '				<div class="user-meta-info">';
	            	html += '					<!-- adbkNo값 hidden요소로 넣어주기 -->';
	            	html += '					<input type="hidden" id="adbkNo'+addr.adbkNo+'" value="'+addr.adbkNo+'" />';
	            	html += '					<input type="hidden" class="form-control" id="c-'+addr.adbkEmpl+'" data-adbkempl="'+addr.adbkEmpl+'">';
	            	html += '					<input type="hidden" class="psGrpNo" value="'+addr.adbkGrpNo+'" />';
	            	html += '					<input type="hidden" class="psGrpNm" value="'+addr.adbkGrpNm+'" />';
	            	html += '					<h6 class="user-name mb-0" data-name="'+addr.adbkNm+'">'+addr.adbkNm+'</h6>';
	            	html += '				</div>';
	            	html += '			</div>';
	            	html += '		</div>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<span class="usr-company" data-company="'+addr.adbkCmpny+'">'+addr.adbkCmpny+'</span>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<span class="usr-department" data-dept="'+addr.adbkDept+'">'+addr.adbkDept+'</span>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<span class="usr-position" data-position="'+addr.adbkClsf+'">'+addr.adbkClsf+'</span>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<span class="usr-email-addr" data-email="'+addr.adbkEmail+'">'+addr.adbkEmail+'</span>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<span class="usr-ph-no" data-phone="'+addr.adbkTelno+'">'+addr.adbkTelno+'</span>';
	            	html += '	</td>';
	            	html += '	<td>';
	            	html += '		<span class="usr-memo" data-memo="'+addr.adbkMemo+'">'+addr.adbkMemo+'</span>';
	            	html += '	</td>';
	            	html += '</tr>';
	            	
	            	tbody.append(html);
	            }
	            $('#pagingArea').remove();
		        
	        },
	        error: function(xhr, status, error) {
	            // 요청이 실패했을 때 실행
	            console.log('서버에러');
	        }
	    });
	}
	/* 시연용 버튼 */
	$('#btn-siyeon').on('click', function() {
		
		$('#c-name').val('박시연');
	    $('#c-company').val('SK텔레콤');
	    $('#c-department').val('서비스개발팀');
	    $('#c-position').val('대리');
	    $('#c-email').val('siyeon@naver.com');
	    $('#c-phone').val('010-1234-1234');
	    $('#c-memo').val('');
		
	});
	
	
	/* ready(function())시작 */
	$(document).ready(function() {
		adbkGroupNo = $('#currentGroupNo').val();
		// 그룹 링크를 클릭했을 때의 처리
		$('.group-link').on('click', function(event) {
			
			// 클릭된 그룹 링크의 data-group-id 속성값을 가져옴
			adbkGroupNo = $(this).attr('data-group-id').split('-')[1];

			groupName = $(this).text().trim();
			
			// 그룹 이름을 <span> 요소에 반영
			$('#adbkGrpNm').text(groupName);
			console.log(adbkGroupNo);
			
			
			
		});
		
		$(".group-link:first").on('click', function(event){
			 var groupUrl = '${pageContext.request.contextPath}/address/addresstable';
			 window.location.href = groupUrl;
		});
		
		$("#createFolderBtn").click(function() {
	        createFolder();
	    });
		$('#btn-add-contact').click(function(){
			updateFolderList();
		});
		
		//세팅모달
		$('#settingBtn').click(function() {
	        $('#smallModal').modal('show');
	        $(".modal-backdrop").remove();
	        loadFolderList();
	    });
		
		
		
		
		
		$(document).on('click', '#folderMod', function() {
			   var checkedItems = $('.contact-chkbox:checked');
			   if (checkedItems.length === 1) {
		    	   isEditMode = true; 
		    	   originalFolderTitle = checkedItems.closest('li').find('.list-group-item-action').text().trim();
		
		    	   var folderNameElement = checkedItems.closest('li').find('.text-dark'); 
		
		    	   folderNameElement.html('<input type="text" class="form-control folder-name-input" value="' + originalFolderTitle + '">' +
		                      '<input type="hidden" class="folder-group-id" value="' + checkedItems.closest('li').find('.group-id').val() + '">');
		
		    	   var buttonsHtml = '<button type="button" class="btn btn-primary btn-sm btn-folder-save" id="folderSave">수정완료</button>' +
		    	                      '<button type="button" class="btn btn-secondary btn-sm btn-folder-cancel" id="modCancel">취소</button>';
		    	   $('.folder-form-check').remove();
		    	   $('#modal-folderFooter').html(buttonsHtml);
		
		    	   checkedItems.closest('li').find('.contact-chkbox').prop('checked', false).prop('disabled', true);
		    	    
		    	   $('#modCancel').on('click', function() {
		  			 exitEditMode();
		  			});
			  } else if (checkedItems.length > 1) {
		      		Swal.fire({
		            html: '<span class="h4" style="font-size: 1.05em;">수정은 한 번에 한 명의 항목만 가능합니다.</span>',
		            icon: 'warning',
		            confirmButtonText: '확인'
		        });
		    } else {
		        // 체크된 항목이 없는 경우
		      Swal.fire('수정할 항목을 선택해주세요.', '', 'warning');
		    }
		 });
		
		/* 수정 상태에서 취소 눌렀을때 */
		$(document).on('click', '#modCancel', function() {
	        exitEditMode();
	 	});
		
		/* 수정완료 눌렀을때 */
		$(document).on('click', '#folderSave', function() {
			var modifiedFolderTitle = $('.folder-name-input').val();
			var groupNo = $('.folder-group-id').val();
			var formData = {
					adbkGroupNo: groupNo,
			        adbkGrpNm: modifiedFolderTitle
			};
			$.ajax({
				type: "POST",
		        url: "/address/modifyFolderName",
		        data: JSON.stringify(formData),
		        contentType: 'application/json;charset=utf-8',
		        success: function(response) {
		            console.log('서버 응답:', response);
		            Swal.fire('성공', '수정이 완료되었습니다.', 'success');
		            exitEditMode();
		         	// 모달 밖 폴더리스트 업데이트
		            updateFolder(groupNo, modifiedFolderTitle,'update');
		            //reloadFolderList();
		            
		        },
		        error: function(xhr, status, error) {
		            console.error('서버 요청 실패:', error);
		            alert('수정에 실패했습니다.');
		        }
			});
	    });
		
		/* 폴더 모달에서 삭제 눌렀을때 */
		$(document).on('click', '#folderDel', function() {
			var checkedItems = $('.contact-chkbox:checked');
		    if (checkedItems.length === 1) {
		    	var groupNo = checkedItems.closest('li').find('.group-id').val();
		        var groupCnt = parseInt(checkedItems.closest('li').find('.group-cnt').val());
		        console.log(groupNo, groupCnt);
		        
		        if (groupCnt > 0) {
		        	Swal.fire({
		        	html: '<span class="h4" style="font-size: 1.05em;">폴더 안에 주소록이 존재하는 경우 폴더를 삭제할 수 없습니다.</span>',
		            icon: 'warning',
		            confirmButtonText: '확인'
		        	});
		            return;
		        }
		        Swal.fire({
		            title: '폴더 삭제',
		            text: '정말로 이 폴더를 삭제하시겠습니까?',
		            icon: 'warning',
		            showCancelButton: true,
		            confirmButtonText: '예',
		            cancelButtonText: '아니오'
		        }).then((result) => {
		            if (result.isConfirmed) {
		            	deleteFolder(groupNo);
		            	exitEditMode();
		            	loadFolderList();
		            	//reloadFolderList();
		            }
		        });

		    }else if (checkedItems.length > 1) {
	        Swal.fire({
	            html: '<span class="h4" style="font-size: 1.05em;">폴더는 한 번에 하나만 삭제 가능합니다.</span>',
	            icon: 'warning',
	            confirmButtonText: '확인'
	        });
	    } else {
	        // 체크된 항목이 없는 경우
	        Swal.fire('삭제할 항목을 선택해주세요.', '', 'warning');
	    }
		    
		});
		
	/* document ready end */
	});
	
</script>