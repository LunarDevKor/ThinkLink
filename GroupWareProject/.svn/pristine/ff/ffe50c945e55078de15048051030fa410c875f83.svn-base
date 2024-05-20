var calendarElem = document.getElementById("calendar");

// 풀캘린더 헤더 설정
var headerToolbar = {
	start: 'prev,next',
	center: 'title',
	end: 'dayGridMonth,dayGridWeek,dayGridDay'
};

//풀캘린더 설정
var calendarOption = {
	height: '700px',
	expandRows: true, // 화면에 맞게 높이 재설정
	slotMinTime: '09:00', // Day 캘린더 시작 시간
	slotMaxTime: '18:00', // Day 캘린더 종료 시간
	// 맨 위 헤더 지정
	headerToolbar: headerToolbar,
	initialView: 'dayGridMonth',
	locale: 'kr',
	nowIndicator: true, // 현재 시간 마크
	dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
	dayMaxEventRows: true, // Row 높이보다 많으면 +숫자 more 링크
	nowIndicator: true,
	eventClick: function (e) {
		var object = e.el.fcSeg.eventRange.def;
		showDetailSchedule(object.publicId);
		return false;
	}
};

document.addEventListener("DOMContentLoaded", function () {
	getComCal();
});

var icons = $(".schedule-detail-icon");

// 스케쥴 컨트롤러에서 캘린더VO 리스트를 받아와 달력에 출력합니다.
function getCal(url) {
	var request = $.ajax({
		url: "/schedule/" + url,
		method: "GET",
		dataType: "json"
	});
	request.done(function (data) {
		for (var i = 0; i < icons.length; i++) {
			icons[i].style.display = "none";
		}
		console.log(data);
		calendarOption.events = data;
		var calendar = new FullCalendar.Calendar(calendarElem, calendarOption);
		calendar.render();
	});
}

// 사내 일정
function getComCal() {
	getCal("getcompanyschdul");
}

function moveToFormPage() {
	location.href = '/admin/schedule/form';
}

// 일정을 클릭했을 때 컨트롤러에서 해당 일정의 상세 정보를 받아옵니다.
function showDetailSchedule(id) {
	var request = $.ajax({
		url: "/schedule/schdulDetail?schdulNo=" + id,
		method: "GET",
		dataType: "json"
	});
	request.done(function (data) {
		setDetailsection(data);
	});
}

var titleBox = $("#schedule-detail-title");
var Box = $("#schedule-detail-content");

var colorCircle = $("#schedule-color-circle");
var iconCategory = $("#schedule-detail-icon-category");
var iconCal1 = $("#schedule-detail-icon-cal-1");
var iconCal2 = $("#schedule-detail-icon-cal-2");
var iconTime = $("#schedule-detail-icon-time");
var iconPlace = $("#schedule-detail-icon-place");
var iconPart = $("#schedule-detail-icon-part");

var title = $("#schedule-detail-title-txt");
var category = $("#schedule-detail-category-txt");
var time1 = $("#schedule-detail-time1-txt");
var time2 = $("#schedule-detail-time2-txt");
var place = $("#schedule-detail-place-txt");
var attendeeBox = $("#schedule-detail-attendee");
var description = $("#schedule-detail-description-txt");

