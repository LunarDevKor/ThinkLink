$(function(){
});

// 더보기 버튼 누르면 모달 띄우고 내부 정보 세팅
function showTaskDetail(e){
	const taskNo = e.dataset.taskNo;
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
		setDetailOnModel(data);
	});
}

// task 정보 모달에 세팅
function setDetailOnModel(task){
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
	$("#taskNo").val(task.taskNo);
	console.log(task);
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

function moveToFormPage() {
	location.href = '/project/form';
}

function moveToProjectMain(prjctNo) {
	location.href = '/project/main?prjctNo='+prjctNo;
}

function showMod(){
	$('#task-detail-progrs').hide();
	$('#select-task-progrs').show();
}

function modProgrs(){

	var taskNo = $('#taskNo').val();
	var taskProgrs = $('#select-task-progrs').val();

	var formData = new FormData();
	formData.append('taskNo',taskNo);
	formData.append('taskProgrs',taskProgrs);

	$.ajax({
		type: 'post',
		url: '/project/modTaskProgrs',
		data: formData,
		processData: false,
		contentType: false,
		success: function(res){
			location.href = location.href;
			$('#prjct-task-tab').trigger("click");
		}
	 });
}