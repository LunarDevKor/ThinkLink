<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/dataTables.bootstrap5.css">
<style>
th>span {
	font-weight: 600;
}

.nav-link.active {
	color: #5A6A85 !important;
}

.page-link {
	border-radius: 0 !important;
}

#dt-search-0 {
	border-radius: 0 !important;
}

thead th {
	border-bottom: 0 !important;
}

#tbody tr td {
	padding: 10px 18px;
}

.dt-column-title span {
	font-weight: 600;
}

/* 일반 페이지 버튼 스타일 */
.dt-paging-button.page-item a.page-link {
  color: #333;
  background-color: #fff;
  border-color: #ddd;
  border-radius: 0;
}

/* 현재 페이지 버튼 스타일 */
.dt-paging-button.page-item.active a.page-link {
  color: #fff;
  background-color: #007bff;
  border-color: #007bff;
  border-radius: 0;
}

/* 비활성화된 버튼 스타일 */
.dt-paging-button.page-item.disabled a.page-link {
  color: #6c757d;
  pointer-events: none;
  background-color: #fff;
  border-color: #ddd;
  border-radius: 0;
}
</style>

<div class="card rounded-0 flex-fill m-0" style="min-height: 800px;">
	<div class="card-body p-0">
		<div class="m-3 ms-4">
			<h3 class="m-0">
				<c:choose>
					<c:when test="${type eq 'all' or type eq 'inprogress' or type eq 'complete' or type eq 'return'}">
						<h5>기안 문서함</h5>
					</c:when>
					<c:when test="${type eq 'temp' }">
						<h5>임시 저장함</h5>
					</c:when>
					<c:when test="${type eq 'approve' }">
						<h5>결재 문서함</h5>
					</c:when>
					<c:when test="${type eq 'viewer' }">
						<h5>참조 문서함</h5>
					</c:when>
				</c:choose>
			</h3>
		</div>
		<c:if test="${type ne 'temp' and type ne 'viewer'}">
			<ul class="nav nav-underline ms-4 border-bottom" id="draftTab">
				<li class="nav-item">
					<a class="nav-link <c:if test='${type == "all"}'>active</c:if>" href="#" id="allLink">
						<span>전체</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <c:if test='${type == "inprogress"}'>active</c:if>" href="#" id="inprogressLink">
						<span>진행</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <c:if test='${type == "complete"}'>active</c:if>" href="#" id="completeLink">
						<span>완료</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <c:if test='${type == "return"}'>active</c:if>" href="#" id="returnLink">
						<span>반려</span>
					</a>
				</li>
			</ul>
		</c:if>
		<table class="table table-borderless w-100 table-hover" id="tbl">
			<thead class="text-start align-middle">
				<tr>
					<th>
						<input type="checkbox" class="form-check-input" id="selectAll">
					</th>
					<th>
						<span>기안일</span>
					</th>
					<th>
						<span>완료일</span>
					</th>
					<th>
						<span>결재양식</span>
					</th>
					<th>
						<span>긴급</span>
					</th>
					<th>
						<span>제목</span>
					</th>
					<th>
						<span>첨부</span>
					</th>
					<th>
						<span>결재상태</span>
					</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:if test="${empty approvalList}">
					<c:set var="msg" value="상신한 문서가 존재하지 않습니다." />
					<c:choose>
						<c:when test="${type eq 'inprogress'}">
							<c:set var="msg" value="진행중인 문서가 존재하지 않습니다." />
						</c:when>
						<c:when test="${type eq 'complete'}">
							<c:set var="msg" value="결재 완료한 문서가 존재하지 않습니다." />
						</c:when>
						<c:when test="${type eq 'return'}">
							<c:set var="msg" value="반려된 문서가 존재하지 않습니다." />
						</c:when>
						<c:when test="${type eq 'viewer'}">
							<c:set var="msg" value="참조할 문서가 존재하지 않습니다." />
						</c:when>
						<c:when test="${type eq 'temp'}">
							<c:set var="msg" value="임시저장 된 문서가 존재하지 않습니다." />
						</c:when>
						<c:when test="${type eq 'approve'}">
							<c:set var="msg" value="결재한 문서가 존재하지 않습니다." />
						</c:when>
					</c:choose>
					<tr>
						<td colspan="7">
							<p class="p-3 text-center">${msg }</p>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty approvalList }">
					<c:forEach items="${approvalList }" var="approval">
						<tr>
							<td>
								<input class="form-check-input" type="checkbox" name="select">
							</td>
							<td>${approval.submitDt }</td>
							<td>${approval.closDt }</td>
							<td>${approval.docNm }</td>
							<td>
								<c:choose>
									<c:when test="${approval.emrgncyYn == 'Y'}">
										<i class="fa-solid fa-light-emergency-on fa-fade fa-xl" style="color: #ff0000;"></i>
									</c:when>
									<c:otherwise>
										<i class="fa-solid fa-light-emergency-on fa-light fa-xl" style="color: #999999;"></i>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:if test="${type eq 'temp'}">
									<a href="/approval/form?docNo=${approval.docNo }&aprovlNo=${approval.aprovlNo }"> ${approval.aprovlNm } </a>
								</c:if>
								<c:if test="${type ne 'temp' }">
									<a href="/approval/document/${approval.aprovlNo }"> ${approval.aprovlNm } </a>
								</c:if>
							</td>
							<td>
								<c:if test="${approval.atchFileGroupNo != null }">
									<div>
										<i class="fa-sharp fa-regular fa-paperclip fa-fw"></i> <span>${approval.fileCount }</span>
									</div>
								</c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${approval.aprovlSttusCode eq 'G101' }">
										<c:set var="state" value="approval-temp" />
									</c:when>
									<c:when test="${approval.aprovlSttusCode eq 'G102' }">
										<c:set var="state" value="approval-ongoing" />
									</c:when>
									<c:when test="${approval.aprovlSttusCode eq 'G103' }">
										<c:set var="state" value="approval-finish" />
									</c:when>
									<c:when test="${approval.aprovlSttusCode eq 'G104' }">
										<c:set var="state" value="approval-return" />
									</c:when>
								</c:choose>
								<span class="badge ${state }"> ${approval.aprovlSttusNm } </span>
							</td>
						</tr>
					</c:forEach>
				</c:if>

			</tbody>
		</table>
	</div>
