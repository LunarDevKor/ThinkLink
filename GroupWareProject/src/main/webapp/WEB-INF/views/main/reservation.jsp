<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
.legend-item {
    display: inline-block;
    margin-right: 20px;
}
.color-box {
    display: inline-block;
    width: 15px;
    height: 15px;
    margin-right: 5px;
}
.reserved {
    background-color: #808080; /* 회색 */
}
.my-reservation {
    background-color: #00BFFF; /* 하늘색 */
}
.my-waiting{
  background-color: #FFA500; /*오렌지색  */ 
}
/* 모든 input 필드에 적용되는 스타일 */
#reservationForm input {
    border: none; /* 테두리 제거 */
    background: transparent; /* 배경색 투명 */
}

/* 일정 이름 필드 스타일 재정의 */
#reservationForm input#title {
    border: 1px solid #ccc; /* 테두리를 회색으로 설정 */
    background: white; /* 배경색을 흰색으로 설정 */
}
.bold-link {
    font-weight: bold; /* Set the font weight to bold */
}
   .nav-link .d-none.d-md-block {
        font-size: 16px; /* Adjust the font size as needed */
}
  #resourceNameRoom, #resourceNameVehicle, #resourceNameSupplies,
        #startRoom, #startVehicle, #startSupplies,
        #endRoom, #endVehicle, #endSupplies,
        #loggedInUserName {
            border: none;
            background: transparent;
            pointer-events: none;
        }
