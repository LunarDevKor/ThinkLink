$(function () {
    function checkall(clickchk, relChkbox) {
        var checker = $("#" + clickchk);
        var multichk = $("." + relChkbox);
    
        checker.click(function () {
            multichk.prop("checked", $(this).prop("checked"));
            $(".show-btn").toggle();
        });
    }
    
    checkall("contact-check-all", "contact-chkbox");
    
    $("#input-search").on("keyup", function () {
        var rex = new RegExp($(this).val(), "i");
        $(".search-table .search-items:not(.header-item)").hide();
        $(".search-table .search-items:not(.header-item)")
            .filter(function () {
                return rex.test($(this).text());
            })
            .show();
    });
    
    $("#btn-add-contact").on("click", function (event) {
        $("#addContactModal #btn-add").show();
        $("#addContactModal #btn-edit").hide();
        $("#addContactModal").modal("show");
    });
    
    function deleteContact() {
        $(".delete").on("click", function (event) {
            event.preventDefault();
            /* Act on the event */
            $(this).parents(".search-items").remove();
        });
    }
    
    function addContact() {
        $("#btn-add").click(function () {
            var getParent = $(this).parents(".modal-content");
    
            var $_name = getParent.find("#c-name");
            var $_company = getParent.find("#c-company");
            var $_department = getParent.find("#c-department");
            var $_position = getParent.find("#c-position");
            var $_email = getParent.find("#c-email");
            var $_phone = getParent.find("#c-phone");
            var $_memo = getParent.find("#c-memo");
    
            var $_getValidationField = document.getElementsByClassName("validation-text");
            var reg = /^.+@[^\.].*\.[a-z]{2,}$/;
            var phoneReg = /^(?:\d|\-)*$/;
    
			var $_nameValue = $_name.val();
			var $_companyValue = $_company.val();
			var $_departmentValue = $_department.val();
			var $_positionValue = $_position.val();
			var $_emailValue = $_email.val();
			var $_phoneValue = $_phone.val();
			var $_memoValue = $_memo.val();
    		var imagePath = "../resources/vendor/images/profile/user-2.jpg";
            
            if ($_nameValue == "") {
                $_getValidationField[0].innerHTML = "이름을 입력하세요.";
                $_getValidationField[0].style.display = "block";
            } else {
                $_getValidationField[0].style.display = "none";
            }
    
            if ($_emailValue == "") {
                $_getValidationField[1].innerHTML = "이메일을 입력하세요.";
                $_getValidationField[1].style.display = "block";
            } else if (reg.test($_emailValue) == false) {
                $_getValidationField[1].innerHTML = "유효하지 않은 이메일 형식입니다.";
                $_getValidationField[1].style.display = "block";
            } else {
                $_getValidationField[1].style.display = "none";
            }
    
			if ($_phoneValue == "") {
				$_getValidationField[2].innerHTML = "휴대폰 번호를 입력하세요.";
				$_getValidationField[2].style.display = "block";
			} else if (phoneReg.test($_phoneValue) == false) {
				$_getValidationField[2].innerHTML = "숫자나 '-'만 입력해주세요.";
				$_getValidationField[2].style.display = "block";
			} else {
				$_getValidationField[2].style.display = "none";
			}
			
    
            if (
	          $_nameValue == "" ||
	          $_emailValue == "" ||
	          reg.test($_emailValue) == false ||
	          $_phoneValue == "" ||
	          phoneReg.test($_phoneValue) == false
	        ) {
	          return false;
	        }
    
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, "0");
            var mm = String(today.getMonth()); //January is 0!
            var time = String(today.getTime());
            var yyyy = today.getFullYear();
            var monthNames = [
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec",
            ];
            today = dd + " " + monthNames[mm] + " " + yyyy;
            var cdate = dd + mm + time;
    
		$html =
		    '<tr class="search-items">' +
		    '<td>' +
		    '<div class="n-chk align-self-center text-center">' +
		    '<div class="form-check">' +
		    '<input type="checkbox" class="form-check-input contact-chkbox primary" id="' +
		    cdate +
		    '">' +
		    '<label class="form-check-label" for="' +
		    cdate +
		    '"></label>' +
		    '</div>' +
		    '</div>' +
		    '</td>' +
		    '<td>' +
		    '<div class="d-flex align-items-center">' +
		    '<img src="' + imagePath + '" alt="avatar" class="rounded-circle" width="35">' +
		    '<div class="ms-3">' +
		    '<div class="user-meta-info">' +
		    '<h6 class="user-name mb-0" data-name="' +
		    $_nameValue +
		    '">' +
		    $_nameValue +
		    '</h6>' +
		    '</div>' +
		    '</div>' +
		    '</div>' +
		    '</td>' +
		    '<td>' +
		    '<span class="usr-company" data-company="' +
		    $_companyValue +
		    '">' +
		    $_companyValue +
		    '</span>' +
		    '</td>' +
		    '<td>' +
		    '<span class="usr-department" data-dept="' +
		    $_departmentValue +
		    '">' +
		    $_departmentValue +
		    '</span>' +
		    '</td>' +
		    '<td>' +
		    '<span class="usr-position" data-position="' +
		    $_positionValue +
		    '">' +
		    $_positionValue +
		    '</span>' +
		    '</td>' +
		    '<td>' +
		    '<span class="usr-email-addr" data-email="' +
		    $_emailValue +
		    '">' +
		    $_emailValue +
		    '</span>' +
		    '</td>' +
		    '<td>' +
		    '<span class="usr-ph-no" data-phone="' +
		    $_phoneValue +
		    '">' +
		    $_phoneValue +
		    '</span>' +
		    '</td>' +
		    '<td>' +
		    '<span class="usr-memo" data-memo="' +
		    $_memoValue +
		    '">' +
		    $_memoValue +
		    '</span>' +
		    '</td>' +
		    '</tr>';
    		
    		//html 다시 그려주는 부분
            //$(".search-table > tbody >tr:first").before($html);
            $("#addContactModal").modal("hide");
    
            var $_setNameValueEmpty = $_name.val("");
            var $_setEmailValueEmpty = $_email.val("");
            var $_setCompanyValueEmpty = $_company.val("");
            var $_setDepartmentValueEmpty = $_department.val("");
            var $_setPositionValueEmpty = $_position.val("");
            var $_setPhoneValueEmpty = $_phone.val("");
            var $_setMemoValueEmpty = $_memo.val("");
    
            deleteContact();
            editContact();
            checkall("contact-check-all", "contact-chkbox");
        });
    }
    
    $("#addContactModal").on("hidden.bs.modal", function (e) {
        var $_name = document.getElementById("c-name");
        var $_email = document.getElementById("c-email");
        var $_company = document.getElementById("c-company");
        var $_department = document.getElementById("c-department");
        var $_position = document.getElementById("c-position");
        var $_phone = document.getElementById("c-phone");
        var $_memo = document.getElementById("c-memo");
        var $_getValidationField = document.getElementsByClassName("validation-text");
    
        var $_setNameValueEmpty = ($_name.value = "");
        var $_setEmailValueEmpty = ($_email.value = "");
        var $_setCompanyValueEmpty = ($_company.value = "");
        var $_setDepartmentValueEmpty = ($_department.value = "");
        var $_setPositionValueEmpty = ($_position.value = "");
        var $_setPhoneValueEmpty = ($_phone.value = "");
        var $_setMemoValueEmpty = ($_memo.value = "");
    
        for (var i = 0; i < $_getValidationField.length; i++) {
            e.preventDefault();
            $_getValidationField[i].style.display = "none";
        }
    });
    
    function editContact() {
        $(".edit").on("click", function (event) {
            $("#addContactModal #btn-add").hide();
            $("#addContactModal #btn-edit").show();
    
            // Get Parents
            var getParentItem = $(this).parents(".search-items");
            var getModal = $("#addContactModal");
    
            // Get List Item Fields
            var $_name = getParentItem.find(".user-name");
            var $_email = getParentItem.find(".usr-email-addr");
            var $_company = getParentItem.find(".usr-company");
            var $_department = getParentItem.find(".usr-department");
            var $_position = getParentItem.find(".usr-position");
            var $_phone = getParentItem.find(".usr-ph-no");
            var $_memo = getParentItem.find(".usr-memo");
    
            // Get Attributes
            var $_nameAttrValue = $_name.attr("data-name");
            var $_emailAttrValue = $_email.attr("data-email");
            var $_companyAttrValue = $_company.attr("data-company");
            var $_departmentAttrValue = $_department.attr("data-department");
            var $_positionAttrValue = $_position.attr("data-position");
            var $_phoneAttrValue = $_phone.attr("data-phone");
            var $_memoAttrValue = $_memo.attr("data-memo");
    
            // Get Modal Attributes
            var $_getModalNameInput = getModal.find("#c-name");
            var $_getModalEmailInput = getModal.find("#c-email");
            var $_getModalCompanyInput = getModal.find("#c-company");
            var $_getModalDepartmentInput = getModal.find("#c-department");
            var $_getModalPositionInput = getModal.find("#c-position");
            var $_getModalPhoneInput = getModal.find("#c-phone");
            var $_getModalMemoInput = getModal.find("#c-memo");
   
            // Set Modal Field's Value
            var $_setModalNameValue = $_getModalNameInput.val($_nameAttrValue);
            var $_setModalEmailValue = $_getModalEmailInput.val($_emailAttrValue);
            var $_setModalCompanyValue = $_getModalCompanyInput.val($_companyAttrValue);
            var $_setModalDepartmentValue = $_getModalDepartmentInput.val($_departmentAttrValue);
            var $_setModalPositionValue = $_getModalPositionInput.val($_positionAttrValue);
            var $_setModalPhoneValue = $_getModalPhoneInput.val($_phoneAttrValue);
            var $_setModalMemoValue = $_getModalMemoInput.val($_memoAttrValue);
    
            $("#addContactModal").modal("show");
    
            $("#btn-edit").click(function () {
                var getParent = $(this).parents(".modal-content");
    
                var $_getInputName = getParent.find("#c-name");
                var $_getInputEmail = getParent.find("#c-email");
                var $_getInputCompany = getParent.find("#c-company");
                var $_getInputDepartment = getParent.find("#c-department");
                var $_getInputPosition = getParent.find("#c-position");
                var $_getInputPhone = getParent.find("#c-phone");
                var $_getInputMemo = getParent.find("#c-memo");
    
                var $_nameValue = $_getInputName.val();
                var $_emailValue = $_getInputEmail.val();
                var $_companyValue = $_getInputCompany.val();
                var $_departmentValue = $_getInputDepartment.val();
                var $_positionValue = $_getInputPosition.val();
                var $_phoneValue = $_getInputPhone.val();
                var $_memoValue = $_getInputMemo.val();
    
                var setUpdatedNameValue = $_name.text($_nameValue);
                var setUpdatedEmailValue = $_email.text($_emailValue);
                var setUpdatedCompanyValue = $_company.text($_companyValue);
                var setUpdatedDepartmentValue = $_department.text($_departmentValue);
                var setUpdatedPositionValue = $_position.text($_positionValue);
                var setUpdatedPhoneValue = $_phone.text($_phoneValue);
                var setUpdatedMemoValue = $_memo.text($_memoValue);
    
                var setUpdatedAttrNameValue = $_name.attr("data-name", $_nameValue);
                var setUpdatedAttrEmailValue = $_email.attr("data-email", $_emailValue);
                var setUpdatedAttrCompanyValue = $_company.attr("data-company", $_companyValue);
                var setUpdatedAttrDepartmentValue = $_department.attr("data-department", $_departmentValue);
                var setUpdatedAttrPositionValue = $_position.attr("data-position", $_positionValue);
                var setUpdatedAttrPhoneValue = $_phone.attr("data-phone", $_phoneValue);
                var setUpdatedAttrMemoValue = $_memo.attr("data-memo", $_memoValue);
    
                $("#addContactModal").modal("hide");
            });
        });
    }
    
    $(".delete-multiple").on("click", function () {
        var inboxCheckboxParents = $(".contact-chkbox:checked").parents(
            ".search-items"
        );
        inboxCheckboxParents.remove();
    });
    
    deleteContact();
    addContact();
    editContact();
});
  
