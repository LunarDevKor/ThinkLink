<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="text-center">
	<h2> <font id="time"></font> ${empl.emplNm }님, 안녕하세요! </h2>
</div>

<script>
let date = new Date();

let hours = temp(date.getHours());
let minutes = temp(date.getMinutes());

$('#time').append(hours + '시' + minutes + '분 ');

function temp(num) {
	return num < 10 ? '0' + num : num;
}
</script>