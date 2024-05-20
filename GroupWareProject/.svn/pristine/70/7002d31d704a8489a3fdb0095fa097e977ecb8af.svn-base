
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
   .nav-link .d-none.d-md-block {
        font-size: 16px; /* Adjust the font size as needed */
}
</style>
<div class="container-fluid">
	<div class="card card-body">
			<div class="row">
			<h3 class="fw-semibold mb-4" style="margin-left: 10px;">
					<i class="fa-sharp fa-regular fa-car-side fa-fw fa"></i>
				&nbsp;대여
			</h3>
			<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4">
			<ul class="nav nav-pills user-profile-tab justify-content-center" id="pills-tab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/myReservation/main';" id="pills-stop-tab" data-bs-toggle="pill" data-bs-target="#pills-stop" type="button" role="tab" aria-controls="pills-stop" aria-selected="true">
						<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;시설물 예약하기&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/myReservation/roomList';" id="pills-stop-tab" data-bs-toggle="pill" data-bs-target="#pills-stop" type="button" role="tab" aria-controls="pills-stop" aria-selected="true">
						<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;예약현황보기&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</button>
				</li>
			</ul>
			</div>
				<!-- 예약목록과 대여목록 링크 -->
				<div class="col-md-4 text-center">
					<div class="d-flex justify-content-start align-items-center">
						<a href="/myReservation/roomList" class="me-2">
							<span class="fs-5 fw-semibold">예약목록</span>
						</a>
						<a href="/myReservation/rentalList">
							<span class="fs-5 fw-semibold">대여목록</span>
						</a>
					</div>
				</div>
				<!-- 검색 폼 및 버튼 -->
				<div class="col-md-8 col-xl-8 text-end d-flex justify-content-end align-items-center">
					<form action="" method="post" id="ReservListId"
						class="d-flex align-items-center">
						<div class="input-group display-inline-block rounded-0">
							<input type="text" name="searchWord" value="${searchWord}"
								class="form-control product-search ps-5" id="searchForm"
								placeholder="검색어를 입력해주세요">
							<button type="submit" class="btn btn-default rounded-0">
								<i class="fas fa-search"></i>검색
							</button>
						</div>
						<input type="hidden" name="page" id="page" />
						<sec:csrfInput />
					</form>
					<div class="action-btn show-btn">
						<a href="javascript:void(0)"
							class="delete-multiple bg-danger-subtle btn me-2 text-danger d-flex align-items-center">
							<i class="ti ti-trash text-danger me-1 fs-5"></i> Delete All Row
						</a>
					</div>
				</div>
			</div>
		</div>

		<div class="card card-body">
				<div class="table-responsive">
					<table class="table search-table align-middle text-nowrap">
						<thead class="header-item">
							<tr>
								<th>
									<div class="n-chk align-self-center text-center">
										<div class="form-check">
											<input type="checkbox" class="form-check-input primary" id="contact-check-all">
											<label class="form-check-label" for="contact-check-all"></label> <span class="new-control-indicator"></span>
										</div>
									</div>
								</th>
								
								<th>&nbsp;&nbsp;&nbsp;시설명</th>
								<th>예약번호</th>
								<th style="width: 30%" >예약시간</th>
								<th>예약내용</th>
								<th>상태</th>
							
							</tr>
						</thead>
						<tbody>
						<!--startRow  -->
							<c:set value="${pagingVO.dataList }" var="reservList" />
							<c:choose>
								<c:when test="${empty reservList }">
									<tr>
										<td colspan="5">조회하신 예약내역이 존재하지 않습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${reservList }" var="reservVO">
										<tr class="search-items">
											<td>
												<div class="n-chk align-self-center text-center">
													<div class="form-check">
														<input type="checkbox" class="form-check-input contact-chkbox primary" id="checkbox1">
														<label class="form-check-label" for="checkbox1"></label>
													</div>
												</div>
											</td>
											<td>
												<div class="d-flex align-items-center">
													<div class="ms-3">
														<div class="user-meta-info">
															<span class="user-work fs-3" > 
															<c:choose>
																	<c:when test="${reservVO.mtgRoomNm =='세미나룸'}">
															        <img src="/resources/timeline/images/room1.jpg" alt="avatar" class="rounded-rectangular" width="35" height="35">
															        </c:when>
																	<c:when test="${reservVO.mtgRoomNm == '프로젝트룸1실'}">
																	<img src="/resources/timeline/images/room2.jpg" alt="avatar" class="rounded-rectangular" width="35" height="35">
															        </c:when>
																	<c:when test="${reservVO.mtgRoomNm == '프로젝트룸2실'}">
																	<img src="/resources/timeline/images/room4.jpg" alt="avatar" class="rounded-rectangular" width="35" height="35">
															        </c:when>
																	<c:when test="${reservVO.mtgRoomNm== '대회의실'}">
																	<img src="/resources/timeline/images/room3.jpg" alt="avatar" class="rounded-rectangular" width="35" height="35">
															        </c:when>
																	<c:when test="${reservVO.mtgRoomNm == '일반회의실'}">
																	<img src="/resources/timeline/images/room5.jpg" alt="avatar" class="rounded-rectangular" width="35" height="35">
															        </c:when>
																	<c:otherwise>
														           		 알수없는 회의실
														        </c:otherwise>
																</c:choose>
															</span>
														</div>
													</div>
													 &nbsp;&nbsp;<span class="usr-email-addr"> ${reservVO.mtgRoomNm}</span>
												</div>
											</td>
											<td>
												<span class="usr-email-addr">${reservVO.resveNo }</span>
											</td>
											<td>
												<span class="usr-location"> <fmt:formatDate value="${reservVO.resveBeginDt}" pattern="yyyy/MM/dd HH:mm" /> ~ <fmt:formatDate value="${reservVO.resveEndDt}" pattern="yyyy/MM/dd HH:mm" /></span>
											</td>
											<td>
												<span class="usr-ph-no">${reservVO.resveCn }</span>
											</td>
											<td>
												<div class="action-btn">
													<a href="/myReservation/detail?resveNo=${reservVO.resveNo }" class="text-primary edit">
														<span class="badge rounded-pill bg-primary-subtle text-primary fw-semibold fs-2">상세보기</span>
													</a>

												</div>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<nav style="margin-top: 20px;" aria-label="Page navigation example" id="pagingArea">${pagingVO.pagingHTML}</nav>
			</div>
	</div>


<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script type="text/javascript">
// 페이징 처리
$(function() {
	var ReservListId = $("#ReservListId");
	var pagingArea = $("#pagingArea");

	pagingArea.on("click", "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		ReservListId.find("#page").val(pageNo);
		ReservListId.submit();
	});
});

$(function () {
    function checkall(clickchk, relChkbox) {
      var checker = $("#" + clickchk);
      var multichk = $("." + relChkbox);
  
      checker.click(function () {
        multichk.prop("checked", $(this).prop("checked"));
        $(".show-btn").toggle();
      });
    }
  
    checkall("contact-check-all", "contact-chkbox");
  
    $("#input-search").on("keyup", function () {
      var rex = new RegExp($(this).val(), "i");
      $(".search-table .search-items:not(.header-item)").hide();
      $(".search-table .search-items:not(.header-item)")
        .filter(function () {
          return rex.test($(this).text());
        })
        .show();
    });

  
    $(".delete-multiple").on("click", function () {
      var inboxCheckboxParents = $(".contact-chkbox:checked").parents(
        ".search-items"
      );
      inboxCheckboxParents.remove();
    });
  
    deleteContact();
    addContact();
    editContact();
  });
  

  
</script>
