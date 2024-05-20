<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#main-wrapper {
	background-color: white;
}
.checkbox-label {
	font-size: larger;
}

.checkbox {
	width: 20px;
	height: 20px;
	vertical-align: middle;
}

.ck-editor__editable[role="textbox"] {
	min-height: 400px;
}

.container-fluid {
	background-color: white;
}
</style>


<c:set value="문서양식 입력" var="headerText" />
<c:if test="${status eq 'u' }">
	<c:set value="문서양식 편집" var="headerText" />
</c:if>

<form class="card card-body" id="docForm" method="post" action="/admin/documents/insertdocform">
	<div class="px-9 pt-4 pb-3">
		<a href="#">
			<h3 class="fw-semibold mb-4">
				<i class="fa-sharp fa-regular fa-file-lines fa-fw fa"></i>
				${headerText }
			</h3>
		</a>
	</div>
	<c:if test="${status eq 'u' }">
		<input type="hidden" name="docNo" value="${selectOne.docNo }" />
	</c:if>
	<div class="row">
		<div class="col-md-8">
            <div class="row">
                <div class="col-md-2">
                    <select class="form-select mb-2" aria-label="doc-type-code" id="docTypeCode" name="docTypeCode">
                        <option selected>분류선택</option>
                        <option value="F101" ${selectOne.docTypeCode == 'F101' ? 'selected' : ''}>일반</option>
                        <option value="F102" ${selectOne.docTypeCode == 'F102' ? 'selected' : ''}>지원</option>
                        <option value="F103" ${selectOne.docTypeCode == 'F103' ? 'selected' : ''}>인사</option>
                        <option value="F104" ${selectOne.docTypeCode == 'F104' ? 'selected' : ''}>휴가</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-center">
                    <label for="useYnCheckbox" class="checkbox-label me-1">사용여부</label>
                    <input type="checkbox" id="useYnCheckbox" class="form-check-input primary" ${status eq 'u' && selectOne.useYn == 'Y' ? 'checked' : 'checked'}>
                	<input type="hidden" id="useYnHidden" name="useYn" value="">
                </div>
            </div>
			<div class="input-group input-group-outline mb-2">
				<input type="text" class="form-control" id="docNm" name="docNm" value="${selectOne.docNm }" placeholder="제목을 입력해주세요.">
                	<c:if test="${status ne 'u' }">
                	<button type="button" class="btn btn-warning rounded-pill me-2" id="yjBtn-siyeon">시연용입력버튼</button>
					</c:if>
			</div>
		</div>
		<div class="col-md-8">
			<div class="input-group input-group-outline">
				<textarea class="form-control" id="docCn" name="docCn">${selectOne.docCn }</textarea>
			</div>
		</div>
		<div class="col-md-8">
			<div class="input-group input-group-outline">
				<!-- <input type="file" class="form-control" id="boFile" name="boFile" multiple="multiple" /> -->
			</div>
		</div>
		<div class="col-md-8">
			<br />
		</div>
		<div class="col-md-8">
			<div class="row">
				<div class="col-md-2">
					<div class="card"></div>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<!-- 분기처리 -->
			<c:set value="등록" var="btnText" />
			<c:if test="${status eq 'u' }">
				<c:set value="수정" var="btnText" />
			</c:if>
			<button type="button" class="btn btn-primary" id="insertBtn">${btnText }</button>
			<c:if test="${status eq 'u' }">
				<button type="button" class="btn btn-danger" id="cancelBtn">취소</button>
			</c:if>
			<c:if test="${status ne 'u' }">
				<button type="button" class="btn btn-info" id="listBtn" onclick="javascript:location.href='/admin/documents/list'">목록</button>
			</c:if>
		</div>
	</div>
	<sec:csrfInput />
