<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#wrap {
  display: inline-block;
  position: relative;
  height: 60px;
  float: right;
  padding: 0;
  position: relative;
}

.search-input {
  height: 60px;
  font-size: 20px;
  display: inline-block;
  font-family: "Lato";
  font-weight: 100;
  border: none;
  outline: none;
  color: #555;
  padding: 3px;
  padding-right: 60px;
  width: 0px;
  position: absolute;
  top: 0;
  right: 0;
  background: none;
  z-index: 3;
  transition: width .4s cubic-bezier(0.000, 0.795, 0.000, 1.000);
  cursor: pointer;
}

.search-input:focus:hover {
  border-bottom: 1px solid #BBB;
}

.search-input:focus {
  width: 1450px;
  z-index: 1;
  border-bottom: 1px solid #BBB;
  cursor: text;
}
.search-btn {
  height: 67px;
  width: 63px;
  display: inline-block;
  color: red;
  float: right;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAADNQTFRFU1NT9fX1lJSUXl5e1dXVfn5+c3Nz6urqv7+/tLS0iYmJqampn5+fysrK39/faWlp////Vi4ZywAAABF0Uk5T/////////////////////wAlrZliAAABLklEQVR42rSWWRbDIAhFHeOUtN3/ags1zaA4cHrKZ8JFRHwoXkwTvwGP1Qo0bYObAPwiLmbNAHBWFBZlD9j0JxflDViIObNHG/Do8PRHTJk0TezAhv7qloK0JJEBh+F8+U/hopIELOWfiZUCDOZD1RADOQKA75oq4cvVkcT+OdHnqqpQCITWAjnWVgGQUWz12lJuGwGoaWgBKzRVBcCypgUkOAoWgBX/L0CmxN40u6xwcIJ1cOzWYDffp3axsQOyvdkXiH9FKRFwPRHYZUaXMgPLeiW7QhbDRciyLXJaKheCuLbiVoqx1DVRyH26yb0hsuoOFEPsoz+BVE0MRlZNjGZcRQyHYkmMp2hBTIzdkzCTc/pLqOnBrk7/yZdAOq/q5NPBH1f7x7fGP4C3AAMAQrhzX9zhcGsAAAAASUVORK5CYII=) center center no-repeat;
  background-size: 50%;
  text-indent: -10000px;
  border: none;
  position: absolute;
  top: 0;
  right: 0;
  z-index: 2;
  cursor: pointer;
  opacity: 0.4;
  cursor: pointer;
  transition: opacity .4s ease;
}

.search-btn:hover {
  opacity: 0.8;
}

