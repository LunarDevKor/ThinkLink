<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-color-theme="Blue_Theme" data-layout="vertical">
<head>
<!-- 메타 태그 영역 -->
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta id="_csrf" name="_csrf" content="${_csrf.token }" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }" />
<style>
.toast-top-end-custom {
	top: 80px;
}
::-webkit-scrollbar {
	width: 8px;
}
::-webkit-scrollbar-track {
/* 	box-shadow: inset 0 0 5px grey; */
	border-radius: 3px;
	background: #fff;
}
::-webkit-scrollbar-thumb {
	background: #c0c0c0;
	border-radius: 10px;
}
::-webkit-scrollbar-corner {
	background: transparent;
}
</style>
<title>THINK LINK</title>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.employeeVO" var="employee" />
	<c:set var="employee" value="${employee }" scope="session" />
</sec:authorize>

<tiles:insertAttribute name="headerPart" />

<script>
	var header = "";
	var token = "";
	var eventSource = null;
	
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
		
		setupSSE();
	})
	
	$(function() {
	    let notiArea = $('#noti');
	    
		$.get('/notilist')
		.done(function (res) {
			notiArea.html('');
			let cnt = 0;
			for(let noti of res) {
				let html = createNotiHTML(noti);
				notiArea.append(html);
				if(noti.ntcnReadDt == null) {
					cnt++;
				}
			}
			
			if(cnt == 0) {
				$('#notiSize').text("0");
				$('#drop2').html('<i class="fa-sharp fa-regular fa-bell fa-xl fa-fw fa"></i>');
			}else{
				$('#notiSize').text(cnt + " New!");
				$('#drop2').html('<i class="fa-sharp fa-regular fa-bell fa-bounce fa-xl fa-fw" style="color: #ff5757;"></i>');
			}
		});
		
		notiArea.on('click', 'a', function(e) {
			e.preventDefault();
			let nextPage = $(this).attr('href');
			let readDt = $(this).data('readDt');
			let ntcnNo = $(this).data('no');
			
			if(readDt != null) {
				location.href = nextPage;
			}else{
				$.ajax({
					url: '/notiread',
					type: 'post',
					contentType: 'application/json; charset=UTF-8',
					data: JSON.stringify({
						ntcnNo : ntcnNo
					})
				}).done(function(res) {
					if(res == 'OK') {
						location.href = nextPage;
					}
				});
			}
		});
		
	});
	
	function createNotiHTML(noti) {
		let content = noti.ntcnContent; 
		if(content.length > 25) {
			content = content.substring(0, 25);
		}
		
		let html = '';
		html += '<a href="'+noti.ntcnUrl+'" class="py-6 px-7 d-flex align-items-center dropdown-item target-link" data-no="'+noti.ntcnNo+'" data-read-yn="'+noti.ntcnReadDt+'">'
		html +=	'	<span class="me-3">';
		html += '		<i class="fa-sharp fa-regular fa-circle-exclamation fa-2xl fa-fw"></i>';
		html += '	</span>';
		html += '	<div class="w-75 d-inline-block v-middle">';
		html += '		<h6 class="mb-1 fw-semibold lh-base">'+content+'</h6>';
		html += '		<span class="fs-2 d-block text-body-secondary">'+noti.ntcnDt+'</span>';	
		html += '	</div>'
		html += '</a>';
		return html;
	}
	
	function setupSSE() {
		
	    if (eventSource && eventSource.readyState !== EventSource.CLOSED) {
	        console.log('SSE connection already open.');
	        return;
	    }
	    
		/*
			Sse 통신을 위한 eventSource 객체 생성 후 header 값 추가
		*/
		eventSource = new EventSource('//${pageContext.request.serverName}:${pageContext.request.serverPort}/sse', {
			headers : {
				'Accept' : 'text/event-stream; charset=UTF-8',
				'Cache-Control' : 'no-cache',
				header : token,
			}
		});
		
		console.log(eventSource.readyState);
		
		eventSource.onopen = () => {
		    console.log('SSE connection opened.');
		};
	
		eventSource.onmessage = (event) => {
			let data = event.data;
			
			if(data.includes('connect')) {
				console.log('서버로 부터 응답');
				return;
			}
			
			console.log('실행됫나?')
			
		    let noti = JSON.parse(data);
		    let notiArea = $('#noti');
		    let html = createNotiHTML(noti);
		    $('#drop2').html('<i class="fa-sharp fa-regular fa-bell fa-bounce fa-xl fa-fw" style="color: #ff5757;"></i>');
		    
		    let cnt = $('#notiSize').text();
		    let nCnt = Number(cnt.split(' ')[0]);
		    $('#notiSize').text((nCnt+1) + " New!");
		    
		    showNotiToast('알림이 도착하였습니다!', 'info');
			notiArea.prepend(html);
		};
	
		eventSource.onerror = (error) => {
			console.log(error);
			eventSource.close();
		};
		
		window.addEventListener('beforeunload', (e) => {
			eventSource.close();
		});
	}
</script>
</head>
<body>

	<div id="main-wrapper">
		<!-- ASIDE 영역 -->
		<tiles:insertAttribute name="aside" />
		<div class="page-wrapper">
			<!-- HEADER 영역 -->
			<tiles:insertAttribute name="header" />
			<div class="body-wrapper">
				<div class="container-fluid">
					<!-- CONTENT 영역 -->
					<tiles:insertAttribute name="content" />
					<!-- FOOTER 영역 -->
					<tiles:insertAttribute name="footer" />
				</div>
			</div>
		</div>
	</div>

	<tiles:insertAttribute name="footerPart" />

</body>
</html>