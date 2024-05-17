<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 78%;
    color: #999999;
}
.filebox label {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #999999;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}
.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
.form-check-input:checked {
	background-color: #FA896B;
    border-color: #FA896B;
}
</style>
	<c:set value="등록" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name"/>	
	</c:if>
</head>
<div style="height: 800px;">
	<div class="px-9 pt-4 pb-3">
		<a href="/admin/board?bbsNo=1">
			<h3 class="fw-semibold mb-4">
				<i class="fa-sharp fa-regular fa-chalkboard fa-fw fa"></i>
				공지사항 등록/수정
			</h3>
		</a>
		<button id="btn-board-siyeon" class="btn btn-outline-warning rounded-0" style="float: right;">시연용 데이터 입력</button>
	</div>
	<form action="/admin/board/insert" id="boardForm" method="post" enctype="multipart/form-data">
		<c:if test="${status eq 'u' }">
			<input type="hidden" name="bbscttNo" value="${boardVO.bbscttNo }"/>
<%-- 			<input type="hidden" name="bbsNo2" value="${boardVO.bbsNo }"/> --%>
		<c:if test="${boardVO.atchFileGrpNo != 0}">
				<input type="hidden" name="atchFileGrpNo" value="${boardVO.atchFileGrpNo }">
			</c:if>
		</c:if>
		<input type="hidden" name="bbsNo" value="${boardVO.bbsNo }"/>
		<c:if test="${boardVO.bbsNo eq '1'}">
		
			<div class="mb-2">
				<label for="importantCheckbox" class="text-danger">
					<i class="fa-sharp fa-regular fa-circle-exclamation text-danger fa-fw"></i>
					<span class="text-danger">중요</span>
				</label>
				<input type="checkbox" id="importantCheckbox" name="importantCheckbox" class="form-check-input rounded-0">
				<input type="hidden" id="imprtncYn" name="imprtncYn" value="N">
			</div>
				
		</c:if>
		<div>
			<input type="text" class="form-control rounded-0" id="bbscttTitle" name="bbscttTitle" value="${boardVO.bbscttTitle }"placeholder="제목을 입력해주세요">
		</div>
		<div>
			<textarea id="bbscttCn" name="bbscttCn" placeholder="내용을 입력해주세요">${boardVO.bbscttCn }</textarea>
		</div>
		<div class="form-group">
							<div class="custom-file filebox">
								<input class="upload-name" value="첨부파일" placeholder="첨부파일">
								<input type="file" class="custom-file-input" id="imgFile" name="imgFile"
									multiple="multiple"> <label class="custom-file-label"
									for="imgFile">파일을 선택해주세요</label>
							</div>
						</div>
						<c:set value="${atchFileList}" var="atchFileList" />
						<c:if test="${status eq 'u' }">
						<c:if test="${not empty atchFileList }"></c:if>
							<div class="card-footer bg-white">
							<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
								<c:forEach items="${atchFileList }" var="boardFile">
									<li>
										<span class="mailbox-attachment-icon"><i class="far fa-file-pdf"></i></span>
				
										<div class="mailbox-attachment-info">
											<a href="#" class="mailbox-attachment-name">
												<i class="fas fa-paperclip"></i> ${boardFile.atchFileNm }
											</a>
											<span class="mailbox-attachment-size clearfix mt-1">
											<span>${boardFile.atchFileFancysize }</span>
												<span class="btn btn-default btn-sm float-right attachmentFileDel" id="span_${boardFile.atchFileNo }">
													<i class="fas fa-times"></i>
												</span>
											</span>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
		<sec:csrfInput />
	</form>
	<div class="d-flex justify-content-end align-items-end" style="height: 16%;">
		<input type="button" class="btn btn-primary rounded-0 me-2" id="insertBtn" value="${name}" data-bbs-no="${boardVO.bbsNo }"></input>
		<c:if test="${status ne 'u' }">
			<button type="button" class="btn btn-danger rounded-0 me-2" onclick="javascript:location.href='/admin/board?bbsNo=1'">취소</button>
		</c:if>
		<c:if test="${status eq 'u' }">
			<button type="button" class="btn btn-info" onclick="javascript:location.href='/board'">목록</button>
		</c:if>
	</div>
</div>
<script src ="${pageContext.request.contextPath }/resources/vendor/libs/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("bbscttCn", {
		filebrowserUploadUrl: '/imageUpload.do?${_csrf.parameterName}=${_csrf.token}'
	});
	CKEDITOR.config.width = "100%";
	CKEDITOR.config.height = "400px";
	
	var boardForm = $('#boardForm');
	var insertBtn = $("#insertBtn");
	var boardForm = $("#boardForm");
	var cancelBtn = $("#cancelBtn");
	
	insertBtn.on("click",function(){
		var title= $("#bbscttTitle").val();
		var content= CKEDITOR.instances.bbscttCn.getData();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요!");
			return false;
		}
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			return false;
		}
		
		if($(this).val() == "수정"){
			boardForm.attr("action", "/admin/board/update");
		}
		boardForm.submit();
	});
	
	cancelBtn.on("click", function(){
		location.href="/board/detail?bbscttNo=${boardVO.bbscttNo}";
	});
	
	$('.attachmentFileDel').on('click', function() {
		let id = $(this).prop('id');
		let idx = id.indexOf('_');
		
		let attachFileNo = id.substring(idx + 1);
		let ptrn = "<input type='hidden' name='delAttachFileNo' value='%V'/>";
		boardForm.append(ptrn.replace("%V",attachFileNo));
		$(this).parents("li:first").hide();
	});
	
	$("#imgFile").on('change',function(){
	  var fileName = $("#imgFile").val();
	  $(".upload-name").val(fileName);
	});
	
	
	

	

});