.short-select {
    width: 30%; /* Adjust the width of the select box to half of its container */
}
</style>
<div class="container-fluid">

 					
	<div class="tab-pane fade show active" id="pills-normal" role="tabpanel" aria-labelledby="pills-normal-tab" tabindex="0">
		<div class="card">
			<br>
			<h3 class="fw-semibold mb-4" style="margin-left: 10px;">&nbsp;&nbsp;
					<i class="fa-sharp fa-regular fa-car-side fa-fw fa"></i>&nbsp;&nbsp;
				대여
			</h3>
			<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4">
				
				<ul class="nav nav-pills user-profile-tab justify-content-center" id="pills-tab" role="tablist">

					<li class="nav-item" role="presentation">
						<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/myReservation/main';" id="pills-stop-tab" data-bs-toggle="pill" data-bs-target="#pills-stop" type="button" role="tab" aria-controls="pills-stop" aria-selected="true">
							<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;시설물 예약하기&nbsp;&nbsp;&nbsp;&nbsp;</span>
						</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/myReservation/roomList';" id="pills-stop-tab" data-bs-toggle="pill" data-bs-target="#pills-stop" type="button" role="tab" aria-controls="pills-stop" aria-selected="true">
							<span class="d-none d-md-block">&nbsp;&nbsp;&nbsp;&nbsp;예약현황보기&nbsp;&nbsp;&nbsp;&nbsp;</span>
						</button>
					</li>
				</ul>
			</div>

					<div class="row gx-0">
						<div class="calendar-header">
			    			<div id="legend">
			    			    <br>
						        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						        <span class="legend-item"><span class="color-box reserved"></span>예약됨</span>
						        <span class="legend-item"><span class="color-box my-reservation"></span>나의 예약</span>
			    			</div>
						</div>
					<div class="col-lg-2">
						<div class="p-4 calendar-sidebar">
							<ul class="nav flex-column">
								<li class="nav-item">
									<a href="#" class="nav-link" id="all-resources">전체설비&nbsp;&nbsp;<i class="fa-solid fa-caret-down fa-lg"></i></a>
									<ul class="submenu">
										<li><a href="#" class="nav-link" id="meeting-rooms" >회의실</a></li>
										<li><a href="#" class="nav-link" id="vehicles">차량</a></li>
										<li><a href="#" class="nav-link" id="supplies">비품</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-lg-10">
						<div class="p-4 calender-sidebar app-calendar">
							<div id="calendar"></div>
						</div>
					</div>
				</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">신청양식 </h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
					<!--회의실예약폼시작  -->
				<form id="meetingRoomForm" class="reservation-form" style="display: none;">
					<div class="modal-body">
						<input id="resourceType" name="resourceType" hidden value="room">
						   			
						예약자원:&nbsp;
						  <input type="text" id="resourceNameRoom" readonly="readonly" >
                    	  <input type="hidden" id="mtngRoomNoId" name="mtngRoomNo">
						<br>
						일정이름 :
						<input type="text" id="resveCnId" name="resveCn" placeholder="일정 이름 입력"/>
						<br /> 시작시간 :
						<input  id="startRoom" name="resveBeginDt" readonly="readonly"/>
						<br /> 종료시간 :
						<input  id="endRoom" name="resveEndDt" readonly="readonly"/>
						<br>
						예약자:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" id="loggedInUserName" value="${user.emplNm}" readonly="readonly" />
						<input type="hidden" id="loggedInUserNo" name="emplNo" value="${user.emplNo}" />
					</div>
					<!--차량예약폼시작  -->
				</form>
				<form id="vehicleForm" class="reservation-form" style="display: none;">
					<div class="modal-body">
						<input id="resourceType" name="resourceType" hidden  value="vehicle">
						예약자원:&nbsp;
						  <input type="text" id="resourceNameVehicle" readonly="readonly" >
                    	  <input type="hidden" id="eqpnmCdIdCar" name="eqpnmCd"> <br>
						대여사유:&nbsp;
						<input type="text" id="erntResnIdCar" name="erntResn" placeholder="대여사유입력"/><br>
					    시작시간 :
						<input  id="startVehicle" name="erntBeginDt" readonly="readonly"/>
						<br /> 종료시간 :
						<input  id="endVehicle" name="erntEndDt" readonly="readonly"/>
						<br>
						예 약 자:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" id="loggedInUserName" value="${user.emplNm}" readonly="readonly" />
						<input type="hidden" id="loggedInUserNo" name="emplNo" value="${user.emplNo}" />
					</div>
				</form>
				
					<!--비품예약폼시작  -->
				<form id="suppliesForm" class="reservation-form" style="display: none;">
					<div class="modal-body">
						<input id="resourceType" name="resourceType" hidden  value="supplies">
						예약자원:&nbsp;
						  <input type="text" id="resourceNameSupplies" readonly="readonly" >
                    	  <input type="hidden" id="eqpnmCdIdSupplies" name="eqpnmCd">
						<br>
						대여사유:&nbsp;
						<input type="text" id="erntResnIdSupplies" name="erntResn" placeholder="대여사유입력"/><br>
						<div >
							<label for="erntQy">수  량:</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   						 <input type="number" id="erntQy" name="erntQy" placeholder="수량입력">
						</div>
					     시작시간 :
						<input  id="startSupplies" name="erntBeginDt" readonly="readonly"/>
						<br /> 종료시간 :
						<input  id="endSupplies" name="erntEndDt" readonly="readonly"/>
						<br>
						예약자:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" id="loggedInUserName" value="${user.emplNm}" readonly="readonly" />
						<input type="hidden" id="loggedInUserNo" name="emplNo" value="${user.emplNo}" />
					</div>
				</form>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="saveChanges" onclick="addReservation()">신청</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">신청상세보기</h5>
            </div>
            <div class="modal-body">
            	<input id="modalEventId" name="" readonly="readonly" type="hidden"/>
                <input  id="modalEventResourceType" name="" readonly="readonly" type="hidden" /></p>
                <p><strong>예약내용:</strong> <input  id="modalEventTitle" name=""/></p>
                <p><strong>예약수량:</strong> <input  id="modalEventQty" name=""/></p>
                <p><strong>시작시간:</strong> <input  id="modalEventStart" name=""  /></p>
                <p><strong>종료시간:</strong> <input  id="modalEventEnd" name=""  /></p>
                <p><strong>예약자:</strong>  <input type="text" id="loggedInUserName" value="${user.emplNm}" readonly="readonly" /></p>
				<input type="hidden" id="loggedInUserNo" name="emplNo" value="${user.emplNo}" />
                
            </div>
            <div class="modal-footer">
            	 <button type="button" class="btn btn-primary" id="saveEventChanges">예약수정</button>
                <button type="button" class="btn btn-secondary" id="deleteEventChanges"   data-bs-dismiss="modal">예약취소</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal END -->
 <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/project/js/sweetalert_custom.js"></script>
<script src="${pageContext.request.contextPath }/resources/timeline/index.global.min.js"></script>

<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'warning');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script type="text/javascript">
var calendar; // 전역 범위에서 calendar 변수 선언
			  //전역 범위에서 자원 변수 선언	
