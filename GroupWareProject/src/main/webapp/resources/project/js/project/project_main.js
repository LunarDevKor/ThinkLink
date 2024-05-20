
var icons = $(".schedule-detail-icon");

var titleBox = $("#schedule-detail-title");
var Box = $("#schedule-detail-content");

var colorCircle = $("#schedule-color-circle");
var iconCal1 = $("#schedule-detail-icon-cal-1");
var iconCal2 = $("#schedule-detail-icon-cal-2");
var iconTime = $("#schedule-detail-icon-time");
var iconPlace = $("#schedule-detail-icon-place");
var iconPart = $("#schedule-detail-icon-part");

var title = $("#schedule-detail-title-txt");
var time1 = $("#schedule-detail-time1-txt");
var time2 = $("#schedule-detail-time2-txt");
var place = $("#schedule-detail-place-txt");
var attendeeBox = $("#schedule-detail-attendee");
var description = $("#schedule-detail-description-txt");

// 풀캘린더 커스텀 버튼
var customButtons = {
	btnWeekRept:{
		text: "주간 보고",
		click: function () {
			fnWeekReport();
		} 
	},
	btnDayRept:{
		text: "일일 보고",
		click: function () {
			fnWeekReport();
		} 
	},
	btnAddRept:{
		text: "업무 보고 작성",
		click: function () {
			showReportForm();
		} 
	},
};

// 풀캘린더 헤더 - 캘린더 탭
var headerToolbar = {
	start: 'prev,next',
	center: 'title',
	end: 'dayGridMonth,dayGridWeek,dayGridDay'
};

// 풀캘린더 헤더 - 업무일지 탭
var headerToolbarReport = {
	start: 'prev,next',
	center: 'title',
	end: 'btnAddRept'
};

//풀캘린더 설정
var calendarOption = {
	customButtons: customButtons,
	height: '750px',
	expandRows: true, // 화면에 맞게 높이 재설정
	slotMinTime: '09:00', // Day 캘린더 시작 시간
	slotMaxTime: '18:00', // Day 캘린더 종료 시간
	initialView: 'dayGridMonth',
	locale: 'kr',
	nowIndicator: true, // 현재 시간 마크
	dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
	dayMaxEventRows: true, // Row 높이보다 많으면 +숫자 more 링크
	nowIndicator: true,
	fixedWeekCount: false
};


/* 업로드 시 필요한 변수 시작 */
const byteUnits = [ "KB", "MB", "GB" ];
var fileArray = [];
var cnt = 1;
var grid;
var fldrType = 0;
/* 업로드 시 필요한 변수 끝 */

