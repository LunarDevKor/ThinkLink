var icon = "<i class='fa-regular fa-envelope' id='mailIcon'></i><i class='fa-regular fa-address-book' id='yjAddressIcon'></i><i class='fa-regular fa-comments'></i>";
// 조직도 모달 열고 배경 제거
$(document).on('click', '#btn-organtree', function() {
	$('#dept-D301').empty();
	makeTree("D301");
	document.getElementById('btn-organtree-modal').click();
	$(".modal-backdrop").remove();
	$(".modal-organixationtree").css({"margin-left":"260px","margin-top":"calc(100vh - 500px)"});
	$(".tree-ad-icon").html(icon);
	$(".organ-tree-empl").off("click");
});

// 조직도 드롭다운
$(document).on('click', '.organ-tree .has-arrow', function() {
	
	if(!$(this).hasClass("active")) { // 클릭한 요소가 활성화되어있지 않은 상태일 때
        // 열려있는 메뉴를 숨기고 다른 클래스를 모두 제거합니다.
        $("ul", $(this).parents("ul:first")).removeClass("in");
        $("a", $(this).parents("ul:first")).removeClass("active");
  
        // 새로운 메뉴를 열고 'active' 클래스를 추가합니다.
        $(this).next("ul").addClass("in");
        $(this).addClass("active");
	} else if ($(this).hasClass("active")) { // 선택된 링크에 'active' 클래스가 있는 경우
        $(this).removeClass("active"); // 'active' 클래스를 제거합니다.
        $(this).parents("ul:first").removeClass("active");
        $(this).next("ul").removeClass("in"); // 다음 <ul>에서 'in' 클래스를 제거합니다.
    }
});

// 조직도 만들기~
function makeTree(deptCode) {
	var getEmpl = $.ajax({
		url: "/empltree/getDeptEmpl?deptCode=" + deptCode,
		async : false,
		method : "GET",
		dataType : "json"		
	});
	getEmpl.done(function(data){
		addEmpls(data);
	});
	
	var getDept = $.ajax({
		url: "/empltree/getdepts?deptCode=" + deptCode,
		method : "GET",
		dataType : "json"
	});
	getDept.done(function(data){
		addDepts(data);
	});
	
	$(".tree-ad-icon").html(icon);
}

// 사원 추가하기~~
function addEmpls(empls) {
	for(let i=0; i<empls.length; i++){
		let empl = empls[i];
		let elem = generateEmplElem(empl);
		document.getElementById("dept-"+empl.deptCode).innerHTML += elem;
	}
}

var deptNm = "";
// 사원 정보 element 만들기
function generateEmplElem(empl) {
	
	var box1 = "<li class='sidebar-item'><div class='organ-tree-empl justify-content-between rounded-0'";
	var box2 = "' ><span class='d-flex justify-content-center align-items-center round-20 rounded-circle'><img class='yen-inner-imag rounded-circle' src='";
	var box3 = "</span><div><span class='tree-ad-icon'></span></div></div></li>";
	
	var elem = box1;
	elem += "data-empl-no='" + empl.emplNo +"' data-empl-nm='" + empl.emplNm + "' data-dept-nm='" + deptNm + "' data-clsf-nm='" + empl.clsfNm;
	elem += box2;
	elem += "/profile/view/"+empl.emplProflPhoto+"";
	elem += "'></span><span class='fw-semibold'>";
	elem += empl.emplNm;
	elem += "</span><span class='col'>";
	elem += empl.clsfNm;
	elem += box3;
	return elem;	
}

// 부서 추가하기~~
function addDepts(depts){
	for(let i=0; i<depts.length; i++){
		let dept = depts[i];
		let elem = generateDeptElem(dept);
		document.getElementById("dept-"+dept.upperDeptCode).innerHTML += elem;
		makeTree(dept.deptCode);
	}
}

// 부서 element 만들기
function generateDeptElem(dept){
	deptNm = dept.deptNm;
	var elem = "<li class='sidebar-item'";
	elem += "><a class='sidebar-link has-arrow my-2' href='javascript:void(0)' aria-expanded='false'><h5 class='hide-menu'>";
	elem += dept.deptNm;
	elem += "</h5></a><ul id='dept-" + dept.deptCode;
	elem += "' aria-expanded='false' class='collapse'></ul></li>";
	return elem;
}

