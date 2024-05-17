<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="card">
	<ul class="nav nav-pills user-profile-tab" id="pills-tab" role="tablist">
		<li class="nav-item" role="presentation" style="margin-left: 30px;">
			<button class="nav-link position-relative rounded-0 active d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/profile/form';" id="pills-account-tab" data-bs-toggle="pill" data-bs-target="#pills-account" type="button" role="tab" aria-controls="pills-account" aria-selected="true">
				<i class="ti ti-user-circle me-2 fs-6"></i> <span class="d-none d-md-block">계정정보</span>
			</button>
		</li>
		<c:if test="${user.clsfCode > 4 }">
			<li class="nav-item" role="presentation" style="margin-left: 20px;">
				<button class="nav-link position-relative rounded-0 d-flex align-items-center justify-content-center bg-transparent fs-3 py-4" onclick="window.location.href='/employee/teamManagement';" id="pills-notifications-tab" data-bs-toggle="pill" data-bs-target="#pills-notifications" type="button" role="tab" aria-controls="pills-notifications" aria-selected="false">
					<i class="fa-solid fa-users"></i>&nbsp;&nbsp;&nbsp; <span class="d-none d-md-block">팀원정보</span>
				</button>
			</li>
		</c:if>
	</ul>

	<div class="card-body">
		<!-- 탭구역 시작 -->
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-account" role="tabpanel" aria-labelledby="pills-account-tab" tabindex="0">
				<!-- 폼시작 -->
				<form action="/profile/modify" method="post" id="profileForm" enctype="multipart/form-data">
					<div class="row">
						<div class="col-lg-3 d-flex align-items-stretch">
							<div class="card w-100 position-relative overflow-hidden">
								<div class="card-body p-4">
									<h5 class="card-title fw-semibold">프로필 이미지</h5>
									<p class="card-subtitle mb-4">&nbsp;</p>
									<div class="text-center">
										<img src="view/${employee.emplProflPhoto }" alt="${employee.emplProflPhoto }" id="profileImg" class="tl-profile-img" width="120" height="120">
										<div class="d-flex align-items-center justify-content-center my-4 gap-6">
											<button class="btn btn-primary" id="uploadBtn">업로드</button>
											<input type="file" class="custom-file-input" id="imgFile" name="imgFile" style="display: none;">
										</div>
										<p class="mb-0">JPG, GIF 또는 PNG 허용</p>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-9 d-flex align-items-stretch">
							<div class="card w-100 position-relative overflow-hidden">
								<div class="card-body p-4">
									<h5 class="card-title fw-semibold">사원정보</h5>
									<p class="card-subtitle mb-4">&nbsp;</p>
									<div class="mb-3">
										<label for="empName" class="form-label">사원이름</label>
										<input type="text" class="form-control" id="empName" value="${employee.emplNm }" disabled="disabled">
									</div>
									<div class="mb-3">
										<label for="dept" class="form-label">부서</label>
										<input type="text" class="form-control" id="dept" value="${employee.deptNm }" disabled="disabled">
									</div>
									<div>
										<label for="position" class="form-label">직급</label>
										<input type="text" class="form-control" id="position" value="${employee.classOfPositionVO.clsfNm }" disabled="disabled">
									</div>
								</div>
							</div>
						</div>
						<div class="col-12">
							<div class="card w-100 position-relative overflow-hidden mb-0">
								<div class="card-body p-4">
									<h5 class="card-title fw-semibold">상세정보</h5>
									<p class="card-subtitle mb-4">&nbsp;</p>
									<div class="row">
										<div class="col-lg-6">
											<div class="mb-3">
												<label for="empId" class="form-label">아이디</label>
												<input type="text" class="form-control" id="emplId" name="emplId" value="${employee.emplId }" disabled="disabled">
											</div>
											<div class="mb-3">
												<label for="empEmail" class="form-label">이메일</label>
												<input type="email" class="form-control" id="emplEmail" name="emplEmail" placeholder="이메일을 입력해주세요." value="${employee.emplEmail }">
											</div>
										</div>
										<div class="col-lg-6">
											<div class="mb-3">
												<label for="empPw" class="form-label">비밀번호</label>
												<input type="password" class="form-control" id="emplPassword" placeholder="부여받은 비밀번호를 입력해주세요.">
											</div>
											<div class="mb-5">
												<label for="empPhone" class="form-label">연락처</label>
												<input type="text" class="form-control" id="emplTelno" name="emplTelno" value="${employee.emplTelno }" placeholder="010-1234-5678">
											</div>
										</div>
										<label for="postCode" class="form-label">우편번호</label>
										<div class="col-12">
											<div class="row">
												<div class="col-3 mb-3">
													<input type="text" class="form-control w-100" id="emplZip" name="emplZip" value="${employee.emplZip }" placeholder="우편번호">
												</div>
												<div class="col-3 mb-3">
													<input type="button" class="btn btn-primary w-50" value="주소검색" onclick="DaumPostcode()">
												</div>
												<div class="col-6"></div>
											</div>
											<div>
												<label for="empAddr1" class="form-label">주소</label>
												<input type="text" class="form-control mb-3" id="emplAdres" name="emplAdres" value="${employee.emplAdres }">
											</div>
											<div>
												<label for="empAddr2" class="form-label">상세주소</label>
												<input type="text" class="form-control" id="emplAdres2" name="emplAdres2" value="${employee.emplAdres2 }">
											</div>
										</div>
										<div class="col-12">
											<div class="d-flex align-items-center justify-content-end mt-4 gap-6">
												<button type="button" class="btn btn-primary" id="saveBtn">저장</button>
												<button type="button" class="btn bg-danger-subtle text-danger" onclick="window.location.href = '/';">취소</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<sec:csrfInput />
				</form>
				<!-- 폼끝 -->
			</div>
		</div>
		<!-- 탭구역 끝 -->
	</div>