$(function(){

	for (var i = 0; i < icons.length; i++) {
		icons[i].style.display = "none";
	}

	// 업무상태 도넛 차트--
	const taskStatusChart = document.getElementById("task-status-chart");
	
	const data = {
		type: 'doughnut',
		data: {
			labels: ["대기", "진행중", "완료"],
			datasets: [
				{
					backgroundColor: [
						'rgb(255, 99, 132)',
						'rgb(54, 162, 235)',
						'rgb(255, 205, 86)'
					],
					data: [todoCnt, doingCnt, doneCnt]
				}
			]
		},
		options: {
			responsive: false,
			legend: {
				display: false,
				position: 'bottom',
			}
		}
	};

	new Chart(taskStatusChart, data);
	// --업무상태 도넛 차트

    
	
	// 업무기한 그래프 --
	var day1 = new Date();
	var day2 = new Date();
	var day3 = new Date();
	var day4 = new Date();
	var day5 = new Date();
	var day6 = new Date();
	var day7 = new Date();
	day1.setDate(day1.getDate()+0);
	day2.setDate(day1.getDate()+1);
	day3.setDate(day1.getDate()+2);
	day4.setDate(day1.getDate()+3);
	day5.setDate(day1.getDate()+4);
	day6.setDate(day1.getDate()+5);
	day7.setDate(day1.getDate()+6);
	
	
	var dueDateOptions = {
			  chart: {
			    type: 'bar'
			  },
			  series: [{
				name: "마감 업무 수",
			    data: [{
			      x: day1,
			      y: dueDateData.D1
			    }, {
			      x: day2,
			      y: dueDateData.D2
			    }, {
			      x: day3,
			      y: dueDateData.D3
			    }, {
			      x: day4,
			      y: dueDateData.D4
			    }, {
			      x: day5,
			      y: dueDateData.D5
			    }, {
			      x: day6,
			      y: dueDateData.D6
			    }, {
			      x: day7,
			      y: dueDateData.D7
			    }]
			  }],

			  chart: {
			    toolbar: { show: false },
			    height: 200,
			    type: "bar",
			    fontFamily: "inherit",
			    foreColor: "#adb0bb",
			    offsetX:-10
			  },
			  plotOptions: {
			    bar: {
			      borderRadius: 4,
			      columnWidth: "45%",
			      distributed: true,
			      endingShape: "rounded",
			    },
			  },

			  dataLabels: {
			    enabled: false,
			  },
			  legend: {
			    show: false
			  },
			  grid: {
			    yaxis: {
			      lines: { show: false },
			    },
			    xaxis: {
			      lines: { show: false },
			    },
			  },
			  xaxis: {
			    axisBorder: { show: false },
			    axisTicks: { show: false },
			    type: "datetime",
			    labels: {
			    	datetimeFormatter : { day: 'dd'},
				    offsetX:10
			    }
			  },
			  yaxis: {
			    labels: { show: false },
			  },
			  tooltip: {
				y: { formatter: function(val, index) {
			        return val.toFixed(0);
			      }},
			    theme: "dark",
			  },
			};
		
	var chart = new ApexCharts(document.querySelector("#dueDateGraph"), dueDateOptions);
	chart.render();
	// 업무기한 그래프 --

	// 캘린더--

	// 홈 탭 캘린더
	var calendarElem = document.getElementById("calendar-home");
	calendarOption.events = prjctSchdulList;
	var calendar = new FullCalendar.Calendar(calendarElem, calendarOption);
	calendar.render();

	// --캘린더 

	// 간트차트 그래프--
	
	    // google.charts.load('current', {'packages':['gantt']});
        // google.charts.setOnLoadCallback(drawChart);
    
        // function drawChart() {
    
        //   var data = new google.visualization.DataTable();
        //   data.addColumn('string', 'Task ID');
        //   data.addColumn('string', 'Task Name');
        //   data.addColumn('string', 'Resource');
        //   data.addColumn('date', 'Start Date');
        //   data.addColumn('date', 'End Date');
        //   data.addColumn('number', 'Duration');
        //   data.addColumn('number', 'Percent Complete');
        //   data.addColumn('string', 'Dependencies');
          
          
        //   var taskDataList = [];
          
        //   for(let i=0; i<taskList.length; i++){
        //       var task = taskList[i];
        //       var taskData = [];
        //       taskData.push((task.taskNo).toString());
        //       taskData.push(task.taskNm);
        //       taskData.push((task.upperTaskNo).toString());
        //       taskData.push(new Date(task.taskBeginDt));
        //       taskData.push(new Date(task.taskEndDt));
        //       taskData.push(null);
        //       taskData.push(task.taskProgrs);
        //       var upperTaskNo = (task.upperTaskNo).toString();
        //       if(upperTaskNo == '0'){
        //           upperTaskNo = null;
        //       }
        //       taskData.push(upperTaskNo);
    
        //       taskDataList.push(taskData);
        //   }
          
        //   data.addRows(taskDataList);
    
        //   var options = {
        //     height: 700,
        //     width: 1000,
        //     gantt: {
        //       trackHeight: 30
        //     }
        //   };
    
        //   var chart = new google.visualization.Gantt(document.getElementById('chart_div'));
    
        //   chart.draw(data, options);
        // }
        
        // --간트차트 그래프

	

});

function fnCalTab(){
    
	// 캘린더 탭 캘린더
	calendarElem = document.getElementById("calendar");
	calendarOption.headerToolbar = headerToolbar;
	calendarOption.events = prjctSchdulList;
	calendarOption.eventClick = function (e) {
		var object = e.el.fcSeg.eventRange.def;
		calendarClick(object.publicId);
		return false;
	}
	var calendar2 = new FullCalendar.Calendar(calendarElem, calendarOption);
	calendar2.render();
}

function fnReptTab(){

    // 업무일지 탭 캘린더
	var reportCalElem = document.getElementById("calendar-report");
    var reportCalOption = calendarOption;
	reportCalOption.headerToolbar = headerToolbarReport;
	reportCalOption.events = reportCalendarList;
	reportCalOption.eventClick = function (e) {
		var object = e.el.fcSeg.eventRange.def;
		reportCalendarClick(object.publicId);
		return false;
	}
	var calendarReport = new FullCalendar.Calendar(reportCalElem, reportCalOption);
	calendarReport.render();
}

function fnWeekReport(){
	console.log("주간 업무일지");
}

/* 캘린더 탭 일정 클릭 이벤트 */
function calendarClick(id){
	var request = $.ajax({
		url: "/schedule/schdulDetail?schdulNo=" + id,
		method: "GET",
		dataType: "json"
	});
	request.done(function (data) {
		setDetailsection(data);
	});
}

