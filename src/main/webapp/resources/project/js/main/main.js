var customButtons = {
	btnMyCal:{
		text: "내 캘린더",
		click: function () {
			fnMyCal();
		} },
	btnDeptCal:{
		text: "부서",
		click: function () {
			fnDeptCal();
		} },
	btnComCal:{
		text: "사내",
		click: function () {
			fnComCal();
		} },
	btnAllCal:{
		text: "전체",
		click: function () {
			fnAllCal();
		} },
};

// 풀캘린더 헤더 설정
var headerToolbar = {
	start: 'btnAllCal,btnComCal,btnDeptCal,btnMyCal',
	center: 'title',
	end: 'prev,next'
};

//풀캘린더 설정
var calendarOption = {
	customButtons: customButtons,
	headerToolbar : headerToolbar,
//		height: '800px',
	contentHeight : 385,
	expandRows: true, // 화면에 맞게 높이 재설정
	initialView: 'dayGridMonth',
	locale: 'kr',
	nowIndicator: true, // 현재 시간 마크
	dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
	dayMaxEventRows: true, // Row 높이보다 많으면 +숫자 more 링크
	nowIndicator: true,
	fixedWeekCount: false
};



function fnAllCal() {
	
	calendarOption.events = allCalendarList;
	var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);

	calendar.render();
	
}

function fnComCal() {
	
	calendarOption.events = comCalendarList;
	var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);

	calendar.render();
	
}

function fnDeptCal() {
	
	calendarOption.events = deptCalendarList;
	var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);

	calendar.render();
	
}

function fnMyCal() {
	
	calendarOption.events = emplCalendarList;
	var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);

	calendar.render();
	
}

$(function(){
	
	calendarOption.events = allCalendarList;
	var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);

	calendar.render();

});

function fnSelectProject(){
	alert(selectedProject);
}

$(function(){
	setTaskSection(prjctNo);
});

function setTaskSection(prjctNo){
	var request = $.ajax({
		type: 'post',
		url: '/project/'
	});
}