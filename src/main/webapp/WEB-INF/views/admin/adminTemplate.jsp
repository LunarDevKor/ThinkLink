<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 메타 태그 영역 -->
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta id="_csrf" name="_csrf" content="${_csrf.token }" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }" />

<title>THINK LINK ADMIN</title>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.employeeVO" var="employee" />
	<c:set var="employee" value="${employee }" scope="session" />
</sec:authorize>

<style>
.header-menu-option {
	display: flex;
	align-items: center;
	padding: 0;
	margin-bottom: 0;
}

.header-option {
	z-index: 10;
	display: block;
	position: absolute;
	top: 12px;
	right: 16px;
}

.header-option ul {
	display: flex;
	align-items: center;
	padding: 0;
}

.header-option ul li {
	display: inline-block;
	margin-right: 10px;
}

.header-option ul li:last-child {
	margin-right: 0;
}

.fa-bars {
	color: #333;
	transition: color 0.3s ease, transform 0.3s ease;
}

#toggle-sidebar {
	margin-left: 15px;
}

#toggle-sidebar:hover .fa-bars {
	color: #007bff;
	transform: scale(1.1);
}

.left-sidebar {
	width: 250px;
	position: fixed;
	left: 0;
	transition: all 0.3s linear;
}

.page-wrapper {
	transition: margin-left 0.3s linear;
	margin-left: 250px;
}

.left-sidebar.hidden {
	left: -250px;
}

.page-wrapper.contracted {
	margin-left: 0px;
}
</style>
<!-- HEADER PART -->
<tiles:insertAttribute name="headerPart" />
</head>
<script>
var header = "";
var token = "";

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
<body style="background: #f1f1f1;">
	<div id="main-wrapper">
		<!-- ASIDE 영역 -->
		<tiles:insertAttribute name="asideAdmin" />
		<div class="page-wrapper">
				<tiles:insertAttribute name="headerAdmin" />
			<div class="container-fluid p-9">
				<!-- CONTENT 영역 -->
				<tiles:insertAttribute name="contentAdmin" />
			</div>
		</div>
	</div>
	<!-- FOOTER PART -->
	<tiles:insertAttribute name="footerPart" />
</body>
<script>
	document.addEventListener("DOMContentLoaded", function(e) {
		let sidebarHidden = false;
		let toggleSidebar = $('#toggle-sidebar');

		function toggleSidebarAdmin() {
			$('.left-sidebar').toggleClass('hidden');
			$('.page-wrapper').toggleClass('contracted');
		}

		$('#toggle-sidebar').on('click', function(e) {
			e.preventDefault();
			toggleSidebarAdmin();
		});
	});
</script>
</html>