// 우측 상세보기 부분에 정보를 넣어용
function setDetailsection(data) {

	console.log(data);

	for (var i = 0; i < icons.length; i++) {
		icons[i].style.display = "none";
	}

	// 기존 텍스트를 비워용
	title.empty();
	category.empty();
	time1.empty();
	time2.empty();
	place.empty();
	attendeeBox.empty();
	description.empty();

	var bgnde = data.schdulBgnde;
	var endde = data.schdulEndde;

	// 제목 및 색상
	colorCircle.attr('class','round-20 rounded-circle');
	colorCircle.addClass("yen-"+data.schdulBgrnColor);
	title.text(data.schdulNm);
	
	// 일정 분류
	iconCategory.show();
	category.text(data.schdulGroupNm);
	
	// 시작 시간, 종료 시간
	iconCal1.show();
	if (data.alldayYn == "Y") {	// 종일 일정일 때
		if ((bgnde - endde) == 0) {	// 근데 이제 하루짜리임
			time1.text(msToDateStr(bgnde));
		} else {	//여러 날임
			var timeStr = msToDateStr(bgnde);
			time1.text(timeStr);
			iconCal2.show();
			timeStr = msToDateStr(endde);
			time2.text(timeStr);
		}
	} else {	// 시간 정해진 일정
		if ((bgnde - endde) <= 86400000) {	// 근데 이제 하루짜리임
			time1.text(msToDateStr(bgnde));
			iconTime.show();
			var timeStr = msToTimeStr(bgnde) + " - " + msToTimeStr(endde);
			time2.text(timeStr);
		} else {	//여러 날임
			var timeStr = msToDateStr(bgnde) + "  " + msToTimeStr(bgnde);
			time1.text(timeStr);
			iconCal2.show();
			timeStr = msToDateStr(endde) + "  " + msToTimeStr(endde);
			time2.text(timeStr);
		}
	}

	// 장소
	if(data.schdulPlace != null && data.schdulPlace != ""){
		iconPlace.show();
		place.text(data.schdulPlace);
	}

	// 참석 인원
	if(data.schdulTypeCode != 'C101'){
		iconPart.show();
		for(let i=0; i<data.attendeeList.length; i++){
			let attendee = data.attendeeList[i];
			var elem = '<span onclick="removeAttendee(this)" class="atendee-elem mb-1 badge rounded-pill text-bg-danger align-items-center" ';
			elem += 'id="atd-' + attendee.emplNo + '">';
			elem += attendee.emplNm + " - " + attendee.deptNm + '</span>';
			document.getElementById("schedule-detail-attendee").innerHTML += elem;
		}
	}


	// 내용
	description.text(data.schdulCn);

	// 버튼
	$("#schdulNo-input").val(data.schdulNo);
	$("#btn-schdul-mod").show();
	$("#btn-schdul-del").show();

}

// json string에서 ms로 넘어온 date 필드를 "YYYY-MM-DD"로 고쳐주겠습니다.
function msToDateStr(ms) {
	var dt = new Date(ms);
	var str = dt.getFullYear() + '-';
	str += String(dt.getMonth() + 1).padStart(2, "0") + '-';
	str += String(dt.getDate()).padStart(2, "0");
	return str;
}

// json string에서 ms로 넘어온 date 필드를 "HH24:MI"로 고쳐주겠습니다.
function msToTimeStr(ms) {
	var dt = new Date(ms);
	var str = String(dt.getHours()).padStart(2, "0") + ':' + String(dt.getMinutes()).padStart(2, "0");
	return str;
}

$(function(){

	var modForm = $('#modForm');
	var updateBtn = $('#btn-schdul-mod');
	var deleteBtn = $('#btn-schdul-del');
	
	updateBtn.on('click', function(){
		modForm.submit();
	});
	
	deleteBtn.on('click', function(){
		Swal.fire({
			title: '해당 일정을 삭제합니다.',
			text: '삭제한 일정은 복구할 수 없습니다.',
			// icon: 'warning',
			
			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			confirmButtonColor: '#d33', // confrim 버튼 색깔 지정
			cancelButtonColor: '#3085d6', // cancel 버튼 색깔 지정
			confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
			cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			
			reverseButtons: false, // 버튼 순서 거꾸로
			
		 }).then(result => {
			// 만약 Promise리턴을 받으면,
			if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

				let schdulNo = $("#schdulNo-input").val();

				var delRequest = $.ajax({
					url: '/schedule/delete',
					method: 'post',
					data: { 'schdulNo': schdulNo }
				});
				delRequest.done(function(data){
					Swal.fire('삭제 완료', '일정이 삭제되었습니다.', 'success').then(result => {
						location.reload(true);
					});
				});
			}
		 });
	});
	

});