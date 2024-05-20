<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	function handleColorTheme(e) {
		$("html").attr("data-color-theme", e);
		$(e).prop("checked", !0);
	}
</script>

<div class="offcanvas customizer offcanvas-end" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
	<div class="d-flex align-items-center justify-content-between p-3 border-bottom">
		<h4 class="offcanvas-title fw-semibold" id="offcanvasExampleLabel">Settings</h4>
		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body h-n80" data-simplebar>
		<h6 class="fw-semibold fs-4 mb-2">Theme</h6>

		<div class="d-flex flex-row gap-3 customizer-box" role="group">
			<input type="radio" class="btn-check light-layout" name="theme-layout" id="light-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary rounded-2" for="light-layout"><i class="icon ti ti-brightness-up fs-7 me-2"></i>Light</label>

			<input type="radio" class="btn-check dark-layout" name="theme-layout" id="dark-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary rounded-2" for="dark-layout"><i class="icon ti ti-moon fs-7 me-2"></i>Dark</label>
		</div>

		<h6 class="mt-5 fw-semibold fs-4 mb-2">Theme Direction</h6>
		<div class="d-flex flex-row gap-3 customizer-box" role="group">
			<input type="radio" class="btn-check" name="direction-l" id="ltr-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary" for="ltr-layout"><i class="icon ti ti-text-direction-ltr fs-7 me-2"></i>LTR</label>

			<input type="radio" class="btn-check" name="direction-l" id="rtl-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary" for="rtl-layout"><i class="icon ti ti-text-direction-rtl fs-7 me-2"></i>RTL</label>
		</div>

		<h6 class="mt-5 fw-semibold fs-4 mb-2">Theme Colors</h6>

		<div class="d-flex flex-row flex-wrap gap-3 customizer-box color-pallete" role="group">
			<input type="radio" class="btn-check" name="color-theme-layout" id="Blue_Theme" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary d-flex align-items-center justify-content-center" onclick="handleColorTheme('Blue_Theme')" for="Blue_Theme" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="BLUE_THEME">
				<div class="color-box rounded-circle d-flex align-items-center justify-content-center skin-1">
					<i class="ti ti-check text-white d-flex icon fs-5"></i>
				</div>
			</label>

			<input type="radio" class="btn-check" name="color-theme-layout" id="Aqua_Theme" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary d-flex align-items-center justify-content-center" onclick="handleColorTheme('Aqua_Theme')" for="Aqua_Theme" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="AQUA_THEME">
				<div class="color-box rounded-circle d-flex align-items-center justify-content-center skin-2">
					<i class="ti ti-check text-white d-flex icon fs-5"></i>
				</div>
			</label>

			<input type="radio" class="btn-check" name="color-theme-layout" id="Purple_Theme" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary d-flex align-items-center justify-content-center" onclick="handleColorTheme('Purple_Theme')" for="Purple_Theme" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="PURPLE_THEME">
				<div class="color-box rounded-circle d-flex align-items-center justify-content-center skin-3">
					<i class="ti ti-check text-white d-flex icon fs-5"></i>
				</div>
			</label>

			<input type="radio" class="btn-check" name="color-theme-layout" id="green-theme-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary d-flex align-items-center justify-content-center" onclick="handleColorTheme('Green_Theme')" for="green-theme-layout" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="GREEN_THEME">
				<div class="color-box rounded-circle d-flex align-items-center justify-content-center skin-4">
					<i class="ti ti-check text-white d-flex icon fs-5"></i>
				</div>
			</label>

			<input type="radio" class="btn-check" name="color-theme-layout" id="cyan-theme-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary d-flex align-items-center justify-content-center" onclick="handleColorTheme('Cyan_Theme')" for="cyan-theme-layout" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="CYAN_THEME">
				<div class="color-box rounded-circle d-flex align-items-center justify-content-center skin-5">
					<i class="ti ti-check text-white d-flex icon fs-5"></i>
				</div>
			</label>

			<input type="radio" class="btn-check" name="color-theme-layout" id="orange-theme-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary d-flex align-items-center justify-content-center" onclick="handleColorTheme('Orange_Theme')" for="orange-theme-layout" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="ORANGE_THEME">
				<div class="color-box rounded-circle d-flex align-items-center justify-content-center skin-6">
					<i class="ti ti-check text-white d-flex icon fs-5"></i>
				</div>
			</label>
		</div>

		<h6 class="mt-5 fw-semibold fs-4 mb-2">Layout Type</h6>
		<div class="d-flex flex-row gap-3 customizer-box" role="group">
			<div>
				<input type="radio" class="btn-check" name="page-layout" id="vertical-layout" autocomplete="off" />
				<label class="btn p-9 btn-outline-primary" for="vertical-layout"><i class="icon ti ti-layout-sidebar-right fs-7 me-2"></i>Vertical</label>
			</div>
			<div>
				<input type="radio" class="btn-check" name="page-layout" id="horizontal-layout" autocomplete="off" />
				<label class="btn p-9 btn-outline-primary" for="horizontal-layout"><i class="icon ti ti-layout-navbar fs-7 me-2"></i>Horizontal</label>
			</div>
		</div>

		<h6 class="mt-5 fw-semibold fs-4 mb-2">Container Option</h6>

		<div class="d-flex flex-row gap-3 customizer-box" role="group">
			<input type="radio" class="btn-check" name="layout" id="boxed-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary" for="boxed-layout"><i class="icon ti ti-layout-distribute-vertical fs-7 me-2"></i>Boxed</label>

			<input type="radio" class="btn-check" name="layout" id="full-layout" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary" for="full-layout"><i class="icon ti ti-layout-distribute-horizontal fs-7 me-2"></i>Full</label>
		</div>

		<h6 class="fw-semibold fs-4 mb-2 mt-5">Sidebar Type</h6>
		<div class="d-flex flex-row gap-3 customizer-box" role="group">
			<a href="javascript:void(0)" class="fullsidebar">
				<input type="radio" class="btn-check" name="sidebar-type" id="full-sidebar" autocomplete="off" />
				<label class="btn p-9 btn-outline-primary" for="full-sidebar"><i class="icon ti ti-layout-sidebar-right fs-7 me-2"></i>Full</label>
			</a>
			<div>
				<input type="radio" class="btn-check " name="sidebar-type" id="mini-sidebar" autocomplete="off" />
				<label class="btn p-9 btn-outline-primary" for="mini-sidebar"><i class="icon ti ti-layout-sidebar fs-7 me-2"></i>Collapse</label>
			</div>
		</div>

		<h6 class="mt-5 fw-semibold fs-4 mb-2">Card With</h6>

		<div class="d-flex flex-row gap-3 customizer-box" role="group">
			<input type="radio" class="btn-check" name="card-layout" id="card-with-border" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary" for="card-with-border"><i class="icon ti ti-border-outer fs-7 me-2"></i>Border</label>

			<input type="radio" class="btn-check" name="card-layout" id="card-without-border" autocomplete="off" />
			<label class="btn p-9 btn-outline-primary" for="card-without-border"><i class="icon ti ti-border-none fs-7 me-2"></i>Shadow</label>
		</div>
	</div>
