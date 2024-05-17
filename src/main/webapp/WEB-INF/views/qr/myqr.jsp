<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<table >
		<tr align="center">
			<td colspan="2">
<%-- 				<img alt="" src="/profile/view/${emp.}"> --%>
			</td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<img alt="" src="/qr/showqr?empNo=${empl.emplNo }">
			</td>
		</tr>
		<tr align="center">
			<td colspan="2"><h2> ${empl.emplNm } </h2></td>
		</tr>
		<tr align="center">
			<td colspan="2">${empl.deptNm }</td>
		</tr>
<!-- 		<tr align="center"> -->
<!-- 			<td width="100">출근</td> -->
<%-- <%-- 			<td>${inTime }</td> --%> --%>
<!-- 		</tr> -->
<!-- 		<tr align="center"> -->
<!-- 			<td>퇴근</td> -->
<%-- <%-- 			<td>${outTime }</td> --%> --%>
<!-- 		</tr> -->
	</table>
</body>
</html>