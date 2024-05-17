<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
   .nav-link .d-none.d-md-block {
        font-size: 16px; /* Adjust the font size as needed */
}
        .card { border-radius: 15px; }
        .side-stick { width: 5px; height: 100%; background-color: #007bff; } /* 색상 코드 변경 가능 */
    </style>


<div class="widget-content searchable-container list">
 
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
				<div class="col-md-4 text-center">
					<div class="d-flex flex-column align-items-start">
						<a href="/myReservation/roomList" class="mb-2">
							<p style="margin: 0"><h5>예약목록</h5></p>
						</a> <a href="/myReservation/rentalList">
							<p style="margin: 0"><h5>대여목록</h5></p>
						</a>
					</div>
				</div>
				<!-- 검색 폼 및 버튼  -->
				<div class="col-md-8 col-xl-8 text-end d-flex justify-content-end align-items-center">
					<form action="" method="post" id="ReservListId" class="d-flex align-items-center">
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
		<!-- 목록시작 -->
        <div class="card-body">
                  <div>
                    <!-- Nav tabs -->
                 	 <ul class="nav nav-pills" role="tablist">
					  <li class="nav-item" role="presentation">
					    <a href="/myReservation/rentalList" class="nav-link" role="tab">
					  신청대기목록
					</a>
					  </li>
					    <li class="nav-item" role="presentation">
					    <a href="/myReservation/returnPending" class="nav-link" role="tab">
					  반납대기목록
					</a>
					  </li>
					  <li class="nav-item" role="presentation">
					    <a href="myReservation/returnSuccess" class="nav-link " role="tab">
					      반납완료목록
					    </a>
					  </li>
					</ul>
                    <!-- Tab panes -->
                    <div class="tab-content border mt-2">
                      <div class="tab-pane active p-3" id="navpill-1" role="tabpanel">
                        <div class="row">
                          <div class="col-md-4">
                            <img src="../assets/images/blog/blog-img1.jpg" alt="" class="img-fluid">
                          </div>
                          <div class="col-md-8">
                           <!-- 승인완료목록 -->
                           
                          </div>
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
								
								<th>대여신청번호</th>
								<th>시설명</th>
								<th>대여수량</th>
								<th>대여내용</th>
								<th>대여시설번호</th>
								<th>대여신청시간</th>
								<th>반납날짜</th>
							</tr>
						</thead>
						<tbody>
						<!--startRow  -->
							<c:set value="${pagingVO.dataList }" var="rentalList" />
							<c:choose>
								<c:when test="${empty rentalList }">
									<tr>
										<td colspan="5">조회하신 예약내역이 존재하지 않습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${rentalList }" var="rentalVO">
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
												<span class="usr-email-addr">${rentalVO.erntNo }</span>
											</td>
											<td>
														<div class="user-meta-info">
															<span class="user-work fs-3" > 
																${rentalVO.itemNm }
															</span>
														</div>
											</td>
											<td>
											 <c:choose>
										    <c:when test="${rentalVO.eqpnmCd eq '6' || rentalVO.eqpnmCd eq '7' || rentalVO.eqpnmCd eq '8' || rentalVO.eqpnmCd eq '9' || rentalVO.eqpnmCd eq '10'}">
										        <span class="usr-email-addr">1</span>
										    </c:when>
										    <c:when test="${rentalVO.eqpnmCd eq '11' || rentalVO.eqpnmCd eq '12' || rentalVO.eqpnmCd eq '13' || rentalVO.eqpnmCd eq '14' || rentalVO.eqpnmCd eq '15'}">
										        <span class="usr-email-addr">${rentalVO.erntQy}</span>
										    </c:when>
										    <c:otherwise>
										        null
										    </c:otherwise>
											</c:choose>

											</td>
											<td>
												<span class="usr-ph-no">${rentalVO.erntResn }</span>
											</td>
											<td>
												<span class="usr-email-addr">${rentalVO.eqpnmCd }</span>
											</td>
											<td>
												<span class="usr-location"> <fmt:formatDate value="${rentalVO.erntBeginDt}" 
 												pattern="yyyy/MM/dd HH:mm" /> ~ <fmt:formatDate value="${rentalVO.erntEndDt}" pattern="yyyy/MM/dd HH:mm" /></span> 
											</td>
											
											<td>
<%-- 											<c:choose> --%>
<%-- 												<c:when test="${rentalVO.prmisnYn eq 'Y'}"> --%>
<!-- 										          <span class="usr-email-addr">승인</span> -->
<%-- 										        </c:when> --%>
<%-- 										        <c:when test="${rentalVO.prmisnYn eq 'N'}"> --%>
<!-- 										          <span class="usr-email-addr">반려</span> -->
<%-- 										        </c:when> --%>
<%-- 										        <c:otherwise>승인대기</c:otherwise> --%>
<%-- 										        </c:choose> --%>

												 <c:if test="${rentalVO.erntRturnDt != null}">
														      <fmt:formatDate value="${rentalVO.erntRturnDt}" pattern="yyyy/MM/dd HH:mm:ss" />
											    </c:if>

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
                      <div class="tab-pane p-3" id="navpill-2" role="tabpanel">
                        <div class="row">
                          <div class="col-md-8">
                            <!--반납대기목록  -->
                          </div>
                          <div class="col-md-4">
                            <img src="../assets/images/blog/blog-img2.jpg" alt="" class="img-fluid">
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane p-3" id="navpill-3" role="tabpanel">
                        <div class="row">
                          <div class="col-md-4">
                            <img src="../assets/images/blog/blog-img3.jpg" alt="" class="img-fluid">
                          </div>
                          <div class="col-md-8">
                           <!-- 반려완료목록 -->
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
	</div>

</div>


<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
// 페이징 처리
 function fnSelectProject() {
            console.log('프로젝트 선택 로직 구현');
        }
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

// $(function () {
//     function checkall(clickchk, relChkbox) {
//       var checker = $("#" + clickchk);
//       var multichk = $("." + relChkbox);
  
//       checker.click(function () {
//         multichk.prop("checked", $(this).prop("checked"));
//         $(".show-btn").toggle();
//       });
//     }
  
//     checkall("contact-check-all", "contact-chkbox");
  
//     $("#input-search").on("keyup", function () {
//       var rex = new RegExp($(this).val(), "i");
//       $(".search-table .search-items:not(.header-item)").hide();
//       $(".search-table .search-items:not(.header-item)")
//         .filter(function () {
//           return rex.test($(this).text());
//         })
//         .show();
//     });

  
//     $(".delete-multiple").on("click", function () {
//       var inboxCheckboxParents = $(".contact-chkbox:checked").parents(
//         ".search-items"
//       );
//       inboxCheckboxParents.remove();
//     });
  
//     deleteContact();
//     addContact();
//     editContact();
//   });

 function returnRental(erntNo) {
    var eventData = {
        erntNo: erntNo,
    };
	
    $.ajax({
        url: '/myReservation/returnRental',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(eventData),
        beforeSend: function(xhr) {
        	 xhr.setRequestHeader(header, token);  
        },
        success: function(response) {
            alert('대여 신청이 반납되었습니다..');
            location.reload(); 
        },
        error: function(xhr) {
            alert('Error updating approval status: ' + xhr.responseText);
        }
    });
}


</script>