var resourcesForRooms = [
    { id: '1', title: '세미나룸' },
    { id: '2', title: '프로젝트룸1실' },
    { id: '3', title: '프로젝트룸2실' },
    { id: '4', title: '대회의실' },
    { id: '5', title: '일반회의실' }
];
var resourcesForVehicles = [
    { id: '6', title: '마티즈8894' },
    { id: '7', title: '모닝1124' },
    { id: '8', title: '소렌토4929' },
    { id: '9', title: '아반떼0769' },
    { id: '10', title: '컬리넌1923' },
    
];
var resourcesForSupplies = [
    { id: '11', title: '마이크' },
    { id: '12', title: '빔프로젝터' },
    { id: '13', title: '의자' },
    { id: '14', title: '화이트보드' },
    { id: '15', title: '노트북' }
];

/*자원카테고리에 따른 리소스 배치  */
function getResourceForType(resourceType) {
	 console.log("Fetching resources for type:", resourceType); // 로그 출력
    switch (resourceType) {
        case 'room':
            return resourcesForRooms;
        case 'vehicle':
            return resourcesForVehicles;
        case 'supplies':
            return resourcesForSupplies;
        default:
            return []; // 기본값은 빈 배열
    }
}

/* 회의실, 차량, 비품 예약조회 */
function fetchResourceReservations(resourceType) {
	
	$.ajax({
		 url: '/myReservation/displayList/' + encodeURIComponent(resourceType),  // 서버 API 경로
        type: 'GET',
        dataType: 'json',
        beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
        
        success: function(data) {
        	console.log("조회된데이터",data);
            setupCalendar(data, resourceType); // 데이터를 받아 캘린더 설정
        },
        error: function(error) {
            console.error('Error fetching reservations:', error);
        }
    });
}


