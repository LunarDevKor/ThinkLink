<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-pagination.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-grid.min.css">
<style>
@font-face {
    font-family: 'SDSamliphopangche_Outline';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Outline.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.a-menu:hover>span {
    border-bottom: 3px solid #1A66CC;
}
.targetLink:hover span{
	border-bottom: 2px solid #003458;
}
.tui-grid-layer-state-content p{
	font-family: 'SDSamliphopangche_Outline';
	font-style: normal;
	font-size: 22px;
	color: black;
}
</style>

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100" style="min-height: 800px;">
		<div class="flex-shrink-0" style="border-right: 1px solid #ddd; width: 13%; max-height: 800px;" id="sideArea">
			<div class="px-9 pt-4 pb-3">
				<a href="/search/all">
					<h3 class="mb-4" style="font-weight: 600;">검색</h3>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="all">
					<span class="fs-6 ms-5">통합검색</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="mail">
					<span class="fs-6 ms-5">메일</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="address">
					<span class="fs-6 ms-5">주소록</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="approval">
					<span class="fs-6 ms-5">전자결재</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="board">
					<span class="fs-6 ms-5">게시글</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="schedule">
					<span class="fs-6 ms-5">일정</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="drive">
					<span class="fs-6 ms-5">자료실</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="noti">
					<span class="fs-6 ms-5">알림</span>
				</a>
			</div>
			<div class="py-3">
				<a href="#" class="w-100 d-block a-menu" data-search="project">
					<span class="fs-6 ms-5">프로젝트</span>
				</a>
			</div>
		</div>
		<div class="row flex-fill">
			<div class="col-12">
				<div class="card">
					<div class="card-body" style="min-height:800px; z-index: 0;" id="grid-select">
						<div id="grid"></div>
					</div>
					<div class="card-body" style="min-height: 800px;" id="all-select">
						<c:if test="${empty searchList }">
							<h4 class="card-title fw-semibold">검색 결과가 존재하지 않습니다</h4>
						</c:if>	
						<c:if test="${not empty searchList }">
						<h4 class="card-title fw-semibold fs-6">"${searchText }" 검색 결과</h4>
						<h6 class="card-subtitle"><strong>${totalCnt }</strong>개의 자료가 검색되었습니다</h6>
						<c:set var="flag" value="true"/>
						<c:set var="target" value="${searchList[0].target }"/>
						<c:set var="count" value="1"/>
						<ul class="search-listing list-style-none">
						<c:forEach var="item" items="${searchList }">
							<c:if test="${target ne item.target }">
								<c:set var="flag" value="true"/>
							</c:if>
							
							<c:if test="${flag}">
								<div class="my-3 py-2 border-top border-bottom" style="background: #f1f1f1;">
									<span class="">
										<a href="#" class="ms-2 fs-6 fw-semibold">${item.target }</a>
									</span>
								</div>
								<c:set var="count" value="1"/>
								<c:set var="flag" value="false"/>
							</c:if>
							
							<c:if test="${count < 6 }">
								<c:set value="empty" var="typeFlag"/>
								<c:choose>
									<c:when test="${item.target eq '게시판' }">
										<c:url var="url" value="/board/detail?bbscttNo=${item.targetNo }" />
										<c:set value="board" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '주소록'}">
										<c:url var="url" value="/address/addresstable" />
										<c:set value="address" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '자료실'}">
										<c:url var="url" value="/drive" />
										<c:set value="drive" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '메일'}">
										<c:url var="url" value="/mail/detail?emailNo=${item.targetNo }" />
										<c:set value="mail" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '알림' }">
										<c:url var="url" value="/noti" />
										<c:set value="noti" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '프로젝트' }">
										<c:url var="url" value="/project/main?prjctNo=${item.targetNo }" />
										<c:set value="project" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '일정' }">
										<c:url var="url" value="/schedule" />
										<c:set value="schedule" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '전자결재' }">
										<c:url var="url" value="/approval/document/${item.targetNo }" />
										<c:set value="approval" var="typeFlag"/>
									</c:when>
									<c:when test="${item.target eq '메모' }">
										<c:url var="url" value="/memo" />
										<c:set value="memo" var="typeFlag"/>
									</c:when>
								</c:choose>
								<li class="">
									<a href="${url }" class="targetLink">
										<p class="fw-bold fs-5 p-2 m-0" data-text="${item.target }">
											<font class="fw-semibold me-2">[${item.target }]</font><span data-id="${item.targetNo }" data-url="${url }">${item.contents }</span>
										</p>
									</a>
								</li>
							</c:if>
							<c:if test="${count == 6 && searchType ne typeFlag}">
								<div class="mt-2">
									<button class="btn rounded-0" style="border: 1px solid #ddd;" data-link="${typeFlag },${searchText}">더 보기<i class="ms-2 fa-sharp fa-regular fa-angles-right fa-fw"></i></button>
								</div>
							</c:if>
							<c:if test="${count >= 6 }">
								<c:if test="${searchType eq typeFlag }">
									<li class="">
										<a href="${url }" class="targetLink">
											<p class="fw-bold fs-5 p-2 m-0" data-text="${item.target }">
												<font class="fw-semibold">[${item.target }]</font> <span data-id="${item.targetNo } " data-url="${url }">${item.contents }</span>
											</p>
										</a>
									</li>
								</c:if>
							</c:if>
							
							<c:set var="target" value="${item.target}"/>
							<c:set var="count" value="${count + 1 }"/>
						</c:forEach>
						</ul>
					</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-grid.min.js"></script>
