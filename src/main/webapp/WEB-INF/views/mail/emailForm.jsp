<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
.w-16 {
	width: 16% !important;
}
/* 일반 페이지 버튼 스타일 */
.page-item .page-link {
  color: #333 !important;
  background-color: #fff !important;
  border-color: #ddd !important;
  border-radius: 0 !important;
}

/* 현재 페이지 버튼 스타일 */
.page-item.active .page-link {
  color: #fff !important;
  background-color: #007bff !important;
  border-color: #007bff !important;
  border-radius: 0 !important;
}

.form-check-input {
	border-radius: 0 !important;
}

.btn-primary {
	background-color: #007bff; /* 기본 배경 색상 */
}

.btn-primary:hover {
	background-color: #339cff; /* 마우스를 올렸을 때의 배경 색상 */
}

.btn-primary:active {
	background-color: #0056b3; /* 버튼을 눌렀을 때의 배경 색상 */
}
</style>
<link rel="stylesheet" href="${pageContex.request.contextPath }/resources/project/css/source/select2.min.css">

<c:set value="" var="title" />
<c:set value="" var="emailNo" />
<c:set value="0" var="atchFileGroupNo" />
<c:choose>
	<c:when test="${status eq 'r'}">
		<c:set value="RE: ${reEmail.emailNm}" var="title" />
	</c:when>
	<c:when test="${status eq 'f'}">
		<c:set value="FW: ${reEmail.emailNm}" var="title" />
		<c:set value="${reEmail.atchFileGroupNo}" var="atchFileGroupNo" />
	</c:when>
	<c:when test="${status eq 'd'}">
		<c:set value="${reEmail.emailNm}" var="title" />
		<c:set value="${reEmail.emailNo}" var="emailNo" />
		<c:set value="${reEmail.atchFileGroupNo}" var="atchFileGroupNo" />
	</c:when>
</c:choose>

