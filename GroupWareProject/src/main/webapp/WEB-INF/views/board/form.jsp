<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>
	<c:set value="등록" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name"/>	
	</c:if>
</head>
<body>
	<div class="px-9 pt-4 pb-3">
		<a href="/board">
			<h3 class="fw-semibold mb-4">등록/수정</h3>
		</a>
	</div>
	<form action="/board/insert" id="boardForm" method="post" enctype="multipart/form-data">
		<c:if test="${boardVO.bbsNo eq '1'}">
			<div>
				<label for="importantCheckbox">중요 공지 여부:</label>
				<input type="checkbox" id="importantCheckbox" name="importantCheckbox">
				<input type="hidden" id="imprtncYn" name="imprtncYn" value="N">
			</div>
		</c:if>
			<input type="hidden" name="bbsNo" value="${boardVO.bbsNo }"/>
		<c:if test="${status eq 'u' }">
			<input type="hidden" name="bbscttNo" value="${boardVO.bbscttNo }"/>
<%-- 			<input type="hidden" name="bbsNo2" value="${boardVO.bbsNo }"/> --%>
		<c:if test="${boardVO.atchFileGrpNo != 0}">
				<input type="hidden" name="atchFileGrpNo" value="${boardVO.atchFileGrpNo }">
			</c:if>
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
	<input type="button" class="btn btn-primary rounded-0" id="insertBtn" value="${name}" data-bbs-no="${boardVO.bbsNo }"></input>
	<c:if test="${status ne 'u' }">
		<button type="button" class="btn btn-danger rounded-0" onclick="javascript:location.href='/board/detail?bbscttNo=${boardVO.bbscttNo}'">취소</button>
	</c:if>
	<c:if test="${status eq 'u' }">
		<button type="button" class="btn btn-info" onclick="javascript:location.href='/board'">목록</button>
	</c:if>
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
			boardForm.attr("action", "/board/update");
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
});

</script>
</body>
</html>