// Validation Process
  
var $_getValidationField = document.getElementsByClassName("validation-text");
var reg = /^.+@[^\.].*\.[a-z]{2,}$/;
var phoneReg = /^\d{3}-\d{4}-\d{4}$/;
  
getNameInput = document.getElementById("c-name");
  
getNameInput.addEventListener("input", function () {
    getNameInputValue = this.value;
  
    if (getNameInputValue == "") {
        $_getValidationField[0].innerHTML = "이름을 입력하세요.";
        $_getValidationField[0].style.display = "block";
    } else {
        $_getValidationField[0].style.display = "none";
    }
});
  
getEmailInput = document.getElementById("c-email");
  
getEmailInput.addEventListener("input", function () {
    getEmailInputValue = this.value;
  
    if (getEmailInputValue == "") {
        $_getValidationField[1].innerHTML = "이메일을 입력하세요.";
        $_getValidationField[1].style.display = "block";
    } else if (reg.test(getEmailInputValue) == false) {
        $_getValidationField[1].innerHTML = "유효하지 않은 이메일 형식입니다.";
        $_getValidationField[1].style.display = "block";
    } else {
        $_getValidationField[1].style.display = "none";
    }
});
  
getPhoneInput = document.getElementById("c-phone");
  
getPhoneInput.addEventListener("input", function () {
    getPhoneInputValue = this.value;
  
    if (getPhoneInputValue == "") {
        $_getValidationField[2].innerHTML = "휴대폰 번호를 입력하세요.";
        $_getValidationField[2].style.display = "block";
    } else if (phoneReg.test(getPhoneInputValue) == false) {
        $_getValidationField[2].innerHTML = "유효하지 않은 휴대폰 번호 형식입니다. (예: 010-1234-1234)";
        $_getValidationField[2].style.display = "block";
    } else {
        $_getValidationField[2].style.display = "none";
    }
});