<div class="card overflow-hidden chat-application">
	<div class="d-flex align-items-center justify-content-between gap-6 m-3 d-lg-none">
		<button class="btn btn-primary d-flex" type="button" data-bs-toggle="offcanvas" data-bs-target="#chat-sidebar" aria-controls="chat-sidebar">
			<i class="ti ti-menu-2 fs-5"></i>
		</button>
		<form class="position-relative w-100">
			<input type="text" class="form-control search-chat py-2 ps-5" id="text-srh" placeholder="Search Contact">
			<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
		</form>
	</div>
	<div class="d-flex w-100">
		<div class="left-part border-end w-16 flex-shrink-0 d-none d-lg-block h-auto">
			<div class="px-9 pt-4 pb-3">
				<a href="/mail/inbox">
				<h3 class="fw-semibold mb-8" style="margin-left: 10px;"><i class="fa-sharp fa-regular fa-envelope fa-fw fa"></i>&nbsp;&nbsp;메일</h3>
			</a>
				<button class="btn btn-primary fw-semibold rounded-0 py-8 w-100" style="margin-top: 20px;" onclick="location.href='/mail/emailForm'">메일 쓰기</button>
			</div>
			<ul class="list-group mh-n100" data-simplebar>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/inbox">
						<i class="ti ti-inbox fs-5"></i>받은메일함<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${inboxNoRead }</span>
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><div class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1">
						<a href="/mail/sent">
							<i class="ti ti-brand-telegram fs-5" style="margin-right: 12px;"></i>보낸메일함
						</a>
						<button type="button" class="btn btn-sm bg-primary-subtle text-primary ms-auto" onclick="location.href='/mail/check'">수신확인</button>
					</div></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/noRead">
						<i class="ti ti-inbox fs-5"></i>안읽은메일함
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/importantbox">
						<i class="ti ti-star fs-5"></i>중요메일함
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/toMe">
						<i class="ti ti-inbox fs-5"></i>내게쓴메일함<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${toMeNoRead }</span>
					</a></li>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/reservation" class="d-block ">
						<i class="ti ti-badge fs-5"></i>예약메일함<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${reservation }</span>
					</a></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/draft">
						<i class="ti ti-file-text fs-5"></i>임시보관함
					</a></li>
				<li class="border-bottom my-3"></li>
				<li class="list-group-item border-0 p-0 mx-9"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1" href="/mail/trash">
						<i class="ti ti-trash fs-5"></i>휴지통<span class="mb-1 badge rounded-pill  bg-primary-subtle text-primary" style="margin-top: 5px; margin-left: -5px">${trashNoRead }</span>
					</a></li>
			</ul>
		</div>
		<!-- 메뉴 옆 오른쪽 구역 시작 -->
		<div class="d-flex w-100" style="margin-top: 9px;">
			<div class="w-100">
				<div class="border-end user-chat-box h-100">
					<div class="px-4 pt-9 pb-6 d-none d-lg-block">
						<div class="d-flex align-items-center">
							<div>
								<span class="fs-5 fw-bold"><i class="fa-sharp fa-regular fa-envelope fa-fw fa"></i> 메일 쓰기</span>
								<button type="button" class="btn btn-sm btn-outline-warning" style="margin-left: 20px; margin-bottom: 10px;" id="dataInput">시연용 데이터</button>
							</div>
						</div>
					</div>
					<nav class="navbar navbar-expand-sm">
						<div class="container-fluid" style="margin-top: 9px;">
							<div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
								<ul class="navbar-nav">
									<li class="nav-item"><span id="send"><label for="send" style="cursor: pointer;"><i class="ti ti-brand-telegram fs-5"></i>보내기</span></label></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<li class="nav-item"><span id="save"><label for="save" style="cursor: pointer;"><i class="ti ti-file-text fs-5"></i>임시보관</span></label></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<li class="nav-item"><span id="preview"><label for="preview" style="cursor: pointer;"><i class="ti ti-inbox fs-5"></i>미리보기</span></label></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<li class="nav-item"><span id="clear"><label for="clear" style="cursor: pointer;"><i class="fa-regular fa-pen"></i> 다시쓰기</span></label></li>
								</ul>
							</div>
						</div>
					</nav>
					<hr />
					<div class="app-chat">
						<form action="/mail/send" id="emailForm" method="post" enctype="multipart/form-data">
							<input type="hidden" id="emailStatusCode" name="emailStatusCode" value="E101">
							<c:if test="${status eq 'd' }">
							<input type="hidden" id="emailNo" name="emailNo" value="${emailNo }">
							</c:if>
							<input type="hidden" id="atchFileGroupNo" name="atchFileGroupNo" value="${atchFileGroupNo }">
							<div class="row align-items-center mb-3">
								<div class="col-md-2 text-center">
									<span>받는 사람</span>
								</div>
								<div class="col-md-2">
									<input type="checkbox" class="form-check-input" id="me" name="me">
									<label for="me">나에게</label>
								</div>
								<div class="col-md-7">
									<select class="select2 form-control" name="receiverArray" id="receiverArray" value="" multiple="multiple">
										<c:forEach items="${employeeList }" var="employee">
											<option id="${employee.emplNo }" value="${employee.emplNo }">${employee.deptNm }&nbsp;${employee.emplNm }&nbsp;${employee.clsfNm }&nbsp;&lt;${employee.emplId }@thinklink.net&gt;</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row align-items-center mb-3">
								<div class="col-md-2 text-center">
									<span>참조</span>
								</div>
								<div class="col-md-2"></div>
								<div class="col-md-7">
									<select class="select2 form-control" name="ccArray" id="ccArray" multiple="multiple">
										<c:forEach items="${employeeList }" var="employee">
											<option value="${employee.emplNo }">${employee.deptNm }&nbsp;${employee.emplNm }&nbsp;${employee.clsfNm }&nbsp;&lt;${employee.emplId }@thinklink.net&gt;</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row text-center align-items-center mb-3">
								<div class="col-md-2">
									<span>제목</span>
								</div>
								<div class="col-md-2"></div>
								<div class="col-md-7">
									<input type="text" name="emailNm" id="emailNm" class="form-control" value="${title }">
								</div>
							</div>
							<div class="row text-center align-items-center mb-3">
								<div class="col-md-2">
									<span>파일첨부</span>
								</div>
								<div class="col-md-2"></div>
								<div class="col-md-3">
									<input class="form-control" type="file" id="files" name="files" multiple>
								</div>
								<!-- 								<div class="col-md-3"> -->
								<!-- 									<input type="file" class="form-control" name="files" id="files" value="자료실" multiple /> -->
								<!-- 								</div> -->
								<div class="col-md-1">
									<button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
								</div>
							</div>
							<div class="row text-center align-items-center mb-3">
								<div class="col-md-4"></div>
								<div class="col-md-7">
									<table class="table" id="tbl">
										<thead>
											<tr>
												<th>
													<span>파일명</span>
												</th>
												<th>
													<span>확장자</span>
												</th>
												<th>
													<span>파일크기</span>
												</th>
											</tr>
										</thead>
											<c:set var="fileListSize" value="0"/>
											<c:if test="${status eq 'd' or status eq 'f'}">
												<c:if test="${not empty attachFileList }">
													<c:set var="fileListSize" value="${attachFileList.size() }"/>
													<c:forEach items="${attachFileList }" var="attachFile">
														<tr>
															<td>${attachFile.atchFileOrnlFileNm }</td>
															<td>${attachFile.atchFileExtsn }</td>
															<td>${attachFile.atchFileFancysize }</td>
															<c:if test="${status eq 'd' }">
																<td>
																	<span class="btn btn-default btn-sm float-right attachmentFileDel" id="span_${attachFile.atchFileNo }"><i class="fas fa-times"></i> </span>
																</td>
															</c:if>
														</tr>
													</c:forEach>
												</c:if>
											</c:if>
										<tbody id="modalFileArea">
										</tbody>
									</table>
								</div>
							</div>
							<div class="row text-center align-items-center mb-3">
								<div class="col-md-12">
									<textarea name="emailCn" id="emailCn"></textarea>
								</div>
							</div>
							<nav class="navbar navbar-expand-sm">
								<div class="container-fluid" style="margin-top: -9px; margin-bottom: 9px;">
									<div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
										<ul class="navbar-nav">
											<li class="nav-item" style="margin-top: 7px;"><span id="reservation"><label for="reservation" style="cursor: pointer;"><i class="ti ti-badge fs-5"></i>예약</span></label></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<li class="nav-item"><input type="datetime-local" class="form-control" id="Trnsmis" name="Trnsmis" value="" style="display: none;" /></li>
										</ul>
									</div>
								</div>
							</nav>
							<sec:csrfInput />
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 메뉴 옆 오른쪽 구역 끝 -->
	</div>
