$(function() {
    let approvalBtn = $('#approval-btn');
    let approvalModal = $('#approval-modal');
    let actionBtn = $('#actionBtn');
    let cancelBtn = $('#cancelBtn');
    let modalExit = $('[data-exit]');
    let docBookMarkBtn = $('#docBookMark');
    
    approvalBtn.on('click', function(e) {
        selectDocList();
        toggleModal();
    });

    $(document).on('click', function(e) {
        if($(e.target).is(approvalModal)) {
            toggleModal();
        }
    });

    modalExit.on('click', function(e) {
    	if($(this).data('exit') == 'approval'){
	        e.preventDefault();
	        toggleModal();
	        
			collapseAllTrees();
    	}
    });
    
    docBookMarkBtn.on('click', function() {
    	var tree = $.ui.fancytree.getTree('#tree');
        var node = tree.getActiveNode();
        
        if(node == undefined) {
        	showAlert('선택된 양식이 없습니다!', '양식을 선택해주세요', 'error');
        	return;
        }
        
       	let docNo = node.key.split('.')[1];
       	let emplNo = connectionTest();
       	
       	$.post('/approval/docbookmark', {emplNo : emplNo, docNo : docNo})
       	.done(function (res) {
       		if(res == 'EXIST') {
       			showToast(node.title + ' 문서는 이미 즐겨찾기에 추가된 항목입니다!', 'warning');
       			return;
       		}
       		
       		if(res == 'OK') {
       			showToast(node.title + ' 문서를 즐겨찾기에 추가하였습니다!', 'success');
       			
       			let doc = {
       				docNm : node.title,
       				docNo : docNo
       			}
       			
       			let html = createBookmarkHTML(doc);
       			bookMarkArea.append(html);
       			
       		}else{
       			showAlert('즐겨찾기 추가에 실패하였습니다!', '잠시 후 다시 시도해주세요', 'error');
       		}
       	});
    });
    
    actionBtn.on('click', function() {
        var tree = $.ui.fancytree.getTree('#tree');
        var node = tree.getActiveNode();
        console.log(node);
        if(node == null) {
            showToast('양식을 선택해주세요!', 'error');
            return;
        }
        console.log(node.title);
        toggleModal();
        let docNo = node.key.split('.')[1];
        location.href='/approval/form?docNo='+docNo;
    });
    
    cancelBtn.on('click', function() {
    	toggleModal();
    	collapseAllTrees();
	});
	
    function toggleModal() {
        approvalModal.toggleClass('show');
    }
    
    // FancyTree 스크립트 부분
    
	$("#search-input").on("keyup", function() {
		if ($("#search-input").val()) {
			searchTree();
		} else {
			collapseAllTrees();
		}
	});

	function collapseAllTrees() {
		var tree = $.ui.fancytree.getTree("#tree");
		tree.visit(function(node) {
			node.setExpanded(false);
			node.setSelected(false);
			node.removeClass("search-hi-lite");
		});
	}

	function searchTree() {
		var tree = $.ui.fancytree.getTree("#tree");
		var searchTerm = $("#search-input").val();
		tree.filterNodes(searchTerm, {
			autoExpand : true,
		});
		tree.visit(function(node) {
			if (node.title.includes(searchTerm)) {
				$(node).addClass("search-hi-lite");
			} else {
				$(node).removeClass("search-hi-lite");
			}
		});
	}
});