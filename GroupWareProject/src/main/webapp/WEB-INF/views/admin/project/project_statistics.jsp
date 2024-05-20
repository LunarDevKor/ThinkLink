<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-pagination.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/tui-grid.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">
<style>
.card {
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}
</style>
<div class="card position-relative overflow-hidden rounded-0">
	<div class="shop-part d-flex w-100">
		<div class="flex-fill">
			<div class="px-9 pt-4 pb-3">
				<a href="/admin/project/stat">
					<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
						<i class="fa-duotone fa-users fa-fw"></i> 프로젝트 통계
					</h3>
				</a>
			</div>
			<div class="container-fluid positon-relative flex-fill mt-4">
				<div class="card bg-white">
					<div class="card-body p-3 pe-4">
						<div class="w-100">
							<div class="px-9 pt-4 pb-3">
								<h4 class="mb-4 text-end" style="font-weight: 600;">
									<span class=""> 진행중인 프로젝트 : ${projectCount} </span>
								</h4>
							</div>
							<div class="row">
								<div class="col-md-12" style="border-bottom: 1px solid #ddd;">
									<div class="d-flex align-items-start gap-6 mb-2">
										<h5 class="fs-5 mb-0 d-none fw-semibold d-lg-block flex-grow-1" data-title="">전체 프로젝트</h5>
									</div>
									<div id="grid"></div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-9">
									<div class="row">
										<div class="col-md-12">
											<p id="prjctTitle" class="fw-semibold fs-6 mb-1 mt-2"></p>
										</div>
										<div class="col-md-8">
											<p id="taskTitle" class="fw-semibold fs-6 mb-1"></p>
											<div id="charts"></div>
										</div>
										<div class="col-md-4">
											<p id="taskDetailTitle" class="fw-semibold fs-6 mb-1"></p>
											<div id="charts2"></div>
										</div>
									</div>
								</div>
								<div class="col-md-3" id="employeeList">
									<div class="card h-100 mt-2">
										<div class="card-body rounded-0">
											<div class="px-9 pt-4 pb-3">
												<h3 class="mb-4" style="font-weight: 600; margin-left: 10px;">
													<i class="fa-solid fa-user fa-fw"></i> 프로젝트 참여자
												</h3>
												<div class="d-inline-block position-relative ps-4" id="profileArea"></div>
											</div>
											<div id="employeeDetailArea">
												<div class="mb-2 employeeDetail" data-prfjct-no="">
													<div class="d-flex justify-content-start align-items-end mt-1">
														<img data-profile="" class="rounded-circle" onerror="this.style.display='none'" width="64" height="64" src="">
														<span class="ms-2 fw-semibold fs-5" data-name=""></span>
														<span class="ms-1 fs-5" data-clsf=""></span>
													</div>
													<div class="mt-2 text-center">
														<span class="me-2 fs-4 ms-auto" data-task-title=""></span>
														<span class="ms-1 fw-semibold fs-5" id="taskCount"></span>
														<span class="ms-4 fs-4 ms-1" data-closing-title=""></span>
														<span class="ms-1 fw-semibold fs-5" id="closingRate"></span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-code-snippet.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/tui-grid.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/project/js/source/apexcharts.min.js"></script>
<script>
let data = JSON.parse('${projectList}'.replaceAll(/\n/g, ''));
var prjctNo;
gridInit(data);
$('#employeeList').hide();

