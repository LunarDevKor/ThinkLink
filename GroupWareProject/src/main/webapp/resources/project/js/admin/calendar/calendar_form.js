$(document).ready(function () {

    var status = $("#status").val();

    if(status != 'u'){
        // 색상 랜덤 배정
        setRandomColor();
    }
    
    let bgnDefaultTime = "12:00";
    let endDefaultTime = "13:00";
    
    if(status == 'u'){
        bgnDefaultTime = $("#bgntime").val();
        endDefaultTime = $("#endtime").val();
    }

    // 시작 시간 타임 피커 설정
    $('#bgntime').timepicker({
        timeFormat: 'HH:mm',
        interval: 30,
        minTime: '08:00',
        maxTime: '19:00',
        defaultTime: bgnDefaultTime,
        dynamic: false,
        dropdown: true,
        scrollbar: false,
        change: bgntimeChanged
    });

    // 끝 시간 타임 피커 설정
    $('#endtime').timepicker({
        timeFormat: 'HH:mm',
        interval: 30,
        minTime: '08:00',
        maxTime: '19:00',
        defaultTime: endDefaultTime,
        dynamic: false,
        dropdown: true,
        scrollbar: false,
        change: endtimeChanged
    });

    // 종일 체크 박스 선택 시 시간 선택 없애고 일정 확인 안되게
    $("#checkAllday").change(function () {
        if ($("#checkAllday").is(":checked")) {
            $(".wrap_time").hide();
        } else {
            $(".wrap_time").show();
        }
    });
});

// 색상 랜덤 변경 - 일정 색상
function setRandomColor(){
    let ranColor = getRandomColor();
    $("#btn-select-color").addClass("yen-"+ranColor);
    $("#bgrnColor").val(ranColor);
    document.getElementById(ranColor).innerHTML = "<i class='fa-solid fa-check fs-7 text-white'></i>";
}

// 랜덤 색상 반환
function getRandomColor(){
    let randNum = Math.floor(Math.random() * 10);
    let ranColor = "red";
    if(randNum == 1){
        ranColor = "orange";
    }
    if(randNum == 2){
        ranColor = "yellow";
    }
    if(randNum == 3){
        ranColor = "yellowgreen";
    }
    if(randNum == 4){
        ranColor = "green";
    }
    if(randNum == 5){
        ranColor = "bluegreen";
    }
    if(randNum == 6){
        ranColor = "blue";
    }
    if(randNum == 7){
        ranColor = "darkblue";
    }
    if(randNum == 8){
        ranColor = "navy";
    }
    if(randNum == 9){
        ranColor = "purple";
    }

    return ranColor;
}

// 색상 선택 모달 띄우고 화면 어둡게 끄기
function showColorModal() {
    document.getElementById('btn-color-modal').click();
    $(".modal-backdrop").remove();
}

// 모달창 색상 원 선택 시 제목 옆 막대 색 변경
function getColor(event) {

	var colorCircles = $(".color-circle");
    for (var i = 0; i < colorCircles.length; i++) {
        colorCircles[i].innerHTML = "";
    }
    event.innerHTML = "<i class='fa-solid fa-check fs-7 text-white'></i>";
    $(".side-stick").attr("class", "side-stick");
    $(".side-stick").addClass("yen-" + event.id);
    $("#bgrnColor").val(event.id);
    document.getElementById("btn-close-color-modal").click();

}

//시작 날짜 변경 시 끝 날짜 선택 영역 변경
function bgndeChanged() {
    // 끝 날짜 최소 선택 => 시작 날짜
    var selectedTime = $("#bgnde").val();
    $("#endde").attr("min", selectedTime);

    var bgnDate = getCurrentDate($("#bgnde").val());
    var endDate = getCurrentDate($("#endde").val());
    
    // 현재 끝 날짜가 시작 날짜 이전이면 => 시작 날짜로 변경
    if (bgnDate > endDate) {
        $("#endde").val(selectedTime);
    }
    
    // 시작 날짜와 끝 날짜가 같으면
    if (bgnDate.getTime() === endDate.getTime()) {
        checkTimeSection(); // 시작 시간과 끝 시간 체크
    }
}

// 끝 날짜 변경 시 시작 날짜 선택 영역 변경
function enddeChanged() {
    // 시작 날짜 최대 선택 => 끝 날짜
    var selectedTime = $("#endde").val();
    $("#bgnde").attr("max", selectedTime);

    var bgnDate = getCurrentDate($("#bgnde").val());
    var endDate = getCurrentDate($("#endde").val());
    // 현재 시작 날짜가 끝 날짜 이후이면 => 끝 날짜로 변경
    if (bgnDate > endDate) {
        $("#bgnde").val(selectedTime);
    }
    // 시작 날짜와 끝 날짜가 같으면
    if (bgnDate.getTime() === endDate.getTime()) {
        checkTimeSection(); // 시작 시간과 끝 시간 체크
    }
}

// 시작 시간과 끝 시간 체크
function checkTimeSection() {
    var bgnTime = $("#bgntime").val();
    var endTime = $("#endtime").val();
    // 시작 시간이 끝시간보다 뒤에 있으면 12시 13시로 세팅
    if (bgnTime > endTime) {
        $("#bgntime").val("12:00");
        $("#endtime").val("13:00");
    }
}