/* 예약데이터 조회*/
function setupCalendar(reservations, resourceType) {
	 console.log("Setting up calendar for resource type:", resourceType); // 함수 시작 시 로그 출력
	    console.log("Reservations data:", reservations); // 예약 데이터 로그 출력
    var calendarEl = document.getElementById('calendar');
    var events = []; // 이벤트 배열 초기화
    var loggedInUserNo = document.getElementById('loggedInUserNo').value;
    var loggedInUserName = document.getElementById('loggedInUserName').value; 
    var loggedInUserNoString = loggedInUserNo.toString(); // 숫자를 String으로 변환
    
    
    reservations.forEach(function(reservation) {
    	  
    	  var isMyReservation = (reservation.emplNo == loggedInUserNoString);
          var backgroundColor = isMyReservation ? '#00BFFF' : '#808080';
          var borderColor = isMyReservation ? '#007BFF' : '#505050';
          var userID = String(reservation.emplNo); // 사용자 ID를 문자열로 변환하여 저장
          var id, title, start, end, resourceId , qty ;
        	
          if (resourceType === 'room') {
              id = reservation.resveNo;
              title = reservation.resveCn; 
              start = reservation.resveBeginDt;
              end = reservation.resveEndDt;
              resourceId = String(reservation.mtngRoomNo);
          } else if (resourceType === 'vehicle') {
              id = reservation.erntNo;
              title = reservation.erntResn; 
              start = reservation.erntBeginDt;
              end = reservation.erntEndDt;
              resourceId = String(reservation.eqpnmCd);
          } else if (resourceType === 'supplies') {
              id = reservation.erntNo;
              title = reservation.erntResn; 
              start = reservation.erntBeginDt;
              end = reservation.erntEndDt;
              resourceId = String(reservation.eqpnmCd); 
              qty = String(reservation.erntQy);
          }
          events.push({
              id: id,
              isMyReservation: isMyReservation,
              title: title,
              start: start,
              end: end,
              resourceId: resourceId,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              resourceType: resourceType,
              emplNo: userID,  
              qty: qty
          });
          console.log("eventPushedEvents",events);
      })
	
    // 이전 캘린더 인스턴스 제거
    if (calendar) {
        calendar.destroy();
    }
    // 새 캘린더 인스턴스 생성
      calendar = new FullCalendar.Calendar(calendarEl, {

        initialView: 'resourceTimelineDay',
        height: '350px',
        expandRows: true,
        slotMinTime: '08:00',
        slotMaxTime: '20:00',
        slotDuration: '00:30:00',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'resourceTimelineDay resourceTimelineWeek'
        },
        selectable: true,
        selectMirror: true,
        navLinks: true,
        editable: true,
        dayMaxEventRows: true,
        nowIndicator: true,
        expandRows: false,
        resources: getResourceForType(resourceType), // 리소스 타입에 맞는 리소스 배열
       
        events: events, // 생성된 이벤트 배열 사용
        
        eventClick: function(info) {
            var loggedInUserNo = document.getElementById('loggedInUserNo').value;
            var eventUserNo = String(info.event.extendedProps.emplNo);
            var eventEnd = info.event.end; // 이벤트의 종료 시간

            // 현재 시간과 이벤트의 시작 시간 비교
//             if (new Date() < eventEnd && loggedInUserNo === eventUserNo) { // 로그인한 사용자와 이벤트의 사용자 번호가 일치하는 경우
            if (eventEnd && loggedInUserNo === eventUserNo) {
                var eventData = {
                    id: info.event.id,
                    title: info.event.title,
                    start: info.event.start,
                    end: info.event.end,
                    userID: info.event.extendedProps.emplNo,
                    resourceType: info.event.extendedProps.resourceType,
                    resourceId: info.event.resourceId,
                    qty: info.event.extendedProps.qty
                };
                console.log("eventData", eventData);

                $('#modalEventId').val(eventData.id);
                $('#modalEventTitle').val(eventData.title);
                $('#modalEventStart').val(formatDateToCustomFormat(eventData.start));
                $('#modalEventEnd').val(formatDateToCustomFormat(eventData.end));
                $('#modalEventResourceType').val(eventData.resourceType);
                
                //수량 input 필드 차량은 숨기기
                if (eventData.resourceType === 'vehicle' || 'room') {
                    $('#modalEventQty').parent().hide(); //차량 수량 필드는 숨기기
                } else {
                    $('#modalEventQty').parent().show(); //다른 자원타입은 보이기
                    $('#modalEventQty').val(eventData.qty); //수량 자원 넣기
                }

                // 모달 창 표시
                $('#editEventModal').modal('show');
            } else { 
                console.log("로그인한 사용자가 아닌 경우 or 이벤트가 과거에 있을 경우", loggedInUserNo);
            }
        },


        select: function(arg) {
	        /* 회의실 시간구간 선택 */	
	        $('#startRoom').val(formatDateToCustomFormat(arg.startStr));
	        $('#endRoom').val(formatDateToCustomFormat(arg.endStr));
	        /* 차량 시간구간 선택 */	
	        $('#startVehicle').val(formatDateToCustomFormat(arg.startStr));
	        $('#endVehicle').val(formatDateToCustomFormat(arg.endStr));
	        /* 비품 시간구간 선택 */	
	        $('#startSupplies').val(formatDateToCustomFormat(arg.startStr));
	        $('#endSupplies').val(formatDateToCustomFormat(arg.endStr));
	        
	        /*예약자원명 선택  */
	        $('#resourceNameRoom').val(arg.resource.title);
	        $('#resourceNameVehicle').val(arg.resource.title);
	        $('#resourceNameSupplies').val(arg.resource.title);
	        $('#mtngRoomNoId').val(arg.resource.id);
	        /*예약자원 id선택  */
	        $('#eqpnmCdIdCar').val(arg.resource.id);
	        $('#eqpnmCdIdSupplies').val(arg.resource.id);
	        $('#exampleModal').modal('show');
	       
        calendar.unselect();
        },
        
        selectAllow: function(arg) {
            return new Date(arg.start) >= new Date(); //지난 날짜 클릭 안됨.
        },
    });

    calendar.render();
}

    // 이벤트 핸들러 등록
    document.getElementById('meeting-rooms').addEventListener('click', function() {
    	document.getElementById('resourceType').value = 'room'; // 회의실 옵션 선택
    	setupCalendar(resourcesForRooms);
        fetchResourceReservations('room');
        showForm('meetingRoomForm');
        
    });
    document.getElementById('vehicles').addEventListener('click', function() {
    	document.getElementById('resourceType').value = 'vehicle'; // 회의실 옵션 선택
    	setupCalendar(resourcesForVehicles);
        fetchResourceReservations('vehicle');
        showForm('vehicleForm');
    });
    document.getElementById('supplies').addEventListener('click', function() {
    	document.getElementById('resourceType').value = 'supplies'; // 비품 옵션 선택
    	setupCalendar(resourcesForSupplies);
        fetchResourceReservations('supplies');
        showForm('suppliesForm');
    });
    
    function showForm(formId) {
        // 모든 폼을 숨김
        document.querySelectorAll('.reservation-form').forEach(form => {
            form.style.display = 'none';
        });
        // 선택된 폼만 표시
        document.getElementById(formId).style.display = 'block';
    }

