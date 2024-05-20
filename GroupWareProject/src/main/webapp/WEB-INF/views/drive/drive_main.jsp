<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.btn-toggle {
	padding: .25rem .5rem;
	font-weight: 600;
	color: var(- -bs-emphasis-color);
	background-color: transparent;
}

.btn-toggle:hover, .btn-toggle:focus {
	color: rgba(var(- -bs-emphasis-color-rgb), .85);
	background-color: var(- -bs-tertiary-bg);
}

.btn-toggle::before {
	width: 1.25em;
	line-height: 0;
	content:
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba(0,0,0,.5)' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e");
	transition: transform .35s ease;
	transform-origin: .5em 50%;
}

.btn-toggle[aria-expanded="true"] {
	color: rgba(var(- -bs-emphasis-color-rgb), .85);
}

.btn-toggle[aria-expanded="true"]::before {
	transform: rotate(90deg);
}

.btn-toggle-nav a {
	padding: .1875rem .5rem;
	margin-top: .125rem;
	margin-left: 1.25rem;
}

.btn-toggle-nav a:hover, .btn-toggle-nav a:focus {
	background-color: var(- -bs-tertiary-bg);
}

.btn:hover {
	border: 1px solid #ddd;
}

.modal-config {
	width: 700px !important;
}

[data-exit] {
	top: 8px;
	right: 8px;
}

.a-menu:hover>span {
	border-bottom: 3px solid #1A66CC;
}

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

#uploadTbl thead th {
	background-color: #EFEFEF;
}

.bt-line {
	border-bottom: 1px solid #ddd;
}

.form-check-input {
	background-color: white;
}

.form-check-input:checked {
	background-color: #5d87ff !important;
	border-color: #5d87ff !important;
}

.btn-gray {
	border: 1px solid #ddd;
}

#imageModal>.interactive-modal-content {
	width: auto !important;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/modal/interactive-modal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-grid.min.css">


<sec:authentication property="principal.employeeVO.AuthList" var="authList" />
<c:set var="isAdmin" value="false" />
<c:forEach var="auth" items="${authList }">
	<c:if test="${auth.authorNm eq 'ROLE_ADMIN' }">
		<c:set var="isAdmin" value="true" />
	</c:if>
</c:forEach>

<script>
	var isAdmin = '${isAdmin}';
</script>

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-shrink-0" style="border-right: 1px solid #ddd; width: 13%" id="sideArea">
			<div class="px-9 pt-4 pb-3">
				<a href="/drive">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-database fa-fw fa"></i>
						드라이브
					</h3>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-id="company">
					<span class="fs-6 ms-5">전사</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-id="department">
					<span class="fs-6 ms-5">부서</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-id="private">
					<span class="fs-6 ms-5">개인</span>
				</a>
			</div>
		</div>
		<div class="card-body p-4 pb-0" style="min-height: 85vh;">
			<div class="d-flex align-items-center gap-6 mb-2">
				<h5 class="fs-5 mb-0 d-none d-lg-block flex-grow-1" data-title="">전사</h5>
				<button class="btn rounded-0" style="border: 1px solid #ddd;" id="all-log-btn">전체 로그</button>
				<form class="position-relative">
					<input type="text" class="form-control search-chat py-2 ps-5 rounded-0" id="drive-search" placeholder="파일 검색...">
					<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
				</form>
				<button class="btn btn-outline-light-indigo text-dark fw-semibold rounded-0 py-8 px-5" id="drive-upload">파일 업로드</button>
			</div>
			<div class="w-100 p-2 pb-3 bt-line">
				<div class="d-inline-block">
					<a href="#" class="me-2" id="new-folder">
						<i class="fa-sharp fa-regular fa-folder fa-xl fa-fw"></i>
						<span>새폴더</span>
					</a>
					<a href="#" class="me-2" id="file-download">
						<i class="fa-sharp fa-regular fa-arrow-down-to-line fa-xl fa-fw"></i>
						<span>다운로드</span>
					</a>
					<a href="#" class="me-2" id="file-delete">
						<i class="fa-sharp fa-regular fa-trash fa-xl fa-fw"></i>
						<span>삭제</span>
					</a>
					<a href="#" class="me-2" id="zip-download">
						<i class="fa-sharp fa-regular fa-file-zipper fa-xl fa-fw"></i>
						<span>목록 다운로드</span>
					</a>
				</div>
			</div>
			<div id="createFolderWrap" class="d-none justify-content-start align-items-center mt-2 bt-line" style="padding-bottom: 8px;">
				<span class="d-inline-block" style="font-weight: 600; height: 24px;">폴더 명</span>
				<input class="form-control form-control-sm w-25 rounded-0 mx-3" id="fNameInput" type="text" placeholder="폴더 이름을 입력하세요.">
				<button class="btn btn-sm btn-gray rounded-0 me-1" data-confirm="new-folder">확인</button>
				<button class="btn btn-sm btn-gray rounded-0" data-cancel="new-folder">취소</button>
			</div>
			<div class="w-100">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<div id="imageModal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content">
		<div class="" id="imageModalContent"></div>
	</div>