function modifyAddress() {
		var checkedItems = $('.contact-chkbox:checked');
		if (checkedItems.length === 1) {
			// 한 명을 체크한 경우 수정 가능하게
			isEditMode = true; // 수정 모드로 변경
			addContactTitle.text('주소록 수정'); // 모달 제목을 "주소록 수정"으로 변경

			// 선택한 체크박스의 값을 가져와서 수정 폼에 채워 넣기
			var selectedRow = checkedItems.closest('tr');
			var name = selectedRow.find('.user-name').data('name');
			var company = selectedRow.find('.usr-company').data('company');
			var department = selectedRow.find('.usr-department').data('dept');
			var position = selectedRow.find('.usr-position').data('position');
			var email = selectedRow.find('.usr-email-addr').data('email');
			var phone = selectedRow.find('.usr-ph-no').data('phone');
			var memo = selectedRow.find('.usr-memo').data('memo');

			// 수정 폼에 값들을 채워 넣기
			$('#c-name').val(name);
			$('#c-company').val(company);
			$('#c-department').val(department);
			$('#c-position').val(position);
			$('#c-email').val(email);
			$('#c-phone').val(phone);
			$('#c-memo').val(memo);
			
			$('#grpNmSelect').val('');
			$('#grpNmSelect').prop('disabled', true);
			
			$('#addContactModal').modal('show'); // 모달 열기
		} else if (checkedItems.length > 1) {
			// 두 명 이상을 체크한 경우
			 Swal.fire({
					html: '<span class="h4" style="font-size: 1.05em;">수정은 한 번에 한 명의 항목만 가능합니다.</span>',
				    icon: 'warning',
				    confirmButtonText: '확인'
				  });
		} else {
			// 체크된 항목이 없는 경우
			Swal.fire('수정할 항목을 선택해주세요.', '', 'warning');
		}

	}
	