</div>
<!-- 스크립트시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'success');
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>
<script>
	let saveBtn = document.getElementById('saveBtn');
	let profileForm = document.getElementById('profileForm');
	var imgFile = $("#imgFile");

	document.getElementById('uploadBtn').addEventListener('click',
			function(event) {
				event.preventDefault(); // 기본 동작 방지
				document.getElementById('imgFile').click(); // 파일 입력 요소 클릭
			});

	// 프로필 이미지 선택 이벤트
	imgFile.on("change", function(event) {
		var file = event.target.files[0];

		if (isImageFile(file)) { // 이미지 파일인 경우
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#profileImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(file);
		} else {
			showToast("이미지 파일을 선택해주세요!", 'warning');
		}
	});

	//이미지 파일인지 체크
	function isImageFile(file) {
		var ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져온다.
		return ($.inArray(ext, [ "jpg", "jpeg", "png", "gif" ]) === -1) ? false
				: true;
	}

	saveBtn.addEventListener('click', function() {
		let emplPassword = document.getElementById('emplPassword');
		let emplEmail = document.getElementById('emplEmail');
		let emplTelno = document.getElementById('emplTelno');
		let emplZip = document.getElementById('emplZip');
		let emplAdres = document.getElementById('emplAdres');
		let emplAdres2 = document.getElementById('emplAdres2');
		// 		let emplProfl_Photo = document.getElementById('emplProfl_Photo');

		if (emplPassword.value == null || emplPassword.value.trim() === '') {
			// 		showAlert('수정 불가!', '비밀번호를 입력해주세요!', 'error');
			showToast('비밀번호를 입력해주세요!', 'info');
			emplPassword.focus();
			return false;
		}
		if (emplEmail.value == null || emplEmail.value.trim() === '') {
			showToast('이메일을 입력해주세요!', 'info');
			emplEmail.focus();
			return false;
		}
		if (emplTelno.value == null || emplTelno.value.trim() === '') {
			showToast('전화번호를 입력해주세요!', 'info');
			emplTelno.focus();
			return false;
		}
		if (emplZip.value == null || emplZip.value.trim() === '') {
			showToast('우편번호를 입력해주세요!', 'info');
			emplZip.focus();
			return false;
		}
		if (emplAdres.value == null || emplAdres.value.trim() === '') {
			showToast('주소를 입력해주세요!', 'info');
			emplAdres.focus();
			return false;
		}

		let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		let telnoRegex = /^010-\d{4}-\d{4}$/;
		let emplZipRegex = /^\d{5}$/;

		if (!emailRegex.test(emplEmail.value)) {
			showToast('이메일이 형식에 맞지 않습니다!', 'warning');
			emplEmail.focus();
			return false;
		}
		if (!telnoRegex.test(emplTelno.value)) {
			showToast('전화번호가 형식에 맞지 않습니다!', 'warning');
			emplTelno.focus();
			return false;
		}
		if (!emplZipRegex.test(emplZip.value)) {
			showToast('우편번호를 5자리로 입력해주세요!', 'warning');
			emplZip.focus();
			return false;
		}

		$.ajax({
			url : '/profile/pwCheck',
			type : 'post',
			data : JSON.stringify({
				emplPassword : emplPassword.value,
			}),
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				if (res === "EXIST") {
					console.log("확인");
					profileForm.submit();
				} else if (res === "NOTEXIST") {
					showToast('비밀번호가 일치하지 않습니다!', 'error');
					emplPassword.focus();
				}
			}
		});
	});

	function DaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('emplZip').value = data.zonecode;
				document.getElementById("emplAdres").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("emplAdres2").focus();
			}
		}).open();
	}
</script>