// 2024.05.03 주소록 기능 - 이영주
$(document).on('click', '.organ-tree-empl #yjAddressIcon', function() {
    var adbkEmpl = $(this).closest('.organ-tree-empl').attr('data-empl-no');
    var emplNo = connectionTest();
    $.ajax({
        type: "GET",
        url: "/address/getFolderList",
        success: function(res) {
            if (res.length === 0) {
                // 주소록 폴더가 없는 경우
                swal.fire({
                    title: '폴더 없음',
                    text: '주소록 폴더가 없습니다. 먼저 폴더를 생성해주세요.',
                    confirmButtonText: '확인'
                });
            } else {
                swal.fire({
                    title: '주소록 폴더 선택',
                    html: generateFolderListHTML(res),
                    showCancelButton: true,
                    confirmButtonText: '폴더에 추가',
                    cancelButtonText: '취소',
                    preConfirm: function() {
                        var adbkGrpNo = $('#addressFolderList').val();
                        // 이미 폴더에 추가된 사람인지 확인하는 쿼리 실행
                        var requestData = {
                        	adbkEmpl: adbkEmpl,
			                adbkGrpNo: adbkGrpNo,
			                emplNo: emplNo
			            };
                        $.ajax({
                            type: "post",
                            url: "/address/checkGroupMember",
                            contentType: 'application/json;charset=utf-8',
                            data: JSON.stringify(requestData),
                            success: function(response) {
                            	if (response === "OK") {
                                    // 중복되지 않은 경우에만 추가
                                    var formData = {
                                        adbkEmpl: adbkEmpl,
                                        adbkGrpNo: adbkGrpNo,
                                        emplNo: emplNo
                                    };
                                    $.ajax({
                                        type: "POST",
                                        url: "/address/addToFolder",
                                        contentType: 'application/json;charset=utf-8',
                                        data: JSON.stringify(formData),
                                        success: function(response) {
                                            swal.fire('성공', '성공적으로 주소록에 추가되었습니다!', 'success');
                                        },
                                        error: function(xhr, status, error) {
                                            swal.fire('오류', '주소록에 추가하는 데 실패했습니다', 'error');
                                        }
                                    });
                                }
                            },
                            error: function(res) {
                            	console.log(res);
                            	swal.fire('중복', '이미 폴더에 추가된 사원입니다.', 'warning');
                            }
                        });
                    }
                });
            }
        },
        error: function(xhr, status, error) {
            console.log("폴더 목록을 가져오는 데 실패했습니다:", error);
        }
    });
});

// 폴더 목록을 html로 
function generateFolderListHTML(folderList) {
    var html = '<select id="addressFolderList">';
    folderList.forEach(function(folder) {
        html += '<option value="' + folder.adbkGroupNo + '">' + folder.adbkGrpNm + '</option>';
    });
    html += '</select>';
    return html;
}


// 2024.05.07 채팅 기능 연결
$(function()  {
 
	let chatOpen = $('#open-chat-blank');
	chatOpen.on('click', function(e) {
		e.preventDefault();
		fnOpenChat()
	});
	
	function fnOpenChat(emplNo) {
		let width = 1575;
		let height = 830; 
		let left = Math.ceil((window.screen.width - width) / 2);
		let top = Math.ceil((window.screen.height - height) / 2);
		let url = '/chat';
		
		if(emplNo) {
			url = '/chat?emplNo='+emplNo;
		}
		
		let popupChat = window.open(url, '사내 채팅', 'width='+width+',height='+height+',left='+left+',top='+top+',status=no,menubar=no,resizable=no,scrollbars=no,location=no');
		popupChat.document.title = '사내 채팅';
	}
	
	$('.organ-tree').on('click', '.fa-comments', function() {
		let emplNo = $(this).closest(".organ-tree-empl").data('emplNo');
		fnOpenChat(emplNo);
	});

});

// 2024.05.08 메일 기능 연결
$(document).on('click', '.organ-tree-empl #mailIcon', function() {
    var emplNo = $(this).closest('.organ-tree-empl').attr('data-empl-no');
	location.href='/mail/sendToEmpl?emplNo='+emplNo;
});