function EmplEditAjax() {
		// 수정 내용 확인을 위한 SweetAlert 창 표시
	    Swal.fire({
	        title: '수정하시겠습니까?',
	        icon: 'question',
	        showCancelButton: true,
	        confirmButtonText: '수정',
	        cancelButtonText: '취소',
	    }).then((result) => {
	        // 사용자가 확인을 누른 경우에만 AJAX 요청 보내기
	        if (result.isConfirmed) {
	            var adbkNo = $('.contact-chkbox:checked').closest('tr').find('input[type="hidden"]').val();

	            // 폼 데이터를 가져옴
	            var formData = {
	                adbkEmail: $('#c-email').val(),
	                adbkTelno: $('#c-phone').val(),
	                adbkMemo: $('#c-memo').val(),
	                adbkNo: adbkNo
	            };

	            // AJAX를 통해 서버로 폼 데이터 전송
	            $.ajax({
	                beforeSend: function(xhr) {
	                    xhr.setRequestHeader(header, token);
	                },
	                type: 'POST',
	                url: '/address/updateEmplAddress',
	                data: JSON.stringify(formData),
	                contentType: 'application/json;charset=utf-8',
	                success: function(response) {
	                    Swal.fire('수정 성공!', '', 'success').then(() => {
	                        window.location.reload();
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error(xhr.responseText);
	                    Swal.fire('오류 발생', '수정에 실패하였습니다.', 'error');
	                }
	            });
	        }
	    });
	}
function setupEmplModalEvents() {
	    // 모달이 열릴 때마다 실행되는 이벤트
	    $('#addContactModal').on('show.bs.modal', function() {
	        addContactTitle.text('외부사원 주소록 등록');
	        // 수정 모드인 경우
	        if (isEditMode) {
	            addContactTitle.text('주소록 수정');
	            $('#btn-add').hide();
	            $('#btn-edit').show();
	            // 회사 이름 필드를 readonly로 설정
	            $('#c-name').prop('disabled', true);
	            $('#c-company').prop('disabled', true);
	            $('#c-department').prop('disabled', true);
	            $('#c-position').prop('disabled', true);
	        } else { // 추가 모드인 경우
	            $('#btn-add').show();
	            $('#btn-edit').hide();
	            // 회사 이름 필드의 readonly 속성을 제거하여 수정 가능하도록 함
	            $('#c-name').prop('disabled', false);
	            $('#c-company').prop('disabled', false);
	            $('#c-department').prop('disabled', false);
	            $('#c-position').prop('disabled', false);
	            $('#grpNmSelect').prop('disabled', false);
	        }
	    });

	    // 모달이 닫힐 때마다
	    $('#addContactModal').on('hidden.bs.modal', function() {
	        $('#btn-add').show();
	        $('#btn-edit').hide();
	        // 회사 이름 필드의 readonly 속성을 제거하여 수정 가능하도록 함
	        $('#c-company').prop('readonly', false);
	        // 수정 모드 해제
	        isEditMode = false;
	        $('#grpNmSelect').prop('disabled', false);
	        //전체체크 하는 체크박스 해제
	        $('#contact-check-all').prop('checked', false);
	        $('.form-check-input').prop('checked', false);
	    });
	}
	
$("#pslGrpDiv").on("keyup", "#input-search", function () {
    var rex = new RegExp($(this).val(), "i");
    $(".search-table .search-items:not(.header-item)").hide();
    $(".search-table .search-items:not(.header-item)")
        .filter(function () {
            return rex.test($(this).text());
        })
        .show();
});	        
	
$(document).on("click", "#contact-check-all", function () {
    $(".contact-chkbox").prop("checked", $(this).prop("checked"));
    $(".show-btn").toggle();
});

$(document).ready(function() {
    
   $(document).on('click', '#copyBtn', function() {
        var selectedData = [];

        $('.search-items input[type="checkbox"]:checked').each(function() {
            var tr = $(this).closest('.search-items');
            var name = tr.find('.user-name').text();
            var company = tr.find('.usr-company').text();
            var department = tr.find('.usr-department').text();
            var position = tr.find('.usr-position').text();
            var email = tr.find('.usr-email-addr').text();
            var phone = tr.find('.usr-ph-no').text();
            var memo = tr.find('.usr-memo').text();

            selectedData.push({
                name: name,
                company: company,
                department: department,
                position: position,
                email: email,
                phone: phone,
                memo: memo
            });
        });

        if (selectedData.length > 0) {
            var copiedText = '';
            $.each(selectedData, function(index, data) {
                copiedText += '이름: ' + data.name + '\n';
                copiedText += '회사: ' + data.company + '\n';
                copiedText += '부서: ' + data.department + '\n';
                copiedText += '직책: ' + data.position + '\n';
                copiedText += '이메일: ' + data.email + '\n';
                copiedText += '전화번호: ' + data.phone + '\n';

                // 두 개 이상의 데이터일 때만 구분자 추가
                if (index < selectedData.length - 1) {
                    copiedText += '--------------------------\n';
                }
            });

            // 텍스트를 복사할 가상 요소를 만듭니다.
            var tempTextArea = $('<textarea>');
            tempTextArea.val(copiedText);
            tempTextArea.css('position', 'fixed');
            tempTextArea.css('top', '0');
            tempTextArea.css('left', '0');
            tempTextArea.css('opacity', '0');

            // 가상 요소를 body에 추가합니다.
            $('body').append(tempTextArea);

            // 가상 요소를 선택하고 복사합니다.
            tempTextArea[0].select();
            document.execCommand('copy');

            // 가상 요소를 제거합니다.
            tempTextArea.remove();

            Swal.fire("성공!", "텍스트가 복사되었습니다!", "success");
            $('.search-items input[type="checkbox"]:checked').prop('checked', false);
            $('#contact-check-all').prop('checked', false);
        } else {
            Swal.fire({
                icon: 'warning',
                title: '경고!',
                text: '복사할 주소록을 선택해주세요.'
            });
        }
    });
});


$(function() {
    var emplNo = connectionTest();

    $(document).on('click', '#shareBtn', function() {
        var selectedData = [];

        $('.search-items input[type="checkbox"]:checked').each(function() {
            var tr = $(this).closest('.search-items');
            var name = tr.find('.user-name').text();
            var company = tr.find('.usr-company').text();
            var department = tr.find('.usr-department').text();
            var position = tr.find('.usr-position').text();
            var email = tr.find('.usr-email-addr').text();
            var phone = tr.find('.usr-ph-no').text();
            var memo = tr.find('.usr-memo').text();

            selectedData.push({
                name: name,
                company: company,
                department: department,
                position: position,
                email: email,
                phone: phone,
                memo: memo
            });
        });

        if (selectedData.length > 0) {
            var copiedText = '';
            $.each(selectedData, function(index, data) {
                copiedText += '이름: ' + data.name + '<br>';
                copiedText += '회사: ' + data.company + '<br>';
                copiedText += '부서: ' + data.department + '<br>';
                copiedText += '직책: ' + data.position + '<br>';
                copiedText += '이메일: ' + data.email + '<br>';
                copiedText += '전화번호: ' + data.phone + '<br>';
                copiedText += '메모: ' + data.memo + '<br>';

                // 두 개 이상의 데이터일 때만 구분자 추가
                if (index < selectedData.length - 1) {
                    copiedText += '----------------------------------<br>';
                }
            });

            // 텍스트를 복사할 가상 요소를 만듭니다.
            var tempTextArea = $('<textarea>');
            tempTextArea.val(copiedText);
            tempTextArea.css('position', 'fixed');
            tempTextArea.css('top', '0');
            tempTextArea.css('left', '0');
            tempTextArea.css('opacity', '0');

            // 가상 요소를 body에 추가합니다.
            $('body').append(tempTextArea);

            // 가상 요소를 선택하고 복사합니다.
            tempTextArea[0].select();
            document.execCommand('copy');

            // 가상 요소를 제거합니다.
            tempTextArea.remove();

            Swal.fire({
                title: '성공!',
                text: '텍스트가 복사되었습니다. 채팅 목록으로 이동하시겠습니까?',
                icon: 'success',
                showCancelButton: true,
                confirmButtonText: '예',
                cancelButtonText: '아니오'
            }).then(function(result) {
                if (result.isConfirmed) {
                    $('.search-items input[type="checkbox"]:checked').prop('checked', false);
                    $('#contact-check-all').prop('checked', false);
                    let width = 1575;
                    let height = 830; 
                    let left = Math.ceil((window.screen.width - width) / 2);
                    let top = Math.ceil((window.screen.height - height) / 2);
                    // 채팅 목록으로 이동
                    window.open('/chat?emplNo=' + emplNo, '사내 채팅', 'width='+width+',height='+height+',left='+left+',top='+top+',menubar=1,resizable=no,scrollbars=no,location=no'); // 채팅 목록 페이지로 이동
                } else {
                    $('.search-items input[type="checkbox"]:checked').prop('checked', false);
                    $('#contact-check-all').prop('checked', false);
                }
            });
        } else {
            Swal.fire({
                icon: 'warning',
                title: '경고!',
                text: '복사할 주소록을 선택해주세요.'
            });
        }
    });

    $('#shareModal').on('show.bs.modal', function (e) {
        if (!$('.search-items input[type="checkbox"]').is(':checked')) {
            // 주소록이 선택되지 않은 경우 모달을 열지 않음
            e.preventDefault();
            Swal.fire({
                icon: 'warning',
                title: '경고!',
                text: '공유할 주소록을 선택해주세요.'
            });
        }
    });
});

	
	
	
	
/* 폴더 삭제 */
	function deleteFolder(groupNo) {
	    $.ajax({
	        type: 'POST',
	        url: '/address/deleteFolder',
	        data: JSON.stringify({ adbkGroupNo: groupNo }),
	        contentType: 'application/json;charset=utf-8',
	        success: function(response) {
	            console.log('폴더 삭제 성공:', response);
	            Swal.fire('성공', '폴더가 삭제되었습니다.', 'success');
	            $('#adbkGroupNo-' + groupNo).closest('li').remove();
	            updateFolder(groupNo,null,'remove');
	        },
	        error: function(xhr, status, error) {
	            console.error('폴더 삭제 실패:', error);
	        }
	    });
	}
	
	function updateFolder(groupNo, modifiedFolderTitle, action) {
	    // 폴더 아이템 찾기
	    var folderItem = $('#group-link-' + groupNo);
	    //modifiedFolderTitle = modifiedFolderTitle.trim();
	    if (action === 'update') {
	        // 해당 폴더 이름 업데이트
	        folderItem.find('.folder-name').text(modifiedFolderTitle); 
	    } else if (action === 'remove') {
	        // 해당 폴더 삭제
	        folderItem.closest('li').remove();
	    }
	}

	
	function exitEditMode() {
		isEditMode = false; 
		originalFolderTitle = ''; 

		var folderNameElement = $('.fa-solid.fa-folder').siblings('.text-dark');
		folderNameElement.text(originalFolderTitle);
		
		var buttonsHtml = '<button type="button" class="btn btn-primary" id="folderMod">수정</button>' +
		                   '<button type="button" class="btn btn-danger" id="folderDel">삭제</button>' +
		                   '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>';
		$('#modal-folderFooter').html(buttonsHtml);
		
		$('.contact-chkbox').prop('disabled', false);
		
		
		loadFolderList();
	}
	
	
	function reloadFolderList() {
		$.ajax({
	        type: "GET",
	        url: "/address/getFolderList",
	        success: function(response) {
	        	var modalBody = $("#modal-folderBody");
	            modalBody.html('');
	            html = '';
	            for (var addr of response) {
                    html += '<li class="list-group-item border-0 p-0 mx-9 px-3 fs-3">';
                    html += '    <a class="d-flex align-items-center gap-6 list-group-item-action text-dark py-8 mb-1 rounded-1">';
                    html += '        <div class="folder-form-check">';
                    html += '            <input type="checkbox" class="form-check-input contact-chkbox primary" id="checkbox'+addr.adbkGroupNo+'" />';
                    html += '            <label class="form-check-label" for="checkbox'+adbkGroupNo+'"></label>';
                    html += '        </div>';
                    html += '        <input type="hidden" class="group-id" value="'+addr.adbkGroupNo+'" id="adbkGroupNo-'+addr.adbkGroupNo+'">';
                    html += '        <input type="hidden" class="group-cnt" value="'+addr.cnt+'" id="grpCnt-'+addr.cnt+'">';
                    html += '        <i class="fa-solid fa-folder fs-6 text-primary" style="color: #FFD43B;"></i>' + addr.adbkGrpNm;
                    html += '    </a>';
                    html += '</li>';
                    
                    modalBody.append(html);
                }
	            var currentFolderCount = $('#pslGrpList').nextUntil('li').length;
	            console.log("폴더 생성 후 폴더 개수:", currentFolderCount);
	        },
	        error: function(xhr, status, error) {
	            console.error("폴더 리스트 가져오기 실패:", error);
	        }
	    });
	
	}
	
	// 모달눌렀을때 바디에 폴더리스트 넣어주기
	function loadFolderList(){
		$.ajax({
	        type: "GET",
	        url: "/address/getFolderList",
	        success: function(response) {
	            console.log("폴더 리스트 가져오기 성공:", response);
	            
	            var modalBody = $("#modal-folderBody");
	            modalBody.html('');
	            html = '';
	            if (response.length === 0) {
	                // 폴더가 없는 경우 폴더를 생성해주세요 문구 추가
	                html += '<li class="list-group-item border-0 p-0 mx-9 px-3 fs-3">';
	                html += '    <span class="text-muted">폴더를 생성해주세요.</span>';
	                html += '    <br/>';
	                html += '</li>';
	            } else {
	                // 폴더가 있는 경우 폴더 리스트 추가
	                for (var addr of response) {
	                    html += '<li class="list-group-item border-0 p-0 mx-9 px-3 fs-3">';
	                    html += '    <a class="d-flex align-items-center gap-6 list-group-item-action text-dark py-8 mb-1 rounded-1">';
	                    html += '        <div class="folder-form-check">';
	                    html += '            <input type="checkbox" class="form-check-input contact-chkbox primary" id="checkbox'+addr.adbkGroupNo+'" />';
	                    html += '            <label class="form-check-label" for="checkbox'+adbkGroupNo+'"></label>';
	                    html += '        </div>';
	                    html += '        <input type="hidden" class="group-id" value="'+addr.adbkGroupNo+'" id="adbkGroupNo-'+addr.adbkGroupNo+'">';
	                    html += '        <input type="hidden" class="group-cnt" value="'+addr.cnt+'" id="grpCnt-'+addr.cnt+'">';
	                    html += '        <i class="fa-solid fa-folder fs-6 text-primary" style="color: #FFD43B;"></i>' + addr.adbkGrpNm;
	                    html += '    </a>';
	                    html += '</li>';
	                }
	            }
	            modalBody.append(html);
	        },
	        error: function(xhr, status, error) {
	            console.error("폴더 리스트 가져오기 실패:", error);
	        }
	    });
	}
	
	
	// 폴더를 생성하는 함수
	function createFolder() {
	    // 이전 폴더 개수를 가져옵니다.
	    var prevFolderCount = $('#pslGrpList').nextUntil('li').length;
	    Swal.fire({
	        title: '폴더 생성하기',
	        html: '<input id="folder-name" class="swal2-input" placeholder="폴더명을 입력하세요">',
	        showCancelButton: true,
	        confirmButtonText: '확인',
	        cancelButtonText: '취소',
	        preConfirm: () => {
	            const folderName = Swal.getPopup().querySelector('#folder-name').value;
	            if (!folderName) {
	                Swal.showValidationMessage('폴더명을 입력해주세요');
	            }
	            return folderName;
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	            const folderName = result.value;

	            // 폴더 생성 요청을 서버로 보내는 AJAX 요청
	            $.ajax({
	                type: "POST",
	                url: "/address/createFolder",
	                data: JSON.stringify({ adbkGrpNm: folderName }),
	                contentType: 'application/json;charset=utf-8',
	                success: function (response) {
	                    console.log("폴더 생성 성공");
	                    // 폴더 생성 후에 현재 폴더의 개수를 다시 가져옵니다.
	                    reloadFolderList();
	                    var currentFolderCount = $('#pslGrpList').nextUntil('li').length;
	                    location.reload(); // 페이지 새로고침
	                    $.ajax({
	                        type: "GET",
	                        url: "/address/getMaxGroupNo",
	                        success: function (response) {

	                            const adbkGroupNo = JSON.parse(response);
	                            // 새로운 폴더 동적으로 추가
	                            const newFolderLink = '<li class="list-group-item border-0 p-0 mx-9 px-3"><a class="d-flex align-items-center gap-6 list-group-item-action text-dark px-3 py-8 mb-1 rounded-1 group-link" href="#" data-group-id="adbkGroupNo-' + adbkGroupNo + '" id="group-link-' + adbkGroupNo + '"><i class="fa-solid fa-folder fs-4 text-primary" style="color: #FFD43B;"></i>' + folderName + '</a></li>';
	                            $('#create-folder-btn-wrapper').before(newFolderLink);
	                        },
	                        error: function (xhr, status, error) {
	                            console.error("폴더 생성 후 그룹 번호 가져오기 실패");
	                        }
	                    });
	                },
	                error: function (xhr, status, error) {
	                    console.error("폴더 생성 실패");
	                }
	            });
	        }
	    });
	}
	
	// 모달안에 폴더 리스트를 업데이트하는 함수
	function updateFolderList() {
	  $.ajax({
	    type: "GET",
	    url: "/address/getFolderList", // 폴더 리스트를 반환
	    success: function(response) {
	    	console.log(response);
	      // 서버로부터 받은 폴더 리스트를 사용하여 폴더 선택 상자를 업데이트
	      $('#grpNmSelect').empty();
	      if (response.length > 0) {
	        response.forEach(function(group) {
	          $('#grpNmSelect').append('<option value="' + group.adbkGroupNo + '">' + group.adbkGrpNm + '</option>');
	        });
	      } else {
	        $('#grpNmSelect').append('<option>개인주소록 그룹을 생성해주세요.</option>');
	      }
	    },
	    error: function(xhr, status, error) {
	      console.error("폴더 리스트 가져오기 실패");
	    }
	  });
	}
	
	updateFolderList();
	
	$(document).on('click', '#deleteBtn', function() {
			
		var adbkGrpNm = $('#adbkGrpNm').text().trim();
		var checkedItems = $('.contact-chkbox:checked');
		var selectedNames = [];
		var selectedIds = []; // 선택된 ID를 저장할 배열

		// 선택된 체크박스에서 이름 수집
		checkedItems.each(function() {
			var selectedRow = $(this).closest('tr');
			var name = selectedRow.find('.user-name').data('name');
			selectedNames.push(name);
			var id = selectedRow.find('input[type="hidden"]').val(); // adbkNo 값 가져오기
			selectedIds.push(id);
		});

		console.log(selectedIds);

		// 선택된 항목이 있는지 확인
		if (selectedNames.length === 0) {
			Swal.fire('삭제할 항목을 선택해주세요!', '', 'warning');
			return;
		}

		// 확인 메시지 띄우기
	    var message = '[' + adbkGrpNm + '] 에서 ' + selectedNames.join(', ') + ' 님을 삭제하시겠습니까?';
	    console.log(adbkGrpNm);
	    Swal.fire({
	        title: '삭제 확인',
	        text: message,
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '확인',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // 확인 버튼이 눌렸을 때의 동작
	            // AJAX 요청 보내기
	            $.ajax({
	                type: 'POST',
	                url: '/address/deleteAddress',
	                data: JSON.stringify({
	                    selectedIds: selectedIds,
	                    adbkGrpNo: adbkGroupNo
	                }), // 선택된 항목의 ID를 서버로 전달
	                contentType: 'application/json;charset=UTF-8',
	                success: function(response) {
	                	Swal.fire('성공', '삭제되었습니다!', 'success');
	                    selectedIds.forEach(function(id) {
	                        // 주어진 ID를 가진 행을 찾아서 삭제
	                        $('#adbkNo' + id).closest('tr').remove();
	                    });
	                    loadPersonalAddressList(adbkGroupNo);
	                    $('#contact-check-all').prop('checked', false);
	        	        $('.form-check-input').prop('checked', false);
	                    
	                },
	                error: function(xhr, status, error) {
	                	Swal.fire({
	                		  icon: 'error',
	                		  title: '삭제 중 오류가 발생했습니다.',
	                		});
	                }
	            });
	        }
	    });
	});
	
	