</form>
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script> -->
<script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/super-build/ckeditor.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/vendor/libs/ckeditor/ckeditor.js"></script> --%>
<script type="text/javascript">
$(function() {
	let editor;
	//setData를 안하고 그냥 에디터안에 뿌리게 했더니 html 태그가 들어있어서 문제가 생김
	//백틱으로 감싸서 setData값에 넣어줘서 해결  
    var selectOneDocCn = `${selectOne.docCn}`;	
	
    CKEDITOR.ClassicEditor.create(document.getElementById("docCn"), {
           // https://ckeditor.com/docs/ckeditor5/latest/features/toolbar/toolbar.html#extended-toolbar-configuration-format
           
           toolbar: {
               items: [
                   'exportPDF','exportWord', '|',
                   'findAndReplace', 'selectAll', '|',
                   'heading', '|',
                   'bold', 'italic', 'strikethrough', 'underline', 'code', 'subscript', 'superscript', 'removeFormat', '|',
                   'bulletedList', 'numberedList', 'todoList', '|',
                   'outdent', 'indent', '|',
                   'undo', 'redo',
                   '-',
                   'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
                   'alignment', '|',
                   'link', 'uploadImage', 'blockQuote', 'insertTable', 'mediaEmbed', 'codeBlock', 'htmlEmbed', '|',
                   'specialCharacters', 'horizontalLine', 'pageBreak', '|',
                   'textPartLanguage', '|',
                   'sourceEditing'
               ],
               shouldNotGroupWhenFull: true
           },
           // Changing the language of the interface requires loading the language file using the <script> tag.
           // language: 'es',
           language: 'ko',
           list: {
               properties: {
                   styles: true,
                   startIndex: true,
                   reversed: true
               }
           },
           // https://ckeditor.com/docs/ckeditor5/latest/features/headings.html#configuration
           heading: {
               options: [
                   { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
                   { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
                   { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
                   { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
                   { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
                   { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
                   { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
               ]
           },
           // https://ckeditor.com/docs/ckeditor5/latest/features/editor-placeholder.html#using-the-editor-configuration
           placeholder: '',
           // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-family-feature
           fontFamily: {
               options: [
                   'default',
                   'Arial, Helvetica, sans-serif',
                   'Courier New, Courier, monospace',
                   'Georgia, serif',
                   'Lucida Sans Unicode, Lucida Grande, sans-serif',
                   'Tahoma, Geneva, sans-serif',
                   'Times New Roman, Times, serif',
                   'Trebuchet MS, Helvetica, sans-serif',
                   'Verdana, Geneva, sans-serif'
               ],
               supportAllValues: true
           },
           // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-size-feature
           fontSize: {
               options: [ 10, 12, 14, 'default', 18, 20, 22 ],
               supportAllValues: true
           },
           // Be careful with the setting below. It instructs CKEditor to accept ALL HTML markup.
           // https://ckeditor.com/docs/ckeditor5/latest/features/general-html-support.html#enabling-all-html-features
           htmlSupport: {
               allow: [
                   {
                       name: /.*/,
                       attributes: true,
                       classes: true,
                       styles: true
                   }
               ]
           },
           // Be careful with enabling previews
           // https://ckeditor.com/docs/ckeditor5/latest/features/html-embed.html#content-previews
           htmlEmbed: {
               showPreviews: true
           },
           
           // The "superbuild" contains more premium features that require additional configuration, disable them below.
           // Do not turn them on unless you read the documentation and know how to configure them and setup the editor.
           removePlugins: [
               // These two are commercial, but you can try them out without registering to a trial.
               //'ExportPdf',
               //'ExportWord',
               'AIAssistant',
               'CKBox',
               'CKFinder',
               'EasyImage',
               // This sample uses the Base64UploadAdapter to handle image uploads as it requires no configuration.
               // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/base64-upload-adapter.html
               // Storing images as Base64 is usually a very bad idea.
               // Replace it on production website with other solutions:
               // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/image-upload.html
               // 'Base64UploadAdapter',
               'MultiLevelList',
               'RealTimeCollaborativeComments',
               'RealTimeCollaborativeTrackChanges',
               'RealTimeCollaborativeRevisionHistory',
               'PresenceList',
               'Comments',
               'TrackChanges',
               'TrackChangesData',
               'RevisionHistory',
               'Pagination',
               'WProofreader',
               // Careful, with the Mathtype plugin CKEditor will not load when loading this sample
               // from a local file system (file://) - load this site via HTTP server if you enable MathType.
               'MathType',
               // The following features are part of the Productivity Pack and require additional license.
               'SlashCommand',
               'Template',
               'DocumentOutline',
               'FormatPainter',
               'TableOfContents',
               'PasteFromOfficeEnhanced',
               'CaseChange'
           ]
       }).then(newEditor => {
           editor = newEditor;
           editor.setData(selectOneDocCn);
       })
       .catch(error => {
           console.error(error);
       });
       
       var insertBtn = $("#insertBtn");
       var docForm = $("#docForm");

       insertBtn.on("click", function() {
           var docTypeCode = $("#docTypeCode").val();
           var docNm = $("#docNm").val();
           var content = editor.getData(); // 에디터 인스턴스에서 데이터 가져오기
           var useYn = $("#useYnCheckbox").prop("checked") ? "Y" : "N";
           $("#useYnHidden").val(useYn);
           
           if (docTypeCode === "분류선택") {
               Swal.fire({
                   icon: 'warning',
                   title: '문서의 분류를 선택해주세요!'
               });
               return; 
           }
           // 제목 입력 여부 확인
           if (!docNm.trim()) {
               Swal.fire({
                   icon: 'warning',
                   title: '문서의 제목을 입력해주세요!'
               });
               return; 
           }

           // 내용 입력 여부 확인
           if (!content.trim()) {
               Swal.fire({
                   icon: 'warning',
                   title: '문서의 내용을 입력해주세요!'
               });
               return; 
           }
           
           if ($(this).text() == "수정") {
               docForm.attr("action", "/admin/documents/modifydocform");
           }
           docForm.submit();
       });
});

   $(document).ready(function() {
       $('#cancelBtn').click(function() {
           window.location.href = '/admin/documents/list';
       });
       
       $('#yjBtn-siyeon').click(function(){
    	   if ($('.raw-html-embed__source').length) {
    		   $('#docNm').val('사외교육결과보고서');
    		   $("#docTypeCode").val("F101");
    		   var htmlContent = `
    			   <span
    			    style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">

    			    <table
    			        style="border: 0px solid #000000; width: 800px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
    			        <!-- Header  -->
    			        <colgroup>
    			            <col width="310" />
    			            <col width="490" />
    			        </colgroup>
    			        <tbody>
    			            <tr>
    			                <td class=""
    			                    style="background: white; padding: 0px !important; border: 0px currentColor; height: 90px; text-align: center; color: black; font-size: 36px; font-weight: bold; vertical-align: middle;"
    			                    colspan="2">사외 교육 결과 보고서</td>
    			            </tr>
    			            <tr>
    			                <td
    			                    style="background: white; padding: 0px !important; border: currentColor; text-align: left; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
    			                    <!-- 에디터   버그. 개행과 공백을 최소화 시키자. -->
    			                    <table
    			                        style="border: 1px solid #000000; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
    			                        <!-- User -->
    			                        <colgroup>
    			                            <col width="90" />
    			                            <col width="220" />
    			                        </colgroup>
    			                        <tbody>
    			                            <tr>
    			                                <td
    			                                    style="background: #dddddd; padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: #000000; font-size: 12px; font-weight: bold; vertical-align: middle;">
    			                                    기안자</td>
    			                                <td
    			                                    style="background: #ffffff; padding: 5px; border: 1px solid black; text-align: left; color: #000000; font-size: 12px; font-weight: normal; vertical-align: middle;">
    			                                    <input id="draftUser"
    			                                        style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2);"
    			                                        name="draftUser" readonly="readonly" type="text" value="" placeholder=""
    			                                        data-dsl="{{label:draftUser}}" data-id="draftUser" data-name="draftUser"
    			                                        data-require="false" data-maxlength="" data-width="" data-defaultstr=""
    			                                        data-editable="false" data-value="" />
    			                                </td>
    			                            </tr>
    			                            <tr>
    			                                <td
    			                                    style="background: #dddddd; padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: #000000; font-size: 12px; font-weight: bold; vertical-align: middle;">
    			                                    소속</td>
    			                                <td
    			                                    style="background: #ffffff; padding: 5px; border: 1px solid black; text-align: left; color: #000000; font-size: 12px; font-weight: normal; vertical-align: middle;">
    			                                    <input id="draftDept"
    			                                        style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2);"
    			                                        name="draftDept" readonly="readonly" type="text" value="Think Link" placeholder=""
    			                                        data-dsl="{{label:draftDept}}" data-id="draftDept" data-name="draftDept"
    			                                        data-require="false" data-maxlength="" data-width="" data-defaultstr=""
    			                                        data-editable="false" data-value="Think Link" />
    			                                </td>
    			                            </tr>
    			                            <tr>
    			                                <td
    			                                    style="background: #dddddd; padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: #000000; font-size: 12px; font-weight: bold; vertical-align: middle;">
    			                                    기안일</td>
    			                                <td
    			                                    style="background: #ffffff; padding: 5px; border: 1px solid black; text-align: left; color: #000000; font-size: 12px; font-weight: normal; vertical-align: middle;">
    			                                    <input id="draftDate"
    			                                        style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2);"
    			                                        name="draftDate" readonly="readonly" type="text" value="" placeholder=""
    			                                        data-dsl="{{label:draftDate}}" data-id="draftDate" data-name="draftDate"
    			                                        data-require="false" data-maxlength="" data-width="" data-defaultstr=""
    			                                        data-editable="false" data-value="" />
    			                                </td>
    			                            </tr>
    			                            <tr>
    			                                <td
    			                                    style="background: #dddddd; padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: #000000; font-size: 12px; font-weight: bold; vertical-align: middle;">
    			                                    문서번호</td>
    			                                <td
    			                                    style="background: #ffffff; padding: 5px; border: 1px solid black; text-align: left; color: #000000; font-size: 12px; font-weight: normal; vertical-align: middle;">
    			                                    <input id="docCodeNo"
    			                                        style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2);"
    			                                        name="docCodeNo" readonly="readonly" type="text" value="" placeholder=""
    			                                        data-dsl="{{label:docCodeNo}}" data-id="docCodeNo" data-name="docCodeNo"
    			                                        data-require="false" data-maxlength="" data-width="" data-defaultstr=""
    			                                        data-editable="false" data-value="" />
    			                                </td>
    			                            </tr>
    			                        </tbody>
    			                    </table>
    			                </td>
    			                <td
    			                    style="background: white; padding: 0px !important; border: currentColor; border-image: none; text-align: right; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
    			                    <span class="sign_type1_inline" data-group-seq="0" data-group-name="신청" data-group-max-count="1"
    			                        data-group-type="type1" data-is-reception=""><span class="sign_tit_wrap"><span
    			                                class="sign_tit"><strong>신청</strong></span></span><span class="sign_member_wrap"
    			                            id="activity_16557"><span class="sign_member"><span class="sign_rank_wrap"><span
    			                                        class="sign_rank">직위</span></span><span class="sign_wrap"><span
    			                                        class="sign_name">홍길동</span></span><span class="sign_date_wrap"><span
    			                                        class="sign_date " id="date_16557"></span></span></span></span></span>
    			                </td>
    			            </tr>
    			        </tbody>
    			    </table>
    			    <br>

    			    <table
    			        style="width: 800px; border-collapse: collapse !important; color: #000; background: #fff; font-size: 12px; border: 0; font-family: malgun gothic,dotum,arial,tahoma; margin-top: 10px">
    			        <colgroup>
    			            <col width="120px">
    			            <col width="680px">
    			        </colgroup>

    			        <tbody>
    			            <tr>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    제목
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="7"
    			                        data-dsl="{{text:subject}}" data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor" type="text"><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="7"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			        </tbody>
    			    </table>


    			    <table
    			        style="width: 800px; margin-top:10px; border-collapse: collapse !important; color: #000; background: #fff; font-size: 12px; border: 0; font-family: malgun gothic,dotum,arial,tahoma;">
    			        <colgroup>
    			            <col width="120px">
    			            <col width="280px">
    			            <col width="120px">
    			            <col width="280px">
    			        </colgroup>

    			        <tbody>
    			            <tr>
    			                <td colspan="4" style="padding: 3px; height: 20px;  vertical-align: middle"
    			                    class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">

    			                    1. 교육개요
    			                </td>
    			            </tr>
    			            <tr>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    교육목표
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle" colspan="3">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="11" data-dsl="{{text}}"
    			                        data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor" type="text"><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="11"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			            <tr>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    교육과정
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle" colspan="3">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="12" data-dsl="{{text}}"
    			                        data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor" type="text"><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="12"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			            <tr>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    교육기간
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="13"
    			                        data-dsl="{{period}}" data-wrapper=""
    			                        style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor ipt_editor_date" type="text"> ~ <input
    			                            class="ipt_editor ipt_editor_date" type="text"><span contenteditable="false"
    			                            class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="13"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    교육기관
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="15" data-dsl="{{text}}"
    			                        data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor" type="text"><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="15"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			            <tr>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    전달교육일시
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="14"
    			                        data-dsl="{{calendar}}" data-wrapper=""
    			                        style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor ipt_editor_date" type="text"><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="14"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			                <td
    			                    style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle; background: #ddd; text-align: center">

    			                    전달교육장소
    			                </td>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="16" data-dsl="{{text}}"
    			                        data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><input class="ipt_editor" type="text"><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="16"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			        </tbody>
    			    </table>


    			    <table
    			        style="width: 800px; margin-top:10px; border-collapse: collapse !important; color: #000; background: #fff; font-size: 12px; border: 0; font-family: malgun gothic,dotum,arial,tahoma;">
    			        <colgroup>
    			            <col width="800px">
    			        </colgroup>

    			        <tbody>
    			            <tr>
    			                <td style="padding: 3px; height: 20px; vertical-align: middle"
    			                    class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">

    			                    2. 교육내용
    			                </td>
    			            </tr>
    			            <tr>
    			                <td style="padding: 3px; height: 200px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="8" data-dsl="{{editor}}"
    			                        data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype="">
    			                        <textarea class="txta_editor" style="height: 100%; width: 100%;"></textarea>
    			                        <span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="8"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			        </tbody>
    			    </table>


    			    <table
    			        style="width: 800px; margin-top:10px; border-collapse: collapse !important; color: #000; background: #fff; font-size: 12px; border: 0; font-family: malgun gothic,dotum,arial,tahoma;">
    			        <colgroup>
    			            <col width="800px">
    			        </colgroup>

    			        <tbody>
    			            <tr>
    			                <td style="padding: 3px; height: 20px; vertical-align: middle"
    			                    class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">

    			                    3. 업무적용점
    			                </td>
    			            </tr>
    			            <tr>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="9"
    			                        data-dsl="{{textarea}}" data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><textarea class="txta_editor"></textarea><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="9"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			        </tbody>
    			    </table>


    			    <table
    			        style="width: 800px; margin-top:10px; border-collapse: collapse !important; color: #000; background: #fff; font-size: 12px; border: 0; font-family: malgun gothic,dotum,arial,tahoma;">
    			        <colgroup>
    			            <col width="800px">
    			        </colgroup>

    			        <tbody>
    			            <tr>
    			                <td style="padding: 3px; height: 20px; vertical-align: middle"
    			                    class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">

    			                    4. 기타
    			                </td>
    			            </tr>
    			            <tr>
    			                <td style="padding: 3px; height: 20px; border: 1px solid #000; vertical-align: middle">
    			                    <span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="10"
    			                        data-dsl="{{textarea}}" data-wrapper=""
    			                        style="width: 100%; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
    			                        data-value="" data-autotype=""><textarea class="txta_editor"></textarea><span
    			                            contenteditable="false" class="comp_active"
    			                            style="display: none; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <span class="Active_dot1"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot2"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                            <span class="Active_dot3"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
    			                                class="Active_dot4"
    			                                style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
    			                        </span> <span contenteditable="false" class="comp_hover" data-content-protect-cover="true"
    			                            data-origin="10"
    			                            style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
    			                            <a contenteditable="false" class="ic_prototype ic_prototype_trash"
    			                                data-content-protect-cover="true" data-component-delete-button="true"></a> </span>
    			                    </span><br>
    			                </td>
    			            </tr>
    			        </tbody>
    			    </table>
    			</span>
               `;
               $('.raw-html-embed__source').val(htmlContent);
    	   } else {
    		  Swal.fire('','먼저 insertHTML 버튼 <svg class="ck ck-icon ck-reset_all-excluded ck-icon_inherit-color ck-button__icon" viewBox="0 0 20 20"><path d="M17 0a2 2 0 0 1 2 2v7a1 1 0 0 1 1 1v5a1 1 0 0 1-.883.993l-.118.006L19 17a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2l-.001-1.001-.116-.006A1 1 0 0 1 0 15v-5a1 1 0 0 1 .999-1L1 2a2 2 0 0 1 2-2h14zm.499 15.999h-15L2.5 17a.5.5 0 0 0 .5.5h14a.5.5 0 0 0 .5-.5l-.001-1.001zm-3.478-6.013-.014.014H14v.007l-1.525 1.525-1.46-1.46-.015.013V10h-1v5h1v-3.53l1.428 1.43.048.043.131-.129L14 11.421V15h1v-5h-.965l-.014-.014zM2 10H1v5h1v-2h2v2h1v-5H4v2H2v-2zm7 0H6v1h1v4h1v-4h1v-1zm8 0h-1v5h3v-1h-2v-4zm0-8.5H3a.5.5 0 0 0-.5.5l-.001 6.999h15L17.5 2a.5.5 0 0 0-.5-.5zM10 7v1H4V7h6zm3-2v1H4V5h9zm-3-2v1H4V3h6z"></path></svg> 을 눌러주세요.', 'warning');
    	   }
       });
   });
</script>