</div>

<div id="inputModal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content" style="width: 400px !important;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold">폴더 생성</h5>
			<a href="#" class="position-absolute fa-active" data-exit="input-modal">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="d-flex justify-content-start align-items-center mt-2 bt-line" style="padding-bottom: 8px;">
			<span class="d-inline-block" style="font-weight: 600; height: 24px;">폴더 명</span>
			<input class="flex-fill form-control form-control-sm w-25 rounded-0 mx-3" id="fNameInputModal" type="text" placeholder="폴더 이름을 입력하세요.">
			<button class="btn btn-sm btn-gray rounded-0 me-1" data-confirm="new-folder">확인</button>
			<button class="btn btn-sm btn-gray rounded-0" data-cancel="new-folder-modal">취소</button>
		</div>
	</div>
</div>

<div id="drive-upload-modal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content modal-config">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold">파일 업로드</h5>
			<a href="#" class="position-absolute fa-active" data-exit="drive-upload">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="row mt-2">
			<div class="col-lg-12" id="">
				<div class="">
					<p>대상 폴더 선택</p>
					<select id="folder-select" class="form-select form-select-sm rounded-0">
					</select>
				</div>
				<div class="my-3 bt-line"></div>
				<div class="mb-2">
					<p>파일첨부</p>
					<div class="filebox d-flex justify-content-start align-items-center">
						<input type="file" id="file" multiple>
						<label class="btn btn-sm rounded-0 fw-bold btn-gray" for="file">파일 선택</label>
						<button class="btn btn-sm rounded-0 fw-bold ms-2 btn-gray" id="deleteBtn">삭제</button>
					</div>
				</div>
				<table class="table table-sm table-responsive table-borderless table-hover" id="upload-tbl">
					<colgroup>
						<col width="10%">
						<col width="60%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>
								<input type="checkbox" class="form-check-input rounded-0" id="modalSelectAll">
							</th>
							<th>파일명</th>
							<th>확장자</th>
							<th>파일크기</th>
						</tr>
					</thead>
					<tbody id="upload-body">
					</tbody>
				</table>
			</div>
		</div>
		<div class="footer text-end doc-footer mt-3">
			<a href="#" class="btn btn-secondary rounded-0" id="uploadBtn">
				<span>확인</span>
			</a>
			<a href="#" class="btn btn-muted rounded-0 ms-2" id="cancelBtn">
				<span>취소</span>
			</a>
		</div>
	</div>
</div>

<div id="logInfoModal" class="interactive-modal" style="z-index: 9999;">
	<div class="interactive-modal-content" style="width:1200px;">
		<header class="position-relative p-4">
			<h5 class="font-weight-bold">파일 로그</h5>
			<a href="#" class="position-absolute fa-active" data-exit="log-info">
				<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
			</a>
		</header>
		<div class="row mt-2">
			<div class="col-lg-12" id="" style="height:500px; overflow: auto;">
				<table class="table table-responsive table-borderless" id="log-tbl">
					<colgroup>
						<col width="20%">
						<col width="15%">
						<col width="45%">
						<col width="20%">
					</colgroup>
					<thead class="">
						<tr class="table-sm border-bottom">
							<th style="background-color: #ddd;">파일명</th>
							<th style="background-color: #ddd;">유형</th>
							<th style="background-color: #ddd;">내용</th>
							<th style="background-color: #ddd;">날짜</th>
						</tr>
					</thead>
					<tbody id="log-body" style="height:500px; overflow-y:auto;">
					</tbody>
				</table>
				
				<table class="table table-responsive" id="log-all-tbl">
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="10%">
					</colgroup>
					<thead class="">
						<tr class="table-sm border-bottom">
							<th style="background-color: #ddd;">파일명</th>
							<th style="background-color: #ddd;">유형</th>
							<th style="background-color: #ddd;">내용</th>
							<th style="background-color: #ddd;">날짜</th>
							<th style="background-color: #ddd;">다운로드 횟수</th>
						</tr>
					</thead>
					<tbody id="log-all-body">
					</tbody>
				</table>
			</div>
		</div>
		<div class="footer text-end doc-footer mt-3">
			<a href="#" class="btn btn-muted rounded-0 ms-2" id="cancelLogInfo">
				<span>취소</span>
			</a>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-grid.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jszip@3.10.1/dist/jszip.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/file-saver@2.0.5/dist/FileSaver.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/drive/drive_modal.js"></script>