/* .autocomplete-input { */
/*     display: block; */
/*     width: 360px; */
/*     margin: 10px auto 0; */
/*     padding: 10px; */
/*     border: 1px solid #ccc; */
/*     border-radius: 8px; */
/*     font-size: 16px; */
/*     outline: none; */
/* } */
.ui-autocomplete {
    position: absolute;
    max-height: 400px;
    margin: 0;
    padding: 0;
    background-color: #fff;
    border: 1px solid #ccc !important;
    border-radius: 8px;
    z-index: 1;
    list-style: none;
    overflow-y: auto;
}
.ui-menu-item div.ui-state-hover,
.ui-menu-item div.ui-state-active {
	background-color: #0077CC;
	border-radius: 0px;
	-webkit-border-radius: 0px;
	-moz-border-radius: 0px;
	background-image: none;
	border:none;
}
.ui-autocomplete li {
    padding: 10px;
    cursor: pointer;
    font-size: 16px;
    color: #000;
}
.ui-autocomplete li strong {
	color: #e63c3c;
/*     color: #0077CC; */
}
.ui-helper-hidden-accessible {
    display: none;
}

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/jquery-ui.min.css">
<script src="${pageContext.request.contextPath }/resources/project/js/source/jquery-ui.min.js"></script>
<script>
$(function () {
    $("#autocomplete").autocomplete({
        source: function (request, response) {
        	let emplNo = connectionTest();
        	$.post('/search', {searchText : request.term, emplNo : emplNo})
        	.done(function(data) {
	            const inputText = request.term.toLowerCase();
	            const filteredItems = [];
	            data.forEach(item => {
	            	let existTarget = filteredItems.filter(exist => exist == '('+item.target+')');
	            	if(existTarget.length == 0) {
	            		filteredItems.push('('+item.target+')');
	            	}
	            	filteredItems.push(item.contents);
	            })
	            
	            response(filteredItems);
        	})
        },
        position: { my: "left top+5" },
        select: function(e, ui) {
        	if(ui.item.value.startsWith('(')) {
        		e.preventDefault();
        		return false;
        	}
        	location.href = '/search/all?s='+ui.item.value;
        },
        focus: function(e, ui) {
        	return false;
        },
        delay: 50,
        minLength: 2,
        open: function () {
            const inputText = $("#autocomplete").val().toLowerCase();
            $(".ui-autocomplete li").each(function () {
            	let div = $('<div class="ui-menu-item-wrapper"></div>');
                let suggestion = $(this).text();
                const index = suggestion.toLowerCase().indexOf(inputText);
                if(suggestion.startsWith('(')) {
                	suggestion = `<span class="fw-semibold text-white" style="border-left:0; border-right:0;">\${suggestion}</span>`
                	suggestion = suggestion.replace('(','').replace(')','');
                	div.append(suggestion);
	                $(this).html(div);
                	$(this).css('border', '1px solid #ddd').css('border-left', '0').css('border-right', '0').css('background', '#6d6f73').addClass('text-center');
                }else if (index !== -1) {
                    const highlightedPart = `<strong>\${suggestion.substr(index, inputText.length)}</strong>`;
                    suggestion = suggestion.substring(0, index) + highlightedPart + suggestion.substring(index + inputText.length);
                    div.append(suggestion);
	                $(this).html(div);
                }
            });
        },
        close: function() {
        }
    });
            
    $('#autocomplete').on('keydown', function(e) {
    	if(e.key == 'Enter' && !e.shiftKey) {
    		let searchString = $(this).val().trim();
    		if(searchString) {
	    		location.href = '/search/all?s='+encodeURIComponent(searchString);
    		}
    	}
    });
});
</script>
<!--  Header Start -->
<header class="topbar">
	<div class="with-vertical">
		<!-- ---------------------------------- -->
		<!-- 헤더 메뉴 시작 -->
		<!-- ---------------------------------- -->
		<nav class="navbar navbar-expand-lg p-0">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link sidebartoggler nav-icon-hover ms-n3" id="headerCollapse" href="javascript:void(0)">
						<i class="ti ti-menu-2"></i>
					</a>
				</li>
			</ul>

			<div class="d-block d-lg-none">
				<a href="../main/index.html" class="text-nowrap logo-img">
					<img src="${pageContext.request.contextPath}/resources/vendor/images/logos/dark-logo.svg" class="dark-logo" alt="Logo-Dark" />
					<img src="${pageContext.request.contextPath}/resources/vendor/images/logos/light-logo.svg" class="light-logo" alt="Logo-light" />
				</a>
			</div>
			<div class="collapse navbar-collapse justify-content-end" id="navbarNav">
				<div class="d-flex align-items-center justify-content-between">
					<a href="javascript:void(0)" class="nav-link d-flex d-lg-none align-items-center justify-content-center" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobilenavbar" aria-controls="offcanvasWithBothOptions">
						<i class="ti ti-align-justified fs-7"></i>
					</a>
					<ul class="navbar-nav flex-row ms-auto align-items-center justify-content-center">
						<!-- ------------------------------- -->
						<!-- 라이트/다크 모드 토글 시작 -->
						<!-- ------------------------------- -->
