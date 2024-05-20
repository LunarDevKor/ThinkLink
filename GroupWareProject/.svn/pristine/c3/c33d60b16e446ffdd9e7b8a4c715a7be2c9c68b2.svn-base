<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 20%;
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

<div class="flex-fill d-flex align-items-stretch">
	<div class="card w-100 position-relative overflow-hidden">
		<div class="card-body p-4">
			<h5 class="card-title fw-semibold">
				서명 이미지
				<span class="text-danger">*</span>
			</h5>
			<p class="card-subtitle mb-4">변경할 서명 이미지를 등록해주세요</p>
			<div class="text-center">
				<img src="${employee.emplSign }" alt="" id="signImg" class="tl-profile-img" width="32" height="40">
				<p class="mb-0">JPG, GIF 또는 PNG 허용</p>
				<form action="/approval/signedit" method="post" enctype="multipart/form-data">
					<div class="filebox my-3">
					    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
					    <label for="signFile">파일찾기</label> 
					    <input type="file" id="signFile" name="signFile" accept="image/*">
					</div>
					<button type="submit" class="btn btn-dark rounded-0">업로드</button>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
	$('#signFile').on('change', function(e) {
		let file = e.target.files[0];
		if(file){
			let reader = new FileReader();
			reader.onload = function(event) {
				$('#signImg').attr('src', event.target.result);
			}
			reader.readAsDataURL(file);
		}
	})
})
</script>