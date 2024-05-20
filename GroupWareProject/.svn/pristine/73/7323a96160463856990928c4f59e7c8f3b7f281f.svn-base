<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/themes/default/style.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/documents/list.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/modal/interactive-modal.css">

<style>
#previewModal {
	max-height: 80vh;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 80%;
	max-width: 1000px;
}

.interactive-modal-content {
	width: 100%;
	max-height: 100vh;
	overflow-y: auto;
}

#previewContent {
	max-height: 800px;
	overflow-y: auto;
	overflow-x: auto;
	white-space: nowrap;
}


#previewContent>div {
	display: inline-block;
}

.btn-close-right {
	position: absolute;
	top: 10px;
	right: 10px;
}

.container-fluid {
	background-color: white;
}
</style>

<div class="px-9 pt-4 pb-3">
	<a href="/admin/documents/list">
		<h3 class="fw-semibold mb-4">
			<i class="fa-sharp fa-regular fa-file-lines fa-fw fa"></i>
			양식관리
		</h3>
	</a>
</div>
<!-- 메인 컨텐츠 -->
<div class="container-fluid">
	<div class="row">
		<!-- 왼쪽 사이드바 -->
		<div class="col-lg-2 col-md-4">
			<div class="doc-wrapper">
				<div class="left-part border-end w-15 flex-shrink-0 d-none d-lg-block"></div>
				<div class="doc-sidebar">
					<!-- 검색 입력 창 -->
					<div class="searchInput d-flex align-items-center me-3">
						<input type="text" id="schName" class="form-control rounded-0" maxlength="20" placeholder="검색">
						<button type="button" class="btn btn-dark bg-dark rounded-0" onclick="fSch()">
							<i class="fa-light fa-magnifying-glass fa-md fa-fw"></i>
						</button>
					</div>
					<!-- 트리 -->
					<div id="tree" style="margin-top: 20px;"></div>
					<div class="simplebar-track simplebar-vertical" style="visibility: visible;">
						<div class="simplebar-scrollbar" style="height: 681px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 오른쪽 컨텐츠 -->
		<div class="col-lg">
			<div class="row">
				<div class="col">
					<div class="right-wrapper">
						<div class="buttonWrpper d-flex justify-content-end">
							<div class="buttonWrapper__item me-2">
								<button class="btn rounded-0 custom-btn" id="docInsertBtn">양식 추가</button>
							</div>
							<div class="buttonWrapper__item me-2">
								<button class="btn rounded-0 custom-btn" id="docModifyBtn">수정</button>
							</div>
							<div class="buttonWrapper__item">
								<button class="btn rounded-0 custom-btn" id="docDeleteBtn">삭제</button>
							</div>
						</div>
						<div class="mt-4" id="selectedFolderInfo">
							<p>
								<span id="selectedFolderName"></span>
							</p>
						</div>
						<div id="listContainer"></div>
					</div>
				</div>
				<div class="col">
					<h4 id="seletedFormName"></h4>
					<div id="docContent"></div>
					<form action="/admin/documents/modifydocform" id="updateForm">
						<sec:csrfInput />
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="previewModal" class="interactive-modal" style="z-index: 1;">
		<div class="container interactive-modal-content">

			<div class="row">
				<div class="col-md-12" id="">
					<div class="card">
						<div class="card-header bg-dark">
							<div class="d-flex justify-content-between align-items-center">
								<div class="text-center flex-grow-1">
									<h5 style="color: white;">미리보기</h5>
								</div>
								<div>
									<i class="fa-light fa-xmark" id="previewCloseBtn" aria-label="Close" style="color: #ffffff; font-size: 24px; cursor: pointer;"></i>
								</div>
							</div>
						</div>
						<div class="card-body preview-content" id="previewContent">
							<div class="row" id=""></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




<script src="${pageContext.request.contextPath }/resources/project/js/source/jstree.min.js"></script>
<%-- <script src="${pageContext.request.contextPath }/vendor/libs/bootstrap-table/dist/bootstrap-table.min.js"></script> --%>