<!-- 						<li class="nav-item"> -->
<!-- 							<a class="nav-link moon dark-layout" href="javascript:void(0)"> -->
<!-- 								<iconify-icon icon="solar:moon-line-duotone" class="moon fs-7"></iconify-icon> -->
<!-- 							</a> -->
<!-- 							<a class="nav-link sun light-layout" href="javascript:void(0)"> -->
<!-- 								<iconify-icon icon="solar:sun-2-line-duotone" class="sun fs-7"></iconify-icon> -->
<!-- 							</a> -->
<!-- 						</li> -->
						
						<li class="nav-item">
							<div id="wrap">
							  <input id="autocomplete" name="search" type="text" placeholder="검색어를 입력하세요..." autocomplete="off" class="search-input autocomplete-input">
							  <input id="search_submit" value="" type="button" class="search-btn">
							</div>
						</li>	
						<!-- ------------------------------- -->
						<!-- 라이트/다크 모드 토글 끝 -->
						<!-- ------------------------------- -->

						<!-- ------------------------------- -->
						<!-- 알림 드롭다운 시작 -->
						<!-- ------------------------------- -->
						<li class="nav-item dropdown">
							<a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
								<i class="fa-sharp fa-regular fa-bell fa-xl fa-fw fa"></i>
							</a>
							<div class="dropdown-menu content-dd dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
								<div class="d-flex align-items-center justify-content-between py-3 px-7">
									<h5 class="mb-0 fs-5 fw-semibold">알림</h5>
									<span class="badge text-bg-danger rounded-4 px-3 py-1 lh-sm" id="notiSize">0</span>
								</div>
								<div class="message-body" data-simplebar id="noti" style="overflow-y:auto;">
								</div>
								<div class="py-6 px-7 mb-1">
									<a href="/noti">
										<button class="btn btn-outline-primary w-100">모든 알림 더보기</button>
									</a>
								</div>

							</div>
						</li>
						<!-- ------------------------------- -->
						<!-- 알림 드롭다운 끝 -->
						<!-- ------------------------------- -->

						<!-- ------------------------------- -->
						<!-- 프로필 드롭다운 시작 -->
						<!-- ------------------------------- -->
						<li class="nav-item dropdown">
							<a class="nav-link pe-0" href="javascript:void(0)" id="drop1" data-bs-toggle="dropdown" aria-expanded="false">
								<div class="d-flex align-items-center">
									<div class="user-profile-img">
										<img src="/profile/view/${employee.emplProflPhoto }" class="rounded-circle" width="35" height="35" alt="" />
									</div>
								</div>
							</a>
							<div class="dropdown-menu content-dd dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop1">
								<div class="profile-dropdown position-relative" data-simplebar>
									<div class="py-3 px-7 pb-0">
										<h5 class="mb-0 fs-5 fw-semibold">사원 정보</h5>
									</div>
									<div class="d-flex align-items-center py-9 mx-7 border-bottom">
										<img src="/profile/view/${employee.emplProflPhoto }" class="rounded-circle" width="80" height="80" alt="" />
										<div class="ms-3">
											<h5 class="mb-1 fs-3 fw-semibold">${employee.emplNm }</h5>
											<span class="mb-1 d-block">${employee.clsfNm }</span>
											<p class="mb-0 d-flex align-items-center gap-2">${employee.deptNm }</p>
										</div>
									</div>
									<div class="message-body">
										<a href="/profile/form" class="py-8 px-7 mt-8 d-flex align-items-center">
											<span class="d-flex align-items-center justify-content-center text-bg-light rounded-1 p-9">
													<i class="fa-duotone fa-user-tie fa-xl fa-fw fa"></i>
											</span>
											<div class="w-75 d-inline-block v-middle ps-3">
												<h6 class="mb-1 fs-3 fw-semibold lh-base">프로필</h6>
												<span class="fs-2 d-block text-body-secondary">계정 설정</span>
											</div>
										</a>
										
										<sec:authentication property="principal.employeeVO.AuthList" var="authList" />
										<c:set var="isAdmin" value="false"/>
										<c:forEach var="auth" items="${authList }">
											<c:if test="${auth.authorNm eq 'ROLE_ADMIN' }">
												<c:set var="isAdmin" value="true"/>
											</c:if>
										</c:forEach>
										
										<c:if test="${isAdmin eq true }">
											<a href="/admin/main" class="py-8 px-7 mt-8 d-flex align-items-center">
												<span class="d-flex align-items-center justify-content-center text-bg-light rounded-1 p-9">
														<i class="fa-duotone fa-user-secret fa-xl fa-fw fa"></i>
												</span>
												<div class="w-75 d-inline-block v-middle ps-3">
													<h6 class="mb-1 fs-3 fw-semibold lh-base">관리자</h6>
													<span class="fs-2 d-block text-body-secondary">사이트 관리</span>
												</div>
											</a>
										</c:if>
									</div>
									<div class="d-grid py-4 px-7 pt-8">
										<form action="/logout" method="post">
											<button class="btn rounded-0 btn-danger form-control">로그아웃</button>
											<sec:csrfInput />
										</form>
									</div>
								</div>

							</div>
						</li>
						<!-- ------------------------------- -->
						<!-- 프로필 드롭다운 끝 -->
						<!-- ------------------------------- -->
					</ul>
				</div>
			</div>
		</nav>
		<!-- ---------------------------------- -->
		<!-- 헤더 메뉴 끝 -->
		<!-- ---------------------------------- -->

		<!-- ------------------------------- -->
		<!-- 작은 메뉴.ver -->
		<!-- ------------------------------- -->
		<!--  Mobilenavbar -->
		<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="mobilenavbar" aria-labelledby="offcanvasWithBothOptionsLabel">
			<nav class="sidebar-nav scroll-sidebar">
				<div class="offcanvas-header justify-content-between">
					<img src="${pageContext.request.contextPath}/resources/vendor/images/logos/favicon.ico" alt="" class="img-fluid" />
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body h-n80" data-simplebar="" data-simplebar>
					<ul id="sidebarnav">
						<li class="sidebar-item">
							<a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
								<span>
									<i class="ti ti-apps"></i>
								</span>
								<span class="hide-menu">Apps</span>
							</a>
							<ul aria-expanded="false" class="collapse first-level my-3">
								<li class="sidebar-item py-2">
									<a href="../main/app-chat.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-chat.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Chat Application</h6>
											<span class="fs-2 d-block fw-normal text-muted">New messages arrived</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/app-invoice.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-invoice.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Invoice App</h6>
											<span class="fs-2 d-block fw-normal text-muted">Get latest invoice</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/app-cotact.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-mobile.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Contact Application</h6>
											<span class="fs-2 d-block fw-normal text-muted">2 Unsaved Contacts</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/app-email.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-message-box.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Email App</h6>
											<span class="fs-2 d-block fw-normal text-muted">Get new emails</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/page-user-profile.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-cart.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">User Profile</h6>
											<span class="fs-2 d-block fw-normal text-muted">learn more information</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/app-calendar.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-date.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Calendar App</h6>
											<span class="fs-2 d-block fw-normal text-muted">Get dates</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/app-contact2.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-lifebuoy.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Contact List Table</h6>
											<span class="fs-2 d-block fw-normal text-muted">Add new contact</span>
										</div>
									</a>
								</li>
								<li class="sidebar-item py-2">
									<a href="../main/app-notes.html" class="d-flex align-items-center">
										<div class="text-bg-light rounded-1 me-3 p-6 d-flex align-items-center justify-content-center">
											<img src="${pageContext.request.contextPath}/resources/vendor/images/svgs/icon-dd-application.svg" alt="" class="img-fluid" width="24" height="24" />
										</div>
										<div class="d-inline-block">
											<h6 class="mb-1 bg-hover-primary">Notes Application</h6>
											<span class="fs-2 d-block fw-normal text-muted">To-do and Daily tasks</span>
										</div>
									</a>
								</li>
								<ul class="px-8 mt-7 mb-4">
									<li class="sidebar-item mb-3">
										<h5 class="fs-5 fw-semibold">Quick Links</h5>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/page-pricing.html">Pricing Page</a>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/authentication-login.html">Authentication Design</a>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/authentication-register.html">Register Now</a>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/authentication-error.html">404 Error Page</a>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/app-notes.html">Notes App</a>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/page-user-profile.html">User Application</a>
									</li>
									<li class="sidebar-item py-2">
										<a class="fw-semibold text-dark" href="../main/page-account-settings.html">Account Settings</a>
									</li>
								</ul>
							</ul>
						</li>
						<li class="sidebar-item">
							<a class="sidebar-link" href="../main/app-chat.html" aria-expanded="false">
								<span>
									<i class="ti ti-message-dots"></i>
								</span>
								<span class="hide-menu">Chat</span>
							</a>
						</li>
						<li class="sidebar-item">
							<a class="sidebar-link" href="../main/app-calendar.html" aria-expanded="false">
								<span>
									<i class="ti ti-calendar"></i>
								</span>
								<span class="hide-menu">Calendar</span>
							</a>
						</li>
						<li class="sidebar-item">
							<a class="sidebar-link" href="../main/app-email.html" aria-expanded="false">
								<span>
									<i class="ti ti-mail"></i>
								</span>
								<span class="hide-menu">Email</span>
							</a>
						</li>
					</ul>
				</div>
			</nav>
		</div>

	</div>
</header>
<!--  Header End -->

