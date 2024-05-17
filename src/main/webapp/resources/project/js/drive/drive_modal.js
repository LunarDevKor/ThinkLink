$(function() {
	let driveUpload = $('#drive-upload');
	let driveUploadModal = $('#drive-upload-modal');
	let uploadBtn = $('#uploadBtn');
	let cancelBtn = $('#cancelBtn');
	let infoCancelbtn = $('#cancelLogInfo');
	let modalExit = $('[data-exit]');

	driveUpload.on('click', function(e) {
		e.preventDefault();
		toggleDriveUploadModal();
		getFoler(fldrType);
	});

	$(document).on('click', function(e) {
		if ($(e.target).is(driveUploadModal)) {
			toggleDriveUploadModal();
		}
		else if ($(e.target).is(imageModal)) {
			toggleImageModal();
		}
		else if($(e.target).is(inputModal)) {
			toggleInputModal();
		}
		else if($(e.target).is(logInfoModal)) {
			toggleLogInfoModal();
		}
	});

	modalExit.on('click', function(e) {
		if ($(this).data('exit') == 'drive-upload') {
			e.preventDefault();
			toggleDriveUploadModal();
		}
		else if ($(this).data('exit') == 'input-modal') {
			e.preventDefault();
			toggleInputModal();
		}
		else if ($(this).data('exit') == 'log-info') {
			e.preventDefault();
			toggleLogInfoModal();
		}
	});

	uploadBtn.on('click', function() {
		toggleDriveUploadModal();
	});

	cancelBtn.on('click', function() {
		toggleDriveUploadModal();
	});
	
	infoCancelbtn.on('click', function() {
		toggleLogInfoModal();
	});
	
	function toggleDriveUploadModal() {
		driveUploadModal.toggleClass('show');
	}

});