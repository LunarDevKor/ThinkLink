<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-fill">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/documents/stat">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-envelope fa-fw fa"></i> 메일 통계
					</h3>
				</a>
			</div>
			<div class="container-fluid positon-relative flex-fill mt-4">
				<div class="card bg-white">
					<div class="card-body p-5">
						<div class="w-100">
							<div class="row" id="chartArea">
								<div class="col-md-12">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">부서별 메일 사용량 통계</h5>
									</div>
									<div id="charts"></div>
								</div>
								<div class="col-md-12">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title="">시간별 메일 사용량 통계</h5>
									</div>
									<div id="charts2"></div>
								</div>
								<div class="col-md-12">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title2="">요일별 메일 사용량 통계</h5>
									</div>
									<div id="charts3"></div>
								</div>
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
createChart();

function createChart() {
	let deptCntList = JSON.parse('${deptCntList}');
	let timeCntList = JSON.parse('${timeCntList}');
	let dayOfWeekCntList = JSON.parse('${dayOfWeekCntList}');
	
	deptCntChart(deptCntList);
	console.log(deptCntList);
	console.log(timeCntList);
	timeCntChart(timeCntList);
	console.log(dayOfWeekCntList);
	dayOfWeekCntChart(dayOfWeekCntList);
}

function deptCntChart(seriesData) {
	
	let data = seriesData.sort((a, b) => Object.values(b) - Object.values(a));
	
	 var options = {
        series: [{
            name: '부서별 메일 사용량',
            data: data.map(val => Object.values(val)).flat()
        }],
        chart: {
            type: 'bar',
            height: 500,
	        toolbar: {
	            show: false // 상단 툴바 숨김
	        },
        },
        colors: [  
			"#FF5733", "#FFC300", "#DAF7A6", "#C70039", "#581845", "#3498DB", "#A3E4D7", "#8E44AD", 
			"#2ECC71", "#E67E22", "#16A085", "#F1C40F", "#E74C3C", "#95A5A6", "#34495E"
		],
        plotOptions: {
            bar: {
                borderRadius: 4,
                horizontal: false,
                distributed: true,
            }
        },
        dataLabels: {
            enabled: false
        },
        xaxis: {
            categories: data.map(val => Object.keys(val)).flat()
        }
    };

    var chart = new ApexCharts(document.querySelector("#charts"), options);
    chart.render();
}

function timeCntChart(seriesData) {
	
	 var options = {
        series: [{
            name: '시간별 메일 사용량',
            data: seriesData.map(data => data.EMAIL_COUNT)
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
	    fill: {
	        type: "gradient",
	        gradient: {
	          shadeIntensity: 1,
	          opacityFrom: 0.7,
	          opacityTo: 0.9,
	          stops: [0, 90, 100]
	        }
	    },
	    stroke: {
	        curve: 'straight'
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
            categories: seriesData.map(data => data.HOUR_OF_DAY)
        }
    };

    var chart = new ApexCharts(document.querySelector("#charts2"), options);
    chart.render();
}

function dayOfWeekCntChart(seriesData) {
	
	 var options = {
        series: [{
            name: '요일별 메일 사용량',
            data: seriesData.map(data => data.EMAIL_COUNT)
        }],
        chart: {
            type: 'bar',
            height: 500,
	        toolbar: {
	            show: false // 상단 툴바 숨김
	        },
        },
        colors: ["#A3E4D7", "#FFC300", "#DAF7A6", "#C70039", "#581845", "#3498DB", "#FF5733"],
        plotOptions: {
            bar: {
                borderRadius: 4,
                horizontal: false,
                distributed: true,
            }
        },
        dataLabels: {
            enabled: false
        },
        xaxis: {
            categories: seriesData.map(data => data.DAY_OF_WEEK)
        }
    };

    var chart = new ApexCharts(document.querySelector("#charts3"), options);
    chart.render();
}

</script>