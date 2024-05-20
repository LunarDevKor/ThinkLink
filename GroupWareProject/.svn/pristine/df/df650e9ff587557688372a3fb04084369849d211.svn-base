<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>

.bg-danger {
    background-color: #ff6b6b;
}
.text-light {
    color: #ffffff !important;
}
.dt-buttons {
     margin-top: 20px; /* Adjust the value as needed for more or less space */
     display: inline-block; /* Makes the div only as wide as its content */
 }  
 #bulkApproveBtn {
    margin-right: 10px; /* Adds space between the approve and reject buttons */
}

.btn-warning {
    background-color: #f0ad4e; /* Bootstrap's default orange */
    border-color: #eea236;
}

.btn-warning:hover {
    background-color: #ec971f;
    border-color: #d58512;
}  

</style>
<div class="widget-content searchable-container list">
<div class="container-fluid">

	<div class="datatables">
		<!-- File export -->
		<div class="row">
			<div class="col-12">
				<!-- start File export -->
				<div class="card">
					<div class="card-body">
							<div class="px-9 pt-4 pb-3">
								<a href="/admin/rental/returnList">
									<h3 class="fw-semibold mb-4">
										<i class="fa-sharp fa-regular fa-car-side fa-fw fa"></i> 반납조회목록
									</h3>
								</a>
							</div>
						<div class="table-responsive">
								<!--대여신청 목록 검색  -->
								<div id="file_export_filter" class="dataTables_filter">
								     <style>
								        #file_export_filter {
								            display: flex;
								            justify-content: flex-end; /* Aligns children to the right */
								        }
								        #ReservListId > div {
								            display: flex;
								            align-items: center; /* Vertically centers the input and button if needed */
								        }
								        #ReservListId input[type="search"] {
								            margin-right: 10px; /* Adds spacing between the input and the button */
								        }
								    </style>
									<form action="" method="post"  id="ReservListId">
										<div>
											<input type="search" name="searchWord" value="${searchWord }" id="searchForm"  class="form-control rounded-0" placeholder="검색어를 입력해주세요" aria-controls="file_export">
											<button type="submit" class="btn btn-primary rounded-0 w-50">
												<i class="fas fa-search"></i>검색
											</button>
										</div>
										<input type="hidden" name="page" id="page" />
										<sec:csrfInput />
									</form>
								</div>
								<hr>
								<!--전체선택  -->
<!-- 								<div> -->
<!-- 									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="selectAll" title="Select All"/>	 -->
<!-- 									&nbsp;&nbsp;&nbsp;<button id="bulkApproveBtn" class="btn btn-success">EXEL</button> -->
<!-- 								</div> -->
							
								<table id="file_export" class="table border w-100 table-striped table-bordered display text-nowrap dataTable" aria-describedby="file_export_info">
									<thead>
										<!-- start row -->
									<tr>
							    <th class="sorting sorting_asc" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 163.854px;">대여 신청번호</th>
									    
									    <th class="sorting" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 150px;">시설명</th>
									    <th class="sorting" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="width: 150px;">신청자</th>
									     <th class="sorting" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="width: 150px;">대여 수량</th>
									    <th class="sorting" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 100px;">대여 신청시간</th>
									    <th class="sorting" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" style="width: 100px;">대여내용</th>
										<th class="sorting" tabindex="0" aria-controls="file_export" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" style="width: 100px;">반납일시</th>
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
													<tr class="odd">
													
														<td> ${rentalVO.erntNo }</td>
														<td class="sorting_1"> ${rentalVO.itemNm }</td>
														<td>${rentalVO.emplNm }</td>
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
														<td>
															<span class="usr-location"> <fmt:formatDate value="${rentalVO.erntBeginDt}" pattern="yyyy/MM/dd HH:mm" /> ~ <fmt:formatDate value="${rentalVO.erntEndDt}" pattern="yyyy/MM/dd HH:mm" />
															</span>
														</td>
														<td>${rentalVO.erntResn }</td>
														<td>
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
								<div class="dataTables_info" id="file_export_info" role="status" aria-live="polite"></div>
								<br>
								<nav style="margin-top: 20px;" aria-label="Page navigation example" id="pagingArea">${pagingVO.pagingHTML}</nav>

						</div>
					</div>
				</div>
				<!-- end File export -->
			</div>
		</div>
	</div>
</div>	
</div>
<script type="text/javascript">

//페이징 처리
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

$(document).ready(function() {
    $('#selectAll').click(function(event) {
        $('.itemCheckbox').prop('checked', this.checked);
    });
	
    $('#bulkApproveBtn').click(function() {
        var selectedIds = $('.itemCheckbox:checked').map(function() {
            return $(this).val();
        }).get();
	    
        if (selectedIds.length > 0) {
            $.ajax({
                url: '/admin/rental/bulkApprove',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({erntNos: selectedIds}),
                success: function(response) {
                    alert('선택한 리스트의 대여신청이 승인되었습니다');
                    location.reload();
                },
                error: function(xhr) {
                    alert('Error: ' + xhr.statusText);
                }
            });
        } else {
            alert('선택된 리스트가 없습니다.');
        }
    });

    
});


</script>