<script>
/* 업로드 시 필요한 변수 시작 */
const byteUnits = [ "KB", "MB", "GB" ];
var fileArray = [];
var formData = new FormData();
var cnt = 1;
var grid;
var fldrType = 0;
/* 업로드 시 필요한 변수 끝 */

/* fldrType 변경  시작*/
var sideArea = $('#sideArea');
var companyLink = $('#company');
var departmentLink = $('#department');
var privateLink = $('#private');
var fldrInfo = {
    'company': { index: 0, title: '전사' },
    'department': { index: 1, title: '부서' },
    'private': { index: 2, title: '개인' }
};

sideArea.on('click', '[data-id]', function() {
	let id = $(this).data('id');
	fldrType = fldrInfo[id].index;
	driveItem.fldrType = fldrType;
	$('[data-title]').text(fldrInfo[id].title);
	
	getDriveFiles();
});

/* fldrType 변경  끝*/

var driveItem = {fldrType : fldrType};
var imageModal = $("#imageModal");
var inputModal = $('#inputModal');
var logInfoModal = $('#logInfoModal');

$('#all-log-btn').on('click', function() {
	toggleAllLogInfoModal(fldrType);
});

function toggleImageModal() {
	imageModal.toggleClass("show");
	if(!imageModal.hasClass('show')) {
		setTimeout(function() {
			imageModal.find('img').remove();
		}, 200);
	}
}

function toggleInputModal() {
	$('#fNameInputModal').val('');
	inputModal.toggleClass('show');
}

function toggleAllLogInfoModal(fldrType) {
	$.get('/drive/alllog', {fldrType : fldrType})
	.done(function(res) {
		createAllHTML(res);
	})
	logInfoModal.toggleClass('show');
}

let logTbl = $('#log-tbl');
let logAllTbl = $('#log-all-tbl');

function toggleLogInfoModal(row) {
	logAllTbl.hide();
	logTbl.show();
	
	if(row) {
		$.get('/drive/getlog', {itemNo : row.itemNo, itemType : row.itemType})
		.done(function(res) {
			createHTML(res);
		})
	}
	
	logInfoModal.toggleClass('show');
}

function createAllHTML(res) {
	logTbl.hide();
	logAllTbl.show();
	
	let logBody = $('#log-all-body');
	
	logBody.html('');
	
	let fileNoObject = {};
	
	res.forEach(log => {
		if(!fileNoObject[log.fileNo]) {
			fileNoObject[log.fileNo] = {
				name: log.fileName,
				rowspan: 1
			};
		} else {
			fileNoObject[log.fileNo].rowspan ++;
		}
	})
	
	let previousFileName = null;
	let html = '';
	
	for (let i = 0; i < res.length; i++) {
	    let delimiter = res[i].logCn.indexOf(']') + 1;
	    let type = res[i].logCn.substring(0, delimiter);
	    let cn = res[i].logCn.substring(delimiter, res[i].logCn.length);
	    
	    if (previousFileName !== res[i].fileName) {
	        html += '<tr>';
	        html += '    <td rowspan="' + fileNoObject[res[i].fileNo].rowspan + '" class="text-center">' + res[i].fileName + '</td>';
	    }
	    
	    html += '<td class="fw-semibold">' + type + '</td>';
	    html += '<td>' + cn + '</td>';
	    html += '<td>' + res[i].logDtToString + '</td>';
	    if (previousFileName !== res[i].fileName) {
	        html += '    <td rowspan="' + fileNoObject[res[i].fileNo].rowspan + '" class="text-center">' + res[i].downloadCnt + '</td>';
	        previousFileName = res[i].fileName;
	    }
	    
	    html += '</tr>';
	}

	logBody.append(html);
}

function createHTML(res) {
	let logBody = $('#log-body');
	let downloadCnt = $('#downloadCnt');
	
	logBody.html('');
	downloadCnt.html('');
	
	downloadCnt.text(res[0].downloadCnt);
	
	let fileNoObject = {};
	
	let html = '';
	
	for(let i = 0; i < res.length; i++) {
		let delimiter = res[i].logCn.indexOf(']')+1;
		let type = res[i].logCn.substring(0, delimiter);
		let cn = res[i].logCn.substring(delimiter, res[i].logCn.length);
		
        html += '<tr>';
        html += '    <td rowspan="" class="text-center">' + res[i].fileName + '</td>';
		html += '	<td class="fw-semibold">'+type+'</td>';
		html += '	<td>'+cn+'</td>';
		html += '	<td>'+res[i].logDtToString+'</td>';
		html += '</tr>';
	}
	
	logBody.append(html);
}