//날짜 포맷 함수: Date 객체를 'YYYY-MM-DD HH24:MI' 형식의 문자열로 변환
function formatDateToCustomFormat(date) {
    var d = new Date(date);
    var year = d.getFullYear();
    var month = ('0' + (d.getMonth() + 1)).slice(-2);
    var day = ('0' + d.getDate()).slice(-2);
    var hour = ('0' + d.getHours()).slice(-2);
    var minute = ('0' + d.getMinutes()).slice(-2);
    return `\${year}-\${month}-\${day} \${hour}:\${minute}`;
}
/* 회의실 예약수정 */
$(document).ready(function() {
	
  $('#editEventModal').on('show.bs.modal', function(event) {
        var resourceType = $('#modalEventResourceType').val();
        if (resourceType === 'vehicle' || resourceType === 'supplies') {
            $('#saveEventChanges').hide(); // Hide the save changes button for vehicles and supplies
            // Make input fields readonly
            $('#modalEventTitle').prop('readonly', true);
            $('#modalEventStart').prop('readonly', true);
            $('#modalEventEnd').prop('readonly', true);
        } else {
            $('#saveEventChanges').show(); // Show the save changes button for other resource types
            // Make input fields editable
            $('#modalEventTitle').prop('readonly', false);
            $('#modalEventStart').prop('readonly', false);
            $('#modalEventEnd').prop('readonly', false);
     	}
 	});    
    $('#saveEventChanges').click(function() {
    	
    	
        // Collect data from the modal fields
        	var resourceType = $('#modalEventResourceType').val();
        	var eventData = {
        	            emplNo: $('#loggedInUserNo').val(), // Assuming you want to send the logged-in user's ID
        	            resveCn: $('#modalEventTitle').val(), // Get the value of the reservation title
        	            resveBeginDt: $('#modalEventStart').val(), // Get the start time
        	            resveEndDt: $('#modalEventEnd').val(), // Get the end time
        	            resveNo: $('#modalEventId').val() // Get the reservation ID
        	        };
        if(confirm('예약을 수정하시겠습니까?')) {	
	        $.ajax({
	            url: '/myReservation/modifyReservation',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(eventData),
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token);  
	            },
		            success: function(response) {
		                    alert('해당 예약이 수정되었습니다.');
		                    $('#editEventModal').modal('hide');
		                    location.reload(); 
		            },
		            error: function(xhr, status, error) {
		                alert('Error updating reservation: ' + xhr.responseText);
			        }
       		 
        	});
        } else {
            // 사용자가 '아니오'를 선택한 경우, 모달창을 닫기
            $('#editEventModal').modal('hide');
        }
  });
    /* 예약취소 */    
    $('#deleteEventChanges').click(function() {
        // Collect data from the modal fields
        	var resourceType = $('#modalEventResourceType').val();
        
	        var eventData = {
	            emplNo: $('#loggedInUserNo').val() // Assuming you want to send the logged-in user's ID
	        };
	        if(resourceType === 'room') {
	            eventData.resveNo = $('#modalEventId').val();
	        }
	        if(resourceType === 'vehicle' || resourceType === 'supplies' ) {
	            eventData.erntNo = $('#modalEventId').val();
	        }  
       
	    var url;
        switch(resourceType) {
            case 'room':
            	url = '/myReservation/deleteReservation'; 
                break;
            case 'vehicle':
            	url = '/myReservation/deleteRentalVehicle'; 
                break;
            case 'supplies':
            	url = '/myReservation/deleteRentalSupplies';
                break;
            default:
            	url = '/myReservation/deleteReservation';
                break;
        }
        if (confirm('예약신청을 취소하시겠습니까?')) {
	        $.ajax({
	            url: url,
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(eventData),
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token);  
	            },
	            success: function(response) {
	            	
	                alert('예약신청이 취소되었습니다!');
	                $('#editEventModal').modal('hide');
	                location.reload(); 
	            }, 
	            error: function(xhr, status, error) {
	                alert('Error updating reservation: ' + xhr.responseText);
	            }
	        });
	    	} else {
	        // 사용자가 '아니오'를 선택한 경우, 모달창을 닫기
	        $('#editEventModal').modal('hide');
   		 }
    
    });    
});


