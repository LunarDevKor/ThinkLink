<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
.w-15 {
	width: 15% !important;
}
</style>

<c:set var="title" value="전체 알림"/>
<c:choose>
	<c:when test="${type == 'unread'}">
		<c:set var="title" value="안읽은 알림"/>
	</c:when>
	<c:when test="${type == 'approval'}">
		<c:set var="title" value="전자결재"/>
	</c:when>
	<c:when test="${type == 'board'}">
		<c:set var="title" value="게시판"/>
	</c:when>
	<c:when test="${type == 'mail'}">
		<c:set var="title" value="메일"/>
	</c:when>
	<c:when test="${type == 'schedule'}">
		<c:set var="title" value="일정"/>
	</c:when>
	<c:when test="${type == 'rental'}">
		<c:set var="title" value="예약 및 대여"/>
	</c:when>
	<c:when test="${type == 'project'}">
		<c:set var="title" value="프로젝트"/>
	</c:when>
</c:choose>

<div class="row">
	<div class="col-xl-2">
		<div class="card">
			<div class="card-body">
				<h4 class="fw-semibold">알림</h4>
				<ul>
					<li>
						<a class="w-100 d-block" href="/noti?type=all">
							<span class="fw-normal fs-4">전체 알림</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=unread">
							<span class="fw-normal fs-4">안읽은 알림</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=approval">
							<span class="fw-normal fs-4">전자결재</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=project">
							<span class="fw-normal fs-4">프로젝트</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=mail">
							<span class="fw-normal fs-4">메일</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=schedule">
							<span class="fw-normal fs-4">일정</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=rental">
							<span class="fw-normal fs-4">예약 및 대여</span>
						</a>
					</li>
					<li class="mt-1">
						<a class="w-100 d-block" href="/noti?type=board">
							<span class="fw-normal fs-4">게시판</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="col-xl-10 overflow-auto">
		<div class="card overflow-auto">
			<div class="card-body overflow-auto" style="height: 85vh !important;">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<p class="h5 card-title fw-semibold m-0">${title } (${fn:length(notiList)})</p>
					<div class="input-group w-15">
						<button type="button" class="btn btn-sm btn-primary" id="allRead">
							<span>
								<i class="fa-solid fa-check fa-fw fa-xl"></i>
								<font class="fw-bold">전체읽음</font>
							</span>
						</button>
						<button type="button" class="btn btn-sm btn-danger" id="allDelete">
							<span>
								<i class="fa-sharp fa-solid fa-x fa-fw fa-xl"></i>
								<font class="fw-bold">전체삭제</font>
							</span>
						</button>
					</div>
				</div>
				<c:forEach var="noti" items="${notiList }">
					<%-- 						<fmt:formatDate var="formatDate" value="${noti.ntcnDt }" pattern="yyyy-MM-dd HH:mm"> --%>
					<div class="col-lg-12 col-md-6">
						<div class="card">
							<a href="${noti.ntcnUrl }" class="stretched-link" data-no="${noti.ntcnNo }" data-read-dt="${noti.ntcnReadDt }">
								<div class="card-body">
									<div class="row">
										<div class="col-1">
											<c:if test="${noti.ntcnReadDt == null}">
												<div class="bg-primary-subtle text-info rounded d-flex align-items-center p-8 justify-content-center">
													<i class="ti ti-bell fs-8" style="color: #ff5757;"></i>
												</div>
											</c:if>
											<c:if test="${noti.ntcnReadDt != null}">
												<div class="bg-primary-subtle text-muted rounded d-flex align-items-center p-8 justify-content-center">
													<i class="ti ti-bell fs-8" style="color: black;"></i>
												</div>
											</c:if>
										</div>
										<div class="col-11 d-flex align-items-center justify-content-start text-start">
											<div>
												<h4 class="card-title text-start">${noti.ntcnContent }</h4>
												<h6 class="card-subtitle mb-0">${noti.ntcnDt }</h6>
											</div>
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<script>
let links = $('.stretched-link');
let allReadBtn = $('#allRead');
let allDeleteBtn = $('#allDelete');
links.on('click', function(e) {
	e.preventDefault();
	let nextPage = $(this).attr('href');
	let readDt = $(this).data('readDt');
	console.log(readDt);
	
	if(readDt == null) {
		let ntcnNo = $(this).data('no');
		sendAjax(ntcnNo);
		location.href = nextPage;
	}else{
		location.href = nextPage;
	}
});

allReadBtn.on('click', function() {
	for(let link of links) {
		let readDt = $(link).data('readDt');
		if(!readDt) {
			sendAjax($(link).data('no'));
		}
	}
	location.href = '/noti';
});

allDeleteBtn.on('click', function() {
	showConfirm('알림 전체삭제!', '정말 삭제하시겠습니까?', 'warning')
	.then(result => {
		if(result.isConfirmed) {
			for(let link of links) {
				sendAjax($(link).data('no'), '/notidelete');
			}
			
			location.href = '/noti';
		}
	});
});

function sendAjax(ntcnNo, url) {
	if(url == undefined) {
		url = '/notiread';
	}
	
	$.ajax({
		url: url,
		type: 'post',
		async: false,
		data: JSON.stringify({
			ntcnNo : ntcnNo
		}),
		contentType: 'application/json; charset=UTF-8'
	})
	.done(function(res) {
		if(res == 'OK') {
			showToast('정상적으로 처리되었습니다!', 'success');
		}
	})
}
</script>