<script type="text/javascript">
$(document).ready(function() {
	
    
	var docInsertBtn = $('#docInsertBtn');
	var docModifyBtn = $('#docModifyBtn');
	var docDeleteBtn = $('#docDeleteBtn');
	var selectAllCheckbox = $('#selectAllCheckbox');
	var checkboxes = $('#listContainer').find('input[name="selectedDocuments"]');
	var schName = $('#schName');
	var docContent = $('#docContent');
	var seletedFormName = $('#seletedFormName');
	var selectedInfo = [];
	var updateForm = $("#updateForm");
	var previewModal = $("#previewModal");
	var previewContent = $("#previewContent");
    // 전체 선택/해제 체크박스 클릭 이벤트
    $(document).on('change', '#selectAllCheckbox', function() {
    	$('.doc-chkbox').prop('checked', $(this).prop('checked'));
	});
    
    $(document).on('click', function(e) {
        if (!$(e.target).closest('#previewModal').length) {
            if (previewModal.hasClass('show')) {
                togglePreviewModal();
            }
        }
    });
    
    /* 저장버튼 */
    $(document).on('click', '#formSaveBtn', function(){
    	var selectedInfo = getSelectedInfo();
    	// 폼에 있는 값 가져오기
        var folderSelect = $('#folderSelect').val(); // 선택된 폴더명
        var formTitle = $('#formTitle').val(); // 양식 제목
        var useYn = $('#useYnCheckbox').prop('checked') ? 'Y' : 'N'; // 사용 여부 체크
        var docNo = selectedInfo[0].docNo;
        
        // 폼에 있는 값들을 객체로 만들어 서버에 전송
        var formData = {
            docTypeCode: folderSelect,
            docNm: formTitle,
            useYn: useYn,
            docNo: docNo
        };
        console.log(formData);
        
        Swal.fire({
            html: '<strong>저장 하시겠습니까?</strong>',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '저장',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                // 사용자가 확인을 눌렀을 때 AJAX 요청 보내기
                $.ajax({
                    url: '/admin/documents/updateDocForm',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(formData),
                    success: function(res) {
                        console.log('저장 성공!');
                        console.log('res:', res);
                        showToast('성공적으로 저장되었습니다!', 'success');
                        /* 다시 그릴것인가 새로고침할것인가? */
                        location.reload();
                        //loadDocData(); 안됨 
                    },
                    error: function(xhr, status, error) {
                        console.log('저장 실패');
                    }
                });
            }
        });
    });
    
    
    $(document).on('click', '.doc-chkbox', function() {
    	console.log('체크');
    	
	});
    
    /* 양식편집버튼 */
    $(document).on('click', '#docUpdateBtn', function() {
    	updateForm.submit();
    	 
	});
    
    /* 프리뷰 X버튼 */
    $(document).on('click', '#previewCloseBtn', function() {
    	previewModal.toggleClass('show');
    	
	});
    
    
    
	 function togglePreviewModal() {
		previewModal.toggleClass('show');
	}
    
    /* 미리보기버튼 */
    $(document).on('click', '#previewBtn', function() {
    	var previewId = $(this).data('preview');
    	console.log('data-preview:',previewId);
    	
    	
    	$.ajax({
            url: '/admin/documents/selectOneDoc', 
            type: 'GET',
            data: { docNo: previewId },
            success: function(res) {
                console.log(res) // 응답 데이터를 인수로 전달하여 모달을 생성
                previewContent.html('');
                var html = '';
                
                html += '<div>' + res.docCn +'</div>';
                
                previewContent.html(html);
                
                togglePreviewModal();
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', error);
            }
        });
    	
    	
	});
    
   
    
    function createPreviewModal(){
    	
    }
    
    /* 문서 삭제 버튼 이벤트 */
    $(document).on('click', '#docDeleteBtn', function() {
    	var selectedInfo = getSelectedInfo();
    	console.log("삭제버튼 눌렀을때 인포:", selectedInfo);
    	drawSelectedInfo(selectedInfo);
    	$('#seletedFormName').text('문서 양식 삭제');
    	
    	delSelectedDoc();
	});
    
    /* 수정버튼 */
    docModifyBtn.click(function() {
    	var selectedInfo = getSelectedInfo();
        console.log("수정버튼 눌렀을때 인포:", selectedInfo);

        // 선택된 정보를 옆에 그려주는 함수 호출
        drawSelectedInfo(selectedInfo);
    });
    
	loadDocData();
	
	docInsertBtn.click(function(){ 
		window.location.href = "${pageContext.request.contextPath}/admin/documents/insertdocform";
	});
	
	
    
    $('#tree').on('select_node.jstree', function(e, data) {
    	var selectedNode = data.node; // 선택된 노드 가져오기
    	var parentText = selectedNode.parent === "#" ? selectedNode.text : $('#tree').jstree(true).get_node(selectedNode.parent).text; // 부모 노드의 텍스트 가져오기
        
        $('#selectedFolderName').text('폴더명: '+parentText);
        var childNodes = selectedNode.children_d; // 선택된 노드의 자식 노드 ID 배열 가져오기
        console.log('####selectedNode', selectedNode);
        console.log('####childNodes', childNodes);
        if (childNodes.length > 0) { // 자식 노드가 있는 경우에만 처리
            var listHtml = '<table style="border-collapse: collapse; width: 100%;">';
            
            listHtml += '<thead><tr><th><input type="checkbox" class="form-check-input primary" id="selectAllCheckbox"></th><th>제목</th><th>최종 수정자</th><th>사용여부</th><th>문서번호</th><th></th></tr></thead>';
            listHtml += '<tbody>';
            childNodes.forEach(function(childNodeId) { // 각 자식 노드에 대해 처리
                var childNode = $('#tree').jstree(true).get_node(childNodeId); // 자식 노드 가져오기
                var docCn = childNode.original.docCn; // 원본 데이터에서 docCn 가져오기
                var emplNm = childNode.original.emplNm;
                var useYn = childNode.original.useYn; 
                var docCodeNo = childNode.original.docCodeNo; 
	                if (useYn === 'Y') { 
	                    useYn = "사용";
	                } else { 
	                    useYn = "사용 안함";
	                }
	                listHtml += '<tr>';
	                listHtml += '<td><input type="checkbox" class="form-check-input doc-chkbox primary" value="' + childNode.id + '"></td>';
	                listHtml += '<td class="form-title">' + childNode.text + '</td>';
	                listHtml += '<td>' + emplNm + '</td>';
	                listHtml += '<td>' + useYn + '</td>'; 
	                listHtml += '<td>' + docCodeNo + '</td>'; 
	                listHtml += '<td><button class="btn btn-rounded btn-dark rounded-0" id="previewBtn" data-preview="'+ childNode.id +'">미리보기</button></td>';
	                listHtml += '</tr>';
            });
            listHtml += '</tbody></table>';

            $('#listContainer').html(listHtml); // #listContainer에 추가
        }
    });
    
   
    
});