<script>
let defaultURL = '/search/';
let type = '${searchType}';
var grid;

$('[data-search]').on('click', function(e) {
	e.preventDefault();
	let searchType = $(this).data('search');
	let url = defaultURL + searchType+'?s=${searchText}';
	location.href = url;
});

$('[data-link]').on('click', function(e) {
	e.preventDefault();
	let [searchType, searchText] = $(this).data('link').split(',');
	let url = defaultURL + searchType + '?s=' + searchText;
	location.href = url;
})

let dataText = $('[data-text]');
if(type != null && type != 'all') {
	$('#all-select').hide();
	dataTextEdit();
}else{
	$('#grid-select').hide();
}

function dataTextEdit() {
	let data = [];
	
	dataText.each((idx, txt) => {
		let id = $(txt).children('span').data('id');
		let url = $(txt).children('span').data('url');
		let arr = $(txt).text().trim().split(']');
		let type = arr[0] + ']';
		let content = arr[1].trim();
		
		let obj = {
			id : id,
			type : type,
			content : content + '!*_*!' + url,
			url : url,
		}
		
		data.push(obj);
	})
	
	gridInit(data);
}


function gridInit(data) {
	tui.Grid.applyTheme('clean');
	tui.Grid.setLanguage('ko', {
		display: {
            noData: '검색 결과가 존재하지 않습니다.',
            loadingData: '로딩중입니다...',
		}
	});
	
	grid = new tui.Grid({
	    el: document.getElementById('grid'),
	    data: data,
	    header: {
	        height: 60, 
	    },
	    columns: 
	    [
	      {
	        header: '목록',
	        name: 'type',
	        width: '80',
	        align: 'center',
	        resizable: true,
	        formatter: function({value}) {
	        	return '<font class="fw-semibold fs-6 text-center">'+value+'</font>';
	        }
	      },
	      {
	        header: '결과',
	        name: 'content',
	        resizable: true,
            formatter: function({value}) {
            	let content = value.split('!*_*!')[0];
            	let url = value.split('!*_*!')[1];
            	
                return '<a class="targetLink" href="'+url+'" target="_blank"><span class="fs-5">'+content+'</span></a>';
            }
	      }
	    ],
	    pageOptions: {
	      useClient: true,
	      perPage: 10,
	      visiblePages: 5,
	      centerAlign: true
	    },
	    bodyHeight: 'fitToParent',
	    rowHeight: 60
	});
}
</script>