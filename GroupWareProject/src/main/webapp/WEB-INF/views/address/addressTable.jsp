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

.detail-search-modal {
	border-radius: 8px;
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
</style>
<div class="container-fluid" style="min-height:800px; max-height:800px;">
	<div class="card w-100">
		<div class="d-flex">
			<div class="left-part border-end w-15 flex-shrink-0 d-none d-lg-block" style="border-radius: 10px 0px 0px 10px;">
				<div class="px-9 pt-4 pb-3">
					<a href="/address/addresstable">
						<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;" >
							<i class="fa-sharp fa-regular fa-address-book fa-fw fa"></i>
							주소록
						</h3>
					</a>
					<a href="javascript:void(0)" id="btn-add-contact" class="btn btn-primary rounded-0 fw-semibold py-8 w-100">
						<i class="ti ti-users text-white me-1 fs-5"></i>
						연락처 추가
					</a>
				</div>

				<ul class="list-group mh-n100" data-simplebar>
					<!-- 개인 주소록 -->
					<li class="fw-semibold text-dark text-uppercase mx-9 my-2 px-3 fs-3" id="pslGrpList">개인 주소록 
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
								<li class="list-group-item border-0 p-0 mx-9 ps-3"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-0 group-link" href="javascript:void(0)" data-group-id="adbkGroupNo-${group.adbkGroupNo}" id="group-link-${group.adbkGroupNo}">
										<i class="fa-solid fa-folder fs-4 text-primary" style="color: #FFD43B;"></i>
										<span class="folder-name">${group.adbkGrpNm}</span>
									</a></li>

							</c:forEach>
						</c:when>
						<c:otherwise>

						</c:otherwise>
					</c:choose>
					<!-- 폴더 생성 버튼 -->
					<li class="list-group-item border-0 p-0 mx-9" id="create-folder-btn-wrapper"><a class="d-flex align-items-center gap-6 text-dark px-2 py-3 mb-1 rounded-1" href="javascript:void(0)" id="createFolderBtn">

							<button type="button" class="justify-content-center w-50 btn mb-1 flex-fill btn-info rounded-0">
								<i class="fas fa-folder-plus fs-5 me-2" style="color: #efd44d"></i>
								폴더 생성
							</button>
						</a></li>

					<li class="fw-semibold text-dark text-uppercase mx-9 my-2 px-3 fs-3">부서 주소록</li>
					<li class="list-group-item border-0 p-0 mx-9 px-3" id="dept_addressbook"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-0" href="javascript:void(0)" onclick="loadDeptAddressBook()">
							<i class="fa-regular fa-address-book fs-4" style="color: #3e6df9;"></i>
							</i>
							전체 주소록
						</a></li>
					<li class="fw-semibold text-dark text-uppercase mx-9 my-2 px-3 fs-3">사내 주소록</li>
					<li class="list-group-item border-0 p-0 mx-9 px-3" id="company_addressbook"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-0" href="${pageContext.request.contextPath}/address/employeeAddressList">
							<i class="fa-regular fa-address-book fs-4" style="color: #3e6df9;"></i>
							</i>
							전체 주소록

						</a></li>

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
			<div class="modal-container">
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
					<div class="modal-content rounded-0">
						<div class="modal-header card-header rounded-0 d-flex align-items-center" style="background: #7e858a;">
							<h5 class="modal-title text-white" id="addContactTitle">외부사원 주소록 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="add-contact-box">
								<div class="add-contact-content">
									<form method="post">
										<div class="form-group align-items-center input-group">
											<label for="c-grpNm" class="me-3">그룹명</label>
											<br />
											<select id="grpNmSelect" class="form-select rounded-0">
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
								<button id="btn-add" class="btn btn-success rounded-0">등록</button>
								<button id="btn-edit" class="btn btn-success rounded-0">수정</button>
								<button class="btn bg-danger-subtle text-danger rounded-0" data-bs-dismiss="modal">취소</button>
							</div>

						</div>
					</div>

				</div>
			</div>
			<div class="card-body m-0 rounded-0" style="min-height:800px; max-height:800px;">
				<div class="row">
					<div id="pslGrpDiv">
						<h3 id="h3-category">개인 주소록</h3>
						<div class="col-md-4 col-xl-3">
							<span id="adbkGrpNm">
								<c:choose>
									<c:when test="${empty addressGrpList}"></c:when>
									<c:otherwise>${not empty addressGrpList ? addressGrpList[0].adbkGrpNm : ''}</c:otherwise>
								</c:choose>
							</span>
							<span id="adbkCnt">총 ${not empty addressGrpList ? addressGrpList[0].cnt : '0' }건</span>
						</div>
						<!-- currentGroupNo hidden input을 여기로 이동 -->
						<input type="hidden" id="currentGroupNo" value="${not empty addressGrpList ? addressGrpList[0].adbkGroupNo : ''}">
						<form class="position-absolute" style="right: 30px;">
							<div class="d-flex align-items-center">
								<input type="text" class="form-control product-search ps-5 rounded-0" id="input-search" placeholder="검색" />
								<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
							</div>
							<!-- 상세검색  -->
							<!-- <span class="position-absolute top-50 end-0 translate-middle-y me-3 " id="advancedSearchBtn" style="cursor: pointer;">상세검색</span> -->
						</form>
					</div>
				</div>
				<br />
				<!-- ////////////////////////////////////////////////////////////////// -->
				<!-- 상세검색 창 -->
				<!-- 			<form id="searchForm2"> -->
				<!-- 							<input type="hidden" name="page" id="page" /> -->
				<!-- 							<div class="row align-items-center"> -->
				<!-- 								<div class="col-md-6"> -->
				<!-- 									<div class="input-group"> -->
				<%-- 										<input type="text" class="form-control" id="searchWord" name="searchWord" value="${searchWord }" placeholder="이름, 회사, 이메일 등" /> --%>
				<!-- 										<button type="submit" class="btn bg-primary-subtle text-primary">검색</button> -->
				<!-- 									</div> -->
				<!-- 								</div> -->
				<!-- 							</div> -->
				<!-- 						</form> -->
				<div class="modal fade" id="detailSearchModal" tabindex="-1" aria-labelledby="detailSearchModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content detail-search-modal">
							<div class="modal-header">
								<h5 class="modal-title" id="detailSearchModalLabel">상세검색</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<!-- 상세 검색 내용 -->
								<form id="searchForm">
									<div class="mb-3">
										<label for="name" class="form-label">이름</label>
										<input type="text" class="form-control" id="detail-adbkNm">
									</div>
									<div class="mb-3">
										<label for="email" class="form-label">이메일</label>
										<input type="email" class="form-control" id="detail-adbkEmail">
									</div>
									<div class="mb-3">
										<label for="phone" class="form-label">휴대전화</label>
										<input type="text" class="form-control" id="detail-adbkTelno">
									</div>
									<div class="mb-3">
										<label for="company" class="form-label">회사</label>
										<input type="text" class="form-control" id="detail-adbkCmpny">
									</div>
									<div class="mb-3">
										<label for="memo" class="form-label">메모</label>
										<input type="text" class="form-control" id="detail-adbkMemo">
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label for="detail-grpNmSelect" class="form-label">주소록 구분</label>
												<select id="detail-grpNmSelect" class="form-select">
													<option value="all">전체</option>
													<option value="psl">개인주소록</option>
													<option value="company">사내주소록</option>
													<option value="dept">부서주소록</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label for="additionalSelectContainer" class="form-label">&nbsp;</label>
												<div id="additionalSelectContainer" style="display: none;">
													<select id="additionalSelect" class="form-select">
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
											</div>
										</div>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" id="detailSearchBtn">검색</button>
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							</div>
						</div>
					</div>
				</div>
				<!-- ////////////////////////////////////////////////////////////////// -->
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
										<!-- 									<div class="col-md-3"> -->
										<!-- 										<a id="kakaotalk-sharing-btn" href="javascript:;"> -->
										<!-- 											<img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png" alt="카카오톡 공유 보내기 버튼" /> -->
										<!-- 										</a> -->
										<!-- 									</div> -->
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
				<div class="row gx-2" id="btnWrapperDiv">
					<!-- 공유,복사는 contact_custom.js에다가 구현하기-->
					<div class="col-auto">
						<button type="button" class="btn rounded-0 btn-indigo" id="shareBtn">채팅방 공유</button>
					</div>
					<div class="col-auto">
						<button type="button" class="btn rounded-0" id="ps-modifyBtn" style="border: 1px solid #ddd;">수정</button>
					</div>
					<div class="col-auto">
						<button type="button" class="btn rounded-0" id="deleteBtn" style="border: 1px solid #ddd;">삭제</button>
					</div>
					<div class="col-auto">
						<button type="button" class="btn rounded-0" id="copyBtn" style="border: 1px solid #ddd;">주소록 복사</button>
					</div>
					<div class="col-auto">
						<button type="button" class="btn btn-outline-warning rounded-0" id="grpAddSiyeon">시연용주소록추가</button>
					</div>

				</div>
				<br />
				<div id="quickAddWrapper" class="d-flex justify-content-start align-items-center">
					<input type="text" class="form-control w-25 rounded-0" style="margin-right: 10px;" placeholder="이름" id="nameInput">
					<input type="text" class="form-control w-25 rounded-0 ms-2" style="margin-right: 10px;" placeholder="이메일" id="emailInput">
					<input type="text" class="form-control w-25 rounded-0 ms-2" style="margin-right: 10px;" placeholder="휴대폰" id="phoneInput">
					<button type="button" class="btn btn-outline-primary rounded-0 ms-2" id="quickAddBtn">빠른추가</button>
					<button type="button" class="btn btn-outline-warning rounded-0 ms-2" id="quickAddBtn-siyeon">시연용입력버튼</button>
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
							</tr>
							<!--위로 옮겨야됨..쓰레기통 모양  -->
							<!-- <th>Action</th> -->
						</thead>
						<tbody id="tbody" style="overflow: auto;">
							<!-- start row -->
							<c:choose>
								<c:when test="${empty selectPersonalList}">
									<td colspan="7" id="noDataText">
										<div style="text-align: center; font-size: 15px;">조회하실 데이터가 없습니다.</div>
									</td>
								</c:when>
								<c:otherwise>
									<!-- 데이터가 있을 때 테이블의 내용을 표시하는 부분 -->
									<c:forEach items="${selectPersonalList}" var="pslList" varStatus="loop">
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
														<c:when test="${empty pslList.emplProflPhoto}">
															<img src="${pageContext.request.contextPath}/resources/vendor/images/profile/user-2.jpg" alt="avatar" class="rounded-circle" width="35" />
														</c:when>
														<c:otherwise>
															<img src="/profile/view/${pslList.emplProflPhoto}" alt="avatar" class="rounded-circle" width="35" />
														</c:otherwise>
													</c:choose>
													<div class="ms-3">
														<div class="user-meta-info">
															<!-- adbkNo값 hidden요소로 넣어주기 -->
															<input type="hidden" id="adbkNo${pslList.adbkNo}" value="${pslList.adbkNo}" />
															<input type="hidden" class="form-control" id="c-${pslList.adbkEmpl }" data-adbkempl="${pslList.adbkEmpl }">
															<input type="hidden" class="psGrpNo" value="${pslList.adbkGrpNo}" />
															<input type="hidden" class="psGrpNm" value="${pslList.adbkGrpNm}" />
															<h6 class="user-name mb-0" data-name="${pslList.adbkNm}">${pslList.adbkNm}</h6>
														</div>
													</div>
												</div>
											</td>
											<td>
												<span class="usr-company" data-company="${pslList.adbkCmpny}">${pslList.adbkCmpny}</span>
											</td>
											<td>
												<span class="usr-department" data-dept="${pslList.adbkDept}">${pslList.adbkDept}</span>
											</td>
											<td>
												<span class="usr-position" data-position="${pslList.adbkClsf}">${pslList.adbkClsf}</span>
											</td>
											<td>
												<span class="usr-email-addr" data-email="${pslList.adbkEmail}">${pslList.adbkEmail}</span>
											</td>
											<td>
												<span class="usr-ph-no" data-phone="${pslList.adbkTelno}">${pslList.adbkTelno}</span>
											</td>
											<td>
												<span class="usr-memo" data-memo="${pslList.adbkMemo}">${pslList.adbkMemo}</span>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>

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
							</tr>
							<!-- end row -->
						</tbody>
					</table>
					<nav aria-label="Page navigation example" id="pagingArea">${pagingVO.pagingHTML }</nav>
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
			</div>
		</div>
	</div>
</div>
</div>
<script src="${pageContext.request.contextPath}/resources/project/js/contact_custom.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/project/js/ajax_custom.js"></script> --%>

<!-- 카카오톡 공유 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js" integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" crossorigin="anonymous"></script>
<!-- 클립보드 js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.11/clipboard.min.js"></script>
<script>
//   Kakao.init('f5336b7d7095c9461123cf508c719025'); // 사용하려는 앱의 JavaScript 키 입력
  
//   Kakao.Share.createCustomButton({
// 	    container: '#kakaotalk-sharing-btn',
// 	    templateId: 107474,
// 	    templateArgs: {
// 	      title: '제목',
// 	      description: '내용',
// 	    },
// 	  });
</script>


<!-- 상세검색스크립트  화면구성이슈로 중단-->
<script type="text/javascript">
var detailSearchBtn = $('#detailSearchBtn');
$(document).ready(function() {
	$('#advancedSearchBtn').on('click', function() {
	    $('#detailSearchModal').modal('show');
	});
	$('#detailSearchBtn').on('click', function() {
	    var searchData = {
	        adbkNm: $('#detail-adbkNm').val(),
	        adbkEmail: $('#detail-adbkEmail').val(),
	        adbkTelno: $('#detail-adbkTelno').val(),
	        adbkCmpny: $('#detail-adbkCmpny').val(),
	        adbkMemo: $('#detail-adbkMemo').val()
	    };

	    var addressType = $('#detail-grpNmSelect').val();
	    if (addressType === 'psl') {
	        var adbkGrpNo = $('#detail-grpNmSelect').val();
	        if (adbkGrpNo) {
	            searchData.adbkGrpNo = adbkGrpNo;
	        }
	    }

	    $.ajax({
	        url: "/address/detailSearch",
	        type: "GET",
	        contentType: 'application/json;charset=UTF-8',
	        data: searchData,
	        success: function(response) {
	            console.log(response);
	        },
	        error: function(xhr, status, error) {
	            console.log('에러');
	        }
	    });
	});
	
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


	$("#detail-grpNmSelect").change(function() {
	    var selectedGroup = $(this).val(); // 선택한 주소록 유형 가져오기
	
	 	// 추가적인 셀렉트 박스 컨테이너 선택
	    var container = $("#additionalSelectContainer");


	    if (selectedGroup === "psl") {
	        container.show();
	    } else {
	        container.hide();
	    }
	});
	

});
</script>

<script type="text/javascript">
	var adbkGrpNm = $('#adbkGrpNm').text().trim();
	var adbkGroupNo;
	var groupName;
	var folderMod = $('#folderMod');
	var folderDel = $('#folderDel');
	var isEditMode = false;
	var disabledFlag = false;
	
	
	var originalFolderTitle = '';
	var modalFolderFooter = $('#modal-folderFooter');
	var psModifyBtn = $('#ps-modifyBtn'); //컨텐츠 헤더에 수정버튼
	var originalTitle = $('#addContactTitle').text();
	var addContactTitle = $('#addContactTitle');
	
	var quickAddBtn = $('#quickAddBtn');
	var categoryNm = $('#h3-category');
	var adbkCnt = $('#adbkCnt');
	var adbkEmplValue;
	
	var grpModifyBtn = $('#grpModifyBtn');	// 그룹이동버튼
	
	/* 빠른추가 */
	function quickAddEvent() {
		$(document).on('click', '#quickAddBtn', function() {
			adbkGrpNm = $('#adbkGrpNm').text().trim();	// 해당그룹이름
	        var name = $('#nameInput').val();
	        var email = $('#emailInput').val();
	        var phone = $('#phoneInput').val();
	        var groupNo = $('.psGrpNo').val(); // 해당 그룹의 번호 가져오기
	        console.log("그룹넘버 : ", adbkGroupNo);
	        if(adbkGroupNo === undefined){
	        	Swal.fire({
	                title: '경고',
	                text: '연락처 추가 전 폴더를 먼저 생성해주세요!',
	                icon: 'warning',
	                confirmButtonText: '확인'
	            });
	            return; 
	        }
	        
	        if (name === '' || email === '' || phone === '') {
	            // 비어 있는 입력란이 있으면 알림 표시
	            Swal.fire({
	                title: '경고',
	                text: '이름, 이메일, 휴대폰은 필수 입력 사항입니다.',
	                icon: 'warning',
	                confirmButtonText: '확인'
	            });
	            return; // 함수 종료
	        }
	     	// 컨펌 창 표시
	        Swal.fire({
	            title: '확인',
	            text: '"' + adbkGrpNm + '" 그룹에 연락처를 추가하시겠습니까?',
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonText: '확인',
	            cancelButtonText: '취소'
	        }).then((result) => {
	            // 사용자가 확인을 누른 경우에 ajax 요청 
	            if (result.isConfirmed) {
	                var formData = {
	                    adbkNm: name,
	                    adbkEmail: email,
	                    adbkTelno: phone,
	                    adbkGroupNo: adbkGroupNo 
	                };

	                $.ajax({
	                    type: 'POST',
	                    url: '/address/insertAddress',
	                    data: JSON.stringify(formData),
	                    contentType: 'application/json;charset=UTF-8',
	                    success: function(response){
	                        console.log('요청이 성공했습니다.');
	                        $('#nameInput').val('');
	                        $('#emailInput').val('');
	                        $('#phoneInput').val('');
	                        loadPersonalAddressList(adbkGroupNo);
	                    },
	                    error: function(xhr, status, error){
	                        console.error('에러 발생:', error);
	                    }
	                });
	            }
	        });
	    });
	}
	        
	
	$(document).ready(function(){
		quickAddEvent();
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
	            $(".search-table > tbody >tr:first").before($html);
	            //let noDataText = $('#noDataText');
	            //noDataText.remove();
	            loadPersonalAddressList(adbkGroupNo);
	        },
	        error : function(xhr, status, error) {
	            console.log("실패...");
	        }
	    });
	});
	
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
	/* 빠른추가 시연용 버튼 */
	$(document).on('click', '#quickAddBtn-siyeon', function() {
		$('#nameInput').val('김시연');
        $('#emailInput').val('zxcv1234@hanmail.net');
        $('#phoneInput').val('010-7897-7557');
	});
	
	$(document).on('click', '#ps-modifyBtn', function() {
		
		var checkedItems = $('.contact-chkbox:checked');
		if (checkedItems.length === 1) {
			// 한 명을 체크한 경우 수정 가능하게
			isEditMode = true; // 수정 모드로 변경
			addContactTitle.text('주소록 수정'); // 모달 제목을 "주소록 수정"으로 변경

			// 선택한 체크박스의 값을 가져와서 수정 폼에 채워 넣기
			var selectedRow = checkedItems.closest('tr');
			
			var name = selectedRow.find('.user-name').data('name');
			var company = selectedRow.find('.usr-company').data('company');
			var department = selectedRow.find('.usr-department').data('dept');
			var position = selectedRow.find('.usr-position').data('position');
			var email = selectedRow.find('.usr-email-addr').data('email');
			var phone = selectedRow.find('.usr-ph-no').data('phone');
			var memo = selectedRow.find('.usr-memo').data('memo');
			var selectedGroup = selectedRow.find('.psGrpNm').val();
			var selectedGrpNo = selectedRow.find('.psGrpNo').val();
			
			console.log('###########수정 버튼 클릭시 해당row',selectedGroup,selectedGrpNo);
			
	        var adbkNo = selectedRow.find('.form-control').data('adbkempl');
			
	        console.log('adbkNo :', adbkNo);
	        
			// 수정 폼에 값들을 채워 넣기
			$('#c-name').val(name);
			$('#c-company').val(company);
			$('#c-department').val(department);
			$('#c-position').val(position);
			$('#c-email').val(email);
			$('#c-phone').val(phone);
			$('#c-memo').val(memo);
				
			// 셀렉트 박스에 선택된 그룹명 설정
			$('#grpNmSelect').val(selectedGrpNo);
			$('#grpNmSelect').prop('disabled', true); // 셀렉트 박스 비활성화
			
			$('#addContactModal').modal('show'); // 모달 열기
		} else if (checkedItems.length > 1) {
			// 두 명 이상을 체크한 경우
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

	// 모달이 열릴 때마다 실행되는 이벤트
	$('#addContactModal').on('show.bs.modal', function() {
		addContactTitle.text('외부사원 주소록 등록');
		
		// 수정 모드인 경우
		if (isEditMode) {
			addContactTitle.text('주소록 수정');
			$('#btn-add').hide();
			$('#btn-edit').show();

		} else { // 추가 모드인 경우
			addContactTitle.text(originalTitle);
			$('#btn-add').show();
			$('#btn-edit').hide();
			$('#grpNmSelect').prop('disabled', false);
		}
		if (disabledFlag){
			$('#c-name').prop('disabled', true);
	        $('#c-company').prop('disabled', true);
	        $('#c-department').prop('disabled', true);
	        $('#c-position').prop('disabled', true);
		}
		$('#c-name').prop('disabled', false);
        $('#c-company').prop('disabled', false);
        $('#c-department').prop('disabled', false);
        $('#c-position').prop('disabled', false);
	});

	// 모달이 닫힐 때마다
	$('#addContactModal').on('hidden.bs.modal', function() {
		$('#btn-add').show();
		$('#btn-edit').hide();
		// 수정 모드 해제
		isEditMode = false;
		$('#grpNmSelect').prop('disabled', false);
		$('.form-check-input').prop('checked', false);
	});

	// 체크박스 클릭 이벤트 처리
	
	$(document).on('click', '.contact-chkbox', function() {
		// 체크된 체크박스의 adbkNo 값을 가져옴 (이렇게 가져오면 adbkNo가 맨위에 있어야 가져와짐..) 수정바람 
		var adbkNo = $(this).closest('tr').find('input[type="hidden"]').val();

		// 가져온 adbkNo 값을 콘솔에 출력
		console.log('선택된 adbkNo 값: ', adbkNo);
		
		// 클릭된 체크박스의 부모 <tr> 요소를 찾음
	    var trElement = $(this).closest('tr');
	    adbkEmplValue = trElement.find('.form-control').data('adbkempl');
	    
	    // 가져온 adbkEmplValue 값을 콘솔에 출력
	    console.log('선택된 adbkEmpl 값: ', adbkEmplValue);
	});

	
	
	$('#btn-edit').on('click', function() {
	    // 수정 내용 확인을 위한 SweetAlert 창 표시
	    Swal.fire({
	        title: '수정하시겠습니까?',
	        icon: 'question',
	        showCancelButton: true,
	        confirmButtonText: '수정',
	        cancelButtonText: '취소',
	    }).then((result) => {
	        // 사용자가 확인을 누른 경우에만 AJAX 요청 보내기
	        if (result.isConfirmed) {
	            var adbkNo = $('.contact-chkbox:checked').closest('tr').find('input[type="hidden"]').val();

	            // 폼 데이터를 가져옴
	            var formData = {										
	                adbkNm: $('#c-name').val(),                         			
	                adbkCmpny: $('#c-company').val(),                     			
	                adbkDept: $('#c-department').val(),                      			
	                adbkClsf: $('#c-position').val(),                      			
	                adbkEmail: $('#c-email').val(),
	                adbkTelno: $('#c-phone').val(),
	                adbkMemo: $('#c-memo').val(),
	                adbkEmpl: adbkEmplValue,
	                adbkNo: adbkNo
	            };

	            // AJAX를 통해 서버로 폼 데이터 전송
	            $.ajax({
	                type: 'POST',
	                url: '/address/updatePsAddress',
	                data: JSON.stringify(formData),
	                contentType: 'application/json;charset=utf-8',
	                success: function(response) {
	                    Swal.fire('수정 성공!', '', 'success').then(() => {
	                        console.log('수정 성공');
	                        $('#addContactModal').modal('hide');
	                        isEditMode = false;
	                        if (adbkEmplValue === 0 || adbkEmplValue === undefined){
	                        	loadPersonalAddressList(adbkGroupNo);
	                        }else{
	                        	loadDeptAddressBook();
	                        }
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error(xhr.responseText);
	                    Swal.fire('오류 발생', '수정에 실패하였습니다.', 'error');
	                }
	            });
	        }
	    });
	});
	
	/* ready(function())시작 */
	$(document).ready(function() {
		adbkGroupNo = $('#currentGroupNo').val();
		// 그룹 링크를 클릭했을 때의 처리
		$(document).on('click', '.group-link', function(event) {
			
			// 클릭된 그룹 링크의 data-group-id 속성값을 가져옴
			adbkGroupNo = $(this).attr('data-group-id').split('-')[1];

			groupName = $(this).text().trim();
			
			// 그룹 이름을 <span> 요소에 반영
			$('#adbkGrpNm').text(groupName);
			$('#currentGroupNo').val(adbkGroupNo);
			console.log(adbkGroupNo);
			// 리스트 뿌려주기 
			loadPersonalAddressList(adbkGroupNo);
			
			console.log(groupName);
			//빠른추가 비워주기 
			$('#nameInput').val('');
            $('#emailInput').val('');
            $('#phoneInput').val('');
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
		
		$(document).on('click', '#grpAddSiyeon', function() {
			adbkGroupNo = $('#currentGroupNo').val();
			var emplNo = connectionTest();
			var selectedIds = [20240083, 20240087, 20240077, 20240061];
			var formData = {
			        adbkGrpNo: adbkGroupNo, // 그룹 번호
			        emplNo: emplNo, // 사용자의 직원 번호
			        selectedIds: selectedIds // 추가할 사람들의 adbkEmpl 목록
			    };
			$.ajax({
			    type: "POST",
			    url: "/address/addMembersToFolder",
			    contentType: 'application/json;charset=utf-8',
			    data: JSON.stringify(formData),
			    cache: false, // 캐시 사용하지 않음
			    success: function(response) {
			        if (response === "OK") {
			            swal.fire('성공', '성공적으로 주소록에 추가되었습니다!', 'success').then(function() {
			                location.reload();
			            });
			        } else {
			            swal.fire('오류', '주소록에 추가하는 데 실패했습니다', 'error');
			        }
			    },
			    error: function(xhr, status, error) {
			        swal.fire('오류', '서버와의 통신 중 오류가 발생했습니다', 'error');
			    }
			});
		});
		
		$(document).on('click', '#folderMod', function() {
		   var checkedItems = $('.contact-chkbox:checked');
		   if (checkedItems.length === 1) {
	    	   isEditMode = true; 
	    	   originalFolderTitle = checkedItems.closest('li').find('.list-group-item-action').text().trim(); 
	
	    	   var folderNameElement = checkedItems.closest('li').find('.text-dark'); 
	
	    	   folderNameElement.html('<input type="text" class="form-control folder-name-input" value="' + originalFolderTitle + '">' +
	                      '<input type="hidden" class="folder-group-id" value="'+checkedItems.closest('li').find('.group-id').val()+'">');
	
	    	   var buttonsHtml = '<button type="button" class="btn btn-primary btn-sm btn-folder-save" id="folderSave">수정완료</button>' +
	    	                      '<button type="button" class="btn btn-secondary btn-sm btn-folder-cancel" id="modCancel">취소</button>';
	    	   $('.folder-form-check').remove();
	    	   $('#modal-folderFooter').html(buttonsHtml);
	
	    	   checkedItems.closest('li').find('.contact-chkbox').prop('checked', false).prop('disabled', true);
	    	    
	    	   $('#modCancel').on('click', function() {
	  			 exitEditMode();
	  			});
	    	   $('#smallModal').on('hidden.bs.modal', function () {
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
		            Swal.fire({
		            	  icon: 'error',
		            	  title: '수정 중 오류가 발생했습니다.',
		            	});
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
	
	/* 개인주소록 리스트 비동기 출력 */
	function loadPersonalAddressList(adbkGroupNo) {
		$.ajax({
			type: "GET",
			url: "/address/selectPersonalList",
			data: { adbkGroupNo: adbkGroupNo },
			
			success: function(response) {
				if (response.length === 0) {
			        // 조회된 주소록이 없는 경우 빈 상태 메시지를 표시
			        var tbody = $("#tbody");
			        tbody.html('<tr><td colspan="7" id="noDataText" style="text-align: center; font-size: 15px;">조회하실 데이터가 없습니다.</td></tr>');
			        $("#adbkCnt").text("총 " + 0 + "건");
				} else {
			        // 조회된 주소록이 있는 경우 테이블에 데이터를 추가
			        console.log(response);
			        var tbody = $("#tbody");
			        tbody.html('');
			        
			        for (let i = 0; i < response.length; i++) {
			            // 주소록 데이터를 테이블에 추가하는 코드
			        	let addr = response[i];
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
		            	if (addr.emplProflPhoto !== null) {
		                    html += '            <img src="/profile/view/'+addr.emplProflPhoto+'" alt="avatar" class="rounded-circle" width="35" />';
		                } else {
		                    html += '            <img src="${pageContext.request.contextPath}/resources/vendor/images/profile/user-2.jpg" alt="avatar" class="rounded-circle" width="35" />';
		                }
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
			        
			        $("#adbkCnt").text("총 " + response.length + "건");
			        
			    }
				// 버튼 리셋 ..
				btnWrapperReset();
				$("#h3-category").text("개인 주소록");
				quickAddReset();
	        },
	        error: function(xhr, status, error) {
	            // 요청이 실패했을 때 실행
	            console.log('서버에러');
	        }
	    });
	}
	
	function quickAddReset(){
		var quickAddWrapper= $("#quickAddWrapper");
		quickAddWrapper.addClass('d-flex justify-content-start align-items-center')
		var html = '';
		html += '<input type="text" class="form-control w-25 rounded-0" style="margin-right: 10px;" placeholder="이름" id="nameInput">';
		html += '<input type="text" class="form-control w-25 rounded-0 ms-2" style="margin-right: 10px;" placeholder="이메일" id="emailInput">';
		html += '<input type="text" class="form-control w-25 rounded-0 ms-2" style="margin-right: 10px;" placeholder="휴대폰" id="phoneInput">';
		html += '<button type="button" class="btn btn-outline-primary rounded-0 ms-2" id="quickAddBtn">빠른추가</button>';
		html += '<button type="button" class="btn btn-outline-warning rounded-0 ms-2" id="quickAddBtn-siyeon">시연용입력버튼</button>';
		quickAddWrapper.html('');
		quickAddWrapper.append(html);
	}
	
	function btnWrapperReset() {
		let btnWrapperDiv = $('#btnWrapperDiv');
        btnWrapperDiv.html('');
        
    	let btnHtml = '';
    	btnHtml += '<div class="col-auto">';
    	btnHtml += '					<button type="button" class="btn rounded-0 btn-indigo" id="shareBtn">채팅방 공유</button>';
    	btnHtml += '				</div>';
    	btnHtml += '				<div class="col-auto">';
    	btnHtml += '					<button type="button" class="btn rounded-0" style="border: 1px solid #ddd;" id="ps-modifyBtn">수정</button>';
    	btnHtml += '				</div>';
    	btnHtml += '				<div class="col-auto">';
    	btnHtml += '					<button type="button" class="btn rounded-0" style="border: 1px solid #ddd;" id="deleteBtn">삭제</button>';
    	btnHtml += '				</div>';
    	btnHtml += '				<div class="col-auto">';
    	btnHtml += '					<button type="button" class="btn rounded-0" style="border: 1px solid #ddd;" id="copyBtn">주소록 복사</button>';
    	btnHtml += '				</div>';
    	btnHtml += '				<div class="col-auto">';
    	btnHtml += '					<button type="button" class="btn btn-outline-warning rounded-0" id="grpAddSiyeon">시연용주소록추가</button>';
    	btnHtml += '				</div>';
        
    	btnWrapperDiv.append(btnHtml);
	}
	
	
	/* 부서주소록 */
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
            	html += '<h3 id="h3-category">부서 주소록</h3>';
            	html += '				<div class="col-md-4 col-xl-3">';
            	html += '					<span id="adbkGrpNm">전체 주소록';
            	html += '					</span> <span id="adbkCnt">총 '+response.deptListCnt+'건</span>';
            	html += '					<form class="position-absolute" style="right: 30px;">';
            	html += '						<input type="text" class="form-control product-search ps-5" id="input-search" placeholder="검색" />';
            	html += '						<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>';
            	html += '					</form>';
            	html += '				</div>';
            	
            	pslGrpDiv.append(html);
	            
	            let btnWrapperDiv = $('#btnWrapperDiv');
	            btnWrapperDiv.html('');
	            
            	let btnHtml = '';
            	btnHtml += '<div class="col-auto">';
            	btnHtml += '					<button type="button" class="btn rounded-0 btn-indigo" id="shareBtn">채팅방 공유</button>';
            	btnHtml += '				</div>';
            	btnHtml += '				<div class="col-auto">';
            	btnHtml += '					<button type="button" class="btn rounded-0" style="border: 1px solid #ddd;" id="ps-modifyBtn">수정</button>';
            	btnHtml += '				</div>';
            	btnHtml += '				<div class="col-auto">';
            	btnHtml += '					<button type="button" class="btn rounded-0" style="border: 1px solid #ddd;" id="copyBtn">주소록 복사</button>';
            	btnHtml += '				</div>';
	            
            	btnWrapperDiv.append(btnHtml);
	            	
	            	
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
		        
	        },
	        error: function(xhr, status, error) {
	            // 요청이 실패했을 때 실행
	            console.log('서버에러');
	        }
	    });
	}
	

</script>