</div>


<!-- Button trigger modal -->
<button type="button" id="previewModal" style="display: none;" class="btn mb-1 bg-warning-subtle text-warning px-4 fs-4 " data-bs-toggle="modal" data-bs-target="#scroll-long-outer-modal"></button>

<!-- Modal -->
<div class="modal fade" id="scroll-long-outer-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="scroll-long-outer-modal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg">
		<div class="modal-content">
			<div class="modal-header d-flex align-items-center">
				<h4 class="modal-title" id="myLargeModalLabel">미리보기</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용 시작 -->
				<div class="position-relative" id="previewHTML"></div>
				<!-- 모달 내용 끝 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn bg-danger-subtle text-danger  waves-effect text-start" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/vendor/libs/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/js/apps/chat.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/select2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/libs/select2/dist/js/select2.full.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/js/forms/select2.init.js"></script>
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>

	//첨부파일 목록 만들기
	const byteUnits = [ "KB", "MB", "GB" ];
	var fileArray = [];
	let deleteBtn = $('#deleteBtn');
	let files = document.getElementById('files');
	let fileArea = document.getElementById('fileArea');
	let modalFileArea = document.getElementById('modalFileArea');
	let formData = new FormData();
	let cnt = 1;

	files.addEventListener('change',function(e) {
		
		var status = "${status}";
		
		if(status == 'f') {
			showToast("전달 메일은 첨부 파일을 수정할 수 없습니다!", 'warning');
			files.value = '';
			return false;
		}
		
		modalFileArea.innerHTML = '';
		
		let fileCnt = e.target.files.length;

		for (let i = 0; i < fileCnt; i++) {
			let file = e.target.files[i];

			let name = file.name;
			let size = getByteSize(file.size);
			let ext = name.substring(name.lastIndexOf('.')+1, name.length).toLowerCase();

			let html = '<tr>';
			html += '<td>' + name + '</td>';
			html += '<td>' + ext + '</td>';
			html += '<td>' + size + '</td>';
			html += '<td></td>';
			html += '</tr>';

			modalFileArea.insertAdjacentHTML('beforeend', html);
			cnt++;

			fileArray.push(file);
		}
	});


	deleteBtn.on('click', function() {
		modalFileArea.innerHTML = '';
		files.value = '';
	});

	function getByteSize(size) {
		for (let i = 0; i < byteUnits.length; i++) {
			size = Math.floor(size / 1024);
			if (size < 1024)
				return size.toFixed(1) + byteUnits[i];
		}
	}
	
