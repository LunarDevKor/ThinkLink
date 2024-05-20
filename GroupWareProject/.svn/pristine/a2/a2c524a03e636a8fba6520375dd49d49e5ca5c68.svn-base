<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/dataTables.bootstrap5.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.min.css">
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

body div.dt-buttons>.dt-button, body div.dt-buttons>div.dt-button-split .dt-button
	{
	background: #fff !important;
	border-radius: 0;
	background-color: #fff !important;
	border: 1px solid #ddd !important;
	color: black !important;
	margin-left: 10px !important;
}

body div.dt-buttons>.dt-button:hover, body div.dt-buttons>div.dt-button-split .dt-button:hover
	{
	background: #fff !important;
	border-radius: 0;
	background-color: #fff !important;
	border: 1px solid #ddd !important;
	color: black !important;
}
color
:
black
!important;
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
<c:choose>
	<c:when test="${type == 'viewer' }">
		<c:set var="title" value="참조 대기 문서" />
	</c:when>
	<c:when test="${type == 'upcoming' }">
		<c:set var="title" value="결재 예정 문서" />
	</c:when>
	<c:otherwise>
		<c:set var="title" value="결재 대기 문서" />
	</c:otherwise>
</c:choose>

<div class="card rounded-0 flex-fill m-0" style="min-height: 800px;">
	<div class="card-body p-0">
		<div class="m-3 ms-4">
			<h3 class="m-0">${title }</h3>
		</div>
		<c:if test="${type ne 'upcoming' and type ne 'viewer' }">
			<ul class="nav nav-underline ms-4 border-bottom" id="tab">
				<li class="nav-item"><a class="nav-link <c:if test='${type == "all"}'>active</c:if>" href="#" id="all">
						<span>전체</span>
					</a></li>
				<li class="nav-item"><a class="nav-link <c:if test='${type == "wait"}'>active</c:if>" href="#" id="wait">
						<span>대기</span>
					</a></li>
				<li class="nav-item"><a class="nav-link <c:if test='${type == "hold"}'>active</c:if>" href="#" id="hold">
						<span>보류</span>
					</a></li>
			</ul>
		</c:if>
		<table class="table table-borderless w-100" id="tbl">
			<thead class="border-bottom text-start table-hover">
				<tr>
					<th>
						<input type="checkbox" class="form-check-input" id="selectAll">
					</th>
					<th>
						<span>기안일</span>
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
						<span>기안자</span>
					</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:if test="${empty approvalList }">
					<tr>
						<td colspan="7">
							<p class="p-3 text-center">결재할 문서가 없습니다.</p>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty approvalList }">
					<c:forEach items="${approvalList }" var="approval">
						<tr>
							<td>
								<input class="form-check-input" type="checkbox" name="select" value="${approval.aprovlNo }">
							</td>
							<td>${approval.submitDt }</td>
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
								<a href="/approval/document/${approval.aprovlNo }"> ${approval.aprovlNm } </a>
							</td>
							<td>
								<c:if test="${approval.atchFileGroupNo != null }">
									<div>
										<i class="fa-sharp fa-regular fa-paperclip fa-fw"></i>
										<span>${approval.fileCount }</span>
									</div>
								</c:if>
							</td>
							<td>${approval.emplNm }</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<div id="all-confrim-modal" class="interactive-modal" style="z-index: 100;">
	<div class="interactive-modal-content" style="width: 400px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold" data-title="">
				정말로 <font style="color: #5A6A85;">일괄 결재</font> 하시겠습니까?
			</h5>
			<a href="#" class="position-absolute fa-active" data-exit="allconfirm">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="card-body rounded-0 p-0">
			<div class="input-group justify-content-center align-items-center">
				<textarea rows="5" cols="15" class="form-control rounded-0" placeholder="의견을 작성해 주세요." style="resize: none;" id="allConfirmMemo"></textarea>
			</div>
		</div>
		<div class="text-end p-0 pt-3">
			<button class="btn btn-sm rounded-0 btn-primary" id="allConfirmBtn">확인</button>
			<button class="btn btn-sm rounded-0" style="border: 1px solid #ddd;" id="allConfirmCancelBtn">취소</button>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/dataTables.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/dataTables.bootstrap5.js"></script>
