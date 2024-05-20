<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.img-preview {
	background-color: #fff !important;
}
.imgPreview img {
	border-top: 1px solid #ddd;
    object-fit: contain; /* 이미지가 컨테이너에 맞게 조절되도록 설정 */
    max-height: 400px; /* 모달창의 크기에 맞게 최대 높이 설정 */
}
.single-note-item {
    height: 250px;  
    display: flex;
    flex-direction: column;
}

.single-note-item img {
    max-height: 150px;
/*     object-fit: cover; /* Ensures the image covers the area, cropping if necessary */ */
    width: 100%;
}

.note-content {
    overflow: hidden;
    flex-grow: 1;
}
.textarea-large {
    width: 100%;  /* 모달의 너비에 맞추어 조정 */
    height: 300px; /* 원하는 높이로 설정 */
}
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 63%;
    color: #999999;
}
.filebox label {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #999999;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}
.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
</style>

<ul class="nav nav-pills p-3 mb-3 rounded align-items-center card flex-row">
					<h3 class="fw-semibold mb-4" style="margin-left: 10px;">
							<i class="fa-sharp fa-regular fa-note-sticky fa-fw fa"></i>
						메모
					</h3>
<!-- 	<li class="nav-item"><a href="javascript:void(0)" class=" -->
<!--                       nav-link -->
<!--                     gap-6 -->
<!--                       note-link -->
<!--                       d-flex -->
<!--                       align-items-center -->
<!--                       justify-content-center -->
<!--                       px-3 px-md-3 -->
<!--                       me-0 me-md-2 text-body-color -->
<!--                     " id="note-trash" onclick="loadTrashNotes()"> -->
<!-- 			<i class="ti ti-trash"></i> <span class="d-none d-md-block font-weight-medium">Trash</span> -->
<!-- 		</a></li> -->
<!-- 	<li class="nav-item"><a href="javascript:void(0)" class=" -->
<!--                       nav-link -->
<!--                     gap-6 -->
<!--                       note-link -->
<!--                       d-flex -->
<!--                       align-items-center -->
<!--                       justify-content-center -->
<!--                       px-3 px-md-3 -->
<!--                       me-0 me-md-2 text-body-color -->
<!--                     " id="note-important" onclick="loadImportantNotes()"> -->
<!-- 			<i class="ti ti-star fill-white"></i> <span class="d-none d-md-block font-weight-medium">Important</span> -->
<!-- 		</a></li> -->
	<li class="nav-item ms-auto"><a href="javascript:void(0)" class="btn btn-primary fw-semibold rounded-0 d-flex align-items-center px-3 gap-6" id="add-notes" style="border: 1px solid #ddd;">
			<i class="ti ti-file fs-4"></i> <span class="d-none d-md-block font-weight-medium fs-3">메모 추가</span>
		</a>
	</li>
</ul>

<div class="tab-content">
	<div id="note-full-container" class="note-has-grid row">
			<!--카드동적생성  -->
	</div>
</div>
<div id="favorites-container">
    <!-- Favorited notes will be listed here -->
</div>
<!-- Detail Note Modal -->
<div class="modal fade" id="detailNoteModal" tabindex="-1" role="dialog" aria-labelledby="detailNoteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailNoteModalLabel">노트상세</h5>
            </div>
            <div class="modal-body">
                <form id="editNoteForm" enctype="multipart/form-data" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" id="note-id" name="memoNo" >
                    </div>
                    <div class="form-group">
					    <textarea class="form-control textarea-large" id="note-description" name="memoCn" ></textarea>
					</div>

                     <br>
                     <div class="form-group">
	                     <div class="form-group img-preview">
	                     	
	            			<!-- Image will be inserted here -->
				        </div>
				        <div class="form-group file-list">
				            <!-- File list will be inserted here -->
				        </div>
				         <input type="file" class="form-control" id="note-detail-image" name="imageFile">
			        </div>
                </form>
            </div>
	            <div class="modal-footer">
					<div class="d-flex gap-6">
						<button id="btn-n-modify" class="btn rounded-0 btn-primary" >저장</button>
						<button id="btn-n-delete" class="btn rounded-0 btn-primary" style="background-color: red; border: none; box-shadow: none;">삭제</button>
						<button class="btn rounded-0 bg-danger-subtle text-danger" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
        </div>
    </div>
</div>

<!-- Modal Add notes -->
<div class="modal fade" id="addnotesmodal" tabindex="-1" role="dialog" aria-labelledby="addnotesmodalTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content border-0">
			<div class="modal-header bg-primary rounded-top">
				<h6 class="modal-title text-white">메모 추가</h6>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="notes-box">
					<div class="notes-content">
						<form action="javascript:void(0);" id="addForm"  enctype="multipart/form-data" method="post">
								<div class="col-md-12">
								   <button class="btn" type="button" id="addTodoBtn" style="background: none; border: none; padding: 0; cursor: pointer;">
<!-- 									    <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"> -->
<!-- 									        <g fill="none" stroke="currentColor" stroke-width="1.75"> -->
<!-- 									            <path d="M2 12c0-4.714 0-7.071 1.464-8.536C4.93 2 7.286 2 12 2c4.714 0 7.071 0 8.535 1.464C22 4.93 22 7.286 22 12c0 4.714 0 7.071-1.465 8.535C19.072 22 16.714 22 12 22s-7.071 0-8.536-1.465C2 19.072 2 16.714 2 12Z"/> -->
<!-- 									            <path stroke-linecap="round" stroke-linejoin="round" d="m8.5 12.5l2 2l5-5"/> -->
<!-- 									        </g> -->
<!-- 									    </svg>TODO추가 -->
									</button>
									<div class="note-description">
										<textarea id="note-has-description" name="memoCn" class="form-control rounded-0"  placeholder="내용을 입력해주세요" rows="15" style="resize: none;" wrap="hard"></textarea>
									</div>
								</div>
									        <ul class="todo-list list-group" id="todoList">
									            <!-- TODO 리스트 동적 추가 -->
									        </ul>
								<br>
								<div class="col-md-12">
									<div class="note-images filebox">
										<input class="upload-name" value="첨부파일" placeholder="첨부파일">
										<input type="file" class="custom-file-input" id="note-has-imgFile" name = "imgFile" >
										<label class="custom-file-label" for="note-has-imgFile">파일을 선택해주세요</label>
									</div>
								<div class="imgPreview">
								</div>
								<div class="file-input-alert" style="display: none; color: red; margin-top: 10px;">아미지 파일을 선택해주세요.</div>
								</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="d-flex gap-6">
					<button id="btn-n-add" class="btn btn-primary rounded-0" disabled>저장</button>
					<button class="btn bg-danger-subtle text-danger rounded-0" data-bs-dismiss="modal">취소</button>
				</div>

			</div>
		</div>
	</div>
</div>
  

<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script src="${pageContext.request.contextPath }/resources/project/js/util/textarea_util.js"></script>
<script type="text/javascript">

/*todo리스트 추가  */
document.getElementById('addTodoBtn').addEventListener('click', function() {
	
	const textarea = document.getElementById('note-has-description');
    let text = replaceNewLineToBrTag(textarea.value);
    let lines = text.split('\n');  // 텍스트를 줄바꿈 기준으로 분할
    let lastLine = lines.pop().trim();  // 배열에서 마지막 줄을 제거하고 공백을 제거

    if (lastLine) {  // 마지막 줄이 비어 있지 않으면
        const todoList = document.getElementById('todoList');
        const newItem = document.createElement('li');
        newItem.className = "list-group-item";
        newItem.innerHTML = `<input type="checkbox" class="form-check-input me-1">\${lastLine}`;
        todoList.appendChild(newItem);

        // 입력 필드 업데이트: 마지막 줄 제거
        textarea.value = lines.join('\n');
    } else {
        alert("입력후 버튼 클릭해주세요");
    }
});

document.addEventListener('DOMContentLoaded', function() {
	   
	
	var alertDiv = document.querySelector('.file-input-alert');
	
    // 'Add Note' 버튼 클릭 이벤트 - 모달창 초기화 및 표시
    document.getElementById('add-notes').addEventListener('click', function () {
    	// Reset input fields
        document.getElementById('note-has-description').value = '';
        document.getElementById('note-has-imgFile').value = '';
        
        // Clear the todo list
        var todoList = document.getElementById('todoList');
        while (todoList.firstChild) {
            todoList.removeChild(todoList.firstChild);
        }

        // Clear the image preview
        var imgPreview = document.querySelector('.imgPreview');
        imgPreview.innerHTML = '';

        // Reset any alert messages
        var fileAlert = document.querySelector('.file-input-alert');
        fileAlert.style.display = 'none';

        // Show the modal dialog
        $('#addnotesmodal').modal('show');
    });

    // 'Discard' 버튼 클릭 이벤트 - 모달창 초기화
    document.querySelectorAll('.btn.bg-danger-subtle').forEach(function(button) {
        button.addEventListener('click', function () {
            resetModal();
        });
    });

    // 모달창 초기화 함수
    function resetModal() {
        document.getElementById('addForm').reset();
        var imgPreview = document.querySelector('.imgPreview');
        imgPreview.innerHTML = ''; // 이미지 프리뷰 초기화
        alertDiv.style.display = 'none'; // 리셋 시 경고 메시지 숨김
        document.getElementById('btn-n-add').disabled = true;
       
    }

    // 이미지 파일 선택 및 썸네일 표시 로직
    document.getElementById('note-has-imgFile').addEventListener('change', function(e) {
        var file = e.target.files[0];
        var imgPreview = document.querySelector('.imgPreview');
        imgPreview.innerHTML = '';  // 기존 썸네일 제거

        if (file && file.type.match('image.*')) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var imgElement = document.createElement('img');
                imgElement.src = e.target.result;
                imgPreview.appendChild(imgElement); // CSS 스타일이 자동으로 적용됨
                document.getElementById('btn-n-add').disabled = false;
                alertDiv.style.display = 'none';// 이미지가 유효하면 경고 숨김
            };
            reader.readAsDataURL(file);
        }else {
			 alertDiv.style.display = 'block'; // 경고 표시
            this.value = '';  // 파일 입력 필드 초기화
        }
    });

// 페이지 로드 시 한 번만 이벤트 핸들러를 등록
$(document).ready(function() {
	
    loadNotes(); 
    
    $('#btn-n-add').off('click').on('click', function(event) {
        event.preventDefault();
        addNote();
    });
    $('#btn-n-modify').prop('disabled', true);

    // 입력 필드나 파일 선택에 변경이 있을 경우 업데이트 버튼 활성화
    $('#editNoteForm').find('input, textarea, select').on('change keyup paste', function() {
        // 내용이 변경되었다면 버튼 활성화
        $('#btn-n-modify').prop('disabled', false);
    });

    // 파일 입력에 대한 특별한 처리
    $('#note-has-imgFile').on('change', function() {
        // 파일이 선택되었을 때도 버튼을 활성화
        $('#btn-n-modify').prop('disabled', false);
    });

    // 업데이트 버튼 클릭 이벤트
    $('#btn-n-modify').click(function() {
        if (!$(this).prop('disabled')) {
            submitNoteDetail();  // 실제 업데이트 처리 함수
        }
    });

/* 노트삭제하기 */    
    $('#btn-n-delete').click(function() {
        
    	// 메모 ID 가져오기
        var noteId = $('#note-id').val();
        // 상세보기 모달에서 메모 ID를 입력하는 hidden input 필드의 값을 사용
        if (confirm('노트를 삭제하시겠습니까?')) { // 사용자에게 삭제 확인 요청
            $.ajax({
            	url: '/deleteNote?id=' + noteId, // 메모 삭제 처리를 위한 서버의 URL
                type: 'DELETE', // HTTP 요청 메서드
                data: { id: noteId }, // 서버로 보낼 데이터
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token)
                },
                success: function(response) {
                    $('#detailNoteModal').modal('hide'); // 모달 창 닫기
                    showToast('노트가 삭제되었습니다.', 'success'); // 성공 알림
                    loadNotes(); // 모든 메모를 다시 로드하여 화면 갱신
                },
                error: function(xhr, status, error) {
                    console.error('Error deleting note:', error);
                    showToast('Failed to delete note', 'error'); // 오류 알림
                }
            });
        }
    });
    
});