$(function(){
	getDriveFiles();
	getFoler(fldrType);
});

/* 메뉴 아이디 선택자 시작 */
let newFolder = $('#new-folder');
let folderArea = $('#createFolderWrap');

let fileDownload = $('#file-download');
let fileDelete = $('#file-delete');
let zipDownload = $('#zip-download');
let fileFilter = $('#file-filter');

let driveSearch = $('#drive-search');
/* 메뉴 아이디 선택자 끝 */

fileDownload.on('click', function() {
	fnFileDownload(fnCheckedFile());
});

fileDelete.on('click', function() {
	if(adminCheck('삭제할 권한이 존재하지 않습니다')){
		fnFileDelete();
	}
});

zipDownload.on('click', function() {
	fnFileDownload(fnGetAllFiles());
});

newFolder.on('click', function() {
	if(adminCheck()){
		toggleNewFolderArea();
	}
});

driveSearch.on('input', function() {
	let searchText = $(this).val();
	if(searchText != '') {
		searchDriveFiles(searchText);
	}else{
		getDriveFiles();
	}
});

tui.Grid.applyTheme('clean', {
	cell: {
		normal: {
		      background: '#fff',
		      border: '#fff',
		      showVerticalBorder: false,
		      showHorizontalBorder: false
		},
		header: {
			background: '#EFEFEF',
		     border: '#ddd',
		     showVerticalBorder: false,
		     showHorizontalBorder: false,
		},
		rowHeader: {
			border: '#fff',
			showVerticalBorder: false,
			showHorizontalBorder: false,
		}
	}
});

tui.Grid.setLanguage('ko');