/*중복예약, 예약등록  */
function collectFormData() {
    var formData = {};
    var resourceType = document.getElementById('resourceType').value;

    switch(resourceType) {
        case 'room':																																																																																			
            formData = {
                resourceType: 'room',
                mtngRoomNo: document.getElementById('mtngRoomNoId').value,
                resveCn: document.getElementById('resveCnId').value,
                resveBeginDt: formatDateToCustomFormat(document.getElementById('startRoom').value),
                resveEndDt: formatDateToCustomFormat(document.getElementById('endRoom').value),
                emplNo: document.getElementById('loggedInUserNo').value
            };
            break;
        case 'vehicle':
            formData = {
                resourceType: 'vehicle',
                eqpnmCd: document.getElementById('eqpnmCdIdCar').value,
                erntResn: document.getElementById('erntResnIdCar').value,
                erntBeginDt: formatDateToCustomFormat(document.getElementById('startVehicle').value),
                erntEndDt: formatDateToCustomFormat(document.getElementById('endVehicle').value),
                emplNo: document.getElementById('loggedInUserNo').value
            };
            break;
        case 'supplies':
            formData = {
                resourceType: 'supplies',
                eqpnmCd: document.getElementById('eqpnmCdIdSupplies').value,
                erntResn: document.getElementById('erntResnIdSupplies').value,
                erntQy: document.getElementById('erntQy').value,
                erntBeginDt: formatDateToCustomFormat(document.getElementById('startSupplies').value),
                erntEndDt: formatDateToCustomFormat(document.getElementById('endSupplies').value),
                emplNo: document.getElementById('loggedInUserNo').value
            };
            break;
    }

    return formData;
}


document.getElementById('saveChanges').addEventListener('click', function() {
	
	
	var formData = collectFormData();
	var urlCheck;
    switch(formData.resourceType) {
        case 'room':
        	urlCheck = '/myReservation/reservations/check'; 
            break;
        case 'vehicle':
        	urlCheck = '/myReservation/rental/check'; 
            break;
        case 'supplies':
        	urlCheck = '/myReservation/rental/check';
            break;
        default:
        	urlCheck = '/myReservation/reservations/check';
            break;
    }
    
    $.ajax({
        url: urlCheck ,  
        type: 'POST',
        contentType: 'application/json; charset=UTF-8', 
        data: JSON.stringify(formData),
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);  
        },
        success: function(response) {
            saveReservation(formData);
        },
        error: function(response) {
            alert( response.responseText);
            $('#exampleModal').modal('hide');
        }
    });
});

function saveReservation(formData) {
  
    var url;
    switch(formData.resourceType) {
        case 'room':
            url = '/myReservation/addRoomReservation'; 
            break;
        case 'vehicle':
            url = '/myReservation/addVehicleReservation'; 
            break;
        case 'supplies':
            url = '/myReservation/addSuppliesReservation';
            break;
        default:
            url = '/myReservation/addRoomReservation';
            break;
    }
   
	    $.ajax({
	        url: url,
	        type: 'POST',
	        processData: false,
	        contentType: 'application/json; charset=UTF-8', 
	        data: JSON.stringify(formData),
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token); 
	        },
	        success: function(res, status, xhr) {
	        	 if (formData.resourceType === 'room') {
	        	        window.location.href = "/myReservation/roomList"; 
	        	      } else {
	        	        window.location.href = "/myReservation/rentalList"; 
	        	      }
	        	  },
	    error: function(xhr, status, error) {
	        showToast("예약 등록에 실패하였습니다.", "error");
	    }
	
	   });
   
};
/*시설 카테고리 클릭시 bold체로 변환  */
var links = document.querySelectorAll('.nav-link');

links.forEach(function(link) {
    link.addEventListener('click', function() {
        // Remove bold from all links
        links.forEach(function(el) {
            el.classList.remove('bold-link');
        });

        // Add bold to the clicked link
        this.classList.add('bold-link');
    });
});


</script>