/* 함수 존 */


function delSelectedDoc(){
	var selectedInfo = getSelectedInfo(); // 선택된 정보 가져오기
    console.log("삭제할 문서 정보:", selectedInfo);
    var docNo = selectedInfo[0].docNo;
    
    if (selectedInfo.length === 0) {
        console.log("삭제할 문서가 선택되지 않았습니다.");
        return;
    }
    
    Swal.fire({
        title: '문서 삭제',
        html: '선택한 문서를 삭제하시겠습니까?<br>이 작업은 복구할 수 없습니다.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '삭제',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.isConfirmed) {
            // 확인 버튼이 클릭된 경우, Ajax 요청 보내기
            $.ajax({
                type: "POST",
                url: "/admin/documents/delSelectedDoc",
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ docNo: docNo }),
                success: function(response) {
                    console.log("문서 삭제 성공");
                    selectedInfo.forEach(function(item) {
                        $('input[value="' + item.docNo + '"]').closest('tr').remove(); // 해당 행 삭제
                        
                    });
                    $('#docContent').html('');	//오른쪽 비워줌
                    $('#seletedFormName').text('');
                },
                error: function() {
                    console.log("삭제실패");
                }
            });
        }
    });
}


function getSelectedInfo() {
    var selectedInfo = [];
    $('.doc-chkbox:checked').each(function() {
        var row = $(this).closest('tr');
        var title = row.find('td:nth-child(2)').text();  // 양식제목
        var emplNm = row.find('td:nth-child(3)').text(); // 최종 수정자
        var useYn = row.find('td:nth-child(4)').text(); // 사용 여부
        var docNo = row.find('.doc-chkbox').val();
        selectedInfo.push({
            title: title,
            emplNm: emplNm,
            useYn: useYn,
            docNo: docNo
        });
    });
    return selectedInfo;
}

