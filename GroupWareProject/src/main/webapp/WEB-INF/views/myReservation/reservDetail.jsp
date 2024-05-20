<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="card-body">
	<h4 class="card-title">예약상세</h4>

	<form class="floating-labels mt-4 pt-2">
		<div class="form-group mb-4">
<!-- 			<select class="form-control form-select" id="input1"> -->
<!-- 				<option></option> -->
<!-- 				<option>세미나룸</option> -->
<!-- 				<option>프로젝트룸1실</option> -->
<!-- 				<option>프로젝트룸2실</option> -->
<!-- 				<option>대회의실</option> -->
<!-- 				<option>일반회의실</option> -->
<!-- 			</select> -->
			<input type="text" class="form-control" id="input1"  value="${roomVO.mtgRoomNm}" readonly="readonly">
			<span class="bar"></span> <label for="input1">시설명</label>
		</div>
		<div class="form-group mb-4">
			<input type="text" class="form-control" id="input2"  value="${roomVO.resveNo}" readonly="readonly">
			<span class="bar"></span> <label for="input2">예약번호</label>
		</div>
		<div class="form-group mb-4"><br>
          <div class="form-group">
             <input type="text" class="form-control" id="input3"  value="  <fmt:formatDate value="${roomVO.resveBeginDt}" pattern="yyyy년 MM월 dd일 HH시 mm분" /> ~ 
             <fmt:formatDate value="${roomVO.resveEndDt}" pattern="yyyy년 MM월 dd일 HH시 mm분" />" readonly="readonly">
          	
          </div>
			<span class="bar"></span> <label for="input3">예약날짜</label>
		</div>
		<div class="form-group mb-4">
			<input type="text" class="form-control" id="input4"  value="${roomVO.resveCn}" readonly="readonly">
			<span class="bar"></span> <label for="input7">예약내용</label>
		</div>
		<div >
			<a href="" class="text-primary edit" onclick="cancelReserv(${roomVO.resveNo })">
			<span class="badge rounded-pill bg-primary-subtle text-primary fw-semibold fs-2">예약취소</span>
			</a>
		</div>
		<sec:csrfInput />
	</form>
</div>
<script type="text/javascript">
	$('.floating-labels .form-control').on(
			'focus blur',
			function(e) {
				$(this).parents('.form-group').toggleClass('focused',
						(e.type === 'focus' || this.value.length > 0));
			}).trigger('blur');

		  // 취소 버튼 클릭 시 이벤트 처리
		 function cancelReserv(resveNo) {
			  var eventData = {
					  resveNo: resveNo,
				    };

		    // Ajax 요청 보내기
		    $.ajax({
		        url: '/myReservation/deleteDetail',
		        type: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify(eventData),
		        beforeSend: function(xhr) {
		        	 xhr.setRequestHeader(header, token);  
		        },
		        success: function(response) {
		            alert('예약 신청이 취소되었습니다.');
		            window.location.href = "/myReservation/roomList"; 
		        },
		        error: function(xhr) {
		            alert('Error updating approval status: ' + xhr.responseText);
		        }
		    });
		  }
	
	
	
</script>