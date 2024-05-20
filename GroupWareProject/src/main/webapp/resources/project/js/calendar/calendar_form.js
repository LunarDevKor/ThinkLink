$(document).ready(function () {

    var status = $("#status").val();

    if(status != 'u'){
        // 색상 랜덤 배정
        setRandomColor();
    }
    setRandomColorToAttendee();
    
    let bgnDefaultTime = "12:00";
    let endDefaultTime = "13:00";
    
    if(status == 'u'){
        bgnDefaultTime = $("#bgntime").val();
        endDefaultTime = $("#endtime").val();
        let attendeeList = $(".atendee-elem");
        for(let i=0; i<attendeeList.length; i++){
            let empl = attendeeList[i];
            addTableOnAttendeeSection2(empl);
            setAttendeeTimeSection();
        }
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
            $(".attendees-unavailable").show();
            $(".attendees-available").hide();
        } else {
            $(".wrap_time").show();
            $(".attendees-unavailable").hide();
            $(".attendees-available").show();
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

// 색상 랜덤 변경 - 참여 인원
function setRandomColorToAttendee(){
    var attendeeElemList = $(".atendee-elem");
    for(let i=0; i<attendeeElemList.length; i++){
        let ranColor = getRandomColor();
        attendeeElemList[i].className += ' yen-' + ranColor;
    }
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


// 캘린더 선택에서 프로젝트 선택 시 프로젝트 선택하게 함
function schdulTypeChange() {
    if ($("#select-cal-type").val() == "C104") {
        $("#select-cal-project-container").show();
    } else {
        $("#select-cal-project-container").hide();
    }
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
    setAttendeeTimeSection();
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
    setAttendeeTimeSection();
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

    setAttendeeTimeSection();

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

    setAttendeeTimeSection();

}

// 참석자 일정 부분 선택 시간 설정
function setAttendeeTimeSection() {


    var bgnDate = getCurrentDate($("#bgnde").val());
    var endDate = getCurrentDate($("#endde").val());
    var selectedDe = getCurrentDate(document.getElementById("selected-date").dataset.value);

    // 현재 표시 날짜가 일정 선택 시간 사이에 있을 때
    if (bgnDate <= selectedDe && selectedDe <= endDate) {
        $("#set-time").css("display", "block");
        if (bgnDate.getTime() === selectedDe.getTime()) { // 현재 표시 날짜가 일정 시작 날짜이면
            setAttendeeTimeBox($("#bgntime").val(), "left");
        } else {
            setAttendeeTimeBox("08:00", "left");
        }

        if (endDate.getTime() === selectedDe.getTime()) { // 현재 표시 날짜가 일정 끝 날짜이면
            setAttendeeTimeBox($("#endtime").val(), "right");
        } else {
            setAttendeeTimeBox("19:00", "right");
        }
    } else { // 현재 표시 날짜가 일정 선택 시간이 아닐 때 => 파란 박스 안보이게
        $("#set-time").css("display", "none");
    }

    // 현재 표시 참석자 일정 반영
    var attEmplElems = document.querySelectorAll('.att_schedule_bd');
    for (let i = 0; i < attEmplElems.length; i++) {
        addAttendeeSchdul(attEmplElems[i].dataset.emplNo);
    }

}

// 참석자 일정 확인 부분 현재 설정 시간 표시 변경(파란 상자)
function setAttendeeTimeBox(time, direction) {

    if (direction == 'left') {
        var percent = getSetTimeStyle(time) + '%';
        $("#set-time").css(direction, percent);
    } else {
        var percent = 100;
        percent -= getSetTimeStyle(time);
        percent += '%';
        $("#set-time").css(direction, percent);
    }

}

// 시간을 파란 박스용 퍼센트로 변경
function getSetTimeStyle(time) {
    if (time == '08:00') {
        return 0;
    } else if (time == '08:00') {
        return 0;
    } else if (time == '08:30') {
        return 50;
    } else if (time == '09:00') {
        return 100;
    } else if (time == '09:30') {
        return 150;
    } else if (time == '10:00') {
        return 200;
    } else if (time == '10:30') {
        return 250;
    } else if (time == '11:00') {
        return 300;
    } else if (time == '11:30') {
        return 350;
    } else if (time == '12:00') {
        return 400;
    } else if (time == '12:30') {
        return 450;
    } else if (time == '13:00') {
        return 500;
    } else if (time == '13:30') {
        return 550;
    } else if (time == '14:00') {
        return 600;
    } else if (time == '14:30') {
        return 650;
    } else if (time == '15:00') {
        return 700;
    } else if (time == '15:30') {
        return 750;
    } else if (time == '16:00') {
        return 800;
    } else if (time == '16:30') {
        return 850;
    } else if (time == '17:00') {
        return 900;
    } else if (time == '17:30') {
        return 950;
    } else if (time == '18:00') {
        return 1000;
    } else if (time == '18:30') {
        return 1050;
    } else if (time == '19:00') {
        return 1100;
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



// 기존 조직도를 참석자 추가용으로 변경
function openOrgTree() {
	$('#dept-D301').empty();
	makeTree("D301");
    document.getElementById('btn-organtree-modal').click();
    $(".modal-backdrop").remove();
    $(".modal-organixationtree").css({ "margin-left": "auto", "margin-top": "300px" });
    $(".tree-ad-icon").html("");
    $("#organ-tree-modal").on("click",".organ-tree-empl", function () {
        addAttendee($(this));
    });
}

// 참석자 목록에 추가
function addAttendee(emplElem) {
    var id = "attendee-" + emplElem.data('emplNo');
    if (document.getElementById(id)) { // 이미 목록에 있으면 메소드 끝
        return false;
    } else { // 없으면 추가 해
        let ranColor = getRandomColor();
        var dept = (emplElem.data('deptNm') == null || emplElem.data('deptNm') == "") ? emplElem.data('clsfNm') : emplElem.data('deptNm');
        var empl = emplElem.data('emplNm') + "-" + dept;
        var elem = '<span onclick="removeAttendee(this)" class="yen-' + ranColor + ' atendee-elem mb-1 badge rounded-pill align-items-center" ';
        elem += 'id="' + id + '">';
        elem += empl + '<iconify-icon icon="carbon:close-filled"></iconify-icon></span>';
        document.getElementById("attendee-box").innerHTML += elem;
        addTableOnAttendeeSection(emplElem);
    }
}

// 참석자 목록에서 삭제
function removeAttendee(e) {
    let id = e.id.substr(9);
    id = 'att_' + id;
    console.log("id : ", id);
    var div = document.getElementById(id);
    // 참석자 일정 확인 목록 삭제
    div.remove();
    // 참석자 목록 elem 삭제
    e.remove();
    var attTabls = $(".att_schedule_bd");
    var attNum = attTabls.length;
    var newHeight = ( attNum * 32 ) + 'px';
    $("#set-time").css("height", newHeight);
}

// 참석자 일정 확인
function addAttendeeSchdul(emplNo) {

    var dateToCheck = document.getElementById("selected-date").dataset.value;

    var request = $.ajax({
        url: "/schedule/getAttendeeSchdul",
        method: "GET",
        data: {
            "emplNo": emplNo,
            "dateToCheck": dateToCheck
        },
        dataType: "json"
    });
    
    request.done(function (data) {
        let id = 'att_' + emplNo;
        var div = document.getElementById(id);
        var divs = div.querySelectorAll("td div");
        // 초기화
        for (let i = 0; i < divs.length; i++) {
            divs[i].classList.remove('busy');
        }

        for (let i = 0; i < data.length; i++) {
            var aData = data[i];
            if (aData.alldayYn == "Y") { // 종일 일정 있으면 몽땅 비지 넣고 메소드 끝
                for (let i = 0; i < divs.length; i++) {
                    divs[i].classList.add('busy');
                }
                return false;
            } else {
                let bgnTime = convertMsToTimeStr(aData.schdulBgnde);
                let endTime = convertMsToTimeStr(aData.schdulEndde);
                setAttendeeSchedule(emplNo, bgnTime, endTime);
            }
            var date = new Date(aData.schdulBgnde);
        }
    });
}

// 참석자 일정 확인 섹션에 일정 정보 반영
function setAttendeeSchedule(emplNo, bgnTime, endTime) {
    let id = 'att_' + emplNo;
    var div = document.getElementById(id);
    let status = 'N';

    for (let t = 8; t <= 19; t++) {
        let hourStr = String(t).padStart(2, '0');
        let timeDiv = div.querySelector(".o" + hourStr);
        if (bgnTime == (hourStr + ":00")) {
            status = "Y";
        }
        if (endTime == (hourStr + ":00")) {
            status = "N";
        }
        if (status == "Y") {
            timeDiv.classList.add("busy");
        }

        timeDiv = div.querySelector(".h" + hourStr);
        if (bgnTime == (hourStr + ":30")) {
            status = "Y";
        }
        if (endTime == (hourStr + ":30")) {
            status = "N";
        }
        if (status == "Y") {
            timeDiv.classList.add("busy");
        }
    }

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


// 이전 날짜 버튼 이벤트 처리
function goPrevDay(){

    // 현재 선택된 날짜에서 하루를 빼서 이전 날짜로 설정
    var currentDate = getCurrentDate(document.getElementById("selected-date").dataset.value);
    currentDate.setDate(currentDate.getDate() - 1);

    if (document.getElementById("selected-date").dataset.value === getTommorrowDate()) {
        // data-value가 오늘 날짜와 같으면 btn_ic_prev2를 숨김
        document.querySelector('.prev-btn').style.display = 'none';
    }

    // 변경된 날짜를 선택된 날짜에 반영
    setSelectedDate(currentDate);

}

// 다음 날짜 버튼 이벤트 처리
function goNextDay(){

    // btn_ic_prev2를 나타냄
    document.querySelector('.prev-btn').style.display = '';

    // 현재 선택된 날짜에서 하루를 더해서 다음 날짜로 설정
    var currentDate = getCurrentDate(document.getElementById("selected-date").dataset.value);
    currentDate.setDate(currentDate.getDate() + 1);

    // 변경된 날짜를 선택된 날짜에 반영
    setSelectedDate(currentDate);

}

// yyyy-mm-dd 형식의 스트링을 date 객체로 반환
function getCurrentDate(data) {
    var currentDate = new Date(data.substring(0, 4),
        parseInt(data.substring(5, 7)) - 1,
        data.substring(8, 10));
    return currentDate;
}

// 변경된 날짜를 선택된 날짜에 반영
function setSelectedDate(currentDate) {
    var selectedDate = document.getElementById("selected-date");
    var year = currentDate.getFullYear();
    var month = ("0" + (currentDate.getMonth() + 1)).slice(-2);
    var day = ("0" + currentDate.getDate()).slice(-2);
    var dateString = year + "-" + month + "-" + day;
    selectedDate.setAttribute("data-value", dateString);
    selectedDate.textContent = month + "월 " + day + "일";

    setAttendeeTimeSection();
}

// 참석자 추가시 일정 확인 목록에 추가
function addTableOnAttendeeSection(empl) {
    var str = '<!-- 참석자 일정 --><div id="att_' + empl.data('emplNo') + '" data-empl-no="' + empl.data('emplNo') + '" class="att_schedule_bd"><div class="tit"><p><span data-user-name="';
    str += empl.data('emplNm') + '" class="txt">' + empl.data('emplNm') + '</span></p></div><div class="timeline"><div class="tb_guide grid_layer"><!-- 배경 --><table><tbody><tr data-attendees-tr="">';
    str += '<td><div class="txt oclock o08">08:00</div><div class="txt halfhour h08">08:30</div></td><td><div class="txt oclock o09">09:00</div><div class="txt halfhour h09">09:30</div>';
    str += '</td><td> <div class="txt oclock o10">10:00</div> <div class="txt halfhour h10">10:30</div> </td> <td> <div class="txt oclock o11">11:00</div> <div class="txt halfhour h11">11:30</div>';
    str += '</td> <td> <div class="txt oclock o12">12:00</div> <div class="txt halfhour h12">12:30</div> </td> <td> <div class="txt oclock o13">13:00</div> <div class="txt halfhour h13">13:30</div>';
    str += '</td> <td> <div class="txt oclock o14">14:00</div> <div class="txt halfhour h14">14:30</div> </td> <td> <div class="txt oclock o15">15:00</div> <div class="txt halfhour h15">15:30</div>';
    str += '</td> <td> <div class="txt oclock o16">16:00</div> <div class="txt halfhour h16">16:30</div> </td> <td> <div class="txt oclock o17">17:00</div> <div class="txt halfhour h17">17:30</div>';
    str += '</td> <td> <div class="txt oclock o18">18:00</div> <div class="txt halfhour h18">18:30</div> </td> <td> <div class="txt oclock o19">19:00</div> <div class="txt halfhour h19">19:30</div>';
    str += '</td> </td> </tr> </tbody> </table> </div> </div> </div>';
    document.getElementById("wrap_att_schedule_bd").innerHTML += str;
    var attTabls = $(".att_schedule_bd");
    var attNum = attTabls.length;
    var newHeight = ( attNum * 32 ) + 'px';
    $(".att_schedul_line").css("height", newHeight);
    $("#set-time").css("height", newHeight);
    setAttendeeTimeSection();
}

// 참석자 추가시 일정 확인 목록에 추가
function addTableOnAttendeeSection2(empl) {
    var emplNo = empl.id;
    emplNo = emplNo.substring(9);
    var emplNmBox = empl.innerText;
    var emplNms = emplNmBox.split(' -');
    var emplNm = emplNms[0];
    var str = '<!-- 참석자 일정 --><div id="att_' + emplNo + '" data-empl-no="' + emplNo + '" class="att_schedule_bd"><div class="tit"><p><span data-user-name="';
    str += emplNm + '" class="txt">' + emplNm + '</span></p></div><div class="timeline"><div class="tb_guide grid_layer"><!-- 배경 --><table><tbody><tr data-attendees-tr="">';
    str += '<td><div class="txt oclock o08">08:00</div><div class="txt halfhour h08">08:30</div></td><td><div class="txt oclock o09">09:00</div><div class="txt halfhour h09">09:30</div>';
    str += '</td><td> <div class="txt oclock o10">10:00</div> <div class="txt halfhour h10">10:30</div> </td> <td> <div class="txt oclock o11">11:00</div> <div class="txt halfhour h11">11:30</div>';
    str += '</td> <td> <div class="txt oclock o12">12:00</div> <div class="txt halfhour h12">12:30</div> </td> <td> <div class="txt oclock o13">13:00</div> <div class="txt halfhour h13">13:30</div>';
    str += '</td> <td> <div class="txt oclock o14">14:00</div> <div class="txt halfhour h14">14:30</div> </td> <td> <div class="txt oclock o15">15:00</div> <div class="txt halfhour h15">15:30</div>';
    str += '</td> <td> <div class="txt oclock o16">16:00</div> <div class="txt halfhour h16">16:30</div> </td> <td> <div class="txt oclock o17">17:00</div> <div class="txt halfhour h17">17:30</div>';
    str += '</td> <td> <div class="txt oclock o18">18:00</div> <div class="txt halfhour h18">18:30</div> </td> <td> <div class="txt oclock o19">19:00</div> <div class="txt halfhour h19">19:30</div>';
    str += '</td> </td> </tr> </tbody> </table> </div> </div> </div>';
    document.getElementById("wrap_att_schedule_bd").innerHTML += str;
    var attTabls = $(".att_schedule_bd");
    var attNum = attTabls.length;
    var newHeight = ( attNum * 32 ) + 'px';
    $(".att_schedul_line").css("height", newHeight);
    $("#set-time").css("height", newHeight);
    setAttendeeTimeSection();
}

function moveToMainPage() {
	location.href = '/schedule';
}


// 유효성 검사 - 권예은
function check() {

    var alert = $("#alert-notice");

    // 타입 코드, psitnCode
    var schdulTypeCode = $("#select-cal-type").val();
    var psitnCode = "";
    if(schdulTypeCode == 'C104'){
    	psitnCode = $("#select-cal-project").val();
    }else if(schdulTypeCode == 'C103'){
    }

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

    var alarm = $("#schdul-alarm").val();
    
    var attendeeList = [];
    var atendeeElems = $(".atendee-elem");

    for(let i=0; i<atendeeElems.length; i++){
        var id = atendeeElems[i].id;
        var emplNo = id.substring(9);
        attendeeList.push(emplNo);
    }
	
    var data = {
        "schdulTypeCode" : schdulTypeCode, 
        "psitnCode" : psitnCode, 
        "schdulNm" : schdulNm, 
        "schdulBgnde" : bgndt, 
        "schdulEndde" : enddt, 
        "schdulCn" : replaceNewLineToBrTag(schdulCn), 
        "schdulBgrnColor" : schdulBgrnColor, 
        "schdulPlace" : schdulPlace, 
        "alldayYn" : alldayYn, 
        "alarm" : alarm, 
        "attendeeList" : attendeeList
    }

    var status = $("#status").val();

    let url = "/schedule/register";

    if(status == 'u'){
        url = "/schedule/modify";
        var schdulNo = $("#schdulNo").val();
        data.schdulNo = schdulNo;
    }

    var request = $.ajax({
        url : url,
        method : "post",
        data : data
    });

    request.done(function(data){

        location.href = '/schedule';
        
    });

}