function createTaskChart(prjctNo) {
	
	$('#charts').html('');
	
	$.ajax({
		url: '/admin/project/tasktype',
		type: 'get',
		data: {prjctNo : prjctNo}
	})
	.done(function(res) {
		
		var options = {
		    chart: {
		        type: 'donut',
		        events: {
		        	dataPointSelection: function(e, chartContext, config) {
		                let taskType = options.labels[config.dataPointIndex];
		                $('#taskDetailTitle').text(taskType + ' 업무');
		                createTaskDetailChart(taskType);
		        	}
		        },
		        foreColor: '#333', // 텍스트 색상 설정
		        height: 400,
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
		    series: res.map(data => data.count),
		    labels: res.map(data => data.taskType),
		    colors: ['#FF6384', '#36A2EB', '#FFCD56'],
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
		
	    var chart = new ApexCharts(document.querySelector("#charts"), options);
	    chart.render();
	})
}

function createTaskDetailChart(taskType) {
	$('#charts2').html('');
	
	$.get('/admin/project/taskdetail', {prjctNo:prjctNo, taskType : taskType})
	.done(function(res) {
		   var options = {
		        series: [{
		            name: taskType,
		            data: res.map(data => data.count)
		        }],
		        chart: {
		            type: 'bar',
		            height: 350,
			        toolbar: {
			            show: false // 상단 툴바 숨김
			        },
		        },
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
	
		    var chart = new ApexCharts(document.querySelector("#charts2"), options);
		    chart.render();
	})
}

function gridInit(data) {
	$('#grid').html('');
	
	tui.Grid.applyTheme('clean', {
		cell: {
		   normal: {
		     border: '#fff',
		     showVerticalBorder: false,
		     showHorizontalBorder: false,
		   },
		   header: {
		     border: '#ddd',
		     showVerticalBorder: false,
		     showHorizontalBorder: false,
		   },
		   rowHeader: {
				border: '#fff',
			     showVerticalBorder: false,
			     showHorizontalBorder: false,
		   }
		},
	});
	tui.Grid.setLanguage('ko', {
		display: {
            noData: '검색 결과가 존재하지 않습니다.',
            loadingData: '로딩중입니다...',
		}
	});
	
	grid = new tui.Grid({
	    el: document.getElementById('grid'),
	    data: data,
	    scrollX: false,
	    scrollY: false,
	    header: {
	        height: 30, 
	    },
	    columns: 
	    [
	      {
	        header: 'id',
	        name: 'prjctNo',
	        hidden: true
	      },
	      {
	        header: '프로젝트 명',
	        name: 'prjctNm',
	        width: '200',
	        resizable: true,
	      },
	      {
	        header: '프로젝트내용',
	        width: '900',
	        name: 'prjctCn',
	        resizable: true,
	      },
	      {
	        header: '시작일자',
	        width: '200',
	        name: 'bgnDateString',
	        resizable: true,
	      },
	      {
	        header: '종료일자',
	        width: '200',
	        name: 'endDateString',
	        resizable: true,
	      }
	    ],
	    pageOptions: {
	      useClient: true,
	      perPage: 5,
	      visiblePages: 5,
	      centerAlign: false
	    },
	    bodyHeight: 'fitToParent',
	    rowHeight: 30
	});
	
	grid.on('click', ev => {
		if(ev.targetType == 'cell') {
			reset();
			$('#taskDetailTitle').text('');
			$('#charts2').html('');
			$('#employeeDetailArea').find('.employeeDetail');
			
			let project = grid.getRow(ev.rowKey);
			prjctNo = project.prjctNo;
			$('#employeeList').show();
			
			$('#prjctTitle').text(project.prjctNm).css('color', project.prjctColorCode);
			$('#taskTitle').text('프로젝트 업무 현황').css('text-align', 'center');
			
			getProjectDetail(project.prjctNo);
		}
	})
}

function getProjectDetail(prjctNo) {
	createTaskChart(prjctNo);
	getProjectParticipants(prjctNo)
}

function getProjectParticipants(prjctNo) {
	$.ajax({
		url: '/admin/project/participants',
		type: 'get',
		data: {prjctNo : prjctNo}
	})
	.done(function(res) {
		let html = '';
		for(let i in res) {
			html += '<div class="mb-2 employee" style="cursor: pointer;" data-empl-no="'+res[i].emplNo+'">';
			html += '	<img data-profile="" class="rounded-circle" width="32" height="32" src="/profile/view/'+res[i].emplProflPhoto+'">';
			html += '	<span class="fw-semibold" data-name="">'+res[i].emplNm+'</span>';
			html += '	<span class="" data-clsf="">'+res[i].clsfNm+'</span>';
			html += '</div>';
		}
		$('#profileArea').html(html);
	});
}

$('#profileArea').on('click', '.employee', function() {
	let emplNo = $(this).data('emplNo');
	let detail = $('#employeeDetailArea').find('.employeeDetail');
	
	detail.find('[data-profile]').show();
	detail.find('[data-profile]').attr('src', $(this).find('[data-profile]').attr('src')).css('border', '3px solid #d9d99b');
	detail.find('[data-name]').text($(this).find('[data-name]').text());
	detail.find('[data-clsf]').text($(this).find('[data-clsf]').text());
	
	createProjectTaskCount(detail, emplNo);
	createProjectTaskClosingRate(detail, emplNo);
})

function createProjectTaskCount(detail, emplNo) {
	$.get('/admin/project/emptaskcnt', {prjctNo : prjctNo, emplNo : emplNo})
	.done(function(res) {
		
		detail.find('[data-task-title]').text('업무 수 : ');
		detail.find('#taskCount').text(res.count);
	})
}

function createProjectTaskClosingRate(detail, emplNo) {
	$.get('/admin/project/emptaskclosing', {prjctNo : prjctNo, emplNo : emplNo})
	.done(function(res) {
		let color;
		
		if(res.rate < 30) {
			color = '#c4342d';
		}else if (res.rate > 31 && res.rate < 69) {
			color = '#eca20c';
		}else {
			color = '#174036';
		}
		
		detail.children().first().css('border-bottom', '2px solid #c0c0c0');
		detail.find('[data-closing-title]').text('업무마감률 : ');
		detail.find('#closingRate').text(res.rate + '%').css('color', color);
	})
}

function reset() {
	let detail = $('#employeeDetailArea').find('.employeeDetail');

	detail.find('[data-profile]').attr('src', '');
	detail.find('[data-profile]').hide();
	detail.find('[data-name]').text('');
	detail.find('[data-clsf]').text('');
	detail.children().first().css('border-bottom', '0');
	detail.find('[data-task-title]').text('');
	detail.find('#taskCount').text('');
	detail.find('[data-closing-title]').text('');
	detail.find('#closingRate').text('');
}
</script>