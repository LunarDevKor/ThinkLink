$(document).ready(function () {

    var status = $("#status").val();
    if (status != 'u') {
        // 색상 랜덤 배정
        setRandomColor();
    }
    setRandomColorToAttendee();

});


// 유효성 검사 - 권예은
function check() {

    var alert = $("#alert-notice");

    // 색상, 제목
    var projectBgrnColor = $("#bgrnColor").val();
    var projectNm = $("#input-title").val();
    if (projectNm == null || projectNm == "") {
        alert.html("제목이 입력되지 않았습니다.");
        return false;
    }

    var bgnde = $("#bgnde").val();
    var bgndt = bgnde;

    var endde = $("#endde").val();
    var enddt = endde;

    var projectCn = $("#projectCn").val();

    var attendeeList = [];
    var atendeeElems = $(".atendee-elem");

    for (let i = 0; i < atendeeElems.length; i++) {
        var id = atendeeElems[i].id;
        var emplNo = id.substring(9);
        attendeeList.push(emplNo);
    }

    var data = {
        "prjctNm": projectNm,
        "prjctBeginDate": bgndt,
        "prjctEndDate": enddt,
        "prjctCn": replaceNewLineToBrTag(projectCn),
        "prjctColorCode": projectBgrnColor,
        "attendeeList": attendeeList
    }

    var status = $("#status").val();

    let url = "/project/register";

    if (status == 'u') {
        url = "/project/modify";
        var prjctNo = $("#prjctNo").val();
        data.prjctNo = prjctNo;
    }

    var request = $.ajax({
        url: url,
        method: "post",
        data: data
    });

    request.done(function (data) {
        location.href = '/project';
    });

}

// 색상 랜덤 변경 - 참여 인원
function setRandomColorToAttendee() {
    var attendeeElemList = $(".atendee-elem");
    for (let i = 0; i < attendeeElemList.length; i++) {
        let ranColor = getRandomColor();
        attendeeElemList[i].className += ' yen-' + ranColor;
    }
}

// 색상 랜덤 변경 - 프로젝트 색상
function setRandomColor() {
    let ranColor = getRandomColor();
    $("#btn-select-color").addClass("yen-" + ranColor);
    $("#bgrnColor").val(ranColor);
    document.getElementById(ranColor).innerHTML = "<i class='fa-solid fa-check fs-7 text-white'></i>";
}

// #btn-select-color onclick
// 색상 선택 모달 띄우고 화면 어둡게 끄기
function showColorModal() {
    document.getElementById('btn-color-modal').click();
    $(".modal-backdrop").remove();
}

// 모달 원 onclick
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

// bgnde onchange
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

}

// endde onchange
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
}

// 참석자 목록에서 삭제
function removeAttendee(e) {
    let id = e.id.substr(9);
    id = 'att_' + id;
    // 참석자 목록 elem 삭제
    e.remove();
}

// 전체 프로젝트 버튼 클릭 시 프로젝트 홈으로 이동
function moveToMainPage() {
    location.href = '/project';
}

// 기존 조직도를 참석자 추가용으로 변경
function openOrgTree() {
    $('#dept-D301').empty();
    makeTree("D301");
    document.getElementById('btn-organtree-modal').click();
    $(".modal-backdrop").remove();
    $(".modal-organixationtree").css({ "margin-left": "auto", "margin-top": "300px" });
    $(".tree-ad-icon").html("");
    $("#organ-tree-modal").on("click", ".organ-tree-empl", function () {
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
    }
}

// 랜덤 색상 반환
function getRandomColor() {
    let randNum = Math.floor(Math.random() * 10);
    let ranColor = "red";
    if (randNum == 1) {
        ranColor = "orange";
    }
    if (randNum == 2) {
        ranColor = "yellow";
    }
    if (randNum == 3) {
        ranColor = "yellowgreen";
    }
    if (randNum == 4) {
        ranColor = "green";
    }
    if (randNum == 5) {
        ranColor = "bluegreen";
    }
    if (randNum == 6) {
        ranColor = "blue";
    }
    if (randNum == 7) {
        ranColor = "darkblue";
    }
    if (randNum == 8) {
        ranColor = "navy";
    }
    if (randNum == 9) {
        ranColor = "purple";
    }

    return ranColor;
}

// yyyy-mm-dd 형식의 스트링을 date 객체로 반환
function getCurrentDate(data) {
    var currentDate = new Date(data.substring(0, 4),
        parseInt(data.substring(5, 7)) - 1,
        data.substring(8, 10));
    return currentDate;
}