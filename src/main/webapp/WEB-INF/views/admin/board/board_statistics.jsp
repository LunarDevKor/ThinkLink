<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">

<style>
tspan {
	display: none;
}
</style>

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-fill">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/board/stat">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-chalkboard fa-fw fa"></i> 게시글 통계
					</h3>
				</a>
			</div>
			<div class="container positon-relative flex-fill mt-4">
				<div class="card bg-white">
					<div class="card-body p-5">
						<div class="w-100">
							<div class="row" id="chartArea">
								<div class="col-md-6">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">게시판 별 게시글 수 현황</h5>
									</div>
									<div id="charts"></div>
								</div>
								<div class="col-md-6">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">게시판 별 댓글 수 현황</h5>
									</div>
									<div id="charts2"></div>
								</div>
								<div class="col-md-12">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title="">게시글 조회수 상위 5개</h5>
									</div>
									<div id="charts3"></div>
								</div>
								<div class="col-md-12">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-sub-title="">게시글 시간대별 통계</h5>
									</div>
									<div id="charts4"></div>
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
chartRendering();

function chartRendering() {
	boardCntChartRender();
	answerCntChartRender();
	boardViewRankChartRender();
	boardWriteChartRender();
}

function boardWriteChartRender() {
	let boardWriteList = JSON.parse('${boardWriteList}');
	
	var options = {
	        series: [{
	            name: '게시글 시간대별 통게',
	            data: boardWriteList.map(data => data.count)
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
	            categories: boardWriteList.map(data => data.hourOfDay)
	        }
	    };

	    var chart = new ApexCharts(document.querySelector("#charts4"), options);
	    chart.render();
}

function boardViewRankChartRender() {
	let boardViewRankList = JSON.parse('${boardViewRankList}');
	console.log(boardViewRankList);
	
	var options = {
		    series: [{
		        name: '조회 수',
		        data: boardViewRankList.map(data => data.bbscttRdcnt)
		    }],
		    chart: {
		        type: 'bar', // 차트 유형을 막대 그래프로 설정
		        height: 400,
		        toolbar: {
		            show: false // 상단 툴바 숨김
		        },
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
		        categories: boardViewRankList.map(data => `\${data.bbscttTitle} - <strong>\${data.emplNm}</strong>` ),
		    },
		    tooltip: {
		        y: {
		            formatter: function (val) {
		                return val;
		            }
		        }
		    }
		};

		var chart = new ApexCharts(document.querySelector("#charts3"), options);
		chart.render();
}

function answerCntChartRender() {
	let answerCntList = JSON.parse('${answerCntList}');
	
	var options = {
		    series: [{
		        name: '댓글 수',
		        data: answerCntList.map(data => data.count)
		    }],
		    chart: {
		        type: 'bar', // 차트 유형을 막대 그래프로 설정
		        height: 500,
		        toolbar: {
		            show: false // 상단 툴바 숨김
		        },
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
		        categories: answerCntList.map(data => data.bbsNm)
		    },
		    legend: {
		        position: 'bottom',
		        horizontalAlign: 'center',
		        fontSize: '14px',
		        markers: {
		            width: 10,
		            height: 10
		        }
		    },
		};

		var chart = new ApexCharts(document.querySelector("#charts2"), options);
		chart.render();
}

function boardCntChartRender() {
	let boardCntList = JSON.parse('${boardCntList}');
	
	var options = {
		    series: [{
		        name: '게시글 수',
		        data: boardCntList.map(data => data.count)
		    }],
		    chart: {
		        type: 'bar', // 차트 유형을 막대 그래프로 설정
		        height: 500,
		        toolbar: {
		            show: false // 상단 툴바 숨김
		        },
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
		        categories: boardCntList.map(data => data.bbsNm)
		    },
		    legend: {
		        position: 'bottom',
		        horizontalAlign: 'center',
		        fontSize: '14px',
		        markers: {
		            width: 10,
		            height: 10
		        }
		    },
		};

		var chart = new ApexCharts(document.querySelector("#charts"), options);
		chart.render();
}
</script>