function drawSelectedInfo(selectedInfo) {
	var docContent = $('#docContent');
    docContent.html('');
    var html = '';
    $('#seletedFormName').text('문서 양식 수정');
    // 폴더 제목 가져오기
    var folderNameText = $('#selectedFolderName').text();
    var folderName = folderNameText.split(': ')[1];
	var btnHtml = '';
    selectedInfo.forEach(function(info) {
    	html += '<table class="table">';
    	html += '<form id="updateForm">';
    	html += '<tr>';
        html += '<td><strong>폴더명: </strong><select class="form-select folder-select" id="folderSelect">';
        html += '<option value="F101" ' + (folderName === '일반' ? 'selected' : '') + '>일반</option>';
        html += '<option value="F102" ' + (folderName === '지원' ? 'selected' : '') + '>지원</option>';
        html += '<option value="F103" ' + (folderName === '인사' ? 'selected' : '') + '>인사</option>';
        html += '<option value="F104" ' + (folderName === '휴가' ? 'selected' : '') + '>휴가</option>';
        html += '</select></td>';
        html += '</tr>';
        html += '<tr>';
        html += '<input type="hidden" id="FormDocCn" val="'+info.docNo+'">';
        html += '<td><strong>양식 제목: </strong><input type="text" class="form-control" id="formTitle" value="' + info.title + '"></td>';
        html += '</tr>';
        html += '<tr>';
        html += '<td><strong>최종 수정자: </strong>' + info.emplNm + '</td>';
        html += '</tr>';
        html += '<tr>';
        html += '<td><strong>양식 편집: </strong> <button class="btn btn-light rounded-0 ms-2" id="docUpdateBtn">양식 편집</button> </td>';
        html += '</tr>';
        html += '<tr>'; 
        html += '<td><strong>사용 여부: </strong><input type="checkbox" id="useYnCheckbox" class="form-check-input primary" ' + (info.useYn === '사용' ? 'checked' : '') + '></td>';
        html += '</tr>';
        html += '</form>';
        html += '</table>';
    });
    var docNo = selectedInfo[0].docNo;
    var hiddenInput = '<input type="hidden" name="docNo" value="' + docNo + '">';
 	$('#updateForm').append(hiddenInput);
 	
    docContent.html(html);
    btnHtml += '<div style="text-align: center;">';
    btnHtml += '<button class="btn btn-rounded btn-light me-3" id="formCancelBtn">취소</button>';
    btnHtml += '<button class="btn btn-rounded btn-primary" id="formSaveBtn">저장</button>';
    btnHtml += '</div>';
	
    docContent.append(btnHtml);
    
}


function selectDocumentsList(){
	$.ajax({
		url: "/admin/documents/doclist",
		type: "get",
		async: false
	})
	.done(function(res){
		
	})
}


function loadDocData() {
    $.ajax({
        url: "/admin/documents/selectdoclist",
        type: "GET",
        dataType: "json",
        success: function(documentsList) {
        	
            // 서버에서 전달받은 JSON 데이터 사용
            var treeData = convertToJstreeFormat(documentsList);
            // jstree 초기화
            $('#tree').jstree({
                "plugins": ["search", "wholerow"],
                "search": {
                    "show_only_matches": true,
                    "show_only_matches_children": true,
                },
                'core': {
                    'data': treeData
                }
            });
        }
    });
}


function fSch() {
    console.log("껌색할께영");
    $('#tree').jstree(true).search($("#schName").val());
}

// jstree의 형식으로 변환
function convertToJstreeFormat(documentsList) {
	var treeData = [];
	for (var i = 0; i < documentsList.length; i++) {
		var document = documentsList[i];
		
		treeData.push({
			"id" : document.id,
			"text" : document.text,
			"parent" : document.parent,
			"docCn" : document.docCn,
			"emplNm" : document.emplNm,
			"useYn"	: document.useYn,
			"docCodeNo" : document.docCodeNo
		});
	}
	console.log('############TreeDATA',treeData);
	return treeData;
}
</script>
</html>