</div>
<script src="${pageContext.request.contextPath }/resources/project/js/source/dataTables.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/dataTables.bootstrap5.js"></script>
<script>
$(function() {
	let text = $('#tbody').text();
	if(!text.includes('존재하지')) {
		$(document).on('preInit.dt', function(e, settings) {
			$('.form-control').removeClass('form-control-sm');
			$('#dt-length-0').removeClass('form-select-sm');
			$('#dt-length-0').addClass('rounded-0');
		})
		let table = new DataTable('#tbl', {
			header: false,		// 헤더 중복 방지
			autoFill: true,		// 자동 완성 활성화
	        paging: true,        // 페이징 기능 활성화
	        pagingType: 'simple_numbers', // 페이지 타입 번호 + 이전/다음 
	        searching: true,     // 검색 기능 활성화
	        ordering: true,      // 정렬 기능 활성화
	        info: false,           // 정보 표시 기능 활성화 (페이지 정보)
	        responsive: true,	// 반응형 활성화
	        stateSave: true,	// 저장 활성화
	        dom: "<'row d-flex justify-content-end align-items-center my-2'<'col-md-5'f><'col-md-1 me-2'l>>"+ // f 검색 l 페이지 사이즈 
	        "t<'bottom d-flex justify-content-center align-items-center mt-5 me-2'p>", // p 페이지네이션
	        order: [
	        	[1, 'desc'],
	        	[3, 'asc'] // 3번째 컬럼 ASC
	        ],
	        columnDefs: [
	        	{
	        		targets: -1,
	        		className: 'order-column'
	        	},
	        	{ width : "5%", orderable : false, targets : 0},
	        	{ width : "10%", targets : 1},
	        	{ width : "10%", targets : 2},
	        	{ width : "10%", targets : 3},
	        	{ width : "10%", targets : 4},
	        	{ width : "35%", targets : 5},
	        	{ width : "10%", targets : 6},
	        	{ width : "10%", targets : 7},
	        ],
	        language: {
	            "lengthMenu": "_MENU_", // 한 페이지에 보여질 항목 수 변경
	            "info": "", // 표시되는 항목 수와 범위 변경
	            "infoEmpty": "", // 검색 결과가 없을 때 표시될 텍스트 변경
	            "infoFiltered": "", // 검색 결과가 있는 경우 표시될 텍스트 변경
	            "zeroRecords": function() {
	                return '<div class="text-center fw-semibold">검색결과가 없습니다.</div>';
	            },
	            "search": "", // 검색 입력란 라벨
	            "searchPlaceholder": "검색어를 입력하세요...", // 검색 입력란 라벨
	            "loadingRecords": "로딩중...", // 로딩중 텍스트
	            "paginate": {
	                "first": '<i class="fa-sharp fa-regular fa-angles-left fa-fw"></i>', // 첫 페이지 버튼의 텍스트를 변경
	                "last": '<i class="fa-sharp fa-regular fa-angles-right fa-fw"></i>', // 마지막 페이지 버튼의 텍스트 변경
	                "next": '<i class="fa-sharp fa-regular fa-angle-right fa-fw"></i>', // 다음 페이지 버튼의 텍스트를 변경
	                "previous": '<i class="fa-sharp fa-regular fa-angle-left fa-fw"></i>' // 이전 페이지 버튼의 텍스트를 변경
	            }
	        }
		})
	}
});

let draftTab = $('#draftTab');
draftTab.on('click', 'a', function(e) {
	e.preventDefault();
	let links = ['allLink', 'inprogressLink', 'completeLink', 'returnLink'];
	let id = $(this).attr('id');
	let href = '/approval/doclist/draft/';
	
	let isLink = links.find(link => link == id);
	
	const lookUpTable = {
		allLink : 'all',
		inprogressLink : 'inprogress',
		completeLink : 'complete',
		returnLink : 'return'
	}

	if(isLink) {
		let nowLoc = window.location.pathname;
		if(nowLoc.includes('approve')) {
			href += 'approve?subType='
		}
		
		href += lookUpTable[id];
	}
	
	location.href = href;
});

$('#tbl').on('change', 'input[type="checkbox"]', function() {
	if($(this).attr('id') == 'selectAll') {
		if($(this).is(":checked")) $("input[name=select]").prop("checked", true);
		else $("input[name=select]").prop("checked", false);
	}else{
		if($(this).attr('name') == 'select') {
			var total = $("input[name=select]").length;
			var checked = $("input[name=select]:checked").length;

			if(total != checked) $("#selectAll").prop("checked", false);
			else $("#selectAll").prop("checked", true); 
		} 
	}
});
</script>