<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
/* textarea의 크기를 조정합니다. */
textarea {
	width: calc(100% - 20px); /* 가로 크기: 부모 요소의 너비에서 20px만큼 빼서 꽉 차게 설정 */
	max-width: 100%; /* 최대 가로 너비는 부모 요소의 너비 */
	height: 100px; /* 세로 크기: 100px */
}

.replyInput {
	/* 	  position: relative; /* 요소의 위치를 상대적으로 설정합니다. */ */
	/*   top: 50px; /* 원하는 위치로 이동합니다. */ */
	
}

.txtContent {
	background: white;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.card {
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}

.card:hover {
	transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
}
/* .card { */
/*     border: none; /* 테두리 제거 */
*
/
/*     margin-top: 20px; /* 원하는 마진 설정 */
 
*
/
/* } */
</style>

<c:set var="badge" value="text-bg-primary" />
<c:if test="${boardVO.bbsNm eq '공지사항' }">
	<c:set var="badge" value="text-bg-danger" />
</c:if>

<div class="card rounded-2 overflow-hidden">
	<div class="card-body p-4">
		<span class="badge ${badge } fs-5 rounded-4 py-1 px-2 lh-sm mt-3">${boardVO.bbsNm }</span>
		<h2 class="fs-9 fw-semibold my-4">${boardVO.bbscttTitle }</h2>
		<div class="d-flex align-items-end gap-4">
			<div class="d-flex align-items-end gap-2">
				<img src="/profile/view/${boardVO.emplProflPhoto}" class="rounded-circle" width="64" height="64" />
				<span class="fw-semibold fs-5">${boardVO.emplNm}</span>
			</div>
			<div class="d-flex align-items-center ms-auto">
				<i class="ti ti-eye text-dark fs-5"> ${boardVO.bbscttRdcnt }</i>
			</div>
			<div class="d-flex align-items-center ms-2">
				<i class="ti ti-message-2 text-dark fs-5"> ${answerCount}</i>
			</div>
			<div class="d-flex align-items-center fs-5">
				<i class="ti ti-point text-dark">${boardVO.rgsde }</i>
			</div>
		</div>
	</div>
	<div class="card-body border-top p-4" style="min-height: 500px;">
		<div style="padding-left: 20px; font-size: 18px;">
			<p class="mb-3 ">${boardVO.bbscttCn }</p>
		</div>
		<c:set value="${atchFileList}" var="atchFileList" />
		<c:if test="${not empty atchFileList }">
			<hr />
			<div class="col-md-12">
				<div class="row">
					<div class="d-flex justify-content-start">
						<c:forEach items="${atchFileList }" var="boardFile">
							<p class="mb-0 text-xs font-weight-bolder text-info text-uppercase">
								<button type="button" class="btn btn-primary btn-sm fileDownload ms-2" data-file-no="${boardFile.atchFilePath }" title="다운로드">
									<h6>${boardFile.atchFileOrnlFileNm }(${boardFile.atchFileFancysize })</h6>
								</button>
							</p>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</div>
<div class="">
	<c:if test="${boardVO.bbsNo ne '1'}">
		<div class="card-body2">
			<h4 class="mb-4 fw-semibold">댓글 작성</h4>
			<input type="hidden" name="answerBbscttNo" id="answerBbscttNo" value="${boardVO.bbscttNo }" />
			<div class="d-flex justify-content-between align-items-end">
				<textarea class="flex-fill form-control bg-white rounded-0 w-75" style="resize: none;" name="content" id="content" rows="6"></textarea>
				<button type="button" class="btn ms-2 rounded-0 btn-primary" id="answerBtn">작성하기</button>
			</div>
			<sec:csrfInput />
			<div class="d-flex align-items-center gap-3 mb-4 mt-7 pt-8">
				<h4 class="mb-0 fw-semibold">댓글</h4>
				<!-- 			<span class="badge bg-primary-subtle text-primary fs-4 fw-semibold px-6 py-8 rounded">달린 댓글 수</span> -->
			</div>


			<div class="position-relative answerList" id="answerList">
				<c:forEach items="${answerList }" var="answer">
					<c:if test="${answer.delYn eq 'N' }">
						<div class="p-4 rounded-2 text-bg-light mb-3 answerArea" id="answerArea">
							<div class="d-flex align-items-center gap-3">
								<img src="/profile/view/${answer.emplProflPhoto}" alt="" class="rounded-circle" width="33" height="33">
								<h6 class="fw-semibold mb-0 fs-4">${answer.answerNm }</h6>
								<!-- 							<span class="p-1 text-bg-muted rounded-circle d-inline-block"></span> -->
							</div>
							<div id="answerContent" class="answerContent" style="font-size: 18px;">
								<p class="my-3">${answer.replyCn }</p>
							</div>

							<div class="answerInfo d-flex justify-content-center aling-items-center">
								<c:if test="${employee.emplNo eq answer.emplNo}">
									<button type="button" class="btn btn-sm btn-warning rounded-0 answerUpdateBtn" id="answerUpdateBtn" data-answer-no="${answer.answerNo }" data-del-yn="${answer.delYn }">수정하기</button>
									<button type="button" class="btn btn-sm btn-danger rounded-0 answerDeleteBtn ms-3" id="answerDeleteBtn" data-answer-no="${answer.answerNo }" data-del-yn="${answer.delYn }">삭제하기</button>
								</c:if>
								<a class="text-bg-info p-2 fs-4 reply ms-auto" href="javascript:void(0)" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Reply" data-answerno="${answer.answerNo }">
									<i class="ti ti-arrow-back-up"></i>
								</a>
							</div>
							<div class="answerModifyArea d-flex justify-content-center align-items-end my-1 d-none"">
								<textarea class="flex-fill form-control bg-white rounded-0 w-75" style="resize: none;" name="content" id="content" rows="6"></textarea>
								<button type="button" class="btn ms-2 rounded-0 btn-primary answerBtn" id="">확인</button>
								<button type="button" class="btn ms-2 rounded-0 btn-danger cancelBtn" id="">취소</button>
							</div>
							<div class="replyContArea d-flex justify-content-center align-items-center" style="margin-top: 10px;"></div>
							<div class="replyListArea" style="margin-top: 10px;"></div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</c:if>
</div>
<div class="d-flex justify-content-end align-items-end">
	<button type="submit" class="btn btn-dark rounded-0 me-2" id="listBtn">목록</button>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<c:if test="${boardVO.bbsNo ne '1'}">
			<button type="button" id="modifyBtn" class="btn btn-dark rounded-0 me-2">수정</button>
			<input type="button" id="deleteBtn" class="btn btn-danger rounded-0 me-2" data-bbscttno="${boardVO.bbscttNo}" value="삭제">
		</c:if>
	</sec:authorize>
	<form action="board/delete" method="post" id="delForm">
		<input type="hidden" name="bbscttNo" id="bbscttNo" value="${boardVO.bbscttNo }" />
		<sec:csrfInput />
	</form>
</div>

<script type="text/javascript">	

	let listBtn = $("#listBtn");
	let modifyBtn = $('#modifyBtn');
	let deleteBtn = $('#deleteBtn');
	let delForm = $('#delForm');
	
	<!-- 게시글 목록버튼 -->
	listBtn.on("click", function() {
		location.href = "/board";
	});
	
	<!-- 게시글 수정버튼 -->
	modifyBtn.on('click', function() {
		delForm.attr('method', 'get');
		delForm.attr('action', 'update');
		delForm.submit();
	});
	
	<!-- 게시글 삭제버튼 -->
	deleteBtn.on('click', function() {
		if (confirm('정말로 삭제하시겠습니까?')) {
			var bbscttNo = $(this).data('bbscttno');

			$.ajax({
				url : '/board/delete?bbscttNo=' + bbscttNo,
				type : 'POST', // POST 메서드 사용
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(response) {
					console.log('삭제되었습니다.');
					location.href = '/board';
				},
				error : function(xhr, status, error) {
					console.error('삭제 중 오류가 발생했습니다.');
					console.error(xhr.responseText);
				}
			});
		}
	});
	

	<!-- 파일 다운로드 -->
// 	$(".fileDownload").on("click",function() {
// 		var filepath = $(this).data("file-no");
// 		console.log(filepath);
// 		location.href = "/download?path=" + filepath + "&${_csrf.parameterName}=${_csrf.token}";
// 	});
	$(".fileDownload").on("click", function() {
	    var fileNo = $(this).data("file-no");
	    console.log(fileNo);
	    location.href = "/download?fileNo=" + fileNo + "&${_csrf.parameterName}=${_csrf.token}";
	});
		
	<!-- 수정 폼 중복 방지 플래그 -->
	var updateFlag = true;
	var replyUpdateFlag = true;

	<!-- 대댓글 작성 열고 닫기 이벤트 -->
	$("#answerList").on("click",".reply",function() {
		var thisClass = $(this).parent('div').next().next();
		$(this).parent('div').siblings('.replyListArea').html('');
		
		if(thisClass.attr('class').includes("open")){
			thisClass.children().remove();
			thisClass.removeClass('open');
			return;
		}
		
		var pno = $(this).data("answerno");
		console.log('parent >>', $(this).parent("div"));
		selectReply($(this).parent("div"), pno);
		
		var html = "";
		html += "<textarea id='replyInput' class='replyInput form-control rounded-0 bg-white' cols='50' rows='4' placeholder='댓글을 작성해주세요...' name='replyTextarea' style='resize:none;'></textarea>";
		html += '<div class="ms-2" style="width:15% !important">';
		html += '	<button type="button" class="btn btn-primary w-100 p-2 mt-2 rounded-0 replyInpBtn" data-no="'+pno+'">등록</button>';
		html += '</div>';
		
		console.log('test >>', $(this).parent('div'));
		console.log('test >>', $(this).parent('div').siblings().eq(3));
		$(this).parent('div').siblings().eq(3).html(html);

		thisClass.addClass('open');
	});
	
	<!-- 대댓글 작성 닫기 이벤트 --> 
	$("#answerList").on("click",".close",function() {
		let ancestor = $(this).parent('div').parent('div');
		ancestor.children().remove();
		$(this).toggleClass('open').toggleClass('close');
		ancestor.removeClass('open');
	});
	
	<!-- 댓글 작성  이벤트 -->
	let answerBtn = $('#answerBtn');
	answerBtn.on('click', function() {

		var bbscttNo = $('input[name="answerBbscttNo"]').val();
		var content = $('#content').val();
		var answerNo = $('#content').val();
		var data = {
			bbscttNo : bbscttNo,
			replyCn : content,
		};

		$.ajax({

			url : '/answer/insert',
			type : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json; charset=utf-8',
		})
		.done(function (response) {
			showToast('댓글이 성공적으로 작성되었습니다.', 'success');
			selectAnswer();
			$('#content').val('');
		});		
	});
	
	<!-- 댓글 수정 폼 이벤트 -->
	$('#answerList').on('click','.answerUpdateBtn',function() {
		console.log(updateFlag);
		
		if (updateFlag) {
			updateFlag = false;
			
			$(this).parent('div').next().toggleClass('d-none');
			var originalContent = $(this).parent('div').prev().text().trim();
			$(this).parent('div').siblings('.answerModifyArea').find('textarea').text(originalContent);
		}else{
			showAlert('수정중인 댓글이 존재합니다!', '', 'warning');
		}
	});
	
	<!-- 댓글 수정 이벤트 -->
	$('#answerList').on('click', '.answerBtn', function() {
		let editedContent = $(this).siblings('textarea').val().trim();
		let bbscttNo = $('input[name="answerBbscttNo"]').val();
		let answerNo = $(this).parent('div').prev().find('.answerUpdateBtn').data('answerNo');
		
		let data = {
			bbscttNo : bbscttNo,
			replyCn : editedContent,
			answerNo : answerNo
		};
		
		$(this).parents('.answerContent').text(editedContent);
		
		$.ajax({
			url : '/answer/update', // 수정 요청을 처리하는 서버 엔드포인트
			method : 'POST', // POST 요청
			data : JSON.stringify(data), // 수정된 내용을 데이터로 전송
			contentType : "application/json; charset=utf-8"
		})
		.done(function (response) {
			showToast('댓글이 성공적으로 수정되었습니다.', 'success');
			updateFlag = true;
			selectAnswer();
		})
	});
	
	<!-- 댓글 수정 취소 이벤트 -->
	$('#answerList').on('click', '.cancelBtn', function() {
		console.log($(this).parent());
		$(this).parent('div').remove();
		updateFlag = true;
		selectAnswer();
	});
	
	<!-- 댓글 삭제 이벤트 -->
	$('#answerList').on('click', ".answerDeleteBtn", function() {
		
		showConfirm('정말 삭제하시겠습니까?', '삭제하면 복구 할 수 없습니다!', 'error')
		.then(result => {
			if(result.isConfirmed) {
		
				let answerNo = $(this).data('answerNo');
				var bbscttNo = $('input[name="answerBbscttNo"]').val();
				var data = {
					bbscttNo : bbscttNo,
					answerNo : answerNo
				};
				
				$.ajax({
					url : '/answer/delete', // 삭제 요청을 처리하는 서버 엔드포인트
					method : 'POST', // POST 요청
					data : JSON.stringify(data), // 수정된 내용을 데이터로 전송
					contentType : "application/json; charset=utf-8",
				})
				.done(function (res){
					selectAnswer();
					showToast('댓글이 성공적으로 삭제되었습니다.', 'success');
				})
		
			}
		})
	});
	
	<!-- 대댓글 작성 이벤트 -->
	$("#answerList").on("click",".replyInpBtn",function(e) {
		// 내용
		var content = $(this).parent('div').siblings('textarea').val();
		
		// 게시글 번호
		var bbscttNo = $('input[name="answerBbscttNo"]').val();
		
		// 댓글 번호
		var pno = $(this).data("no");
		
		$.ajax({
			url : '/answer/insert2',
			type : 'POST',
			data : JSON.stringify({
				bbscttNo : bbscttNo,
				replyCn : content,
				upperAnswerNo : pno
			}),
			contentType : 'application/json; charset=utf-8'
		})
		.done(function(response) {
			console.log('parent2 >>', $(e.target).parent().parent("div"));
			selectReply($(e.target).parent().parent("div"), pno);
			$('#replyInput').val('');
			showToast('댓글이 성공적으로 작성되었습니다.', 'success');
		});
	});
	
	<!-- 대댓글 수정  폼 그려주기 -->
	$('#answerList').on('click','.replyUpdateBtn',function() {
		
		if(replyUpdateFlag) {
			replyUpdateFlag = false;
			
			let txt = $(this).prev().text();
			let answerNo = $(this).data('answerNo');
			
			let textarea = document.createElement('textarea');
			let updateButton = document.createElement('button');
			let cancelButton = document.createElement('button');
			
			textarea.classList.add('form-control', 'rounded-0', 'bg-primary-subtle', 'border-primary', 'mb-2');
			textarea.style.resize = 'none';
			textarea.style.marginTop = '10px';
			textarea.value = txt;
			
			updateButton.classList.add('btn', 'btn-warning', 'rounded-0', 'replyConfirmBtn');
			updateButton.textContent = '확인';
			updateButton.dataset.answerNo = answerNo;
			
			cancelButton.classList.add('btn', 'btn-danger', 'rounded-0', 'ms-2', 'replyCancelBtn');
			cancelButton.textContent = '취소';
			cancelButton.dataset.answerNo = answerNo;
			
// 			let div = document.createElement('div');
// 			div.classList.add('mt-2');
// 			let jDiv = $(div);
			
// 			let parent = $(this).parent('div'); 
			let parent = $(this).parent('.cancelDiv'); 
			
			cancelItem = parent.children('div').siblings().remove();
			parent.append(textarea).append(updateButton).append(cancelButton);
// 			jDiv.append(textarea).append(updateButton).append(cancelButton);
		}
	});
	
	var cancelItem;
	<!-- 대댓글 확인 이벤트-->
	$('#answerList').on('click','.replyConfirmBtn',function() {
		let answerNo = $(this).data('answerNo');
		let replyCn = $(this).siblings('textarea').val();
		
		let data = {
			replyCn : replyCn,
			answerNo : answerNo
		}
		
		let el = $(this).parent().parent().parent().parent();
		console.log("**",el); //answerArea
		
		let pno = $(this).parent().parent().parent().parent().find('.answerInfo').find('.answerUpdateBtn').data('answerNo');
		console.log("***",$(this).parent().parent().parent().parent().find('.answerInfo').find('.answerUpdateBtn').data('answerNo'));
		
		let replyListArea = $(this).parent().parent().parent();
		console.log("*",replyListArea);
		
		$.ajax({
			url : '/answer/update2', // 수정 요청을 처리하는 서버 엔드포인트
			method : 'POST', // POST 요청
			data : JSON.stringify(data), // 수정된 내용을 데이터로 전송
			contentType : "application/json; charset=utf-8",
		})
		.done(function(response) {
			replyUpdateFlag = true;
			showToast('댓글이 성공적으로 수정되었습니다.', 'success');
// 			selectReply(el, pno);
			selectReply(replyListArea, pno);
		})
	});
	
	<!-- 대댓글 삭제 이벤트-->
	$('#answerList').on('click', ".replyDeleteBtn", function(e) {
		var answerNo = $(this).data('answerNo');
		var data = {
			answerNo : answerNo,
		};
		
		let el = $(this).parent().parent().parent().parent();
		let pno = $(this).parent().parent().parent().parent().find('.answerInfo').find('.answerUpdateBtn').data('answerNo');
		
		$.ajax({
			url : '/answer/delete2', // 삭제 요청을 처리하는 서버 엔드포인트
			method : 'POST', // POST 요청
			data : JSON.stringify(data), // 수정된 내용을 데이터로 전송
			contentType : "application/json; charset=utf-8"
		})
		.done(function(res) {
			showToast('댓글이 성공적으로 삭제되었습니다.', 'success');
			selectReply(el, pno);
		});
	});
	
	<!-- 취소 이벤트-->
	$('#answerList').on('click', ".replyCancelBtn", function(e) {
		
		e.preventDefault();
// 		$('.cancelDiv')
// 		console.log("@@@@@@",$('.cancelDiv:not(:first-child)').html());
		var parent = $(this).parent(".cancelDiv");
		$(this).parent().children('div').siblings().remove();
		parent.append(cancelItem);
		console.log();
		replyUpdateFlag = true;
			
	});
	
	function selectAnswer() {
		var bbscttNo = $('input[name="answerBbscttNo"]').val();
		$.ajax({
			url : '/answer?bbscttNo=' + bbscttNo,
			type : 'get',
			contentType : "application/json; charset=utf-8"
		})
		.done(function (response) {
			let str = '';
			if (response != null) 
				str = createAnswerHTML(response);
			
			$("#answerList").html(str);
		});
	}
	
	function selectReply(ele, pno) {

		var bbscttNo = $('input[name="answerBbscttNo"]').val();
		var upperAnswerNo = pno;
		let str = "";
		
		$.ajax({
			url : '/answer/reply?upperAnswerNo=' + upperAnswerNo,
			type : 'get',
			contentType : "application/json; charset=utf-8"
		})
		.done(function (response){
// 			console.table(response);
			let str = '';
			str = createReplyHTML(response);
			console.log("$$$",ele);// ele=answerArea
			$(ele).parent().find('.replyListArea').html(str);
// 			$(ele).parent().children('.replyListArea').html(str);
			
// 			$(".replyList").html(str);
		});
	}
	
	function createReplyHTML(response) {
		let str = '';
		
		for (var i = 0; i < response.length; i++) {
			
			var delYn = response[i].delYn;
			
			if (delYn != "Y" ){
				
				str += '<div class="p-4 rounded-2 text-bg-light mb-3 ms-7 cancelDiv" style="position:relative;">';
				str += '	<div class="d-flex align-items-center gap-3">';
				str += '		<img src="/profile/view/'+response[i].emplProflPhoto+'" alt="" class="rounded-circle" width="40" height="40">';
				str += '		<h6 class="fw-semibold mb-0 fs-4">'+ response[i].answerNm + '</h6>';
// 				str += '		<span class="p-1 text-bg-muted rounded-circle d-inline-block"></span>';
				str += '	</div>';
				str += '	<p class="my-3 replyContent " id="replyContent" style="font-size:18px;">'+ response[i].replyCn + '</p>';
				
				if('${employee.emplNo}' == response[i].emplNo){
					str +=  '<div class="d-flex justify-content-end align-items-end">';
					str +=	'<button type="button" class="btn btn-warning rounded-0 ms-2 replyUpdateBtn " id="replyUpdateBtn" data-answer-no="'+response[i].answerNo+'">수정하기</button>';
					str +=	'<button type="button" class="btn btn-danger rounded-0 ms-2 replyDeleteBtn" id="replyDeleteBtn" data-answer-no="'+response[i].answerNo+'" data-del-yn="'+response[i].delYn+'">삭제하기</button>';
					str +=  '</div>'
 				}
				str += '</div>';
			}
		}
		
		return str;
	}
	
	function createAnswerHTML(response) {
		let str = '';
		
		for (var i = 0; i < response.length; i++) {
			str += '<div class="p-4 rounded-2 text-bg-light mb-3 answerArea" id="answerArea">';
			str += '	<div class="d-flex align-items-center gap-3">';
			str += '		<img src="/profile/view/'+response[i].emplProflPhoto+'" alt="" class="rounded-circle" width="33" height="33">';
			str += '		<h6 class="fw-semibold mb-0 fs-4">';
			str += '			<div>' + response[i].answerNm + '</div>';
			str += '		</h6>';
			//str += '		<span class="p-1 text-bg-muted rounded-circle d-inline-block"></span>';
			str += '	</div>';
			str += '	<p class="my-3">' + response[i].replyCn + '</p>';
					
				str += '	<div class="answerInfo d-flex justify-content-center aling-items-center">                                                                         ';
			if ('${employee.emplNo}' == response[i].emplNo) {
				str += '		<button type="button" class="btn btn-sm btn-warning rounded-0 answerUpdateBtn" id="answerUpdateBtn" data-answer-no="'+response[i].answerNo+'"">수정하기</button>';
				str += '		<button type="button" class="btn btn-sm btn-danger rounded-0 answerDeleteBtn ms-3" id="answerDeleteBtn" data-answer-no="'+response[i].answerNo+'"">삭제하기</button> ';
			}
				str += '		<a class="text-bg-info p-2 fs-4 reply ms-auto" href="javascript:void(0)" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Reply" data-answerno="'+response[i].answerNo+'">             ';
				str += '			<i class="ti ti-arrow-back-up"></i>                                                                                                                                                  ';
				str += '		</a>                                                                                                                                                                                     ';
				str += '	</div>                                                                                                                                                                                       ';
				str += '	<div class="answerModifyArea d-flex justify-content-center align-items-end my-1 d-none"">                                                                                                    ';
				str += '		<textarea class="flex-fill form-control bg-white rounded-0 w-75" style="resize: none;" name="content" id="content" rows="6"></textarea>                                                           ';
				str += '		<button type="button" class="btn ms-2 rounded-0 btn-primary answerBtn" id="">확인</button>                                                                                  ';
				str += '		<button type="button" class="btn ms-2 rounded-0 btn-danger cancelBtn" id="">취소</button>                                                                                  ';
				str += '	</div>                                                                                                                                                                                       ';
				str += '	<div class="replyContArea d-flex justify-content-center align-items-center" style="margin-top: 10px;">                                                                                       ';
				str += '	</div>';
				str += '	<div class="replyListArea" style="margin-top: 10px;">';
				str += '	</div>';
			
			str += '</div>';
		}
		
		return str;
	}
</script>