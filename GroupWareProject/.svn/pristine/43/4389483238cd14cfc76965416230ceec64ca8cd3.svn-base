 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<!-- Modal -->
 <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">일정 추가하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				일정이름 :<input type="text" id="title" /></br>
				<div class="form-group">
				<label for="start">시작시간:</label>
				<select class="form-control" id="start" onchange="startChange()">
					<option value="09:00">09:00</option>
					<option value="09:30">09:30</option>
					<option value="10:00">10:00</option>
					<option value="10:30">10:30</option>
					<option value="11:00">11:00</option>
					<option value="11:30">11:30</option>
					<option value="12:00">12:00</option>
					<option value="12:30">12:30</option>
					<option value="13:00">13:00</option>
					<option value="13:30">13:30</option>
					<option value="14:00">14:00</option>
					<option value="14:30">14:30</option>
					<option value="15:00">15:00</option>
					<option value="15:30">15:30</option>
					<option value="16:00">16:00</option>
					<option value="16:30">16:30</option>
					<option value="17:00">17:00</option>
					<option value="17:30">17:30</option>
					<option value="18:00">18:00</option>
					<option value="18:30">18:30</option>
				</select>
			  </div>
			   <div class="form-group">
				<label for="end">종료시간:</label>
				<select class="form-control" id="end">
					<option value="09:30">09:30</option>
					<option value="10:00">10:00</option>
					<option value="10:30">10:30</option>
					<option value="11:00">11:00</option>
					<option value="11:30">11:30</option>
					<option value="12:00">12:00</option>
					<option value="12:30">12:30</option>
					<option value="13:00">13:00</option>
					<option value="13:30">13:30</option>
					<option value="14:00">14:00</option>
					<option value="14:30">14:30</option>
					<option value="15:00">15:00</option>
					<option value="15:30">15:30</option>
					<option value="16:00">16:00</option>
					<option value="16:30">16:30</option>
					<option value="17:00">17:00</option>
					<option value="17:30">17:30</option>
					<option value="18:00">18:00</option>
					<option value="18:30">18:30</option>
					<option value="19:00">19:00</option>
				</select>
			  </div>
		  </div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closeModal">취소</button>
				<button type="button" class="btn btn-primary" id="saveChanges">추가</button>
			</div>
		</div>
	</div>
</div>
    
 <!-- Modal END -->
 
 
 <!-- calendar-->
   <div class="card">
		<div>
			<div class="row gx-0">
				<div class="col-lg-12">
					<div class="p-4 calender-sidebar app-calendar">
						<div id="calendar"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/resources/project/js/sweetalert_custom.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/vendor/libs/fullcalendar/index.global.min.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/project/js/source/index.global.min.js"></script>

    <script>
        const exampleModal = document.querySelector("#exampleModal");
        const calendarEl = document.querySelector('#calendar');
        const start = document.querySelector("#start");
        const end = document.querySelector("#end");
        const title = document.querySelector("#title");


        //캘린더 헤더
        const headerToolbar = {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'resourceTimeline'
        }

        // 캘린더 옵션
        const calendarOption = {
            height: '700px', // calendar 높이 설정
            expandRows: true, // 화면에 맞게 높이 재설정
            slotMinTime: '09:00', // Day 캘린더 시작 시간
            slotMaxTime: '23:00', // Day 캘린더 종료 시간
            // 맨 위 헤더 지정
            headerToolbar: headerToolbar,
            initialView: 'resourceTimeline',  // default: dayGridWeek 'dayGridMonth', 'timeGridDay', 'listWeek'
            locale: 'ko',        // 언어 설정
            selectable: true,    // 영역 선택
            selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
            navLinks: true,      // 날짜,WeekNumber 클릭 여부, default false
            editable: true,      // event(일정) 
            dayMaxEventRows: true,  
            nowIndicator: true,
            resources: [
			   {
				   id: '1',
				   title: '제 1회의실'
			   },
			   {
				   id: '2',
				   title: '제 2회의실'
			   },
			   {
				   id: '3',
				   title: '제 3회의실'
			   },
			   {
				   id: '4',
				   title: '제 4회의실'
			   },
			   {
				   id: '5',
				   title: '제 5회의실'
			   },
			 ],
            
            select: function(arg){
            
            //지난날짜 선택시 alert띄우기
            var now = new Date();
            var selectedStart = arg.start;
       
	            if (selectedStart < now) {
	                alert("현재 시각 이후의 일정만 선택할 수 있습니다.");
	                return;
	            }else{
	        
		        $('#exampleModal').modal('show');
	            }
            }
        }
        // 캘린더 생성
       
        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
        // 캘린더 그리기
         calendar.render();
        
    	 
        
        document.getElementById('saveChanges').addEventListener('click', function() {
    		let title = document.getElementById('title').value;
    		let start = document.getElementById('start').value;
    		let end = document.getElementById('end').value;
    		
    		if(title == null || title.trim() === '') {
    			showToast('일정 제목이 입력되지 않았습니다!!', 'warning');
    			return false;
    		}
    		if(start == null || start.trim() === '') {
    			showToast('일정 시작일이 입력되지 않았습니다!!', 'warning');
    			return false;
    		}
    		if(end == null || end.trim() === '') {
    			showToast('일정 종료일이 입력되지 않았습니다!!', 'warning');
    			return false;
    		}
    		if(start > end) {
    			showAlert('시작일이 종료일을 넘을 수는 없습니다!!', 'error');
    			return false;
    		}
    		
    		const eventData = {
    				title: title,
    				start: start,
    				end: end,
    		};
    		
    		calendar.addEvent(eventData);
    		
    		$('#exampleModal').modal('hide');
    		
    		$('#title').val('');
    		$('#start').val('');
    		$('#end').val('');
    	});
        

    
    </script>