<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-pagination.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-grid.min.css">
<style>
	span.title {
		padding-left: 0px;
		margin-bottom: 16px;
		font-weight: 600;
		font-size: 18px;
	}
	
	#tbl thead tr {
		border: 1px solid #ddd;
		border-left: none;
		border-right: none;
	}
</style>

<div class="container positon-relative pt-4">
	<div class="px-9 pt-4 pb-3">
		<a href="/admin/approval">
			<h3 class="fw-semibold mb-4">
				<i class="fa-sharp fa-regular fa-file-signature fa-fw fa"></i>
				결재관리
			</h3>
		</a>
	</div>
	<div class="p-5 text-center bg-white rounded-3 w-100">
		<div class="w-100">
			<span class="float-start title">검색</span>
		</div>
		<div class="mt-5">
			<form action="/admin/approval/search" method="post" id="frm">
				<table class="table table-borderless text-start align-middle">
					<tr>
						<td>검색 기간</td>
						<td class="input-group">
							<input type="date" class="form-control" id="submitDt">
							<input type="date" class="form-control" id="closDt">
						</td>
					</tr>
					<tr>
						<td>결재 양식</td>
						<td>
							<select class="form-select" id="docSelect">
								<option>---양식을 선택해주세요---</option>
								<c:forEach var="documents" items="${documentsList }">
									<option value="${documents.docNo }">${documents.docNm }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>기안자</td>
						<td><input type="text" class="form-control" id="emplNm" /></td>
					</tr>
					<tr>
						<td>기안부서</td>
						<td><input type="text" class="form-control" id="deptNm" /></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" class="form-control" id="aprovlNm"/></td>
					</tr>
					<tr>
						<td>진행상태</td>
						<td class="text-start">
							<input type="checkbox" class="form-check-input checkAll" id="allCheckInput" />
							<label for="allCheckInput" class="me-3">전체</label>
							<input type="checkbox" class="form-check-input check" id="inprogress" value="G102" />
							<label for="allCheckInput" class="me-3">진행중</label>
							<input type="checkbox" class="form-check-input check" id="complete" value="G103" />
							<label for="allCheckInput" class="me-3">완료</label>
							<input type="checkbox" class="form-check-input check" id="return" value="G104"/>
							<label for="allCheckInput">반려</label>
						</td>
					</tr>
				</table>
				<sec:csrfInput/>
			</form>
		</div>
		<hr class="border border-2"/>
		
		<button type="button" class="btn btn-dark rounded-0" id="searchBtn">검색</button>
	</div>
</div>
<div class="container positon-relative mt-4">
	<div class="card bg-white">
		<div class="card-body p-5 text-center">
			<div class="w-100">
				<span class="float-start title">결재 문서</span>
			</div>
			<div id="grid">
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-grid.min.js"></script>
<script>
let tbody = $('#tbody');
let searchBtn = $('#searchBtn');

let data = JSON.parse('${approvalList}');
gridInit(data);

searchBtn.on('click', function() {
	let submitDt = $('#submitDt').val();
	let closDt = $('#closDt').val();
	let docNm = $('#docSelect').val().startsWith('---') ? '' : $('#docSelect').val();
	let emplNm = $('#emplNm').val();
	let deptNm = $('#deptNm').val();
	let aprovlNm = $('#aprovlNm').val();
	
	let checkedArr = $('.check:checked');
	let aprovlSttusCode = [];
	
	for(let i = 0; i < checkedArr.length; i++) {
		aprovlSttusCode.push(checkedArr[i].value);
	}
	
	let obj = {
		submitDt : submitDt,
		closDt : closDt,
		docNm : docNm,
		emplNm : emplNm,
		deptNm : deptNm,
		aprovlNm : aprovlNm,
		aprovlSttusCode : aprovlSttusCode
	}
	
	$.ajax({
		url: '/admin/approval/search',
		type: 'post',
		contentType: 'application/json; charset=UTF-8',
		data: JSON.stringify(obj)
	})
	.done(function(res) {
		gridInit(res)
	});
});


function gridInit(data) {
	$('#grid').html('');
	
	tui.Grid.applyTheme('clean', {
		cell: {
		   normal: {
		     border: '#fff',
		     showVerticalBorder: false,
		     showHorizontalBorder: false,
		   },
		   header: {
		     border: '#ddd',
		     showVerticalBorder: false,
		     showHorizontalBorder: false,
		   },
		   rowHeader: {
				border: '#fff',
			     showVerticalBorder: false,
			     showHorizontalBorder: false,
		   }
		},
	});
	tui.Grid.setLanguage('ko', {
		display: {
            noData: '검색 결과가 존재하지 않습니다.',
            loadingData: '로딩중입니다...',
		}
	});
	
	grid = new tui.Grid({
	    el: document.getElementById('grid'),
	    data: data,
	    scrollX: false,
	    scrollY: false,
	    header: {
	        height: 30, 
	    },
	    columns: 
	    [
	      {
	        header: '기안일',
	        name: 'submitDtToString',
	        width: '150',
	        resizable: true,
	      },
	      {
	        header: '결재일',
	        width: '150',
	        name: 'closDtToString',
	        resizable: true,
	      },
	      {
	        header: '결재양식',
	        width: '100',
	        name: 'docNm',
	        resizable: true,
	      },
	      {
	        header: '기안자',
	        width: '60',
	        name: 'emplNm',
	        resizable: true,
	      },
	      {
	        header: '제목',
	        width: '550',
	        name: 'aprovlNm',
	        resizable: true,
	        formatter: function({value}) {
	        	let aprovlNm = value.split('*_*')[0];
	        	let aprovlNo = value.split('*_*')[1];
	        	
	        	let url = '/approval/document/'+aprovlNo;
	        	
	        	return '<a href="'+url+'"><span class="fw-semibold">'+aprovlNm+'</span></a>';
	        }
	      },
	      {
	        header: '결재상태',
	        width: '60',
	        name: 'aprovlSttusNm',
	        resizable: true,
	      },
	      {
	        header: '문서번호',
	        width: '100',
	        name: 'docCodeNo',
	        resizable: true,
	      }
	    ],
	    pageOptions: {
	      useClient: true,
	      perPage: 5,
	      visiblePages: 5,
	      centerAlign: true
	    },
	    bodyHeight: 'fitToParent',
	    rowHeight: 30
	});
}
</script>