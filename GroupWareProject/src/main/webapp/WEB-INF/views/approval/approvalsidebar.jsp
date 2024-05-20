<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/ui.fancytree.min.css">
<div class="d-flex w-100">
	<div class="left-part border-end w-15 flex-shrink-0 d-none d-lg-block">
		<div class="px-9 pt-4 pb-3">
			<a href="/approval">
				<h3 class="font-weight-bold mb-4" style="margin-left: 10px;">
				<i class="fa-sharp fa-regular fa-file-signature fa-fw fa"></i>
				전자결재
				</h3>
			</a>
			<button class="btn btn-outline-light-indigo text-dark fw-semibold rounded-0 py-8 w-100" id="approval-btn">새 결재 진행</button>
		</div>
		<div class="d-flex justify-content-center align-items-center ">
			<div class="accordion accordion-flush w-75 flex-fill" id="accordionPanelsStayOpenExample">
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="false" aria-controls="panelsStayOpen-collapseOne">
							<span class="font-weight-bold">자주 쓰는 양식</span>
						</button>
					</h2>
					<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body">
							<div class="ms-3" id="bookmark-area"></div>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
						<button class="accordion-button show" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo">
							<span class="font-weight-bold">결재하기</span>
						</button>
					</h2>
					<div id="panelsStayOpen-collapseTwo" class="accordion-collapse show" aria-labelledby="panelsStayOpen-headingTwo">
						<div class="accordion-body">
							<div class="ms-3 content-area">
								<a href="/approval/list/all">
									<p>
										결재 대기 문서
										<span class="text-primary" id="allCnt"></span>
									</p>
								</a>
								<a href="/approval/list/viewer">
									<p>
										참조 대기 문서
										<span class="text-primary" id="viewerCnt"></span>
									</p>
								</a>
								<a href="/approval/list/upcoming">
									<p>
										결재 예정 문서
										<span class="text-primary" id="approveCnt"></span>
									</p>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingThree">
						<button class="accordion-button show" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="true" aria-controls="panelsStayOpen-collapseThree">
							<span class="font-weight-bold">개인문서함</span>
						</button>
					</h2>
					<div id="panelsStayOpen-collapseThree" class="accordion-collapse show" aria-labelledby="panelsStayOpen-headingThree">
						<div class="accordion-body">
							<div class="ms-3 content-area">
								<a href="/approval/doclist/draft/all">
									<p>기안 문서함</p>
								</a>
								<a href="/approval/doclist/draft/temp">
									<p>임시 저장함</p>
								</a>
								<a href="/approval/doclist/draft/approve">
									<p>결재 문서함</p>
								</a>
								<a href="/approval/doclist/draft/viewer">
									<p>참조 문서함</p>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingFour">
						<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour">
							<span class="font-weight-bold">부서문서함</span>
						</button>
					</h2>
					<div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingFour">
						<div class="accordion-body">
							<div class="ms-3 content-area">
								<a href="#">
									<p>기안 완료함</p>
								</a>
								<a href="#">
									<p>부서 참조함</p>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingFive">
						<button class="accordion-button show" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="true" aria-controls="panelsStayOpen-collapseFive">
							<span class="font-weight-bold">환경설정</span>
						</button>
					</h2>
					<div id="panelsStayOpen-collapseFive" class="accordion-collapse show" aria-labelledby="panelsStayOpen-headingFive">
						<div class="accordion-body">
							<div class="ms-3 content-area">
								<a href="/approval/option">
									<p>서명 관리</p>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="approval-modal" class="interactive-modal" style="z-index: 1;">
		<div class="interactive-modal-content modal-config">
			<header class="position-relative p-4">
				<h5 class="font-weight-bold">결재양식 선택</h5>
				<a href="#" class="position-absolute fa-active" data-exit="approval">
					<i class="fa-regular fa-xmark fa-fw fa-xl fa"></i>
				</a>
			</header>
			<div class="d-flex justify-content-end align-items-center">
				<button class="btn btn-outline-muted rounded-0 p-1" id="docBookMark">자주 쓰는 양식으로 추가</button>
			</div>
			<div class="row mt-2">
				<div class="col-md-5" id="">
					<div class="searchInput input-group">
						<input type="text" id="search-input" class="form-control rounded-0" maxlength="20" placeholder="양식제목" />
						<button type="button" class="btn btn-dark bg-dark rounded-0">
							<i class="fa-light fa-magnifying-glass fa-xl fa-fw"></i>
						</button>
					</div>
					<div id="tree" style="height: 300px;"></div>
				</div>
				<div class="col-7 doc-detail" id="">
					<div class="card rounded-0">
						<div class="p-2 approval-gray border-bottom">
							<span class="text-start font-weight-bold text-dark m-2">상세정보</span>
						</div>
						<div class="card-body rounded-0 p-0">
							<table class="table table-borderless text-center align-middle">
								<tr>
									<th>제목</th>
									<td data-title=""></td>
								</tr>
								<tr class="">
									<th>전사문서함</th>
									<td>문서함</td>
								</tr>
								<tr class="">
									<th>기안부서</th>
									<td>
										<select name="" id="" class="form-select rounded-0">
											<option value="">ThinkLink</option>
										</select>
									</td>
								</tr>
								<tr class="">
									<th>부서문서함</th>
									<td>
										<select name="" id="" class="form-select rounded-0">
											<option value="">미지정</option>
										</select>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="footer text-end doc-footer mt-3">
				<a href="#" class="btn btn-secondary rounded-0" id="actionBtn">
					<span>확인</span>
				</a>
				<a href="#" class="btn btn-muted rounded-0 ms-2" id="cancelBtn">
					<span>취소</span>
				</a>
			</div>
		</div>
	</div>

	<script src="${pageContext.request.contextPath }/resources/project/js/source/jquery.fancytree-all-deps.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/project/js/approval/approval-modal.js"></script>

	<script>
	
	getDocumentsCount();
	getDocumentsBookmark();
	
	var bookMarkArea = $('#bookmark-area');
	
	function getDocumentsBookmark() {
		let emplNo = connectionTest();
		$.get('/approval/doc/bookmark?emplNo='+emplNo)
		.done(function(res) {
			res.forEach(doc => {
				let html = createBookmarkHTML(doc);
				bookMarkArea.append(html);
			})
		});
	}
	
	function createBookmarkHTML(doc) {
		let html = '';
		
		html += '<div class="d-flex justify-content-between align-items-center my-2">'
		html += '	<a href="/approval/form?docNo='+doc.docNo+'">';
		html += '		<span>'+doc.docNm+'</span>';
		html += '	</a>';
		html += '	<span style="cursor: pointer;" data-del="'+doc.docNo+'"><i class="fa-sharp fa-regular fa-xmark fa-fw"></i></span>';
		html += '</div>'
		
		return html;
	}
	
	bookMarkArea.on('click', '[data-del]', function(e) {
		let delNo = $(this).data('del');
		let emplNo = connectionTest();
		let target = $(this).parent();
		if(delNo) {
			$.post('/approval/doc/del', {docNo : delNo, emplNo : emplNo})
			.done(function(res) {
				if(res == 'OK') {
					target.remove();
					showToast('즐겨찾기가 삭제되었습니다!');
				}
			})
		}
	})
	
	function getDocumentsCount() {
		let emplNo = connectionTest();
		$.ajax({
			url: '/approval/listcount',
			type: 'get',
			data: {emplNo : emplNo},
			dataType: 'json'
		})
		.done(function(res) {
			
			for (let data of res) {
				let type = data.TYPE;
				
				if(type == 'all') {
					$('#allCnt').text('('+data.CNT+')');
				}else if(type == 'viewer'){
					$('#viewerCnt').text('('+data.CNT+')');
				}else{
					$('#approveCnt').text('('+data.CNT+')')
				}
			}
			
		})
	}
		
	function selectDocList() {
		$.ajax({
			url: '/admin/documents/doclist',
			type: 'get',
			async: false
		})
		.done(function(res) {
			console.log(res);
			renderTreeView(res);
		});
	}
	
	function renderTreeView(res) {
		let source = [];
		treeData = res;
		
		treeData.forEach(tree => {
			const newTree = {
			  title: tree.docTypeNm,
			  key: tree.docTypeCode,
			  folder: true,
			  children: []
			};
		  
			const exist = source.findIndex(data => data.title === newTree.title);
		  
			if(exist === -1) {
				source.push(newTree);
			}
		  
			source.forEach(data => {
				if(data.title === newTree.title) {
					data.children.push({
					  title: tree.docNm,
					  key: `\${tree.docTypeCode}.\${tree.docNo}`
					});
				}
			});
			
			console.log(source);
		});
		
		$("#tree").fancytree({
			activeVisible : true, // Make sure, active nodes are visible (expanded)
			autoActivate : true, // Automatically activate a node when it is focused using keyboard
			checkbox : false, // Show check boxes
			icon : true, // Display node icons
			keyboard : true, // Support keyboard navigation
			clickFolderMode : 2, // 1:activate, 2:expand, 3:activate and expand, 4:activate (dblclick expands)
			selectMode : 3, // 1:single, 2:multi, 3:multi-hier
			debugLevel : 2, // 0:quiet, 1:errors, 2:warnings, 3:infos, 4:debug
			filter : {
				highlight : true, // Highlight matches by wrapping inside 
				mode : "hide" // Grayout unmatched nodes (pass "hide" to remove unmatched node instead)
			},
			source : source,
			
			click: function(event, data) {
				var node = data.node;
				if(!node.folder){
					let title = document.querySelector('[data-title]');
					title.textContent = node.title;
				}
			}
		});
	}
</script>