<script src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.min.js"></script>
<script>
let tab = $('#tab');
let text = $('#tbody').text();
$(function() {
	let allConfirmModal = $('#all-confrim-modal');
	let allconfirm = $('#allconfirm');
	let allConfirmBtn = $('#allConfirmBtn');
	let allConfirmCancelBtn = $('#allConfirmCancelBtn');
	
	function toggleAllConfirmModal() {
		allConfirmModal.toggleClass('show');
	}
	
	$('[data-exit]').on('click', function() {
		let data = $(this).data('exit');
		if(data == 'allconfirm') {
			toggleAllConfirmModal();
		}
	})
	
	allConfirmCancelBtn.on('click', function() {
		allConfirmModal.toggleClass('show');
	})
	
	$(document).on('click', function(e) {
		if($(e.target).is(allConfirmModal)) {
			toggleAllConfirmModal();
		}
	})
	
	allConfirmBtn.on('click', function() {
		let checkedEl = $('input[name="select"]:checked');
		if(checkedEl.length == 0) {
			showToast('선택된 항목이 없습니다!', 'warning');
			return;
		}
		
		for (var i = 0; i < checkedEl.length; i++) {
			let aprovlNo = checkedEl[i].value;
			let emplNo = connectionTest();
			
			let obj = {
				aprovlNo : aprovlNo,
				approverNo : emplNo,
				sanctnerSttusCode : 'G303',
				sanctnerMemo : $('#allConfirmMemo').val()
			}
			
			
			$.ajax({
				url: '/approval/confirm',
				type: 'post',
				contentType: 'application/json; charset=UTF-8',
				data: JSON.stringify(obj)
			})
			.done(function(res) {
				if(i == checkedEl.length) {
					$('#allConfirmMemo').val('');
					toggleAllConfirmModal();
					
					showAlert(checkedEl.length + '개의 결재가 완료되었습니다!', '', 'success')
					.then(result => {
						if(result.isConfirmed) {
							window.location.reload();
						}
					})
				}
			})
		}
	})
	
	
	if(!text.includes('없습니다')) {
			$(document).on('preInit.dt', function(e, settings) {
				$('.form-control').removeClass('form-control-sm');
				$('#dt-length-0').removeClass('form-select-sm');
				$('#dt-length-0').addClass('rounded-0');
				
				let href = location.href.substring(location.href.lastIndexOf('/')+1, location.href.length).replace('#','');
				let arr = ['all','wait','hold'];
				let flag = arr.includes(href);
				
				if(!flag) {
					$('.dt-buttons').addClass('d-none');
				}
			})
			let table = new DataTable('#tbl', {
			buttons: [
				{
					text: '<i class="fa-sharp fa-regular fa-list-check fa-fw fa-xl"></i><font class="ms-2">일괄결재</font>',
					action: function() {
						 
						toggleAllConfirmModal();
					}
				}
			],
			header: false,		// 헤더 중복 방지
			autoFill: true,		// 자동 완성 활성화
	        paging: true,        // 페이징 기능 활성화
	        pagingType: 'simple_numbers', // 페이지 타입 번호 + 이전/다음 
	        searching: true,     // 검색 기능 활성화
	        ordering: true,      // 정렬 기능 활성화
	        info: false,           // 정보 표시 기능 활성화 (페이지 정보)
	        responsive: false,	// 반응형 활성화
	        stateSave: true,	// 저장 활성화
	        dom: "<'row d-flex justify-content-end align-items-center my-2'<'col-md-6'B><'col-md-5'f><'col-md-1'l>>"+ // f 검색 l 페이지 사이즈 
	        "t<'bottom d-flex justify-content-center align-items-center mt-5 me-2'p>", // p 페이지네이션
	        order: [
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
	        	{ width : "45%", targets : 4},
	        	{ width : "10%", targets : 5},
	        	{ width : "10%", targets : 6},
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

const linkTable = {
	allLink : 'all',
	waitLink : 'wait',
	
}
tab.on('click', 'a', function(e) {
	e.preventDefault();
	let links = ['all', 'wait', 'hold'];
	let id = $(this).attr('id');
	let href = '/approval/list/';
	
	let link = links.find(link => link == id);
	
	if(link) {
		href += link;
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