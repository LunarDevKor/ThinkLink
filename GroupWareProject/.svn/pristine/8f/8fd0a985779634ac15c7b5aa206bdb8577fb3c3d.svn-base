<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<h4 class="fw-semibold mb-8" style="margin-bottom: 30px;">조직도 관리</h4>

<div class="card mt-3">

	<div class="card-body">
	
		
				<div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-organ-tree" role="tabpanel" aria-labelledby="nav-organ-tree-tab" tabindex="0">
						<div class="searchInput input-group">
							<input type="text" id="oragn-search" class="form-control rounded-0" maxlength="20" placeholder="이름/부서/직위" />
							<button type="button" class="btn btn-dark bg-dark rounded-0">
								<i class="fa-light fa-magnifying-glass fa-xl fa-fw"></i>
							</button>
						</div>
						<div id="jsTree" class="overflow-auto" style="height: 300px;"></div>
					</div>
					<div class="tab-pane fade" id="nav-my-approval-line" role="tabpanel" aria-labelledby="nav-my-approval-line-tab">
						<section class="" style="height: 339px;">
							<ul id="line-area">
							</ul>
						</section>
					</div>
					<div class="tab-pane fade" id="nav-my-references-line" role="tabpanel" aria-labelledby="nav-my-refer-line-tab">
						<section class="" style="height: 339px;">
							<ul id="refer-area">
							</ul>
						</section>
					</div>
				</div>
	
	</div>
	<!-- 아래쪽 구역 끝 -->
</div>
<!-- 스크립트시작 -->
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>
	// 페이징 처리
	$(function() {
		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
	});
	
function enabled(emplNo,emplNm,clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"을(를) 이용중지하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/enabledUpdate",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						$('#' + emplNo).remove();
						showToast(emplNm+" 사원의 상태가 변경되었습니다!", 'success');
					}
				}
			});
		}
	});
}

function deleteAuth(emplNo,emplNm,clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"을(를) 관리자에서\n삭제하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/deleteAuth",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						var newHtml = `N <a class='mb-0' href='#' onclick="insertAuth('\${emplNo}','\${emplNm}')"> [지정]</a>`;
						$('#adminStatus'+emplNo).html(newHtml);
						showToast(emplNm+" 사원이 관리자에서 삭제되었습니다!", 'success');
					}
				}
			});
		}
	});
	
}

function insertAuth(emplNo,emplNm,clsfNm) {
	
	showConfirm(emplNm+" "+clsfNm+"을(를) 관리자로\n지정하시겠습니까?",'','question').then(result=> {
		if(result.isConfirmed){
			$.ajax({
				url:"/admin/employee/insertAuth",
				type:"post",
				data: JSON.stringify({emplNo : emplNo}),
				contentType : "application/json; charset=utf-8",
				success: function(res){
					if(res === "SUCCESS") {
						var newHtml = `Y <a class='mb-0' href='#' onclick="deleteAuth('\${emplNo}','\${emplNm}')"> [삭제]</a>`;
						$('#adminStatus'+emplNo).html(newHtml);
						showToast(emplNm+" 사원이 관리자로 지정되었습니다!", 'success');
					}
				}
			});
		}
	});
}
</script>