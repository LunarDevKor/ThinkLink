<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-fill">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/rental/stat">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-car-side fa-fw fa"></i> 대여및예약 통계
					</h3>
				</a>
			</div>
			<div class="container-fluid positon-relative flex-fill mt-4">
				<div class="card bg-white">
					<div class="card-body p-5">
						<div class="w-100">
							<div class="row">
								<div class="col-md-12">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">많이 빌린 비품/차량</h5>
									</div>
									<div id="charts"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="d-flex align-items-start gap-6 mb-2">
									<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title="">예약 시간대 별 통계</h5>
								</div>
								<div id="charts2"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script src="${pageContext.request.contextPath }/resources/project/js/source/apexcharts.min.js"></script>
<script>
chartRendering();

function chartRendering() {
	mostRentalChartRender();
	dayRentalChartRender();
}

function mostRentalChartRender() {
	let mostRentalList = JSON.parse('${mostRentalList}');
	
	var options = {
	        series: [{
	            name: '가장 많이 대여한 비품',
	            data: mostRentalList.map(data => data.count)
	        }],
	        chart: {
		        type: 'bar', // 차트 유형을 라인 차트로 설정
		        height: 500,
		        toolbar: {
		            show: false // 상단 툴바 숨김
		        }
		    },
		    plotOptions: {
		        bar: {
		            borderRadius: 4,
		            horizontal: false,
		            distributed: true
		        }
		    },
		    dataLabels: {
		        enabled: false
		    },
	        xaxis: {
	            categories: mostRentalList.map(data => data.itemNm)
	        }
	    };

	    var chart = new ApexCharts(document.querySelector("#charts"), options);
	    chart.render();
}

function dayRentalChartRender() {
	let dayRentalList = JSON.parse('${dayRentalList}');
	
	var options = {
	        series: [{
	            name: '예약 시간대별 통게',
	            data: dayRentalList.map(data => data.count)
	        }],
	        chart: {
		        type: 'area', // 차트 유형을 라인 차트로 설정
		        height: 500,
		        toolbar: {
		            show: false // 상단 툴바 숨김
		        },
		        zoom: {
		            enabled: false
		        }
		    },
		    stroke: {
		        curve: 'smooth'
		    },
		    grid: {
		        row: {
		            colors: ['#f3f3f3', 'transparent'], // 행의 배경색을 교차로 설정
		            opacity: 0.5
		        },
		    },
		    dataLabels: {
		        enabled: true,
		        style: {
		            colors: ['#0033ff']
		        }
		    },
	        xaxis: {
	            categories: dayRentalList.map(data => data.hourOfDay)
	        }
	    };

	    var chart = new ApexCharts(document.querySelector("#charts2"), options);
	    chart.render();
}
</script>