</div>

<!--  Search Bar -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg">
		<div class="modal-content rounded-1">
			<div class="modal-header border-bottom">
				<input type="search" class="form-control fs-3" placeholder="Search here" id="search" />
				<a href="javascript:void(0)" data-bs-dismiss="modal" class="lh-1">
					<i class="ti ti-x fs-5 ms-3"></i>
				</a>
			</div>
			<div class="modal-body message-body" data-simplebar="">
				<h5 class="mb-0 fs-5 p-1">Quick Page Links</h5>
				<ul class="list mb-0 py-2">
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Modern</span> <span class="fs-3 text-muted d-block">/dashboards/dashboard1</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Dashboard</span> <span class="fs-3 text-muted d-block">/dashboards/dashboard2</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Contacts</span> <span class="fs-3 text-muted d-block">/apps/contacts</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Posts</span> <span class="fs-3 text-muted d-block">/apps/blog/posts</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Detail</span> <span class="fs-3 text-muted d-block">/apps/blog/detail/streaming-video-way-before-it-was-cool-go-dark-tomorrow</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Shop</span> <span class="fs-3 text-muted d-block">/apps/ecommerce/shop</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Modern</span> <span class="fs-3 text-muted d-block">/dashboards/dashboard1</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Dashboard</span> <span class="fs-3 text-muted d-block">/dashboards/dashboard2</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Contacts</span> <span class="fs-3 text-muted d-block">/apps/contacts</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Posts</span> <span class="fs-3 text-muted d-block">/apps/blog/posts</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Detail</span> <span class="fs-3 text-muted d-block">/apps/blog/detail/streaming-video-way-before-it-was-cool-go-dark-tomorrow</span>
						</a></li>
					<li class="p-1 mb-1 bg-hover-light-black"><a href="#">
							<span class="fs-3 text-dark fw-normal d-block">Shop</span> <span class="fs-3 text-muted d-block">/apps/ecommerce/shop</span>
						</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="dark-transparent sidebartoggler"></div>
