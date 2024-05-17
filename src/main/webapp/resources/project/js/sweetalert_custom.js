// Default Alert(기본 얼럿)
const showAlert = (title, text, icon) => {
  return Swal.fire({
    title,
    text,
    icon,
    confirmButtonText: '확인',
    customClass: {
    	popup: 'rounded-0',
    	confirmButton: 'btn btn-primary rounded-0',
    },
    allowEscapeKey: true,
    allowEnterKey: true
  });
};

// Confirm Alert(확인창 얼럿)
const showConfirm = (title, text, icon, confirmButtonText = '확인', cancelButtonText = '취소') => {
  return Swal.fire({
    title,
    text,
    icon,
    showCancelButton: true,
    confirmButtonText,
    cancelButtonText,
    showClass: {
    	popup: 'animate__animated animate__zoomIn animate__faster'
    },
    hideClass: {
    	popup: 'animate__animated animate__zoomOut animate__faster'
    },
    customClass: {
    	popup: 'rounded-0',
    	confirmButton: 'btn btn-primary rounded-0',
    	cancelButton: 'btn btn-danger rounded-0'
    },
    allowEscapeKey: true,
    allowEnterKey: true
  });
};

// Toast (토스트)
const showToast = (title, icon) => {
  const Toast = Swal.mixin({
    toast: true,
    position: 'center',
    showConfirmButton: false,
    timer: 1500,
    timerProgressBar: true,
    showClass: {
    	popup: 'animate__animated animate__slideInUp'
    },
    hideClass: {
	  	popup: 'animate__animated animate__fadeOut'
	},
    didOpen: (toast) => {
      toast.addEventListener('mouseenter', Swal.stopTimer);
      toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
  });

  Toast.fire({
    icon,
    title
  });
};

// 알림 Toast (알림 토스트)
const showNotiToast = (title, icon) => {
  const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 2000,
    timerProgressBar: true,
    showClass: {
    	popup: 'animate__animated animate__lightSpeedInRight'
    },
    hideClass: {
	  	popup: 'animate__animated animate__lightSpeedOutRight'
	},
	customClass: {
		popup: 'toast-top-end-custom' // 특정 toast에 대한 클래스 추가
	},
    didOpen: (toast) => {
      toast.addEventListener('mouseenter', Swal.stopTimer);
      toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
  });

  Toast.fire({
    icon,
    title
  });
};


/*
	*아이콘 설정값
		success : 성공
		error : 실패
		warning : 경고
		info : 정보
		question : 질문
	
	----------------------------------------------------------
	토스트 사용 예시
	
	Toast.fire({
		icon: '아이콘 설정 값',
		title: '제목 값',
		text: '내용 값'
	});
	
	----------------------------------------------------------
	Alert 사용 예시
	
	Swal.fire({
		icon: '아이콘 설정 값',
		title: '제목 값',
		text: '내용 값'
		cancelButtonColor: '취소 버튼 색상 값'
		cancelButtonText: '취소 버튼 텍스트 값'
	});
	
	* confirm 창
		Swal.fire 속성에 밑에 있는 코드 추가
		
		confirmButtonColor: 'Confirm 버튼 색상 값'
		confirmButtonText: 'Confirm 버튼 텍스트 값'
		
	----------------------------------------------------------
	Promise 사용 예시
	
	Swal.fire({
		icon: '아이콘 설정 값',
		title: '제목 값',
		text: '내용 값'
		cancelButtonColor: '취소 버튼 색상 값'
		cancelButtonText: '취소 버튼 텍스트 값'
		confirmButtonColor: 'Confirm 버튼 색상 값'
		confirmButtonText: 'Confirm 버튼 텍스트 값'
	})
	// Promise 이벤트 핸들링
	.then(result => {
		if(result.isConfirmed) { // confirm 버튼 눌렀다면
			... 이후 코드
		}else if(result.isDismissed) { // cancel 버튼 눌렀다면
			... 이후 코드
		}
	});
	
	----------------------------------------------------------
	INPUT/HTML 사용 예시
	
    Swal.fire({
		icon: '아이콘 설정 값',
		title: '제목 값',
		html: '<input type="password" id="pw" class="swal2-input" placeholder="비밀번호">',
		cancelButtonColor: '취소 버튼 색상 값'
		cancelButtonText: '취소 버튼 텍스트 값'
		confirmButtonColor: 'Confirm 버튼 색상 값'
		confirmButtonText: 'Confirm 버튼 텍스트 값'
	
	HTML로 INPUT 추가
	
	OR
	
    Swal.fire({
	icon: '아이콘 설정 값',
	title: '제목 값',
	input: 'text',
	inputPlaceholder: '입력 하세요...',
	inputAttributes: {
    	autocapitalize: "off"
  	},
	cancelButtonColor: '취소 버튼 색상 값'
	cancelButtonText: '취소 버튼 텍스트 값'
	confirmButtonColor: 'Confirm 버튼 색상 값'
	confirmButtonText: 'Confirm 버튼 텍스트 값'
	
	----------------------------------------------------------
	Alert 창 안에서 Ajax 실행 예시
	
	Swal.fire({
	  title: 'Submit your Github username',
	  input: 'text',
	  inputAttributes: {
	    autocapitalize: 'off'
	  },
	  showCancelButton: true,
	  confirmButtonText: 'Look up',
	  
	  showLoaderOnConfirm: true, // 데이터 결과를 받을때까지, 버튼에다가 로딩바를 표현
	  preConfirm: (login) => { // 확인 버튼 누르면 실행되는 콜백함수
	    return fetch(`요청할 주소`)
	      .then(response => {
	        if (!response.ok) {
	          throw new Error(response.statusText)
	        }
	        return response.json()
	      })
	      .catch(error => {
	        Swal.showValidationMessage(
	          `Request failed: ${error}`
	        )
	      })
	  },
	  
	  // 실행되는 동안 배경 누를때 모달창 안닫히도록 설정
	  // isLoading() 즉, 로딩이 진행되는 동안 false를 리턴하게 해서 ousideClick을 안되게 하고, 로딩 상태가 아니면 ousideClick을 허용한다.
	  allowOutsideClick: () => !Swal.isLoading() 
	  
	}).then((result) => {
	
	  if (result.isConfirmed) { // 결과 확인 버튼 눌렀을 경우
	    Swal.fire({ // 실행되는 Alert
	      title: `${result.value.login}'s avatar`,
	      imageUrl: result.value.avatar_url
	    })
	  }
	})
	
*/