grid = new tui.Grid({
    el: document.getElementById('grid'),
    rowHeaders: ['checkbox'],
    bodyHeight: 500,
    scrollX: false,
    scrollY: false,
    treeColumnOptions: {
      name: 'itemNm',
      useIcon: true,
      useCascadingCheckbox: true
    },
    columns: [
      {
        header: '이름',
        name: 'itemNm',
        editor: 'text',
        validation: {
        	dataType: 'string',
        	required: true
        },
        width: 500
      },
      {
        header: '크기',
        name: 'itemSize',
       	sortable: true,
      },
      {
        header: '확장자',
        name: 'itemExtsn',
        filter: {
        	type: 'select'
        }
      },
      {
        header: '등록날짜',
        name: 'itemRgsde',
        sortable: true,
      }
    ],
    contextMenu: ({rowKey, columnName}) => (
    	[
    		[
				{
					name: 'view',
					label: '미리보기',
					action: () => {
						let target = grid.getRow(rowKey);
						if(isImageFile(target.itemExtsn)){
							viewImage(target.itemPath);
						}else{
							showToast('이미지 파일이 아닙니다!', 'error');
							return;
						}
					}
				},
				{
					name: 'download',
					label: '다운로드',
					action: () => {
						let target = grid.getRow(rowKey);
						if(target.itemType == 'FOLDER'){
							let files = getFileInFolder(grid.getChildRows(rowKey));
							console.table(files);
							fnFileDownload(files);
							return;
						}
						fnFileDownloadOne(target);
					}
				},
				{
					name: 'modify',
					label: '이름변경',
					action: () => {
						if(adminCheck('수정할 권한이 존재하지 않습니다')) {
							grid.startEditing(rowKey, columnName);
						}
					}
				},
				{
					name: 'folder',
					label: '폴더생성',
					action: () => {
						if(adminCheck()) {
							toggleInputModal();
						}
					}
				},
				{
					name: 'delete',
					label: '삭제',
					action: () => {
						if(adminCheck('삭제할 권한이 존재하지 않습니다')) {
							showConfirm('정말 삭제하시겠습니까?', '', 'warning')
							.then(result => {
								if(result.isConfirmed) {
									fnFileDelete(rowKey);
									grid.removeRow(rowKey);
								}
							});
						}
					}
				},
				{
					name: 'copy',
					label: '행 복사',
					action: 'copyRows'
				},
				{
					name: 'log',
					label: '로그확인',
					action: () => {
						if(adminCheck('로그를 확인할 권한이 존재하지 않습니다')) {
							let row = grid.getRow(rowKey);
							toggleLogInfoModal(row);
						}
					}
				}
    		]
    	]
    ),
    draggable: true
  });

  grid.on('expand', ev => {
    const { rowKey } = ev;
    const descendantRows = grid.getDescendantRows(rowKey);

    console.log('rowKey: ' + rowKey);
    console.log('descendantRows: ' + descendantRows);
    
  });
  
	grid.on('drop', ev => {
		const { rowKey, targetRowKey } = ev;
		let thisItem = grid.getRow(rowKey);
		let targetItem = grid.getRow(targetRowKey);
		
		console.log(thisItem);
		console.log(targetItem);
		
		if(rowKey == targetRowKey) {
			return;
		}
		
		if(targetItem == undefined) {
			return;
		}
		
		if(thisItem.itemType == 'FOLDER' && targetItem.itemType == 'FILE') {
			return;
		}
		
		if((thisItem.itemType == 'FILE' && targetItem.itemType == 'FOLDER')
				|| (thisItem.itemType == 'FOLDER' && targetItem.itemType == 'FOLDER')) {
			
			thisItem.upperFldrNo = targetItem.itemNo;
			
			// AJAX 파일 이동 요청
			fnFileMove(thisItem);
		}
		
		if(thisItem.itemType == 'FILE' && targetItem.itemType == 'FILE'){
			ev.stopped = true;
			parentRowKey = grid.getParentRow(targetRowKey);
// 			console.log('parentRowKey =>', parentRowKey);
			
			if(parentRowKey == null) {
				parentRowKey = {rowKey: null};
			}
			
			let allGrid = grid.getData();
			let itemNm = '새폴더';
			let count = 1;
			
			let exist = allGrid.some(item => item.itemNm == itemNm);
			while(exist) {
				count++;
				itemNm = `\${itemNm}(\${count})`;
				exist = allGrid.some(item => item.itemNm == itemNm);
			}
			
			let createDt = toStringByDate(new Date());
// 			console.log(createDt);
			let item = {
				emplNo: connectionTest(),
				itemNm: itemNm,
				itemExtsn: " ",
				itemRgsde: createDt,
				itemType: 'FOLDER',
				fldrType: fldrType,
				_attributes: {
					expanded: true
				}
			}
			
			let folder = {
				emplNo: connectionTest(),
				upperFldrNo: parentRowKey.itemNo,
				fldrNm: itemNm,
				fldrType: fldrType,
			}
			
			grid.appendTreeRow(item, {
				parentRowKey: parentRowKey.rowKey,
				focus: true
			});
			
			let targetIdx = findGridIndexByProperty('itemNm', itemNm);
			
// 			console.log('targetIdx => ',targetIdx);
// 			console.log('thisItem RowNum =>', thisItem._attributes.rowNum);
// 			console.log('targetItem RowNum =>', targetItem._attributes.rowNum);
			
			let thisRowNum = thisItem._attributes.rowNum;
			let targetRowNum = targetItem._attributes.rowNum;
			
			if(thisRowNum > targetRowNum) {
				grid.moveRow(rowKey, targetIdx, {appended: true});
				targetIdx = findGridIndexByProperty('itemNm', itemNm);
				grid.moveRow(targetRowKey, targetIdx, {appended: true});
			}else{
				grid.moveRow(rowKey, targetIdx, {appended: true});
				targetIdx = findGridIndexByProperty('itemNm', itemNm);
				grid.moveRow(targetRowKey, targetIdx, {appended: true});
			}
			
			// AJAX 폴더 생성 요청
			let itemNo = mergedFileCreateFolder(folder);
			
			thisItem.upperFldrNo = itemNo;
			targetItem.upperFldrNo = itemNo;
			
			// AJAX 파일 이동 요청
			fnFileMove(thisItem);
			fnFileMove(targetItem);
		}
    	
	});
	
	function findGridIndexByProperty(prop, val) {
		let allGrid = grid.getData();
		let newFolder = allGrid.find(row => row[prop] === val);
		return grid.getIndexOfRow(newFolder.rowKey);
	}

  grid.on('collapse', ev => {
    const { rowKey } = ev;
    const descendantRows = grid.getDescendantRows(rowKey);

    console.log('rowKey: ' + rowKey);
    console.log('descendantRows: ' + descendantRows);
  });
  
  grid.on('editingFinish', ev => {
	  if(adminCheck('수정할 권한이 존재하지 않습니다')) {
		  const { rowKey, value , save } = ev;
		  let target = grid.getRow(rowKey);
		  
		  $.post('/drive/editname', {itemNo:target.itemNo, itemNm : value, itemType : target.itemType})
		  .done(function(res) {
			  if(res == 'OK')
				ev.save = true;
		  })
	  }
  })
  
/* 모달 확인 이벤트 */
$('[data-confirm]').on('click', function() {
	let data = $(this).data('confirm');
	
	if(data == 'new-folder') {
		// AJAX 요청
		let item = getFocusItem();
		let upperFldrNo = 0;
		
		if(item != null && item.itemType == 'FOLDER') {
			upperFldrNo = item.itemNo;
		}
		
		createNewFolder(upperFldrNo);
	}	
})

