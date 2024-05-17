<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token }" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }" />
</head>

<c:import url="${pageContext.request.contextPath }/WEB-INF/views/part/headerpart.jsp" charEncoding="UTF-8"/>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/modal/interactive-modal.css">
<style>
.transitionDiv {
	transition: width 0.8s, opacity 0.8s;
}
</style>

<script>
function connectionTest() {
	let emplNo = '${employee.emplNo}';
	if(emplNo == null || emplNo.trim() == '') {
		showAlert('서버 오류가 발생하였습니다!', '잠시 후 다시 시도해주세요', 'error')
		.then(result => {
			if(result.isConfirmed) {
				location.href='/';
			}
		});
		
		return;
	}
	return emplNo;
}

$(document).ready(function() {
    /*
		CSRF 토큰 값을 META 데이터에서 받아온다
    */
	header = $('meta[name="_csrf_header"]').attr('content');
	token = $('meta[name="_csrf"]').attr('content');
	
	/*
		모든 ajax 실행 전 RequestHeader에 csrf header값과 token 값을 추가
	*/
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
})
</script>

<div class="card overflow-hidden chat-application">
	<div class="d-flex">
		<div class="w-100 d-none d-lg-block border-end user-chat-box" id="chatBox">
			<div class="px-4 pt-9 pb-6">
				<div class="d-flex align-items-center justify-content-between mb-3">
					<div class="d-flex align-items-center">
						<div class="position-relative">
							<img src="/profile/view/${employee.emplProflPhoto }" alt="user1" width="54" height="54" class="rounded-circle" />
							</span>
						</div>
						<div class="ms-3" id="myStatus">
							<span class="h5 fw-semibold mb-2">${employee.emplNm }</span> <span class="fs-4 fw-semibold">${employee.clsfNm }</span> <span class="ms-2">${employee.deptNm }</span>
							<p class="mb-0 fs-2">${estbs.estbsCn}</p>
						</div>
					</div>
					<div class="ms-auto">
						<a class="chat-menu text-dark px-2 fs-7 bg-hover-primary nav-icon-hover position-relative" href="#" id="groupChat">
							<i class="fa-solid fa-plus fx-2xl fa-fw"></i>
						</a>
					</div>
					<div class="dropdown">
						<a class="text-dark fs-6 nav-icon-hover" href="javascript:void(0)" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="ti ti-dots-vertical"></i>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a class="dropdown-item d-flex justify-content-center align-items-center gap-2 border-bottom" href="javascript:void(0)">
									<span> <input type="button" class="btn btn-sm btn-secondary" id="estbsCnBtn" value="상태메시지 변경" />
									</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row mb-3 ">
				<div class="col-lg-12 col-md-6">
					<div class="card">
						<div class="card-body p-0 m-1">
							<!-- Nav tabs -->
							<ul class="nav nav-pills flex-column flex-sm-row mt-4" role="tablist">
								<li class="nav-item flex-sm-fill text-sm-center" role="presentation">
									<a class="nav-link active" data-bs-toggle="tab" href="#navpill-11" role="tab" aria-selected="true" id="chatList">
										<span> <font style="vertical-align: inherit;"><font style="vertical-align: inherit;">친구목록</font></font>
										</span>
									</a>
								</li>
								<li class="nav-item flex-sm-fill text-sm-center" role="presentation">
									<a class="nav-link" data-bs-toggle="tab" href="#navpill-22" role="tab" tabindex="-1" aria-selected="false" id="talkList">
										<span> <font style="vertical-align: inherit;"><font style="vertical-align: inherit;">대화목록</font></font>
										</span>
									</a>
								</li>
							</ul>
							<!-- Tab panes -->
							<div class="tab-content mt-2">
								<div class="tab-pane p-0 active show" id="navpill-11" role="tabpanel">
									<div class="row">
										<div class="col-md-12 m-0 p-0">
											<div class="m-2">
												<div class="position-relative m-1 mb-2" id="chatSearchArea">
													<input type="text" class="form-control search-chat py-2 ps-5" id="chatSearch" placeholder="검색어를 입력하세요..." />
													<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
												</div>
												<hr class="m-1 mb-2" />
												<div class="app-chat" style="height: 500px; overflow-y: auto;">
													<ul class="chat-users mb-0">
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane p-3" id="navpill-22" role="tabpanel">
									<div class="row">
										<div class="col-md-12 m-0 p-0">
											<div class="m-2">
												<form class="position-relative m-1 mb-2">
													<input type="text" class="form-control search-chat py-2 ps-5" id="talkSearch" placeholder="검색어를 입력하세요..." />
													<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
												</form>
												<hr class="m-1 mb-2" />
												<div class="app-talk" style="height: 500px; overflow-y: auto;">
													<ul class="talk-users mb-0">
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="w-75 w-xs-100 chat-container" id="talkBox">
			<div class="chat-box-inner-part h-100">
				<div class="chatting-box d-block">
					<div class="p-9 border-bottom chat-meta-user d-flex align-items-center justify-content-between">
						<div class="hstack gap-3 current-chat-user-name">
							<div class="position-relative">
								<img src="${pageContext.request.contextPath}/resources/vendor/images/profile/user-2.jpg" alt="user1" width="48" height="48" class="rounded-circle" />
								</span>
							</div>
							<div class="ms-3 d-inline-block w-75" id="status" data-emplno="" data-groupno="">
								<span class="h5 mb-1 name fw-semibold"></span> <span class="fs-4 fw-semibold"></span> <span class="ms-2"></span> <span class="mb-0 d-inline-block w-75"></span>
							</div>
						</div>
						<ul class="list-unstyled mb-0 d-flex align-items-center">
							<li>
								<a class="chat-menu text-dark px-2 fs-7 bg-hover-primary nav-icon-hover position-relative z-index-5" href="#" id="fileBox">
									<i class="ti ti-menu-2"></i>
								</a>
							</li>
						</ul>
					</div>
					<div class="d-flex parent-chat-box app-chat-right">
						<div class="chat-box w-xs-100">
							<div class="chat-box-inner p-9" style="overflow-y: auto;">
								<div class="chat-list chat active-chat" data-user-id="1"></div>
							</div>
							<div class="px-9 py-6 border-top chat-send-message-footer">
								<div class="d-flex align-items-center justify-content-between">
									<div class="d-flex align-items-center gap-2 w-85">
										<input type="text" class="form-control message-type-box text-muted border-0 p-0 ms-2" placeholder="메세지를 입력하세요..." fdprocessedid="0p3op" />
									</div>
									<ul class="list-unstyledn mb-0 d-flex align-items-center">
										<li>
											<input type="file" name="files" id="file" multiple style="display: none;">
											<label for="file"> <a class="text-dark px-2 fs-7 bg-hover-primary nav-icon-hover position-relative z-index-5">
													<i class="ti ti-paperclip"></i>
												</a>
											</label>
										</li>
									</ul>
								</div>
							</div>
						</div>

					</div>

				</div>
			</div>
		</div>
		<div class="offcanvas offcanvas-start user-chat-box chat-offcanvas" tabindex="-1" id="chat-sidebar" aria-labelledby="offcanvasExampleLabel">
			<div class="offcanvas-header">
				<h5 class="offcanvas-title" id="offcanvasExampleLabel">Chats</h5>
				<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="px-4 pt-9 pb-6">
				<div class="d-flex align-items-center justify-content-between mb-3">
					<div class="d-flex align-items-center">
						<div class="position-relative">
							<img src="${pageContext.request.contextPath}/resources/vendor/images/profile/user-1.jpg" alt="user1" width="54" height="54" class="rounded-circle" />
							</span>
						</div>
						<div class="ms-3">
							<h6 class="fw-semibold mb-2">Mathew Anderson</h6>
							<p class="mb-0 fs-2">Designer</p>
						</div>
					</div>
					<div class="dropdown">
						<a class="text-dark fs-6 nav-icon-hover" href="javascript:void(0)" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="ti ti-dots-vertical"></i>
						</a>
						<ul class="dropdown-menu">
							<li>
								<a class="dropdown-item d-flex align-items-center gap-2 border-bottom" href="javascript:void(0)">
									<span> <i class="ti ti-settings fs-4"></i>
									</span> Setting
								</a>
							</li>
							<li>
								<a class="dropdown-item d-flex align-items-center gap-2" href="javascript:void(0)">
									<span> <i class="ti ti-help fs-4"></i>
									</span> Help and feadback
								</a>
							</li>
							<li>
								<a class="dropdown-item d-flex align-items-center gap-2" href="javascript:void(0)">
									<span> <i class="ti ti-layout-board-split fs-4"></i>
									</span> Enable split View mode
								</a>
							</li>
							<li>
								<a class="dropdown-item d-flex align-items-center gap-2 border-bottom" href="javascript:void(0)">
									<span> <i class="ti ti-table-shortcut fs-4"></i>
									</span> Keyboard shortcut
								</a>
							</li>
							<li>
								<a class="dropdown-item d-flex align-items-center gap-2" href="javascript:void(0)">
									<span> <i class="ti ti-login fs-4"></i>
									</span> Sign Out
								</a>
							</li>
						</ul>
					</div>
				</div>
				<form class="position-relative mb-4">
					<input type="text" class="form-control search-chat py-2 ps-5" id="text-srh" placeholder="Search Contact" />
					<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
				</form>
				<div class="dropdown">
					<a class="text-muted fw-semibold d-flex align-items-center" href="javascript:void(0)" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						Recent Chats <i class="ti ti-chevron-down ms-1 fs-5"></i>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="javascript:void(0)">Sort by time</a>
						</li>
						<li>
							<a class="dropdown-item border-bottom" href="javascript:void(0)">Sort by Unread</a>
						</li>
						<li>
							<a class="dropdown-item" href="javascript:void(0)">Hide favourites</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>

