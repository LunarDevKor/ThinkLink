<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<!-- 메타 태그 영역 -->
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta id="_csrf" name="_csrf" content="${_csrf.token }" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }" />

<title>THINK LINK</title>

<tiles:insertAttribute name="headerPart"/>
</head>

<body>
	<tiles:insertAttribute name="content"/>
	
	<tiles:insertAttribute name="footerPart"/>
	
<c:if test="${not empty message }">
	<script>
		Swal.fire({
			title: '로그인 실패!',
			text: '${message}',
			icon: 'error',
			confirmButtonText: '확인'
		}).then((result) => {
			if(result.isConfirmed) {
				<c:remove var="message" scope="request"/>
				<c:remove var="message" scope="session"/>
				location.replace('/login');
			}
		});
	</script>
</c:if>
</body>
</html>