/*노트 등록하기  */
    function addNote() {
        var formData = new FormData(document.getElementById('addForm'));
        
        for (let key of formData.keys()) {
            console.log(key);
            console.log(formData.get(key));
        }
        
        let memoCn = formData.get('memoCn');
        
        formData.delete('memoCn');
        formData.append('memoCn', replaceNewLineToBrTag(memoCn));
        
        for (let key of formData.keys()) {
            console.log(key);
            console.log(formData.get(key));
        }
        
     //todo 아이템 
        var todoList = document.getElementById('todoList').children;
        var todos = [];
        for (var i = 0; i < todoList.length; i++) {
            todos.push(todoList[i].textContent.trim());
        }

        // Add todos to formData
        for (var i = 0; i < todos.length; i++) {
            formData.append('todos[' + i + ']', todos[i]);
        }

       
        $.ajax({
            url: '/addNote',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend : function(xhr) {
 				xhr.setRequestHeader(header, token);
 			 },
            success: function(data) {
                if (data.status === 'success') {
                   
                	$('#addnotesmodal').modal('hide');
                	showToast('성공적으로 등록되었습니다.', 'success');
                	 loadNotes();
//                 	addNoteToPage(note);
                   
                } else {
                    console.error('Add Note Failed:', data.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }
    var descriptionInput = document.getElementById('note-has-description');
    var addButton = document.getElementById('btn-n-add');

    // 'Note Title'과 'Note Description' 입력 필드의 내용을 확인하여
    // 둘 다 비어 있지 않은 경우에만 'Add' 버튼을 활성화하는 함수
    function updateButtonState() {
        var isDescriptionEmpty = descriptionInput.value.trim() === "";
        addButton.disabled = isDescriptionEmpty;
    }

    // 'Note Description' 입력 필드에 대한 'keyup' 이벤트 리스너 추가
    descriptionInput.addEventListener('keyup', updateButtonState);
});

/*노트리스트 조회  */
function loadNotes() {
    $.ajax({
        url: '/getNotes', // 서버의 노트 데이터 리스트를 제공하는 엔드포인트
        type: 'GET',
        dataType: 'json',
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(data) {
            $('#note-full-container').empty(); // 기존에 노트 컨테이너를 비움.
       		for(let i = 0; i<data.length; i++){
       			let note = data[i];
       			addNoteToPage(note);
       		}
        },
        error: function(xhr, status, error) {
            console.error('Error loading notes: ', error);
        }
    });
}
/*등록한 노트 카드 생성하기  */
function addNoteToPage(data) {
	 // 중복 체크
    if ($('#note-full-container').find(`div[data-note-id="${data.memoNo}"]`).length > 0) {
        return; // 이미 존재하면 추가하지 않음
    }
    var imageTag = ''; // 초기 이미지 태그는 비어있음
	    if (data.imgFilePath) {
	        var imageUrl = `/displayFile?path=\${data.imgFilePath}`;
	        imageTag = `<img src="\${imageUrl}" class="img-fluid img-thumbnail" alt="Note Image" style="max-width:50%; height:auto;">`;
	    }
    var newNoteHTML = `
        <div class="col-md-4 single-note-item all-category" data-note-id="\${data.memoNo}">
            <div class="card card-body">
            		<p class="note-date fs-2"></p>
                <div class="note-content">
                    <p class="note-inner-content">\${data.memoCn}</p>
                </div>
                \${imageTag} 
		</div>`;
// 	            <div class="d-flex align-items-center">
// 		            <a href="javascript:void(0)" class="link me-1" data-note-id="\${data.memoNo}">
// 		                <i class="ti ti-star fs-6 favourite-note"></i>
// 		            </a>
		        
// 		            <a href="javascript:void(0)" class="link text-danger ms-2" data-note-id="\${data.memoNo}">
// 		                <i class="ti ti-trash fs-6 remove-note"></i>
// 		            </a>
// 	       		</div>
//             </div>

    // 생성된 HTML 문자열을 페이지의 특정 컨테이너에추가
    $('#note-full-container').append(newNoteHTML);
    
    // 카드에 클릭 이벤트 추가
    $(`div[data-note-id="${data.memoNo}"]`).on('click', function() {
        showNoteDetailModal($(this).data('note-id'));
    });
    
}


// //노트 즐겨찾기 처리
// $(document).on('click', '.favourite-note', function(event) {
//     event.stopPropagation();  // 이벤트 버블링 중단
//     var $note = $(this).closest('.single-note-item'); 
//     var noteId = $note.data('note-id');
//     var isFavorited = $note.hasClass('note-favourite'); // Check if the note is currently favorited

//         $.ajax({
//             url: '/FavoriteNote', 
//             type: 'POST', 
//             data: { noteId: noteId }, 
//             success: function(response) {
//             	 showToast('즐겨찾기에 추가되었습니다.', 'success');
//                 $note.toggleClass('note-favourite'); 
//             },
//             error: function(xhr, status, error) {
//                 console.error('Error favoriting note:', error);
//                 alert('Failed to favorite note: ' + xhr.responseText); 
//             }
//         });

// });

$(document).on('click', '.favourite-note', function(event) {
    event.stopPropagation();  
    var $note = $(this).closest('.single-note-item');
    var noteId = $note.data('note-id');
    var isFavorited = $note.hasClass('note-favourite'); 
 
    
    $.ajax({
        url: '/FavoriteNote', 
        type: 'POST',
        data: {
            noteId: noteId,
            isFavorited: isFavorited  
        },
        success: function(response) {
            if (isFavorited) {
                showToast('즐겨찾기에서 해제되었습니다.', 'info'); 
                
            } else {
                showToast('즐겨찾기에 추가되었습니다.', 'success');
            }
            $note.toggleClass('note-favourite');  
        },
        error: function(xhr, status, error) {
            console.error('Error toggling favorite status:', error);
            alert('Failed to toggle favorite status: ' + xhr.responseText);
        }
    });
});


/* 즐겨찾기함 조회  */
function loadImportantNotes() {
    $.ajax({
        url: '/getImportantNotes',
        type: 'GET',
        dataType: 'json',
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(response) {
        	  console.log("AJAX Success, Response:", response);
        	
            $('#note-full-container').empty();
            for(let i = 0; i<response.length; i++){
       			let note = response[i];
       			addNoteToPage(note);
       		
            }
        },
        error: function(xhr, status, error) {
            console.error('Error loading important notes:', error);
        }
    });
}



// 노트 삭제(휴지통으로 이동) 처리
$(document).on('click', '.remove-note', function(event) {
    event.stopPropagation();  
    var $note = $(this).closest('.single-note-item'); 
    var noteId = $note.data('note-id');
    console.log('Moving note to trash:', noteId);
    $.ajax({
        url: '/moveToTrash',
        type: 'POST', 
        data: { noteId: noteId }, 
        success: function(response) {
        	 showToast('휴지통으로 이동했습니다.', 'success');
        	 
        },
        error: function(xhr, status, error) {
            alert('Failed to trash note: ' + xhr.responseText); 
        }
    });
});

/* 삭제함에 조회  */
function loadTrashNotes() {
    $.ajax({
        url: '/getTrashNotes',
        type: 'GET',
        dataType: 'json',
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(response) {
        	  console.log("AJAX Success, Response:", response);
            $('#note-full-container').empty();
            for(let i = 0; i<response.length; i++){
       			let note = response[i];
       			addNoteToPage(note);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error loading  Trashnotes:', error);
        }
    });
}


/*카테고리별 노트 조회  */
// $(".note-link").click(function () {
//     var category = $(this).attr("id");
//     if (category === "all-category") {
//         loadNotes();  // This function should load all notes
//     } else if (category === "note-trash") {
//         loadTrashNotes();  // Load trashed notes
//     } else if (category === "note-important") {
//         loadImportantNotes();  // Load important notes
//     }
//     $(".note-link").removeClass("active");
//     $(this).addClass("active");
// });
	 $(".note-link").click(function () {
		var category = $(this).attr("id");
		 if (category === "note-important") {
			 loadImportantNotes();
		 }
		 $(".note-link").removeClass("active");
	     $(this).addClass("active");
	 });


/* 노트상세조회하기 */
function showNoteDetailModal(noteId) {
    $.ajax({
        url: '/getNoteDetail',
        type: 'GET',
        data: { id: noteId },
        success: function(response) {
            console.log("Data loaded into modal:", response.memoVO);
            $('#note-id').val(response.memoVO.memoNo);
            $('#note-description').val(replaceBrTagToNewLine(response.memoVO.memoCn));
            
            if (response.files && response.files.length > 0) {
                // 이미지 미리보기 설정
                var imageUrl = `/displayFile?path=\${response.files[0].atchFilePath}`;
                $('.img-preview').html(`<img src="\${imageUrl}" class="img-fluid img-thumbnail" style="width: 50%; height: auto;" alt="Attached Image">`);
                
                // 파일 리스트 출력
                var fileListHtml = '<ul>';
                response.files.forEach(file => {
                    fileListHtml += `<li class="float-end my-3">\${file.atchFileOrnlFileNm} (\${file.atchFileFancysize})</li>`;
                });
                fileListHtml += '</ul>';
                $('.file-list').html(fileListHtml); // 파일 목록을 나타내는 HTML 엘리먼트에 추가
            } else {
                $('.img-preview').empty(); // 이미지 미리보기 영역을 비웁니다.
                $('.file-list').empty(); // 파일 리스트 영역을 비웁니다.
            }

            $('#detailNoteModal').modal('show');
        },
        error: function(error) {
            console.error('Error fetching note details:', error);
        }
    });
}

// Event listener for opening the modal
$(document).on('click', '.single-note-item', function() {
    var noteId = $(this).data('note-id');
    showNoteDetailModal(noteId);
});
/*노트수정하기  */
function submitNoteDetail() {
    var formData = new FormData(document.getElementById('editNoteForm'));
    
    $.ajax({
        url: '/updateNote', 
        type: 'POST',
        data: formData,
        processData: false, 
        contentType: false,  
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(response) {
            $('#detailNoteModal').modal('hide');
            showToast('메모 수정이 완료되었습니다', 'success');
            loadNotes();  // Reload notes to reflect the changes
        },
        error: function(xhr, status, error) {
            console.error('Error updating note:', error);
            showToast('Failed to update note', 'error');
        }
    });
}
document.getElementById('note-detail-image').addEventListener('change', function(e) {
    var file = e.target.files[0];
    var imgPreview = document.querySelector('.img-preview');
    imgPreview.innerHTML = '';  // 기존의 이미지 미리보기를 제거

    if (file && file.type.match('image.*')) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var imgElement = document.createElement('img');
            imgElement.src = e.target.result; // 파일 내용을 src로 설정
            imgElement.style.width = "100%";  // 이미지가 imgPreview의 너비에 맞추어 표시
            imgElement.style.height = "auto";  // 높이는 자동으로 조정되어 비율 유지
            imgElement.style.objectFit = "contain";  // 컨테이너에 맞게 이미지 조정
            imgPreview.appendChild(imgElement);  // 생성된 img 요소를 imgPreview 컨테이너에 추가
        };
        reader.readAsDataURL(file);  // 파일을 읽어 데이터 URL로 변환
    } else {
        imgPreview.innerHTML = '선택한 파일이 이미지 형식이 아닙니다.'; // 이미지 파일이 아닌 경우 메시지 표시
    }
});
</script>