$(document).ready(function() {
    $("#importantCheckbox").on("change", function() {
        var checkbox = $(this);
//         console.log(this);
        var hiddenField = $("#imprtncYn");
        
        if (checkbox.prop("checked")) {
            hiddenField.val("Y");
            console.log(hiddenField.val());
        } else {
            hiddenField.val("N");
            console.log(hiddenField.val());
        }
    });
    
    
	var btnBoardSiyeon = $("#btn-board-siyeon");
	
	btnBoardSiyeon.on("click", function(){
		$("#bbscttTitle").val('2024 워크샵 일정 안내');
		var htmlContent =`- 일시: 2024년 6월 13일(목) - 6월 14일(금) <br>
				- 목적: 직원 역량 강화 및 부서 간 협업 증진 <br>
				- 참가 대상: 전 직원 대상 <br>
				[ 주요 프로그램 ] <br>
				- 부서별 우수 사례 공유 및 토론 <br>
				- 신기술 동향 및 산업 변화 세미나 <br>
				- 팀 빌딩 및 소통 증진 워크숍 <br>
				- 우수 직원 시상 및 사내 문화 행사 <br>
				[ 참고 사항 ] <br>
				- 워크샵 참석은 필수이며, 일정 조정이 필요한 경우 사전에 부서장에게 문의 바랍니다. <br>
				- 원활한 진행을 위해 사전 등록이 필요하며, 등록 기한은 2024년 5월 31일까지입니다. <br>
				- 기타 문의 사항은 인사팀으로 연락 주시기 바랍니다. <br>
				또한 2024년 6월 13-14일에는 차세대 반도체 소자 워크샵도 개최될 예정입니다. <br>
				이 워크샵은 국내 반도체 산업의 경쟁력 제고와 전문 인력 양성을 목적으로 하며, 메모리, AI, 양자, 비메모리 등 다양한 반도체 기술을 다룰 예정입니다.
				관심 있는 직원들의 참여를 권장드립니다.`;
		CKEDITOR.instances.bbscttCn.setData(htmlContent);
		$("#importantCheckbox").prop('checked', true);
		$("#imprtncYn").val("Y");
	});
});

</script>