//------------------------------------------------------
	
	
//CK에디터 submit
$(function() {
	CKEDITOR.replace("emailCn", {
		filebrowserUploadUrl : '/imageUpload.do?${_csrf.parameterName}=${_csrf.token}'
	});
	CKEDITOR.config.width = "100%";
	CKEDITOR.config.height = "400px";

    var selectElement = document.getElementById("receiverArray");
    var selectElement2 = document.getElementById("ccArray");
    var status = "${status}";
	
    // 답장, 전달일 때
    if (status === 'r' || status === 'f') {
    	
    	// 답장시 표시할 내용 정의
        var emailtext =`<br/>
        -----Original Message-----
    <br/><b>From:</b> ${sender.deptNm} ${sender.classOfPositionVO.clsfNm} ${sender.emplNm} &lt;${sender.emplId}@thinklink.net&gt; 
    <br/><b>To:</b> `;

    	<c:forEach items="${receptionList }" var="receptionVO">
    	    <c:if test="${receptionVO.emailRecptnRecpTypeCode eq 'E201'}">
    	        emailtext += "${receptionVO.receiverVO.deptNm} ${receptionVO.receiverVO.classOfPositionVO.clsfNm} ${receptionVO.receiverVO.emplNm} &lt;${receptionVO.receiverVO.emplId}@thinklink.net&gt;; ";
    	    </c:if>
    	</c:forEach>

    	emailtext += "<br/><b>Cc:</b> ";

    	<c:forEach items="${receptionList }" var="receptionVO">
    	    <c:if test="${receptionVO.emailRecptnRecpTypeCode eq 'E202'}">
    	        emailtext += "${receptionVO.receiverVO.deptNm} ${receptionVO.receiverVO.classOfPositionVO.clsfNm} ${receptionVO.receiverVO.emplNm} &lt;${receptionVO.receiverVO.emplId}@thinklink.net&gt;; ";
    	    </c:if>
    	</c:forEach>

    	emailtext += `<br/><b>Sent:</b> ${reEmail.emailTrnsmis}
    <br/><b>Subject:</b> ${reEmail.emailNm}`;

    	emailtext += `<br/><br/>${reEmail.emailCn}`;

        var editor = CKEDITOR.instances.emailCn;
        editor.setData(emailtext);
    	
    }
    
    if (status === 'r' || status === 'e') {
    	// 답장할 때 받는 사람 select 하기
	    for (var i = 0; i < selectElement.options.length; i++) {
	        if (selectElement.options[i].value === "${sender.emplNo}") {
	            selectElement.options[i].selected = true;
	            $(selectElement.options[i]).text(selectElement.options[i].textContent).trigger('change');		
	        }
    	}
    }
    
    //임시보관함에서 이동했을 때
	if (status === 'd') {
    	
    	//내용 표시할 내용 정의
		var emailtext =`${reEmail.emailCn}`;
        var editor = CKEDITOR.instances.emailCn;
        editor.setData(emailtext);
        
     	//받는사람 select
	    for (var i = 0; i < selectElement.options.length; i++) {
	    	<c:forEach items="${receptionList }" var="receptionVO">
    	    	<c:if test="${receptionVO.emailRecptnRecpTypeCode eq 'E201'}">
		        	if (selectElement.options[i].value === "${receptionVO.receiverVO.emplNo}") {
		            	selectElement.options[i].selected = true;
		            	$(selectElement.options[i]).text(selectElement.options[i].textContent).trigger('change');		
		        	}
		        </c:if>
		    </c:forEach>
    	}
     	
	    //참조 select
	    for (var i = 0; i < selectElement2.options.length; i++) {
	    	<c:forEach items="${receptionList }" var="receptionVO">
    	    	<c:if test="${receptionVO.emailRecptnRecpTypeCode eq 'E202'}">
		        	if (selectElement2.options[i].value === "${receptionVO.receiverVO.emplNo}") {
		            	selectElement2.options[i].selected = true;
		            	$(selectElement2.options[i]).text(selectElement2.options[i].textContent).trigger('change');		
		        	}
		        </c:if>
		    </c:forEach>
    	}
	}
    
    $("#me").change(function() {
        if ($(this).is(":checked")) {
        	for (var i = 0; i < selectElement.options.length; i++) {
    	        if (selectElement.options[i].value === "${user.emplNo}") {
    	            selectElement.options[i].selected = true;
    	            $(selectElement.options[i]).text(selectElement.options[i].textContent).trigger('change');
    	        }
        	}
        } else {
        	for (var i = 0; i < selectElement.options.length; i++) {
    	        if (selectElement.options[i].value === "${user.emplNo}") {
    	            selectElement.options[i].selected = false;
    	            $(selectElement.options[i]).text('').trigger('change');
    	        }
        	}
        }
    });
    
	var send = $("#send");
	var emailForm = $("#emailForm");

	//보내기 버튼
	send.on("click", function() {
		var receiverArray = $("#receiverArray").val();
		var title = $("#emailNm").val();
// 		var atchFileGroupNo = ${reEmail.atchFileGroupNo};

		if (receiverArray == null || receiverArray == "") {
			
			showToast("받는 사람을 입력해주세요!", "info");
			return false;
		}
		
		if (title == null || title == "") {
			
			showConfirm("제목이 입력되지 않았습니다.\n제목 없이 메일을 보내시겠습니까?",'','question').then(result=> {
				if(result.isConfirmed){
					if(dateCompare()){
						if(status === "d"){
							emailForm.attr("action", "/mail/update");
						}
							emailForm.submit();
					}
				}	
			});
			
		}else {
			if(dateCompare()){
				if(status === "d"){
					emailForm.attr("action", "/mail/update");
				}
// 				if(status === "f") {
// 					var ptrn = "<input type='hidden' name='atchFileGroupNo' value='%V'/>";
// 					emailForm.append(ptrn.replace("%V", atchFileGroupNo));
// 				}
				emailForm.submit();
			}
		}
	});
	
	var Trnsmis = $("#Trnsmis"); //예약시간
	var reservation = $("#reservation"); //예약버튼
	
	var emailStatusCode = $("#emailStatusCode"); //메일상태
	
	var save = $("#save"); // 임시저장버튼
	var preview = $("#preview"); // 미리보기버튼
	var clear = $("#clear"); //다시쓰기 버튼
	var me = $("#me"); // 나에게 체크박스
	
	var receiverArray = $("#receiverArray"); //받는 사람
	var ccArray = $("#ccArray"); //참조
	var emailNm = $("#emailNm"); //제목
	var content = CKEDITOR.instances.emailCn.getData(); //내용
	
	var flag_reservation; //예약 여부
	
	// 입력된 날짜가 현재 날짜보다 이전인지 확인
	function dateCompare() {
	    var inputDate = new Date($("#Trnsmis").val());
	    var currentDate = new Date();

	    if(inputDate < currentDate) {
	    	showToast("예약시간이 현재보다 과거입니다!","warning");
	    	return false;
	    }
	    return true;
	}
	
	receiverArray.on("change",function(){
		var selectReceiver = receiverArray.val();
		console.log("체인지이벤트받는사람:" + selectReceiver);
	});
	
	//예약 버튼
	reservation.on("click", function(){
		
		if(!flag_reservation) {
			Trnsmis.css("display", "");
			reservation.html("<label for='reservation' style='cursor: pointer;'><i class='ti ti-badge fs-5'></i>취소");
			emailStatusCode.val("E102");
			flag_reservation = true;
		}else {
			Trnsmis.css("display", "none");
			Trnsmis.val("");
			reservation.html("<label for='reservation' style='cursor: pointer;'><i class='ti ti-badge fs-5'></i>예약");
			emailStatusCode.val("E101");
			flag_reservation = false;
		}
	});
	
	//임시저장 버튼
	save.on("click", function(){
		
		if(status == 'd') {
			$("#emailNo").val(1);
		}
		
		if(flag_reservation) {
			showConfirm("예약시간이 설정되어있습니다.\n예약하지 않고 임시저장 하시겠습니까?",'','question').then(result=> {
				if(result.isConfirmed){
					Trnsmis.val("");
					emailStatusCode.val("E103");
					emailForm.submit();
				}	
			});
		}else {
			emailStatusCode.val("E103");
			emailForm.submit();
		}
	});
	
	//미리보기 버튼
	preview.on("click", function(){
		
		var receiverArray = $("#receiverArray").val(); //받는 사람
		var ccArray = $("#ccArray").val(); //참조
		var emailNm = $("#emailNm").val(); //제목
		var content= CKEDITOR.instances.emailCn.getData(); //내용
		var fileCount = $("#files")[0].files.length;
		var fileListSize = `${fileListSize}`; //기존에 있던 파일 개수
		var fileListSizeInt = parseInt(fileListSize);
		
		$.ajax({
			url :"preview",
			method :"post",
			data: JSON.stringify({
				receiverArray : receiverArray,
				ccArray : ccArray
			}),
			contentType : "application/json;charset=utf-8",
	        beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(receptionList) {
			
				// 변경할 HTML 코드
			    var newHTML = `
			    	<div class="chat-box email-box mh-n100 p-9" data-simplebar="init">
					<div class="chat-list chat active-chat" data-user-id="1">
						<div class="hstack align-items-start mb-7 pb-1 align-items-center justify-content-between flex-wrap gap-6">
							<div class="d-flex align-items-center gap-2">
								보낸 사람
								<img src="view/${user.emplProflPhoto }" alt="${user.emplProflPhoto }" width="48" height="48" class="rounded-circle">
								<div>
									<h6 class="fw-semibold mb-0">${user.deptNm }&nbsp;${user.clsfNm }</h6>
									<h5 class="fw-semibold mb-0">${user.emplNm }</h5>
									<p class="mb-0">${user.emplId }@thinklink.net</p>
								</div>
							</div>
						</div>
						<div class="hstack align-items-start mb-7 pb-1 align-items-center justify-content-between flex-wrap gap-6">
							<div class="d-flex align-items-center gap-2">
								받는 사람`;
								
							for (var i = 0; i < receptionList[0].length; i++) {
					        var receiver = receptionList[0][i];
					        newHTML += `
					            <img src="view/\${receiver.emplProflPhoto}" alt="\${receiver.emplProflPhoto}" width="48" height="48" class="rounded-circle">
					            <div>
					                <h6 class="fw-semibold mb-0">\${receiver.deptNm}&nbsp;\${receiver.classOfPositionVO.clsfNm}</h6>
					                <h5 class="fw-semibold mb-0">\${receiver.emplNm}</h5>
					                <p class="mb-0">\${receiver.emplId}@thinklink.net</p>
					            </div>`;
						    }
					
				newHTML += 			
						`</div>
						</div>
						<div class="hstack align-items-start mb-7 pb-1 align-items-center justify-content-between flex-wrap gap-6">
							<div class="d-flex align-items-center gap-2">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;참조&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`;
									
								for (var i = 0; i < receptionList[1].length; i++) {
							        var receiver = receptionList[1][i];
							        newHTML += `
							            <img src="view/\${receiver.emplProflPhoto}" alt="\${receiver.emplProflPhoto}" width="48" height="48" class="rounded-circle">
							            <div>
							                <h6 class="fw-semibold mb-0">\${receiver.deptNm}&nbsp;\${receiver.classOfPositionVO.clsfNm}</h6>
							                <h5 class="fw-semibold mb-0">\${receiver.emplNm}</h5>
							                <p class="mb-0">\${receiver.emplId}@thinklink.net</p>
							            </div>`;
							    }
								
				newHTML += 				
							`</div>
						</div>
					</div>
					<hr>
					<div class="border-bottom pb-7 mb-7">
						<h4 class="fw-semibold text-dark mb-3">\${emailNm}</h4>
						<p class="mb-3 text-dark">\${content}</p>
					</div>
					<div class="mb-3">
						<h6 class="fw-semibold mb-0 text-dark mb-3">첨부파일 \${fileCount + fileListSizeInt}개</h6>
						<div class="d-block d-sm-flex align-items-center gap-4">
						</div>
					</div>
				</div>
			    `;
		
			    // 변경할 HTML 코드로 주어진 요소를 교체
			    $("#previewHTML").html(newHTML);
			    $("#previewModal").click();
	    
			}
		});
	});
	
	//다시 쓰기 버튼
	clear.on("click", function(){
		location.href = "emailForm";
	});
	

	// 기존 업로드되어 있는 파일 'X' 버튼 클릭 이벤트
	$(".attachmentFileDel").on("click", function(){
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var atchFileNo = id.substring(idx + 1);
		var ptrn = "<input type='hidden' name='delFileNo' value='%V'/>";
		emailForm.append(ptrn.replace("%V", atchFileNo));
		$(this).parents("tr:first").hide();
	});
	
	$("#dataInput").on("click",function(){
		
	     var emailNm = document.getElementById("emailNm");
	     var selectElement = document.getElementById("receiverArray");
	     var selectElement2 = document.getElementById("ccArray");
		 var editor = CKEDITOR.instances.emailCn;
		 
		 emailNm.value = "[홈페이지 개편] 가능 여부 확인";
		 var emailtext = `<p>안녕하세요.</p>

			 <p>일전에 말씀하셨던 홈페이지 개편안 내부 검토 완료하였습니다.</p>

			 <p>프로젝트 기안 올릴까요?</p>
						 `;
		 
	     editor.setData(emailtext);
	     
// 	     selectElement.options[42].selected = true;
// 	     $(selectElement.options[42]).text(selectElement.options[42].textContent).trigger('change');
	     
// 	     selectElement.options[41].selected = true;
// 	     $(selectElement.options[41]).text(selectElement.options[41].textContent).trigger('change');
	     
// 	     selectElement2.options[35].selected = true;
// 	 	$(selectElement2.options[35]).text(selectElement2.options[35].textContent).trigger('change');	

		for (var i = 0; i < selectElement.options.length; i++) {
    	        if (selectElement.options[i].value === '20240064' || selectElement.options[i].value === '20240065') {
    	            selectElement.options[i].selected = true;
    	            $(selectElement.options[i]).text(selectElement.options[i].textContent).trigger('change');
    	        }
        	}
		
	});
});


</script>