// 우측 상세보기 부분에 정보를 넣어용
function setDetailsection(data) {

	for (var i = 0; i < icons.length; i++) {
		icons[i].style.display = "none";
	}

	// 기존 텍스트를 비워용
	title.empty();
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
	description.html(data.schdulCn);

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

/* 업무일지 탭 일정 클릭 이벤트 */
function reportCalendarClick(id){
	var request = $.ajax({
		url: "/project/reportDetail?reptNo=" + id,
		method: "GET",
		dataType: "json"
	});
	request.done(function (data) {
		showReptDetail(data);
	});
}

function showReptDetail(data){
	let empl = data.empl;
	$('#reportForm').hide();
	$('#reportDetail').show();
	$('#reptWriterImg').attr('src','/profile/view/'+empl.emplProflPhoto);
	$('#reptWriterNmClsf').text(empl.emplNm);
	$('#reptWriterDept').text(empl.deptNm);
	$('#reportDetailTitle').text(data.prjctReprtNm);
	$('#reportDetailCn').html(data.prjctReprtCn);
}

function fnGanttTab(){

    var data1 = [
        {
            from: '2024-04-10',
            to: '2024-05-03',
            label: "Example Value1",
            desc: "aa",
            customClass: "ganttRed",
            // dataObj: foo.bar[i]
        }, {
            from: '2012-04-15',
            to: '2012-04-28',
            label: "Example Value2",
            desc: "bb",
            customClass: "ganttRed",
            // dataObj: foo.bar[i]
        }
    ];

    var data2 = [
        {
            from: '2024-04-20',
            to: '2024-05-25',
            label: "Example Value3",
            desc: "cc",
            customClass: "ganttRed",
            // dataObj: foo.bar[i]
        }, {
            from: '2012-04-25',
            to: '2012-05-18',
            label: "Example Value4",
            desc: "dd",
            customClass: "ganttRed",
            // dataObj: foo.bar[i]
        }
    ];

    var source2 = [
        {
            name: "Example",
            desc: "first",
            values: data1,
            id: 1,
            cssClass: "redLabel"
        }, {
            name: "Example2",
            desc: "second",
            values: data2,
            id: 2,
            cssClass: "redLabel"
        }
    ];

    var source = [];

    for(let i=0; i<taskList.length; i++){
        var task = taskList[i];
        var data = {
            name : task.taskNm,
            values: [{
                from: task.taskBeginDtStr,
                to: task.taskEndDtStr,
                desc: task.taskNm
            }]
        }
        source.push(data);
    }


    $ ( "#gantt_div" ). gantt ({ 
        source : source , 
        itemsPerPage: taskList.length,
        scale : "days" , 
        minScale : "weeks" , 
        maxScale : "months" , 
        onItemClick : function ( data ) { 
            Alert ( "클릭한 항목 - 세부 정보 표시" ); }, 
        onAddClick : function ( dt , rowId ) { 
            warning ( "빈 공간을 클릭했습니다. 항목을 추가하세요!" ) }, 
        onRender : function () { 
            console . log ( "차트 렌더링됨" )} 
    }); 
}

function showReportForm(){
	$("#reportDetail").hide();
	$("#reportForm").show();
}

function hideReportForm(){
	$("#reportForm").hide();
}

function checkReportForm(){

	var formData = new FormData();

	let reportTitle = $('#reportTitle').text();
	let reportCn = replaceNewLineToBrTag($('#reportFormTextArea').val());
	let targetDate = $('#reportTargetDate').val();
	formData.append('prjctReprtNm',reportTitle);
	formData.append('prjctReprtCn',reportCn);
	formData.append('prjctReprtTargetDateString',targetDate);
	formData.append('prjctNo',prjctNo);

	for(let i in fileArray) {
		formData.append('files', fileArray[i]);
	}

	 $.ajax({
		type: 'post',
		url: '/project/insertRept',
		data: formData,
		processData: false,
		contentType: false,
		success: function(res){
			location.href = location.href;
			$('#prjct-report-tab').trigger("click");
		}
	 });

}

/* 파일 업로드 시 파일 배열에 저장 및 파일 목록 표시 */
$("#formFile").on('change',function(e){
	for(let i=0; i < e.target.files.length; i++){
		let file = e.target.files[i];
		let html = createUploadHTML(file);

		$('#uploadFileBox').append(html);

		fileArray.push(file);
	}
});

function createUploadHTML(file){
	let name = file.name;

	let html = 
	`<div id="" class="uploadFile d-flex align-items-center gap-3" data-file-name="${name}">
		<i class="fa-regular fa-paperclip"></i>
		<h6 class="fw-semibold mb-0">${name}</h6>
		<i class="fa-solid fa-xmark" onclick="removeThis(event)"></i>
	</div>`;

	return html;
}

function removeThis(e){
	let target = e.target.parentElement;
	let fileName = target.dataset.fileName;
	for(let i=0; i<fileArray.length; i++){
		if(fileArray[i].name === fileName){
			fileArray.splice(i,1);
			break;
		}
	}
	target.remove();
}

$('#reportTargetDate').on('change',function(e){
	let targetDate = e.target.value;
	let reportTitle = $('#reportTitle').text();
	reportTitle = reportTitle.substring(10);
	reportTitle = targetDate + reportTitle;
	$('#reportTitle').text(reportTitle);
})

function showTaskDetail(taskNo){
	console.log(taskNo);
}


// 더보기 버튼 누르면 모달 띄우고 내부 정보 세팅
function showTaskDetail(taskNo){
	getDetail(taskNo);
    document.getElementById('btn-modal-task-detail').click();
    $(".modal-backdrop").remove();
}

// task 상세 정보 가져오는 ajax
function getDetail(taskNo){
	var request = $.ajax({
		url : "/project/taskDetail?taskNo=" + taskNo,
		method: "GET",
		dataType: "json"
	});
	request.done(function(data){
		setDetailOnModal(data);
	});
}

// task 정보 모달에 세팅
function setDetailOnModal(task){
	$("#modaltaskDetailLabel").text(task.taskNm);
	$("#task-detail-side-stick").attr("class","side-stick yen-"+task.prjctColor);
	$("#modaltaskDetailLabelPrjct").text(task.prjctNm);
	$("#task-detail-empl").text(task.emplNm);
	$("#task-detail-bgndt").text(task.taskBeginDtStr);
	$("#task-detail-enddt").text(task.taskEndDtStr);
	$("#task-detail-priort").text(convertDegree(task.taskPriort));
	$("#task-detail-imprtnc").text(convertDegree(task.taskImprtnc));
	$("#task-detail-progrs").text(task.taskProgrs + '%');
	$("#task-detail-cn").html(task.taskCn);
}

function convertDegree(num){
	if(num == 1){
		return "낮음";
	} else if(num == 2){
		return "보통";
	} else if(num == 3){
		return "높음";
	}
}

function showTaskForm(){
    document.getElementById('btn-modal-task-form').click();
    $(".modal-backdrop").remove();
}

function moveToProjectMain(prjctNo){
	location.href = '/project/main?prjctNo='+prjctNo;
}

function addTask(){

	var taskNm = $('#taskTitle').val();
	var emplNo = $('#select-task-empl').val();
	var bgnde = $('#bgnde').val();
	var endde = $('#endde').val();
	var priort = $('#select-task-priort').val();
	var imprtnc = $('#select-task-imprtnc').val();
	var taskCn = $('#taskFormTextArea').val();

	var formData = new FormData();
	formData.append('taskNm',taskNm);
	formData.append('emplNo',emplNo);
	formData.append('taskBeginDtStr',bgnde);
	formData.append('taskEndDtStr',endde);
	formData.append('taskPriort',priort);
	formData.append('taskImprtnc',imprtnc);
	formData.append('taskCn',taskCn);
	formData.append('prjctNo',prjctNo);

	$.ajax({
	   type: 'post',
	   url: '/project/insertTask',
	   data: formData,
	   processData: false,
	   contentType: false,
	   success: function(res){
		   location.href = location.href;
		   $('#prjct-task-tab').trigger("click");
	   }
	});


}

function moveToReportTab(){

}

function setDataForPresentation(){
	var data1 = `	1. 오늘 계획
	 - 최종 발표
	
	2. 계획 대비 진행 현황
	 - 80%
	
	3. 지연 이슈
	 - 프로그램 오류 발견
	
	4. 이슈 대응 방안
	 - 쿼리 수정 필요
	
	5. 내일 계획
	 - 수정 후 테스트
	
	6. 비고
	 - 일정 등록 쿼리에 전사 일정 등록 시 오류 발생합니다.
	   수정 후 재테스트 진행하겠습니다.
	`;
	$("#reportFormTextArea").val(data1);
}

function setTaskDataForPresentation(){
	var cnData = `프로세스 흐름 정리

 - 기존 페이지 프로세스 개선점 반영
 - 메모 보고 추가
 - 게시판 카테고리 개편`;
	$('#taskTitle').val('프로세스 흐름');
	$('#select-task-empl').val('20240004');
	$('#bgnde').val('2024-05-17');
	$('#endde').val('2024-05-25');
	$('#select-task-priort').val('3');
	$('#select-task-imprtnc').val('3');
	$('#taskFormTextArea').val(cnData);
}

function moveToFormPage() {
	location.href = '/project/form';
}