/* 모달 닫기 이벤트 */
$('[data-cancel]').on('click', function() {
	let data = $(this).data('cancel');
	
	if(data == 'new-folder') {
		toggleNewFolderArea();
	}else if(data == 'new-folder-modal') {
		toggleInputModal();
	}
})

/* 드라이브 파일 리스트 바디 */
let driveBody = $('#drive-body');

/* 업로드 모달 바디 */
let uploadBody = $('#upload-body');
let uploadBtn = $('#uploadBtn');

/* 체크박스 전체 선택 */
toggleCheckbox('#tbl', 'selectAll', 'select');
toggleCheckbox('#upload-tbl', 'modalSelectAll', 'modalSelect');

/* 업로드 모달 파일 업로드 시 파일 배열에 저장 */
$('#file').on('change', function(e) {
	for (let i = 0; i < e.target.files.length; i++) {
		let file = e.target.files[i];
		let html = createUploadHTML(file);
		
		uploadBody.append(html);
		
		cnt++;
		fileArray.push(file);
	}
})

/* 업로드 모달 체크박스로 파일 삭제 */
$('#deleteBtn').on('click', function() {
	let checkedFiles =  document.querySelectorAll('input[name="modalSelect"]:checked');
	
	for(let i = 0; i < checkedFiles.length; i++) {
		let name = checkedFiles[i].parentElement.nextElementSibling.textContent;
		deleteSavedFile(name);
		
		checkedFiles[i].parentElement.parentElement.remove();
		cnt--;
	}
	
	$('#modalSelectAll').prop('checked', false);
});

/* 업로드 모달 개별 파일 삭제 */
uploadBody.on('click', 'span[name="uploadDelete"]', function() {
	let fileName = $(this).closest('td').siblings().eq(0).text();
	deleteSavedFile(fileName);
	$(this).closest('tr').remove();
})

/* 파일 업로드 */
uploadBtn.on('click', function() {
	if(fileArray.length == 0) {
		showAlert('최소한 하나의 파일을 추가해주세요!', '', 'error');
		return;
	}
	
	for(let i in fileArray) {
		formData.append('files', fileArray[i]);
	}
	
	let upperFldrNo = $('#folder-select').val() == null ? 0 : $('#folder-select').val();
	formData.append('upperFldrNo', upperFldrNo);
	formData.append('fldrType', fldrType);
	formData.append('filePath', $('#folder-select option:selected').text());
	
	$.ajax({
		type : 'post',
		url : '/drive/upload',
		data : formData,
		processData : false,
		contentType : false,
		success : function(res) {
			formData = new FormData();
			fileArray = [];
			uploadBody.html('');
			
			getDriveFiles();
			
			showToast('파일이 성공적으로 업로드 되었습니다!', 'success');
		}
	});
})

function adminCheck(msg) {
	if(!msg) {
		msg = '폴더를 생성할 권한이 존재하지 않습니다';
	} 
	
	if(fldrType == 0 && (!isAdmin || isAdmin == 'false')) {
		showToast(msg, 'warning');
		return false;
	}
	
	return true;
}

/* 폴더 안의 파일들 재귀 호출 후 파일 반환 */
function getFileInFolder(childRows, files = []) {
	
	for(let i = 0; i<childRows.length; i++) {
		let item = childRows[i];
		if(item.itemType == 'FOLDER') {
			getFileInFolder(item._children, files);
		}else if(item.itemType == 'FILE'){
			let file = {
				itemNm : item.itemNm.substring(0, item.itemNm.lastIndexOf('.')),
				itemExtsn: item.itemExtsn,
				itemPath : item.itemPath 
			};
			files.push(file);
		}
	}
	
	return files;
}

/* 포커스 행 반환 */
function getFocusItem() {
	let upperFldrNo = 0;
	let focusItem = grid.getFocusedCell();
	if(focusItem.rowKey != null) {
		let item = grid.getRow(focusItem.rowKey);
		return item;
	}
	
	return null;
}

/* 파일 이동 함수 */
function fnFileMove(item) {
	$.ajax({
		url: '/drive/filemove',
		type: 'post',
		contentType: 'application/json; charset=UTF-8',
		data: JSON.stringify(item)
	})
	.done(function(res) {
		console.log(res);
	});
}

/* 업로드 모달 폴더 불러오는 함수 */
function getFoler(fldrType) {
	$.get('/drive/getfolder', {fldrType : fldrType, emplNo : connectionTest()})
	.done(function(res) {
		let folderSelect = $('#folder-select');
		folderSelect.html('');
		
		res.forEach(function (folder) {
			let opt = document.createElement('option');
			opt.value = folder.fldrNo;
			opt.textContent = folder.fldrNm;
			folderSelect.append(opt);
		})
	})
}

