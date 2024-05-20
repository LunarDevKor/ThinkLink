<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-fill">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/documents/stat">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-file-lines fa-fw"></i>
						양식 통계
					</h3>
				</a>
			</div>
			<div class="container-fluid positon-relative flex-fill mt-4">
				<div class="card bg-white">
					<div class="card-body p-5">
						<div class="w-100">
							<div class="row" id="chartArea">
								<div class="col-md-8">
									<div class="row">
										<div class="col-md-12">
											<div class="d-flex align-items-start gap-6 mb-2">
												<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">양식별 사용량 통계</h5>
											</div>
											<div id="charts"></div>
											<div id="back"></div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="d-flex align-items-start gap-6 mb-2">
											<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title=""></h5>
										</div>
										<div id="charts2"></div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title2=""></h5>
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

getChartData();
let data;
var target;

async function getChartData() {
	let response = await fetch('/admin/documents/chart');
	data = await response.json();
	createSeriesData(data);
}

function createSeriesData(data) {
	let seriesData = data.reduce((acc, { docNm, count }) => {
		  acc[docNm] = (acc[docNm] || 0) + parseInt(count);
		  return acc;
	}, {});
	
	let sortedSeriesData = Object.entries(seriesData).sort((a, b) => b[1] - a[1]);
	
	let seriesDataForChart = sortedSeriesData.map(([docNm, count]) => ({ docNm, count }));

	console.log(seriesDataForChart);
	 
	createChart(seriesDataForChart);
}

function createDeptSeiresData(docNm) {
	const filteredDocs = data.filter(doc => doc.docNm === docNm);
	
	const seriesData = filteredDocs.reduce((acc, { deptNm, count }) => {
	acc[deptNm] = (acc[deptNm] || 0) + parseInt(count);
	return acc;
	}, {});
	
	let sortedSeriesData = Object.entries(seriesData).sort((a, b) => b[1] - a[1]);
	
	let seriesDataForChart = sortedSeriesData.map(([deptNm	, count]) => ({deptNm, count}));
	
	return seriesDataForChart;
}

function createChart(seriesData) {
	
    var options = {
        series: [{
            name: '문서 사용량',
            data: seriesData.map(data => data.count)
        }],
        chart: {
            type: 'bar',
            height: 500,
            events: {
                click: function(event, chartContext, {seriesIndex, dataPointIndex, config}) {
					if(dataPointIndex >= 0) {
					    let select = config.xaxis.categories[dataPointIndex];
					    createDeptChart(createDeptSeiresData(select), select);
						$('#charts3').html('');
						$('[data-sub-title2]').text('');
					}
                }
            },
	        toolbar: {
	            show: false // 상단 툴바 숨김
	        },
        },
        colors: ['#f9c74f', '#f9844a', '#f3722c', '#f8961e', '#90be6d', '#43aa8b', '#577590'],
        plotOptions: {
            bar: {
                borderRadius: 4,
                horizontal: true,
                distributed: true,
            }
        },
        dataLabels: {
            enabled: false
        },
        xaxis: {
            categories: seriesData.map(data => data.docNm)
        }
    };

    var chart = new ApexCharts(document.querySelector("#charts"), options);
    chart.render();
}

function createDeptChart(seriesData, target) {
	
	console.log(seriesData);
	
    var options = {
        series: [{
            name: '문서 사용량',
            data: seriesData.map(data => data.count)
        }],
        chart: {
            type: 'bar',
            height: 500,
	        toolbar: {
	            show: false // 상단 툴바 숨김
	        },
            events: {
                click: function(event, chartContext, {seriesIndex, dataPointIndex, config}) {
					if(dataPointIndex >= 0) {
					    let deptNm = config.xaxis.categories[dataPointIndex];
					    createEmployeeChart(deptNm, target);
					}
                }
            },
        },
        colors: ['#f9c74f', '#f9844a', '#f3722c', '#f8961e', '#90be6d', '#43aa8b', '#577590'],
        plotOptions: {
            bar: {
                borderRadius: 4,
                horizontal: true,
                distributed: true,
            }
        },
        dataLabels: {
            enabled: false
        },
        xaxis: {
            categories: seriesData.map(data => data.deptNm)
        }
    };
	$('#charts2').html('');
	$('[data-sub-title]').text('부서별 문서 양식 사용량 통계');
    var chart = new ApexCharts(document.querySelector("#charts2"), options);
    chart.render();
}

function createEmployeeChart(select, target) {
	$.ajax({
		url: '/admin/documents/empchart',
		data: {deptNm : select, docNm : target},
		type: 'get',
		async: false
	})
	.done(function(res) {
		
		var options = {
		        series: [{
		            name: '문서 사용량',
		            data: res.map(data => data.count)
		        }],
		        chart: {
		            type: 'bar',
		            height: 1100,
			        toolbar: {
			            show: false // 상단 툴바 숨김
			        },
		        },
		        colors: ['#f9c74f', '#f9844a', '#f3722c', '#f8961e', '#90be6d', '#43aa8b', '#577590'],
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
		            categories: res.map(data => data.emplNm)
		        }
		    };
			$('#charts3').html('');
			$('[data-sub-title2]').text(select + ' 사원별 문서 양식 사용량 통계');
		    var chart = new ApexCharts(document.querySelector("#charts3"), options);
		    chart.render();
	})
}

</script>