<div id="estbsModal" class="interactive-modal">
	<div class="container interactive-modal-content" style="width:30% !important;">
		<div class="row">
			<div class="col-md-12" id="modalContent">
				<div class="input-group" id="estbsContent">
					<input type="text" class="form-control" id="modalText" placeholder="변경하고자 하는 상태메시지를 입력해주세요..." value="${estbs.estbsCn }">
					</p>
					<button class="btn  btn-sm btn-secondary" id="modalConfirm">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="imageModal" class="interactive-modal">
	<div class="container interactive-modal-content">
		<div class="row">
			<div class="col-md-12" id="imageModalContent"></div>
		</div>
	</div>
</div>

<div id="groupModal" class="interactive-modal">
	<div class="container interactive-modal-content" style="width: 500px;">
		<div class="row">
			<div class="col-md-12" id="groupModalContent">
				<div class="d-flex justify-content-end align-items-center">
					<button class="btn rounded-0 mb-3" style="border: 1px solid #ddd;" id="testBtn">시연용 버튼</button>
				</div>
				<div style="height: 500px; overflow-y: auto;">
					<table class="table">
						<thead>
							<tr class="text-center align-middle">
								<th>
									<input type="checkbox" id="selectAll" class="form-check-input">
								</th>
								<th>사진</th>
								<th>이름</th>
								<th>직급</th>
								<th>부서</th>
							</tr>
						</thead>
						<tbody id="tableContent">
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-end align-items-center mt-2">
					<div class="input-group">
						<input type="text" class="form-control rounded-0" placeholder="그룹 채팅방 제목을 입력해주세요..." id="title">
						<input type="button" class="btn btn-primary rounded-0" id="groupModalConfirmBtn" value="초대">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="fileBoxModal" class="interactive-modal" style="z-index: 0;">
	<div class="container interactive-modal-content">
		<div class="row">
			<div class="col-md-12" id="fileBoxModalContent" style="height: 600px; overflow-y: auto;">
				<div class="card">
					<div class="card-header">
						<span class="h3 text-center">파일 서랍함</span>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-lg-6 col-md-3" id="imageDiv">
								<div class="p-3 d-flex align-items-center justify-content-between">
									<h6 class="fw-semibold mb-0 text-nowrap">
										이미지 <span class="text-muted" id="imageLength"></span>
									</h6>
									<a href="#">
										<i class="fa-solid fa-angles-right fa-xl fa-fw fw-bold"></i>
									</a>
								</div>
								<div class="row mb-7 text-nowrap" id="imgArea" style="overflow: auto;"></div>
							</div>
							<div class="col-lg-6 col-md-3" id="fileDiv">
								<div class="files-chat">
									<div class="p-3 d-flex align-items-center justify-content-between">
										<h6 class="fw-semibold mb-0 text-nowrap">
											파일 <span class="text-muted" id="fileLength"></span>
										</h6>
										<a href="#">
											<i class="fa-solid fa-angles-right fa-xl fa-fw fw-bold"></i>
										</a>
									</div>
									<div class="files-chat" id="fileArea"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<c:import url="${pageContext.request.contextPath }/WEB-INF/views/part/footerpart.jsp" charEncoding="UTF-8"/>
	<!-- 브라우저 호환성을 위한 sockJS 추가 -->
	<script src="${pageContext.request.contextPath}/resources/project/js/source/sockjs.min.js"></script>
	<script>
	
	var outsideLink = false;
	
	function isOutsideLink() {
		let url = new URL(window.location.href);
		let no = url.searchParams.get('emplNo');
		if(no != undefined) {
			outsideLink = true;
		}
		
		if(outsideLink) {
			let chatUsers = document.querySelectorAll('.chat-users > li a');
			for(let i = 0; i<chatUsers.length; i++) {
				let targetNo = chatUsers[i].getAttribute('data-emplno');
				if(targetNo == no) {
					setTimeout(function() {
						chatUsers[i].click();
					}, 100);
					break;
				}	
			}
		}
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	var viewFlag = true;
	var area = document.querySelector('.chat-list');
	var chatUsers = $('.chat-users');
	var talkUsers = $('.talk-users');
	var chatList = $('#chatList');
	var talkList = $('#talkList');
	var fileBtn = $('#file');
	
	var estbsCnBtn = document.getElementById('estbsCnBtn');
	var modalBtn = document.getElementById("modalBtn");
	var modal = document.getElementById("estbsModal");
	
	var groupModal = document.getElementById("groupModal");
	var groupModalConfirmBtn = document.getElementById('groupModalConfirmBtn');
	
	var chatBox = $('#chatBox');
	var talkBox = $('#talkBox');
	
	var chatSearch = $('#chatSearch');
	var talkSearch = $('#talkSearch');
	
	var oldChatText = '';
	var oldTalkText = '';
	
	var groupChatBtn = $('#groupChat');
	var fileBoxBtn = $('#fileBox');
	var fileBoxModal = document.getElementById("fileBoxModal");
	
	var fileDiv = $('#fileDiv');
	var imageDiv = $('#imageDiv');
	
	var imageModal = document.getElementById("imageModal");
	
	var imageWidth = 0;
	var fileWidth = 0;
	
	getChatList();
	talkBox.hide();
	
	/* 이미지 클릭 시 썸네일 모달 출력 */
	$('#imgArea').on('click', 'a img', function(e) {
		if($(this).attr('src')) {
			e.preventDefault();
			let src = $(this).attr('src')
			toggleImageModal();
			$(imageModal).css('z-index', 1);
			$('#imageModalContent').append($('<img>').attr('src', src).addClass('img-fluid img-thumbnail'));
		}
	});
	
	<!-- 파일 서랍함 애니메이션 효과 이벤트 (이미지영역) -->
	imageDiv.on('click', '.fa-solid', function(e) {
		let width = fileDiv.innerWidth();
		
		if(width > 560) {
			fileDiv.animate({
				width: '0',
				opacity: '0'
			},800, function() {
				fileDiv.hide();
				imageDiv.addClass('transitionDiv');
				imageDiv.toggleClass('col-lg-6 col-lg-12');
				imageDiv.toggleClass('col-md-3 col-md-6');
				setTimeout(function() {
					imageDiv.removeClass('transitionDiv');			
				}, 800)
			});
			imageWidth = width;
		}else{
			fileDiv.show();
			imageDiv.addClass('transitionDiv');
			imageDiv.toggleClass('col-lg-6 col-lg-12');
			imageDiv.toggleClass('col-md-3 col-md-6');
			fileDiv.animate({
				width: imageWidth,
				opacity: "1.0"
			}, 800, function() {
				fileDiv.removeAttr("style");
				setTimeout(function() {
					imageDiv.removeClass('transitionDiv');			
				}, 800)
			});
		}
	});
	
	<!-- 파일 서랍함 애니메이션 효과 이벤트 (파일영역) -->
	fileDiv.on('click', '.fa-solid', function() {
		
		let width = imageDiv.innerWidth();
		
		if(width > 560) {
			imageDiv.animate({
				width: '0',
				opacity: '0'
			},800, function() {
				imageDiv.hide();
				fileDiv.addClass('transitionDiv');
				fileDiv.toggleClass('col-lg-6 col-lg-12');
				fileDiv.toggleClass('col-md-3 col-md-6');
				
				setTimeout(function() {
					fileDiv.removeClass('transitionDiv');			
				}, 800)
			});
			fileWidth = width;
		}else{
			imageDiv.show();
			fileDiv.addClass('transitionDiv');
			fileDiv.toggleClass('col-lg-6 col-lg-12');
			fileDiv.toggleClass('col-md-3 col-md-6');
			imageDiv.animate({
				width: fileWidth,
				opacity: "1.0"
			}, 800, function() {
				imageDiv.removeAttr("style");
				setTimeout(function() {
					fileDiv.removeClass('transitionDiv');			
				}, 800)
			});
		}
	
	});
	
	/* FontAwesome 애니메이션 클래스 동적으로 추가하는 이벤트 */
	$('.fa-solid').on('mouseenter', function() {
		$(this).addClass('fa-beat');
	}).on('mouseleave', function() {
		$(this).removeClass('fa-beat');
	})
	
	/* 채팅 영역 애니메이션 이벤트 */
	function viewTalkBox() {
		if(viewFlag){
			chatBox.fadeOut('fast', function() {
				chatBox.removeClass('w-100').addClass('w-25').fadeIn('slow');
				talkBox.fadeIn('slow');
			});
			viewFlag = !viewFlag;
		}
	}
	
	/* 이미지 모달 및 상태메시지 변경 모달 */
	function toggleModal() {
		modal.classList.toggle("show");
		if(!$(modal).hasClass('show')){
			setTimeout(function() {
				$(modal).find('img').remove();
			}, 200);
		}
	}
	
	/* 그룹 채팅방 생성 모달 */
	function toggleGroupModal() {
		groupModal.classList.toggle("show");
	}
	
	$('#testBtn').on('click', function() {
		let target = $('#tableContent').find('input[type="checkbox"]');
		let targetTable = [20240087, 20240083, 20240077, 20240061];
		for(let i = 0; i < target.length; i++) {
			let targetNo = $(target[i]).data('no');
			if(targetTable.includes(targetNo)) {
				$(target[i]).attr('checked', true);	
			}
		}
		$('#title').val('홈페이지 개편 프로젝트 단체 채팅방');		
	});
	
	/* 파일 서랍함 모달 */
	function toggleFileBoxModal() {
		fileBoxModal.classList.toggle("show");
	}
	
	/* 이미지 박스 모달 */
	function toggleImageModal() {
		imageModal.classList.toggle("show");
		if(!$(imageModal).hasClass('show')) {
			setTimeout(function() {
				$(imageModal).find('img').remove();
			}, 200);
		}
	}
	
	/* 상태메시지 변경 버튼 이벤트 */
	estbsCnBtn.addEventListener("click", function() {
		$('#estbsContent').show();
		toggleModal();
	});
	
	/* 상태메시지 수정 버튼 이벤트 */
	$('#modalConfirm').on('click', function() {
		let estbsCn = $('#modalText').val();
		
		$.ajax({
			url: '/chat/modify',
			type: 'POST',
			contentType: 'application/json; charset=UTF-8',
			data: JSON.stringify(
				{
					estbsCn : estbsCn,
					emplNo : '${employee.emplNo}'
				}
			)
		})
		.done(function(res) {
			$('#myStatus').find('p').text(res);
			toggleModal();
			$('#estbsContent').hide();
		})
	});
	
	/* 모달 바깥 쪽 클릭 시 모달을 닫히게 하는 이벤트 */
	window.addEventListener("click", function (event) {
		if (event.target === modal) {
			$('#estbsContent').hide();
			toggleModal();
		}
		
		if (event.target === fileBoxModal) {
			toggleFileBoxModal();
		}
		
		if (event.target === imageModal) {
			toggleImageModal();
		}
		
		if(event.target === groupModal) {
			toggleGroupModal();
		}
	});
	  
	var socket = null;
	connect();
	
	/* WebSocket 연결 */
	function connect() {
		var sock = new SockJS('//${pageContext.request.serverName}:${pageContext.request.serverPort}/chat');
		socket = sock;
	}
	
	/* 스크롤 애니메이션 이벤트 */
	chatUsers.animate({
		scrollTop: chatUsers.prop('scrollHeight')
	}, 500);
	
	/* 친구 탭에 있는 유저 클릭시 발생하는 이벤트 */
	chatUsers.on('click', 'li a', function(e) {
		viewTalkBox();
		
		let no = $(this).data('emplno');
		let name = $(this).find('.emplNm').text();
		let clsf = $(this).find('.clsf').text();
		let dept = $(this).find('.dept').text();
		let statusMsg = $(this).find('.statusMsg').text().trim();
		let profile = $(this).find('.profile').attr('src');
		
		$('.current-chat-user-name').find('.rounded-circle').attr('src', '${pageContext.request.contextPath}' + profile);
		$('#status').find('span').eq(0).text(name);
		$('#status').find('span').eq(1).text(clsf);
		$('#status').find('span').eq(2).text(dept);
		$('#status').find('span').eq(3).text(statusMsg);
		$('#status').data('emplno', no);
		
		let groupNo = groupCreate(no);
		
		socket.send(JSON.stringify({
			mssagGroupNo: groupNo,
			emplNo : ${employee.emplNo},
			type: 'enter'
		}));
		
		getChatHistory(groupNo);
		getFileList(groupNo);
	});
	
	/* 대화목록 탭에 있는 유저 클릭시 발생하는 이벤트 */
	talkUsers.on('click', 'li a', function(e) {	
		let groupNo = $(this).data('groupno');
		
		socket.send(JSON.stringify({
			mssagGroupNo: groupNo,
			emplNo : '${employee.emplNo}',
			type: 'enter'
		}));
		
		$.ajax({
			url: '/chat/talk/${employee.emplNo}?groupNo='+groupNo,
			type: 'get',
		})
		.done(function(res) {
			viewTalkBox();
			let profileImg = '/profile/view/'+res.emplProflPhoto;
			/* 단톡 이미지 */
			if(!res.emplProflPhoto) {
				profileImg = '${pageContext.request.contextPath}/resources/project/images/logo/CHAT_LOGO.jpg';
			}
			
			$('#status').siblings('div').first().find('img').attr('src', profileImg);
			
			if(res.emplNm == null || res.emplNm == undefined) {
				$('#status').find('span').eq(0).text(res.mssagGroupNm);
				$('#status').find('span').eq(1).text('');
				$('#status').find('span').eq(2).text('');
				$('#status').find('span').eq(3).text('');
				$('#status').data('groupno', res.mssagGroupNo);
				getChatHistory(res.mssagGroupNo);
				return;
			}
			let statusMsg = res.estbs_cn;
			
			if(statusMsg == null) {
				statusMsg = '';
			}
			
			$('#status').find('span').eq(0).text(res.emplNm);
			$('#status').find('span').eq(1).text(res.clsfCode);
			$('#status').find('span').eq(2).text(res.deptCode);
			$('#status').find('span').eq(3).text(statusMsg);
			$('#status').data('emplno', res.emplNo);
			$('#status').data('groupno', res.mssagGroupNo);
			
			console.log('emplNo : ' + $('#status').data('emplno'));
			console.log('groupNo : ' + $('#status').data('groupno'));
			
			getChatHistory(groupNo);
			getFileList(groupNo);
		});
	});
	
	/* 친구 탭 클릭시 발생하는 이벤트 */
	chatList.on('click', function() {
		getChatList();
	});
	
	/* 대화목록 탭 클릭시 발생하는 이벤트 */
	talkList.on('click', function() {
		getTalkList();
	});
	
	/* 메시지 송신 이벤트 */
	document.querySelector('.message-type-box').addEventListener('keydown', function(e) {
		if(e.key === 'Enter'){
// 	        // Start getting time
// 	        var now = new Date();
// 	        var hh = now.getHours();
// 	        var min = now.getMinutes();
// 	        var ampm = hh >= 12 ? "오후 " : "오전 ";
// 	        hh = hh % 12;
// 	        hh = hh ? hh : 12;
// 	        hh = hh < 10 ? "0" + hh : hh;
// 	        min = min < 10 ? "0" + min : min;
// 	        var time = ampm + hh + ":" + min;
// 	        // End
		
		var message = this.value;
		if (message === "") {
		    return;
		}
		this.value = '';
		scrollToBottom();
		const obj = {
			emplNo : '${employee.emplNo}',
			mssagGroupNo : $('#status').data('groupno'),
			mssagCn : message
		};
		
		socket.send(JSON.stringify(obj));
		}
	});
	
	socket.onopen = function() {
		console.log('[CONNECTION OPEN]');
		setTimeout(function() {
			isOutsideLink();
		},100);
	};
	
	socket.onmessage = function(message) {
		console.log(message);
		let msg = JSON.parse(message.data);
		let html;
		if(msg.type == 'upload'){
			createFileHTML(msg);
			return;			
		}else if(msg.type == 'update'){
// 			updateReadCount();
			return;
		}
		
		if(msg.emplNo == '${employee.emplNo}') {
			html = createSenderHTML(msg);
		}else{
			html = createRecipientHTML(msg);
		}
		
		area.insertAdjacentHTML('beforeend', html);
		
		scrollToBottom();
	};
	
	socket.onclose = function() {
		console.log('[CONNECTION CLOSE]');
	};
	
	socket.onerror = function(err) {
		console.error('[ERROR] : ' + err);
	};
	
	talkBox.on('click', 'a', function(e) {
		if(e.target.src) {
			e.preventDefault();
			console.log(e.target.href);
				
			let src = $(this).children().eq(0).attr('src');
			$('#estbsContent').hide();
			
			toggleModal();
			$('#modalContent').append($('<img>').attr('src', src).addClass('img-fluid img-thumbnail'));
		}
	});
	
	chatSearch.on('propertychange change keyup paste input', function() {
		let query = $(this).val();
		
		if(query == oldChatText) {
			return;
		}
		
		oldChatText = query;
		
		getChatList(query);
	});
	
	talkSearch.on('propertychange change keyup paste input', function() {
		let query = $(this).val();
		
		if(query == oldTalkText) {
			return;
		}
		
		oldTalkText = query;
		
		getTalkList(query);
	});
	
	fileBoxBtn.on('click', function() {
		toggleFileBoxModal();
		let groupNo = $('#status').data('groupno');
		getFileList(groupNo);
	});
	
	groupChatBtn.on('click', function() {
		$.ajax({
			url: '/chat/chatlist?emplNo=${employee.emplNo}',
			type: 'get'
		})
		.done(function (res) {
			let tableContent = $('#tableContent');
			tableContent.html('');
			
			for(let i in res) {
				
				let html = '';
				
				html += '      <tr class="text-center align-middle">';
				html += '        <td>';
				html += '          <input type="checkbox" data-no="'+res[i].emplNo+'" name="select" class="form-check-input">';
				html += '        </td>';
				html += '        <td>';
				html += '          <img src="/profile/view/'+res[i].emplProflPhoto+'" class="img-fluid rounded-circle round-50">';
				html += '        </td>';
				html += '        <td>';
				html += '          <span>'+res[i].emplNm+'</span>';
				html += '        </td>';
				html += '        <td>';
				html += '          <span>'+res[i].clsfCode+'</span>';
				html += '        </td>';
				html += '        <td>';
				html += '          <span>'+res[i].deptCode+'</span>';
				html += '        </td>';
				html += '      </tr>';
				
				tableContent.append(html);
			}
			
			toggleGroupModal();
		});
	});
	
	$('#groupModalContent').on('change', 'input[type="checkbox"]', function() {
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
	
	groupModalConfirmBtn.addEventListener('click', function() {
		let checkedEl = $('#tableContent').find('input[name=select]:checked');
		let element = [];
		let title = $('#title').val();
		
		if(!title) {
			showToast('방 제목을 입력해주세요!', 'error');
			return false;
		}
		
		if(checkedEl.length < 2) {
			showToast('두 명 이상 선택해주세요!', 'error');
			return false;
		}
		
		for(let el of checkedEl) {
			element.push($(el).data('no'));
		}
		
		element.push(${employee.emplNo});
		
		$.ajax({
			url: '/chat/group/'+title,	
			type: 'post',
			data: JSON.stringify(element),
			contentType: 'applicaiton/json; charset=UTF-8'
		})
		.done(function(res){
			let selectEl = $('#tableContent').find('input[name=select]');
			for(let el of selectEl) {
				$(el).prop('checked', false);
			}
			let groupNo = res.mssagGroupNo;
			
			$('#status').data('groupno', groupNo);
			$('#status').data('groupTypeCode', res.mssagGroupTypeCode);
			$('#status').find('span').eq(0).text(res.temp);
			
			console.log($('#status').data('groupno'));
			console.log($('#status').data('groupTypeCode'));
			
			socket.send();
			
			let profileImg = '${pageContext.request.contextPath}/resources/project/images/logo/CHAT_LOGO.jpg';
			$('#status').siblings('div').first().find('img').attr('src', profileImg);
			
			toggleGroupModal();
			viewTalkBox();
			getChatHistory(groupNo);
		});
	});
	
	fileBtn.on('change', function(event) {
		let files = event.target.files;
		let formData = new FormData();
		
		for (let i in files) {
			let file = files[i];
			formData.append('files', file);
		}
		
		$.ajax({
			url: '/chat/talk/file',
			type: 'post',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data: formData,
			processData: false,
			contentType: false,
		})
		.done(function(res) {
			
			let obj = {
				emplNo : '${employee.emplNo}',
				mssagGroupNo : $('#status').data('groupno'),
				mssagCn : res,
				type: 'upload'
			}
			
			socket.send(JSON.stringify(obj));
		});
	});
	
});
	
// function updateReadCount() {
// 	let readCount= $('span[name="readCount"]')
// 	for(let ele of readCount) {
// 		if(ele.textContent != 0) {
// 			ele.textContent = ele.textContent - 1;
// 		}
// 	}
// }

function getChatHistory(groupNo) {
	let emplNo = ${employee.emplNo};
	let area = $('.chat-list');
	area.html('');
	
	let obj = {
		emplNo : emplNo,
		mssagGroupNo: groupNo
	}
	
	$.get('/chat/talk/history', obj)
	.done(function (res) {
		console.log(res);
		
		for(let i in res) {
			let msg = {
				emplNm : res[i].emplNm,
				emplProflPhoto: res[i].emplProflPhoto,
				mssagCn : res[i].mssagCn,
				rgsde : res[i].rgsde,
				atchFileGroupNo : res[i].atchFileGroupNo,
				readCount : res[i].readCount
			}
			
			let html = '';
			if(res[i].emplNo == emplNo) {
				msg.emplNo = emplNo;
				html = createSenderHTML(msg);
			}else{
				msg.emplNo = res[i].emplNo;
				html = createRecipientHTML(msg);
			}
			
			area.append(html);
		}
		
		setTimeout(function() {
			let target = $('.chat-box-inner');
			target.scrollTop(target.prop('scrollHeight'));
		}, 200);
	});
}

function getFileList(groupNo) {
	$.get('/chat/talk/file/'+groupNo)
	.done(function(res) {
		let imageFileList = res[0];
		let fileList = res[1];
		
		if(fileList.length != 0) {
			let fileArea = $('#fileArea');
			let imageArea = $('#imgArea');
			
			imageArea.html('');
			fileArea.html('');
			
			$('#fileLength').html('('+fileList.length+')');
			let count = 0;
			for(let file of fileList) {
				let html = '';
				
				html += '<a href="/chat/download?path='+file.mssagCn+'" class="hstack gap-3 file-chat-hover justify-content-between text-nowrap mb-9">';
				html += '	<div class="d-flex align-items-center gap-3">';
				html += '		<div class="rounded-1 text-bg-light p-6">';
				html += '			<img src="${pageContext.request.contextPath}/resources/vendor/images/chat/icon-adobe.svg" alt="" width="24" height="24" />';
				html += '		</div>';
				html += '		<div>';
				html += '			<h6 class="fw-semibold">'+file.atchFileOrnlFileNm+'</h6>';
				html += '			<div class="d-flex align-items-center gap-3 fs-2 text-muted">';
				html += '				<span>'+file.atchFileFancysize+'</span>';
				html += '				<span>'+dateFormat(file.rgsde)+'</span>';
				html += '			</div>';
				html += '		</div>';
				html += '	</div>';
				html += '	<span class="position-relative nav-icon-hover download-file">';
				html += '		<i class="ti ti-download text-dark fs-6 bg-hover-primary"></i>';
				html += '	</span>';
				html += '</a>';
				
				fileArea.append(html);
				
				count++;
				if(count == 7) {
					break;
				}
			}
		}
		
		if(imageFileList.length != 0) {
			let imgArea = $('#imgArea');
			imgArea.html('');
			$('#imageLength').html('('+imageFileList.length+')');
			let count = 0;
			for (let image of imageFileList) {
				let html = '';
				
				html += '<div class="col-lg-6 col-md-3 mb-2">';
				html += '	<a href="#">';
				html += '		<img src="/chat/displayFile?path='+image.mssagCn+'" alt="" class="rounded img-fluid" />';
				html += '	</a>';
				html += '</div>';
				
				imgArea.append(html);
				count++;
				if(count == 4) {
					break;
				}
			}
		}
	})
}

function getChatList(query) {
	let url = '/chat/chatlist?emplNo=${employee.emplNo}';
	if(query != undefined) {
		url += '&emplNm='+query;	
	}
	$.get(url)
	.done(function(res){
		$('.chat-users').html('');
		let area = document.querySelector('.chat-users');
		for(let i in res) {
			let statusMsg = res[i].estbsCn;
			if(statusMsg == null) {
				statusMsg = '';
			}
			
			if(statusMsg.length > 25) {
				statusMsg = statusMsg.substring(0, 25) + '..';
			}
			
			let html = '';
		
			html += '<li>';
			html += '	<a href="javascript:void(0)" class="px-4 py-3 bg-hover-light-black d-flex align-items-start justify-content-between chat-user bg-light-subtle" id="chat_user_1" data-emplno="'+res[i].emplNo+'">';
			html += '		<div class="d-flex align-items-center">';
			html += '			<span class="position-relative">';
			html += '				<img src="/profile/view/'+res[i].emplProflPhoto+'" alt="user1" width="48" height="48" class="rounded-circle profile" />';
			html += '					<span class="visually-hidden">New alerts</span>';
			html += '				</span>';
			html += '			</span>';
			html += '			<div class="ms-3 d-inline-block w-75 info">';
			html += '				<span class="h5 mb-1 fw-semibold chat-title emplNm" data-username="'+res[i].emplNm+'">'+res[i].emplNm+'</span>';
			html += '				<span class="fs-4 fw-semibold clsf">'+res[i].clsfCode+'</span>';
			html += '				<span class="ms-2 dept">'+res[i].deptCode+'</span>';
			html += '				<span class="fs-3 text-truncate text-body-color d-block statusMsg">';
			html += '					'+statusMsg+'';					
			html += '				</span>';
			html += '			</div>';
			html += '		</div>';
			html += '	</a>';
			html += '</li>';
			
			area.insertAdjacentHTML('beforeend', html);
			
		}
	});
}

function getTalkList(query) {
	let url = '/chat/talklist?emplNo=${employee.emplNo}';
	
	if(query != undefined) {
		url += '&emplNm='+query;
	}
	
	$.get(url)
	.done(function(res) {
		$('.talk-users').html('');
		let area = document.querySelector('.talk-users');
		
		for(let i in res) {
			let html = '';
			
			let msg = res[i].mssagCn;
			if(msg == null || msg.trim() == '') {
				msg = '';
			}
			
			if(msg.length > 25) {
				msg = msg.substring(0, 25) + '...';
			}
			
			let src = '/profile/view/'+res[i].emplProflPhoto+'';
			
			if(!res[i].emplProflPhoto) {
				src = '${pageContext.request.contextPath}/resources/project/images/logo/CHAT_LOGO2.jpg';	
			}
		
			html += '<li class="border">';
			html += '	<a href="javascript:void(0)" class="px-4 py-3 bg-hover-light-black d-flex align-items-start justify-content-between chat-user bg-light-subtle" id="chat_user_1" data-groupno="'+res[i].mssagGroupNo+'">';
			html += '		<div class="d-flex align-items-center flex-fill">';
			html += '			<span class="position-relative">';
			html += '				<img src="'+src+'" alt="user1" width="48" height="48" class="rounded-circle" />';
			html += '					<span class="visually-hidden">New alerts</span>';
			html += '				</span>';
			html += '			</span>';
			html += '			<div class="ms-3 d-inline-block w-75">';
			html += '				<span class="h5 mb-1 fw-semibold chat-title" data-username="'+res[i].mssagGroupNm+'">'+res[i].mssagGroupNm+'</span>';
			html += '				<span class="fs-3 text-truncate text-body-color d-block">';
			html += '					'+msg+'';	
			html += '				</span>';
			html += '			</div>';
			html += '		</div>';
			html += '		<p class="fs-2 mb-0 text-muted">'+res[i].msgRgsde+'</p>';
			html += '	</a>';
			html += '</li>';
		
			area.insertAdjacentHTML('beforeend', html);
		}
	});
}

function groupCreate(emplNo) {
	let obj = { my : '${employee.emplNo}', friend : emplNo};
	let groupNo = 0;
	$.ajax({
		url: '/chat/create',
		type: 'post',
		async: false,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		contentType: 'application/json; charset=UTF-8',
		data: JSON.stringify(obj)
	})
	.done(function(res){
		$('#status').data('groupno', res);
		groupNo = res;
	});
	
	return groupNo;
}

function createFileHTML(msg) {
	let area = $('.chat-list');
	let emplNo = ${employee.emplNo};
	
	console.log(msg);
		
	let html = '';
	if(emplNo == msg.emplNo) {
		html += '<div class="text-end mb-3" data-id="'+msg.emplNo+'"> ';
		html += '	<div class="p-2 bg-info-subtle text-dark rounded-1 d-inline-block fs-3">';
		html += '	<div class="p-2 text-bg-light rounded-1 d-inline-block text-dark fs-3" style="max-width:350px;">';
		
		let fileName = msg.mssagCn.split('_')[1];
		
		if(isImageFile(msg.mssagCn)){
			html += '			<a data-fslightbox href="/chat/displayFile?path='+msg.mssagCn+'">';
			html += '				<img src="/chat/displayFile?path='+msg.mssagCn+'" class="img-fluid img-thumbnail">';
			html += '			</a>';	
		}else{
			html += '			<a href="/chat/download?path='+msg.mssagCn+'" class="img-fluid img-thumbnail">'+fileName+'</a>';			
		}
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="d-block fs-2">';
		html += '		'+ msg.rgsde +'';
		html += '	</div>';
		html += '</div>';
		
		area.append(html);
	}else{
		html += '<div class="hstack gap-3 align-items-start mb-7 justify-content-start" data-id="'+msg.emplNo+'">';
		html += '	<img src="/profile/view/'+msg.emplProflPhoto+'" alt="user8" width="40" height="40" class="rounded-circle" />';
		html += '	<div>';
		html += '		<div class="p-2 text-bg-light rounded-1 d-inline-block text-dark fs-3">';
		
		let fileName = msg.mssagCn.split('_')[1];
		
		if(isImageFile(msg.mssagCn)){
			html += '			<a data-fslightbox href="/chat/displayFile?path='+msg.mssagCn+'">';
			html += '				<img src="/chat/displayFile?path='+msg.mssagCn+'" class="img-fluid img-thumbnail" style="max-width: 350px;">';
			html += '			</a>';
		}else{
			html += '			<a href="/chat/download?path='+msg.mssagCn+'" class="img-fluid img-thumbnail">'+fileName+'</a>';			
		}
		html += '		</div>';
		html += '		<h6 class="fs-2 text-muted">'+msg.rgsde+'</h6>';
		html += '	</div>';
		html += '</div>';
		
		area.append(html);
	}
	
	scrollToBottom();
}

function createRecipientHTML(msg) {
	let html = '';
	let img = '';
	let rgsde = dateFormat(msg.rgsde);
		html += '<div class="hstack gap-3 align-items-start mb-7 justify-content-start" data-id="'+msg.emplNo+'">';
		html += '	<div>'
		html += '		<img src="/profile/view/'+msg.emplProflPhoto+'" alt="user8" width="40" height="40" class="rounded-circle" />';
		html += '		<h6 class="mt-2 fw-semibold">'+msg.emplNm+'</h6>';
		html += '	</div>'
		html += '	<div>';
	if(msg.atchFileGroupNo > 0) {
		
		let fileName = msg.mssagCn.split('_')[1];
		
		if(isImageFile(msg.mssagCn)){
			html += '			<a data-fslightbox href="/chat/displayFile?path='+msg.mssagCn+'" onclick="return false;">';
			html += '				<img src="/chat/displayFile?path='+msg.mssagCn+'" class="img-fluid img-thumbnail" style="max-width:300px;">';
			html += '			</a>';	
		}else{
			html += '			<a href="/chat/download?path='+msg.mssagCn+'" class="img-fluid img-thumbnail">'+fileName+'</a>';			
		}
	}else{
		html += '		<div class="text-bg-light rounded-1 d-inline-block text-dark fs-3" style="padding:9px; max-width: 600px;">'+msg.mssagCn+'</div>';
	}
	html += '		<h6 class="fs-2 text-muted my-2"><span name="readCount" class="" data-read-id="'+msg.emplNo+'">'+rgsde+'<span class="text-warning fw-bold ms-2"></span></h6>';
	html += '	</div>';
	html += '</div>';
	
	return html;
}

function createSenderHTML(msg) {
	let rgsde = dateFormat(msg.rgsde);
	let html = '';
	html += '<div class="text-end mb-3" data-id="'+msg.emplNo+'"> ';
	if(msg.atchFileGroupNo > 0) {
		html += '	<div class="p-2 bg-info-subtle text-dark rounded-1 d-inline-block fs-3" style="max-width:300px;">';
		
		let fileName = msg.mssagCn.split('_')[1];
		
		if(isImageFile(msg.mssagCn)){
			html += '			<a data-fslightbox href="/chat/displayFile?path='+msg.mssagCn+'">';
			html += '				<img src="/chat/displayFile?path='+msg.mssagCn+'" class="img-fluid img-thumbnail">';
			html += '			</a>';		
		}else{
			html += '			<a href="/chat/download?path='+msg.mssagCn+'" class="img-fluid img-thumbnail">'+fileName+'</a>';			
		}
	}else{
		html += '	<div class="p-2 bg-info-subtle text-dark rounded-1 d-inline-block fs-3" style="text-align: justify; max-width: 600px;">';
		html += '		'+ msg.mssagCn +'';
	}
	
	html += '	</div>';
	html += '	<div class="d-block fs-2"><span name="readCount" class="text-warning fw-bold me-2" data-read-id="'+msg.emplNo+'"></span>';
	html += '		'+ rgsde +'';
	html += '	</div>';
	html += '</div>';
	
	return html;
}

function dateFormat(rgsde) {
	let time = rgsde.split(' ')[1];
	let hours = time.split(':')[0];
	let minutes = time.split(':')[1];
	let period = hours <= 12 ? "오전" : "오후";
	
	hours = hours % 12 || 12;
	hours = hours < 10 ? "0" + hours : hours;
	
	return period + ' ' + hours + ":" + minutes;
}

function isImageFile(fileName) {
	let pattern = /jpg|jpeg|gif|png/i;
	return fileName.match(pattern);
}

function scrollToBottom(){
	let area = $('.chat-box-inner');
	$('.chat-box-inner').animate({
		scrollTop: area.prop('scrollHeight')
	});
}
</script>