/* 선택한 파일 가져오기 */
function fnCheckedFile() {
	let checkedFiles = grid.getCheckedRows();
	let fileList = checkedFiles.filter(el => el.itemType == 'FILE');
	
	if(fileList.length == 0) {
		showToast('파일을 선택해주세요!', 'error');
		return;
	}
	
	return fileList;
}

/* 모든 파일 가져오기 */
function fnGetAllFiles() {
	let allFiles = grid.getData();
	let fileList = allFiles.filter(el => el.itemType == 'FILE');
	
	if(fileList.length == 0) {
		showToast('파일이 존재하지 않습니다!', 'error');
		return;
	}
	
	return fileList;
}

/* 파일 삭제 함수 */
function fnFileDelete(rowKey) {
	
	let delFolders = [];
	let delFiles = [];
	let elList;
	if(rowKey !== undefined) {
		let target = grid.getRow(rowKey);
		if(target.itemType == 'FOLDER') {
			delFolders.push(target.itemNo);
		}else if(target.itemType == 'FILE') {
			delFiles.push(target.itemNo);
		}
	}else {
		elList = grid.getCheckedRows();
		
		if(elList.length == 0) {
			showToast('삭제할 대상을 선택해주세요!', 'error');
			return;
		}
		
		delFolders = elList.filter(el => el.itemType == 'FOLDER').map(folder => folder.itemNo);
		delFiles = elList.filter(el => el.itemType == 'FILE').map(file => file.itemNo);
		
	}
	
	fetch('/drive/del', {
		method: 'POST',
		headers: {
			[header]: token,
			'X-Requested-With': 'XMLHttpRequest',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			delFolders : delFolders,
			delFiles : delFiles
		})
	})
	.then(response => response.text())
	.then(text => {
		if(rowKey == undefined) {
			elList.forEach((el) => {
				grid.removeRow(el.rowKey);
			});
			
			showToast('정상적으로 삭제되었습니다!', 'success');
		}
	});
}

/* 압축 파일 및 하나의 파일 다운로드 */
function fnFileDownload(fileList) {
	
	if(fileList.length >= 2) {
		let zip = new JSZip();
		
		let fetchPromises = fileList.map(file => {
	        return fetch('/drive/download?itemNo=' + encodeURIComponent(file.itemNo))
	        .then(response => response.blob())
	        .then(data => {
	            zip.file(file.itemNm+'.'+file.itemExtsn, data);
	        });
	    });

	    Promise.all(fetchPromises).then(function() {
	        zip.generateAsync({type:'blob', compression: "DEFLATE"}).then(function(content) {
	            saveAs(content, '개발 관련.zip');
	        });
	    });
	    
	}else
		fnFileDownloadOne(fileList[0]);
}


/* 파일 다운로드 하는 함수 */
function fnFileDownloadOne(item) {
	let url = '/drive/download?itemNo='+item.itemNo;
	let path = item.itemPath;
	fetch(url)
	.then(response => response.blob())
	.then(blob => {
		saveAs(blob, path.substring(path.lastIndexOf('_')+1, path.length));
	})
}

/* 이미지 불러오는 함수 */
function viewImage(path) {
	let img = document.createElement('img');
	let jImg = $(img);
	jImg.attr('src', '/display?p='+path);
	jImg.addClass('img-thumbnail', 'img-fluid');
	
	$('#imageModalContent').append(jImg);
	
	toggleImageModal();
}


/* 드라이브 메인 파일 얻어오는 함수 */
function getDriveFiles() {
	$.post('/drive/files', driveItem)
	.done(function(res) {
		grid.resetData(organizeFolders(res));
	});
}
/* 드라이브 검색 함수 */
function searchDriveFiles(text) {
	let obj = structuredClone(driveItem);
	obj.searchText = text;
	$.post('/drive/search', obj)
	.done(function(res) {
		
		if(res.length > 2) {
			grid.resetData(organizeFolders(res));
		}else{
			grid.resetData(res);
		}
	});
}

