<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="${pageContext.request.contextPath }/resources/vendor/js/plugins/bootstrap-validation-init.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/libs/inputmask/dist/jquery.inputmask.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/vendor/js/forms/mask.init.js"></script>

<div class="card mt-3">
	<div class="card-body">
		<div class="tab-content" id="pills-tabContent">
			<!-- 폼시작 -->
			<form action="/admin/employee/insert" method="post" id="employeeForm" enctype="multipart/form-data">
				<c:if test="${status eq 'u' }">
					<input type="hidden" name="emplNo" id="emplNo" value="${empl.emplNo }" />
				</c:if>
				<div class="row">
					<div class="col-lg-6 d-flex align-items-stretch">
						<div class="card w-100 position-relative overflow-hidden">
							<div class="card-body p-4">
								<h5 class="card-title fw-semibold">사원정보</h5>
								<p class="card-subtitle mb-4"></p>
								<div class="mb-3">
									<label for="empName" class="form-label">사원이름</label> <span class="text-danger">*</span>
									<input type="text" class="form-control" id="emplNm" name="emplNm" value="${empl.emplNm }" required="required" ${status eq 'u' ? "disabled='disabled'" : ''} />
									<div class="invalid-feedback"></div>
								</div>
								<div class="mb-3">
									<label for="dept" class="form-label">부서</label> <span class="text-danger">*</span>
									<select class="form-select" id="deptCode" name="deptCode" required>
										<option value="">부서를 선택해주세요</option>
										<c:forEach items="${deptList}" var="dept">
											<option value="${dept.deptCode}" ${dept.deptCode eq empl.deptCode ? 'selected' : ''}>${dept.deptNm}</option>
										</c:forEach>
									</select>
									<div class="invalid-feedback"></div>
								</div>
								<div class="mb-3">
									<label for="position" class="form-label">직급</label> <span class="text-danger">*</span>
									<select class="form-select" id="clsfCode" name="clsfCode" required>
										<option value="">직급을 선택해주세요</option>
										<c:forEach items="${clsfList }" var="clsf">
											<option value="${clsf.clsfCode }" ${clsf.clsfCode  eq empl.clsfCode ? 'selected' : ''}>${clsf.clsfNm }</option>
										</c:forEach>
									</select>
									<div class="invalid-feedback"></div>
								</div>
								<div class="mb-3">
									<label for="empPhone" class="form-label">입사날짜</label> <span class="text-danger">*</span>
									<div class="form-group">
										<input type="date" class="form-control" id="emplEncpn" name="emplEncpn_" value="<fmt:formatDate value="${empl.emplEncpn }" pattern="yyyy-MM-dd"/>" required>
										<div class="invalid-feedback"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 d-flex align-items-stretch">
						<div class="card w-100 position-relative overflow-hidden">
							<div class="card-body p-4">
								<h5 class="card-title fw-semibold">
									프로필 이미지 <span class="text-danger">*</span>
								</h5>
								<p class="card-subtitle mb-4"></p>
								<div class="text-center">
									<c:choose>
										<c:when test="${empty empl.emplProflPhoto }">
											<img src="${pageContext.request.contextPath }/resources/project/images/other/default_profile.jpg" alt="${empl.emplProflPhoto }" id="profileImg" class="tl-profile-img" width="120" height="120">
										</c:when>
										<c:otherwise>
											<img src="/admin/employee/view/${empl.emplProflPhoto }" alt="${empl.emplProflPhoto }" id="profileImg" class="tl-profile-img" width="120" height="120">
										</c:otherwise>
									</c:choose>
									<div class="d-flex align-items-center justify-content-center my-4 gap-6">
										<button class="btn btn-primary" id="imgUploadBtn">업로드</button>
										<input type="file" class="custom-file-input" id="imgFile" name="imgFile" style="display: none;">
									</div>
									<p class="mb-0">JPG, GIF 또는 PNG 허용</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 d-flex align-items-stretch">
						<div class="card w-100 position-relative overflow-hidden">
							<div class="card-body p-4">
								<h5 class="card-title fw-semibold">
									서명 이미지 <span class="text-danger">*</span>
								</h5>
								<p class="card-subtitle mb-4"></p>
								<div class="text-center">
									<c:choose>
										<c:when test="${empty empl.emplSign }">
											<img src="${pageContext.request.contextPath }/resources/project/images/other/default_sign.jpg" alt="${empl.emplSign }" id="signImg" class="tl-profile-img" width="120" height="120">
										</c:when>
										<c:otherwise>
											<img src="${empl.emplSign }" alt="${empl.emplSign }" id="signImg" class="tl-profile-img" width="120" height="120">
										</c:otherwise>
									</c:choose>
									<div class="d-flex align-items-center justify-content-center my-4 gap-6">
										<button class="btn btn-primary" id="signUploadBtn">업로드</button>
										<input type="file" class="custom-file-input" id="signFile" name="signFile" style="display: none;">
									</div>
									<p class="mb-0">JPG, GIF 또는 PNG 허용</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12">
						<div class="card w-100 position-relative overflow-hidden mb-0">
							<div class="card-body p-4">
								<h5 class="card-title fw-semibold">상세정보</h5>
								<p class="card-subtitle mb-4"></p>
								<div class="row">
									<div class="col-lg-6">
										<div class="mb-3">
											<label for="empId" class="form-label">아이디</label> <span class="text-danger">*</span>
											<input type="text" class="form-control" id="emplId" name="emplId" value="${empl.emplId }" required="required" ${status eq 'u' ? "disabled='disabled'" : ''}>
											<div class="invalid-feedback"></div>
										</div>
										<div class="mb-5">
											<label for="empEmail" class="form-label">이메일</label> <span class="text-danger">*</span>
											<input type="email" class="form-control" id="emplEmail" name="emplEmail" placeholder="ex) thinklink@thinklink.net" value="${empl.emplEmail }">
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-lg-6">
										<div class="mb-3">
											<label for="empPw" class="form-label">비밀번호</label> <span class="text-danger">*</span>
											<input type="password" class="form-control" id="emplPassword" name="emplPassword" value="${empl.emplPassword }" required>
											<div class="invalid-feedback"></div>
										</div>
										<div class="mb-5">
											<label for="empPhone" class="form-label">연락처</label> <span class="text-danger">*</span>
											<input type="text" class="form-control" id="emplTelno" name="emplTelno" value="${empl.emplTelno }" placeholder="ex) 010-1234-5678">
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-lg-3">
										<div class="mb-3">
											<label for="empId" class="form-label">은행명</label> <span class="text-danger">*</span>
											<select class="form-select" id="bankNm" name="employeeDetailVO.bankNm" required>
												<option value="">은행을 선택해주세요</option>
												<option value="002" ${empl.employeeDetailVO.bankNm eq '002' ? 'selected' : ''}>KDB산업은행</option>
												<option value="003" ${empl.employeeDetailVO.bankNm eq '003' ? 'selected' : ''}>IBK기업은행</option>
												<option value="004" ${empl.employeeDetailVO.bankNm eq '004' ? 'selected' : ''}>KB국민은행</option>
												<option value="007" ${empl.employeeDetailVO.bankNm eq '007' ? 'selected' : ''}>수협은행</option>
												<option value="011" ${empl.employeeDetailVO.bankNm eq '011' ? 'selected' : ''}>NH농협은행</option>
												<option value="020" ${empl.employeeDetailVO.bankNm eq '020' ? 'selected' : ''}>우리은행</option>
												<option value="023" ${empl.employeeDetailVO.bankNm eq '023' ? 'selected' : ''}>SC제일은행</option>
												<option value="027" ${empl.employeeDetailVO.bankNm eq '027' ? 'selected' : ''}>한국씨티은행</option>
												<option value="031" ${empl.employeeDetailVO.bankNm eq '031' ? 'selected' : ''}>대구은행</option>
												<option value="032" ${empl.employeeDetailVO.bankNm eq '032' ? 'selected' : ''}>부산은행</option>
												<option value="034" ${empl.employeeDetailVO.bankNm eq '034' ? 'selected' : ''}>광주은행</option>
												<option value="035" ${empl.employeeDetailVO.bankNm eq '035' ? 'selected' : ''}>제주은행</option>
												<option value="037" ${empl.employeeDetailVO.bankNm eq '037' ? 'selected' : ''}>전북은행</option>
												<option value="039" ${empl.employeeDetailVO.bankNm eq '039' ? 'selected' : ''}>경남은행</option>
												<option value="081" ${empl.employeeDetailVO.bankNm eq '081' ? 'selected' : ''}>하나은행</option>
												<option value="088" ${empl.employeeDetailVO.bankNm eq '088' ? 'selected' : ''}>신한은행</option>
												<option value="089" ${empl.employeeDetailVO.bankNm eq '089' ? 'selected' : ''}>케이뱅크</option>
												<option value="090" ${empl.employeeDetailVO.bankNm eq '090' ? 'selected' : ''}>카카오뱅크</option>
											</select>
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-lg-3">
										<div class="mb-3">
											<label for="empEmail" class="form-label">예금주</label> <span class="text-danger">*</span>
											<input type="text" class="form-control" id="accountDpstr" name="employeeDetailVO.accountDpstr" value="${empl.employeeDetailVO.accountDpstr }" required>
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-lg-3">
										<div class="mb-3">
											<label for="postCode" class="form-label">우편번호</label> <span class="text-danger">*</span>
											<input type="text" class="form-control w-100" id="emplZip" name="emplZip" value="${empl.emplZip }">
											<div class="invalid-feedback"></div>
										</div>

									</div>
									<div class="col-lg-3">
										<div class="mb-3">
											<input type="button" class="btn btn-primary w-50" value="주소검색" onclick="DaumPostcode()" style="margin-top: 30px;">
										</div>
									</div>
									<div class="col-6">
										<div class="mb-3">
											<label for="empPw" class="form-label">계좌번호</label> <span class="text-danger">*</span>
											<input type="input" class="form-control" id="bankAcnutno" name="employeeDetailVO.bankAcnutno" value="${empl.employeeDetailVO.bankAcnutno }" required>
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-6">
										<div class="mb-3">
											<label for="empAddr1" class="form-label">주소</label> <span class="text-danger">*</span>
											<input type="text" class="form-control mb-3" id="emplAdres" name="emplAdres" value="${empl.emplAdres }">
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-3">
										<div class="mb-3">
											<label for="empEmail" class="form-label">주민등록번호</label> <span class="text-danger">*</span>
											<input type="input" class="form-control w-100" id="emplIhidnum" name="emplIhidnum" value="${empl.emplIhidnum }" placeholder="ex) 900101-1111111" required="required" ${status eq 'u' ? "disabled='disabled'" : ''}>
											<div class="invalid-feedback"></div>
										</div>
									</div>
									<div class="col-3">
										<div class="mb-3">
											<div class="mb-3">
												<input type="button" class="btn btn-primary w-50" value="계좌실명조회" onclick="" style="margin-top: 30px;">
											</div>
										</div>
									</div>
									<div class="col-6">
										<div class="mb-3">
											<label for="empAddr2" class="form-label">상세주소</label>
											<input type="text" class="form-control" id="emplAdres2" name="emplAdres2" value="${empl.emplAdres2 }">
										</div>
									</div>
								</div>
								<div class="col-12">
									<div class="d-flex align-items-center justify-content-end mt-4 gap-6">
										<button type="button" class="btn btn-primary" id="saveBtn">저장</button>
										<button type="button" class="btn bg-danger-subtle text-danger" onclick="window.location.href='teamManagement';">취소</button>
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
</div>
<!-- 스크립트시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>
<script>
	let saveBtn = document.getElementById('saveBtn');
	let employeeForm = $("#employeeForm");
	var imgFile = $("#imgFile");
	var signFile = $("#signFile");

	document.getElementById('imgUploadBtn').addEventListener('click',
			function(event) {
				event.preventDefault(); // 기본 동작 방지
				document.getElementById('imgFile').click(); // 파일 입력 요소 클릭
			});

	document.getElementById('signUploadBtn').addEventListener('click',
			function(event) {
				event.preventDefault(); // 기본 동작 방지
				document.getElementById('signFile').click(); // 파일 입력 요소 클릭
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

	// 사인 이미지 선택 이벤트
	signFile.on("change", function(event) {
		var file = event.target.files[0];

		if (isImageFile(file)) { // 이미지 파일인 경우
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#signImg").attr("src", e.target.result);
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

	//---------------------------------------------------------------------------	

	let emplNm = document.getElementById('emplNm');
	let flag_emplNm;
	let deptCode = document.getElementById('deptCode');
	let flag_deptCode;
	let clsfCode = document.getElementById('clsfCode');
	let flag_clsfCode;
	let emplEncpn = document.getElementById('emplEncpn');
	let flag_emplEncpn;

	let emplId = document.getElementById('emplId');
	let flag_emplId;
	let emplPassword = document.getElementById('emplPassword');
	let flag_emplPassword;
	let emplEmail = document.getElementById('emplEmail');
	let flag_emplEmail;
	let emplTelno = document.getElementById('emplTelno');
	let flag_emplTelno;

	let bankNm = document.getElementById('bankNm');
	let flag_bankNm;
	let bankAcnutno = document.getElementById('bankAcnutno');
	let flag_bankAcnutno;
	let accountDpstr = document.getElementById('accountDpstr');
	let flag_accountDpstr;
	let emplIhidnum = document.getElementById('emplIhidnum');
	let flag_emplIhidnum;

	let emplZip = document.getElementById('emplZip');
	let flag_emplZip;
	let emplAdres = document.getElementById('emplAdres');
	let flag_emplAdres;
	let emplAdres2 = document.getElementById('emplAdres2');

	let emplNmRegex = /^[가-힣]{2,5}$/;
	let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	let telnoRegex = /^010-\d{4}-\d{4}$/;
	let emplZipRegex = /^\d{5}$/;
	let emplIhidnumRegex = /^\d{6}-\d{7}$/;
	let bankAcnutnoRegex = /^[0-9]{1,20}$/;
	let idPassRegex = /^[a-zA-Z0-9]+$/;

	var status = `${status}`;
	var where = `${where}`;

	if (status == 'u') {

		employeeForm.attr("action", "/employee/update");

		flag_emplNm = true;
		flag_deptCode = true;
		flag_clsfCode = true;
		flag_emplEncpn = true;

		flag_emplId = true;
		flag_emplPassword = true;
		flag_emplEmail = true;
		flag_emplTelno = true;

		flag_bankNm = true;
		flag_bankAcnutno = true;
		flag_accountDpstr = true;
		flag_emplIhidnum = true;

		flag_emplZip = true;
		flag_emplAdres = true;
	}

	// 규칙이 다른 유효성 검사 클래스 변경
	function validateDetail(selectElement, regex, errorMessage, flag) {
		var invalidFeedbackDiv = selectElement.nextElementSibling;

		if (!regex.test(selectElement.value) || selectElement.value == null
				|| selectElement.value.trim() == '') {
			selectElement.classList.add('is-invalid');
			invalidFeedbackDiv.textContent = errorMessage;
			return false;
		} else {
			selectElement.classList.remove('is-invalid');
			selectElement.classList.add('is-valid');
			invalidFeedbackDiv.textContent = '';
			return true;
		}
	}

	// 이름
	emplNm.addEventListener('input', function() {
		flag_emplNm = validateDetail(emplNm, emplNmRegex,
				'이름을 한글 2~5자 이내로 입력해주세요', flag_emplNm);
	});

	// 이메일
	emplEmail.addEventListener('input', function() {
		flag_emplEmail = validateDetail(emplEmail, emailRegex,
				'이메일 형식에 알맞게 입력해주세요', flag_emplEmail);
	});

	// 전화번호
	emplTelno.addEventListener('input', function() {
		flag_emplTelno = validateDetail(emplTelno, telnoRegex,
				'전화번호 형식에 알맞게 입력해주세요', flag_emplTelno);
	});

	// 우편번호
	emplZip.addEventListener('input', function() {
		flag_emplZip = validateDetail(emplZip, emplZipRegex,
				'우편번호를 5자리로 입력해주세요', flag_emplZip);
	});

	// 생년월일
	emplIhidnum.addEventListener('input', function() {
		flag_emplIhidnum = validateDetail(emplIhidnum, emplIhidnumRegex,
				"'-'를 포함하여 입력해주세요", flag_emplIhidnum);
	});

	// 계좌번호
	bankAcnutno.addEventListener('input', function() {
		flag_bankAcnutno = validateDetail(bankAcnutno, bankAcnutnoRegex,
				"'-'를 제외한 20자리 이하의 숫자를 입력해주세요", flag_bankAcnutno);
	});

	// 아이디
	emplId.addEventListener('input', function() {
		flag_emplId = validateDetail(emplId, idPassRegex, '영문과 숫자로만 입력해주세요',
				flag_emplId);

		if (flag_emplId) { //아이디 중복체크

			var invalidFeedbackDiv = emplId.nextElementSibling;
			var id = emplId.value;

			$.ajax({
				url : "/admin/employee/idCheck",
				type : "post",
				data : JSON.stringify({
					emplId : id
				}),
				contentType : "application/json; charset=UTF-8",
				success : function(res) {
					if (res === "EXIST") {
						emplId.classList.add('is-invalid');
						invalidFeedbackDiv.textContent = '중복된 아이디가 있습니다';
						flag_emplId = false;
					} else {
						emplId.classList.remove('is-invalid');
						emplId.classList.add('is-valid');
						invalidFeedbackDiv.textContent = '';
						flag_emplId = true;
					}
				}
			});
		}
	});

	// 비밀번호
	emplPassword.addEventListener('input', function() {
		flag_emplPassword = validateDetail(emplPassword, idPassRegex,
				'영문과 숫자로만 입력해주세요', flag_emplPassword);
	});

	// 필수기입 사항 클래스 변경
	function validateDefalt(selectElement, flag) {
		var invalidFeedbackDiv = selectElement.nextElementSibling;

		if (!selectElement.value || selectElement.value.trim() == '') {
			selectElement.classList.remove('is-valid');
			selectElement.classList.add('is-invalid');
			invalidFeedbackDiv.textContent = '필수기입 항목입니다';
			return false;
		} else {
			selectElement.classList.remove('is-invalid');
			selectElement.classList.add('is-valid');
			invalidFeedbackDiv.textContent = '';
			return true;
		}
	}

	// 부서
	deptCode.addEventListener('input', function() {
		flag_deptCode = validateDefalt(deptCode, flag_deptCode);
	});

	// 직급
	clsfCode.addEventListener('input', function() {
		flag_clsfCode = validateDefalt(clsfCode, flag_clsfCode);
	});

	// 입사날짜
	emplEncpn.addEventListener('input', function() {
		flag_emplEncpn = validateDefalt(emplEncpn, flag_emplEncpn);
	});

	// 은행
	bankNm.addEventListener('input', function() {
		flag_bankNm = validateDefalt(bankNm, flag_bankNm);
	});

	// 예금주
	accountDpstr.addEventListener('input', function() {
		flag_accountDpstr = validateDefalt(accountDpstr, flag_accountDpstr);
	});

	// 주소
	emplAdres.addEventListener('input', function() {
		flag_emplAdres = validateDefalt(emplAdres, flag_emplAdres);
	});

	// 저장 버튼
	saveBtn
			.addEventListener(
					'click',
					function() {

						var elementFlagArray = [
								[ emplNm, flag_emplNm, '이름을 한글 2~5자 이내로 입력해주세요' ],
								[ deptCode, flag_deptCode, '필수기입 사항입니다' ],
								[ clsfCode, flag_clsfCode, '필수기입 사항입니다' ],
								[ emplEncpn, flag_emplEncpn, '필수기입 사항입니다' ],
								[ emplId, flag_emplId, '영문과 숫자로만 입력해주세요' ],
								[ emplPassword, flag_emplPassword,
										'영문과 숫자로만 입력해주세요' ],
								[ emplEmail, flag_emplEmail,
										'이메일 형식에 알맞게 입력해주세요' ],
								[ emplTelno, flag_emplTelno,
										'전화번호 형식에 알맞게 입력해주세요' ],
								[ bankNm, flag_bankNm, '필수기입 사항입니다' ],
								[ accountDpstr, flag_accountDpstr, '필수기입 사항입니다' ],
								[ bankAcnutno, flag_bankAcnutno,
										"'-'를 제외한 20자리 이하의 숫자를 입력해주세요" ],
								[ emplIhidnum, flag_emplIhidnum,
										"'-'를 포함하여 입력해주세요" ],
								[ emplZip, flag_emplZip, '우편번호를 5자리로 입력해주세요' ],
								[ emplAdres, flag_emplAdres, '필수기입 사항입니다' ] ];

						for (var i = 0; i < elementFlagArray.length; i++) {
							if (!elementFlagArray[i][1]) {
								var invalidFeedbackDiv = elementFlagArray[i][0].nextElementSibling;
								elementFlagArray[i][0].classList
										.add('is-invalid');
								invalidFeedbackDiv.textContent = elementFlagArray[i][2];
								elementFlagArray[i][0].focus();
								showToast(
										'필수항목이 입력되지 않았거나\n형식에 맞지 않은 내용이 있습니다!',
										'info');
								return false;
							}
						}

						if (status == null || status == '') {

							var imgFile = $("#imgFile")[0];
							var signFile = $("#signFile")[0];

							if (!imgFile.files[0]) {
								showToast('프로필 이미지를 첨부해주세요!', 'info');
								return false;
							}

							if (!signFile.files[0]) {
								showToast('서명 이미지를 첨부해주세요!', 'info');
								return false;
							}
						}

						employeeForm.submit();
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
				flag_emplZip = true;
				emplZip.classList.remove('is-invalid');
				emplZip.classList.add('is-valid');
				emplZip.nextElementSibling.textContent = '';
				document.getElementById("emplAdres").value = addr;
				flag_emplAdres = true;
				emplAdres.classList.remove('is-invalid');
				emplAdres.classList.add('is-valid');
				emplAdres.nextElementSibling.textContent = '';
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("emplAdres2").focus();
			}
		}).open();
	}
</script>