//일정 시작 시간 변경 시
function bgntimeChanged() {

    // 일정 시작 날짜와 끝 날짜가 같으면
    if ($("#bgnde").val() == $("#endde").val()) {

        // 일정 끝나는 시간 최소 시간을 일정 시작 시간 다음 시간으로 변경
        let nextTime = getNextTime($("#bgntime").val());
        if ($('#endtime').timepicker('option', 'minTime') != nextTime) {
            $('#endtime').timepicker('option', 'minTime', nextTime);
        }

        if ($("#bgntime").val() > $("#endtime").val()) { // 변경한 시작 시간이 끝 시간보다 크면
            // 끝 시간을 시작 시간 다음 시간으로 변경
            $("#endtime").val(getNextTime($("#bgntime").val()));
        }

    }

}

//일정 끝 시간 변경 시
function endtimeChanged() {

    // 일정 시작 날짜와 끝 날짜가 같으면
    if ($("#bgnde").val() == $("#endde").val()) {

        // 일정 시작 시간 최대 시간을 일정 끝 시간으로 변경
        if ($('#bgntime').timepicker('option', 'maxTime') != getPrevTime($("#endtime").val())) {
            $('#bgntime').timepicker('option', 'maxTime', getPrevTime($("#endtime").val()));
        }

        if ($("#bgntime").val() > $("#endtime").val()) { // 변경한 끝 시간이 시작 시간보다 크면
            // 시작 시간을 끝 시간 전 시간으로 변경
            $("#bgntime").val(getPrevTime($("#endtime").val()));
        }

    }

}

//30분 전의 시간 리턴
function getPrevTime(time) {
    let min = time.substring(3, 5);
    let hour = Number(time.substring(0, 2));
    if (time == '08:00') {

    } else {
        if (min == "00") {
            min = "30";
            hour -= 1;
        } else {
            min = "00";
        }
    }
    return hour + ":" + min;
}

//30분 후의 시간 리턴
function getNextTime(time) {
    let min = time.substring(3, 5);
    let hour = Number(time.substring(0, 2));
    if (time == '19:00') {

    } else {
        if (min == "00") {
            min = "30";
        } else {
            min = "00";
            hour += 1;
        }
    }
    return hour + ":" + min;
}

// ms를 받아 hh:mm으로 변환
function convertMsToTimeStr(ms) {
    let date = new Date(ms);
    let hourNum = date.getHours();
    let hourStr = String(hourNum).padStart(2, '0');
    let minNum = date.getMinutes();
    let minStr = String(minNum).padStart(2, '0');
    let timeStr = hourStr + ':' + minStr;
    return timeStr;
}

// 장소 선택 시 회의실 선택하면 입력창 숨기기, 직접 입력 선택하면 입력창 보이기
function placeTypeChange() {
    if ($("#select-place-type").val() == "text") {
        $("#select-meeting-room-container").hide();
        $("#input-place-text-container").show();
    } else {
        $("#input-place-text-container").hide();
        $("#select-meeting-room-container").show();
    }
}

// 오늘 날짜를 가져오는 함수
function getTommorrowDate() {
    var today = new Date();
    var dd = String(today.getDate() + 1).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
    var yyyy = today.getFullYear();

    return yyyy + "-" + mm + "-" + dd;
}

// yyyy-mm-dd 형식의 스트링을 date 객체로 반환
function getCurrentDate(data) {
    var currentDate = new Date(data.substring(0, 4),
        parseInt(data.substring(5, 7)) - 1,
        data.substring(8, 10));
    return currentDate;
}

function moveToMainPage() {
	location.href = '/admin/schedule';
}


// 유효성 검사 - 권예은
function check() {

    var alert = $("#alert-notice");

    // 타입 코드, psitnCode
    var schdulTypeCode = $("#select-cal-type").val();
    var psitnCode = "";

    // 색상, 제목
    var schdulBgrnColor = $("#bgrnColor").val();
    var schdulNm = $("#input-title").val();
    if(schdulNm == null || schdulNm == ""){
        alert.html("제목이 입력되지 않았습니다.");
        return false;
    }

    var alldayYn = ($("#checkAllday").is(':checked'))? "Y" : "N";
    var bgnde = $("#bgnde").val();
    var bgntime = $("#bgntime").val();
    var bgndt = bgnde + " " + bgntime;

    var endde = $("#endde").val();
    var endtime = $("#endtime").val();
    var enddt = endde + " " + endtime;

    if( alldayYn == "N" && bgndt == enddt){
        alert.html("일정 시작 시간과 종료 시간이 같을 수 없습니다.");
        return false;
    }

    var schdulCn = $("#schdulCn").val();

    var placeType = $("#select-place-type").val();
    var schdulPlace = "";
    if(placeType == "meetingroom"){
        schdulPlace = $("#select-meeting-room").val();
    }else {
        schdulPlace = $("#mySchdulPlace").val();
    }

    var data = {
        "schdulTypeCode" : schdulTypeCode, 
        "psitnCode" : psitnCode, 
        "schdulNm" : schdulNm, 
        "schdulBgnde" : bgndt, 
        "schdulEndde" : enddt, 
        "schdulCn" : schdulCn, 
        "schdulBgrnColor" : schdulBgrnColor, 
        "schdulPlace" : schdulPlace, 
        "alldayYn" : alldayYn, 
    }

    var status = $("#status").val();

    let url = "/admin/schedule/register";

    if(status == 'u'){
        url = "/admin/schedule/modify";
        var schdulNo = $("#schdulNo").val();
        data.schdulNo = schdulNo;
        console.log("modify");
    }

    var request = $.ajax({
        url : url,
        method : "post",
        data : data
    });

    request.done(function(data){

        location.href = '/admin/schedule';
        
    });

}