function organizeFolders(res) {
    function findChildren(parentFolder) {
        if (parentFolder) { // 부모 폴더가 있는 경우
            parentFolder._attributes = { expanded: true };
        }
        
        let childrenFolders = res.filter(item => item.itemType == 'FOLDER' && 
            (parentFolder ? item.upperFldrNo == parentFolder.itemNo : !res.find(f => f.itemNo == item.upperFldrNo)))
            .map(childFolder => findChildren(childFolder));

        let childrenFiles = res.filter(item => item.itemType === 'FILE' && 
            (parentFolder ? item.upperFldrNo === parentFolder.itemNo : !res.find(f => f.itemNo == item.upperFldrNo)));
        childrenFiles.forEach(file => { file.parentRowKey = parentFolder ? parentFolder.itemNo : undefined; });

        if (parentFolder) {
            parentFolder._children = [...childrenFolders, ...childrenFiles];
            return parentFolder;
        } else {
            return [...childrenFolders, ...childrenFiles]; // 부모 폴더가 없는 경우, 최상위 요소 반환
        }
    }

    // 최상위 요소 찾기 (상위 폴더 번호가 없거나, 해당 번호를 가진 상위 폴더가 없는 경우)
    let topLevelItems = res.filter(item => !item.upperFldrNo || !res.find(f => f.itemNo == item.upperFldrNo));
    let organizedFolders = topLevelItems.flatMap(item => findChildren(item));

    console.log(organizedFolders);
    return organizedFolders;
}

/* 새 폴더 생성 함수 */
function createNewFolder(upperFldrNo) {
	
	let fldrNm = $('#fNameInput').val().trim() == '' ? $('#fNameInputModal').val() : $('#fNameInput').val();
	
	$.ajax({
		url: '/drive/newfolder',
		type: 'post',
		contentType: 'application/json; charset=UTF-8',
		data: JSON.stringify({
			emplNo : connectionTest(),
			fldrNm : fldrNm,
			upperFldrNo : upperFldrNo,
			fldrType : fldrType
		})
	})
	.done(function(res) {
		
		if($('#fNameInput').val()) {
			$('#fNameInput').val('');
			toggleNewFolderArea();
		}else{
			$('#fNameInputModal').val('');
			toggleInputModal();			
		}
		
		getDriveFiles();
	})
}

/* 파일 합칠 시 새로운 폴더 생성 함수(위랑 중복..) */
function mergedFileCreateFolder(folder) {
	
	let itemNo;
	
	$.ajax({
		url: '/drive/newfolder',
		type: 'post',
		contentType: 'application/json; charset=UTF-8',
		async: false,
		data: JSON.stringify(folder)
	})
	.done(function(res) {
		itemNo = res;
		getDriveFiles();
	})
	
	return itemNo;
}


/* 저장된 파일 삭제 함수 */
function deleteSavedFile(name) {
	for(let j = 0; j < fileArray.length; j++) {
		if(fileArray[j].name === name) {
			fileArray.splice(j, 1);
			break;
		}
	}
}

/* 파일 업로드 HTML 그려주는 함수 */
function createUploadHTML(file) {
	
	let name = file.name;
	let size = getByteSize(file.size);
	let ext = name.substring(name.lastIndexOf('.')+1, name.length).toLowerCase();
	
	let html = 
	`<tr>
		<td>
			<input type="checkbox" class="form-check-input rounded-0" name="modalSelect" value="\${cnt}"/>
			<span class="d-inline-block" name="uploadDelete" style="cursor:pointer;"><i class="fa-sharp fa-regular fa-xmark fa-fw"></i></span>
		</td>
		<td>\${name}</td>
		<td>\${ext}</td>
		<td>\${size}</td>
	</tr>`;
	
	return html;
}

function toggleNewFolderArea() {
	$('#fNameInput').val('');
	folderArea.toggleClass('d-none').toggleClass('d-flex');
}

/* 토글 체크박스 함수 */
function toggleCheckbox(table, selectAll, select) {
    $(table).on('change', 'input[type="checkbox"]', function () {
        if ($(this).attr('id') == selectAll) {
            $(`input[name=\${select}]`).prop("checked", $(this).is(":checked"));
        } else if ($(this).attr('name') == select) {
            var total = $(`input[name=\${select}]`).length;
            var checked = $(`input[name=\${select}]:checked`).length;
            $(`#\${selectAll}`).prop("checked", total == checked);
        }
    });
}

/* 바이트 사이즈 얻어오는 함수 */
function getByteSize(size) {
	for (let i = 0; i < byteUnits.length; i++) {
		size = Math.floor(size / 1024);
		if (size < 1024)
			return size.toFixed(1) + byteUnits[i];
	}
}

/* 이미지 파일 확인 함수 */
function isImageFile(fileName) {
	let pattern = /jpg|jpeg|gif|png/i;
	return fileName.match(pattern);
}

/* 0 추가 함수 */
function leftPad(value) {
    if (value >= 10) {
        return value;
    }

    return `0\${value}`;
}

/* Date (yyyy-MM-dd) 형식으로 반환 */
function toStringByDate(date, delimiter = '-') {
    const year = date.getFullYear();
    const month = leftPad(date.getMonth() + 1);
    const day = leftPad(date.getDate());

    return [year, month, day].join(delimiter);
}
</script>