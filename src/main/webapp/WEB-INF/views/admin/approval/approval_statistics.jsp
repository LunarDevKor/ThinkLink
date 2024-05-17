<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">

<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-fill">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/approval/stat">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-sharp fa-regular fa-file-signature fa-fw fa"></i> 결재 통계
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
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">부서별 기안량 통계</h5>
									</div>
									<div id="charts"></div>
									<div id="back"></div>
								</div>
								<div class="col-md-6">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">부서별 반려량 통계</h5>
									</div>
									<div id="charts2"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container positon-relative flex-fill mt-4">
				<div class="card bg-white">
					<div class="card-body p-5">
						<div class="w-100">
							<div class="row" id="chartArea2">
								<div class="col-md-6">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">결재자별 결재 통계</h5>
									</div>
									<div id="charts3"></div>
								</div>
								<div class="col-md-6">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">결재 시간대 통계</h5>
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
	let colors = ['#008FFB', '#00E396', '#FEB019', '#FF4560', '#775DD0', '#546E7A'];
	var chart = null;
	let chartType = '1';
	let isLoaded = false;
	
	approvalChartRender();
	approvalReturnChartRender();
	approvalSanctionerChartRender();
	approvalTimeChartRender();
	
	function approvalTimeChartRender() {
		let sanctnerDtArr = [];
		let countArr = [];
		
		$.ajax({
			url : '/admin/approval/sanctimestat',
			type : 'get',
			async : false,
		})
		.done(function(res) {
			for(let i in res) {
				sanctnerDtArr.push(res[i].chartSanctnerDt);
				countArr.push(res[i].count);
			}
			console.log(res);
		});
		
		var options = {
		    series: [{
		        name: '결재 건수',
		        data: countArr
		    }
		    ],
		    
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
		    theme: {
		        mode: 'light', // 'light' 또는 'dark'
		        palette: 'palette1', // 색상 팔레트 지정
		        monochrome: {
		            enabled: false,
		            color: '#255aee',
		            shadeTo: 'light',
		            shadeIntensity: 0.65
		        },
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
		    dataLabels: {
		        enabled: true,
		        style: {
		            colors: ['#0033ff']
		        }
		    },
		    tooltip: {
		        y: {
		            formatter: function (val) {
		                return val + " 건";
		            }
		        }
		    },
		    stroke: {
		        curve: 'smooth' // 선의 형태를 부드럽게 설정
		    },
		    title: {
		        text: '결재 시간대별 통계',
		        align: 'left'
		    },
		    grid: {
		        row: {
		            colors: ['#f3f3f3', 'transparent'], // 행의 배경색을 교차로 설정
		            opacity: 0.5
		        },
		    },
		    xaxis: {
		        categories: sanctnerDtArr
		    },
		    responsive: [{
		        breakpoint: 480,
		        options: {
		            chart: {
		                width: 300
		            },
		            legend: {
		                position: 'bottom'
		            }
		        }
		    }]
		};

		// 차트를 초기화하고 지정된 요소에 표시
		var chart = new ApexCharts(document.querySelector("#charts4"), options);
		chart.render();
	}
	
	function approvalSanctionerChartRender() {
		
		let emplNmArr = [];
		let countArr = [];
		let colors = ['#FFD700', '#C0C0C0', '#CD7F32', '#4B8BEA', '#77DD77'];
		$.ajax({
			url : '/admin/approval/sancstat',
			type : 'get',
			async : false,
		})
		.done(function(res) {
			for(let i in res) {
				emplNmArr.push(res[i].emplNm);
				countArr.push(res[i].count);
			}
			console.log(res);
		});
		
		var options = {
			    series: [{name: '결재 량', data: countArr}],
			    chart: {
			        type: 'bar', // 차트 타입을 막대 차트로 설정
			        height: 500,
			        toolbar: {
			            show: false // 상단 툴바 숨김
			        },
			    },
			    colors: colors,
			    plotOptions: {
			        bar: {
			            borderRadius: 3,
			            horizontal: false, // 수직 막대 차트로 설정
			            distributed: true,
			        }
			    },
			    dataLabels: {
			        enabled: false
			    },
			    tooltip: {
			        y: {
			            formatter: function (val) {
			                return val + " 건";
			            }
			        }
			    },
			    xaxis: {
			    	categories: emplNmArr
			    },
			    title: {
			        text: '결재자별 결재 통계 - 상위 5명',
			        align: 'left'
			    }
			};

			var chart = new ApexCharts(document.querySelector("#charts3"), options);
			chart.render();
	}
	
	/* 부서별 반려 통계 */
	function approvalReturnChartRender() {
		let returnData;
		$.ajax({
			url : '/admin/approval/returnstat',
			type : 'get',
			async : false,
		})
		.done(function(res) {
			returnData = createChartDate(res);	
			console.log(returnData);
		});
		
		var options = {
			    series: [{
			        name: '반려 건수',
			        data: returnData.dataCount
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
			        categories: returnData.dataLabel
			    },
			    legend: {
			        position: 'bottom', // 범례 위치 설정
			        horizontalAlign: 'center', // 범례 정렬 설정
			        fontSize: '14px', // 범례 폰트 크기 설정
			        markers: {
			            width: 10,
			            height: 10
			        }
			    },
			};

			// 차트를 초기화하고 지정된 요소에 표시
			var chart = new ApexCharts(document.querySelector("#charts2"), options);
			chart.render();
	}
	
	$('#chartArea').on('click', '#backBtn', function() {
		approvalChartRender();
		$(this).remove();
	})
	
	/* 부서별 결재량 상세 통계 */
	function approvalDetailRender(deptNm) {
        $.ajax({
        	url: '/admin/approval/countstat',
        	type: 'get',
        	data: {chartType: chartType, deptNm : deptNm},
        	async: false
        })
        .done(function(res) {
        	returnData = createChartDate(res, chartType);
        	
        	chart.updateOptions({
        		series: returnData.dataCount,
				labels: returnData.dataLabel
        	},true,true,true);
        })
        
		chartType = '0';
        
        let jButton = $('<button class="btn rounded-0 fw-semibold" id="backBtn" style="border: 1px solid #ddd">');
        jButton.text('뒤로가기');
        $('#back').append(jButton);
	}
	
	/* 부서별 결재량 통계 */
	function approvalChartRender() {
		let returnData;
		$.ajax({
			url : '/admin/approval/countstat',
			type : 'get',
			async : false,
		})
		.done(function(res) {
			returnData = createChartDate(res);	
			console.log(returnData);
		});
		
		var options = {
			    chart: {
			        type: 'donut',
			        events: {
			        	dataPointSelection: function(e, chartContext, config) {
			        		if(chartType == '1') {
				                var deptNm = options.labels[config.dataPointIndex];
				        		approvalDetailRender(deptNm);
			        		}
			        	}
			        },
			        foreColor: '#333', // 텍스트 색상 설정
			        height:500,
			        toolbar: {
			            show: false // 상단 툴바 숨김
			        },
			        animations: {
			            enabled: true,
			            easing: 'easeinout',
			            speed: 400,
			            animateGradually: {
			                enabled: true,
			                delay: 150
			            },
			            dynamicAnimation: {
			                enabled: true,
			                speed: 350
			            }
			        }
			    },
			    series: returnData.dataCount,
			    labels: returnData.dataLabel,
			    colors: colors,
			    plotOptions: {
			        pie: {
			            donut: {
			                labels: {
			                    show: true,
			                    total: {
			                        show: true,
			                        label: '전체',
			                        formatter: function (w) {
			                            // 전체 합계를 계산하여 반환
			                            return w.globals.seriesTotals.reduce((a, b) => {
			                                return a + b
			                            }, 0)
			                        }
			                    }
			                }
			            }
			        }
			    },
			    legend: {
			        position: 'bottom', // 범례 위치 설정
			        horizontalAlign: 'center', // 범례 정렬 설정
			        fontSize: '14px', // 범례 폰트 크기 설정
			        markers: {
			            width: 10,
			            height: 10
			        }
			    },
			    responsive: [{
			        breakpoint: 480,
			        options: {
			            chart: {
			                width: 300 // 반응형 디자인에서의 차트 크기 조정
			            },
			            legend: {
			                position: 'bottom' // 반응형 디자인에서 범례 위치 조정
			            }
			        }
			    }]
			};
		
		if(!isLoaded) {
			chart = new ApexCharts(document.querySelector("#charts"), options);
			chart.render();
			isLoaded = true;
		}else{
			chart.updateOptions({
        		series: returnData.dataCount,
				labels: returnData.dataLabel
        	},true,true,true);
			
			chartType = '1';
		}
	} 
	
	function createChartDate(approvalList, chartType) {
		let returnData = {};
		let dataLabel = [];
		let dataCount = [];
		for(let i = 0; i<approvalList.length; i++) {
			if(chartType == '1') {
				dataLabel.push(approvalList[i].emplNm);
			}else{
				dataLabel.push(approvalList[i].deptNm);
			}
			dataCount.push(approvalList[i].count);
		}
		
		returnData.dataLabel = dataLabel;
		returnData.dataCount = dataCount;
		
		return returnData;
	}
</script>