<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/project/css/source/apexcharts.min.css">
<style>
.content-header-t {
	color: #888;
	letter-spacing: -0.5px;
	margin: 0 4px;
	font-size: 13px;
	margin: 0 4px;
}

span.title {
	padding-left: 0px;
	margin-bottom: 16px;
	font-weight: 600;
	font-size: 18px;
}

#tbl tbody th {
	color: #888;
	font-weight: 600;
}

[data-list] li a:hover {
	color: #6d82a6 !important;
}
</style>
<div class="container positon-relative pt-4">
	<div>
		<span class="content-header-t">기본 관리</span>
		<h4 style="line-height: 40px;">서비스 정보</h4>
	</div>
	<div class="p-5 text-center bg-white rounded-3 w-100">
		<div class="w-100">
			<span class="float-start title">기본 정보</span>
		</div>
		<div class="mt-5">
			<table class="table table-responsive table-borderless bg-light" id="tbl">
				<tbody>
					<tr>
						<th>사이트명</th>
						<td>ThinkLink</td>
						<th>담당자</th>
						<td>${employee.emplNm }</td>
					</tr>
					<tr>
						<th>사이트URL</th>
						<td>thinklink.com</td>
						<th>관리자 이메일</th>
						<td>thinklink@gmail.com</td>
					</tr>
					<tr>
						<th>총 계정수</th>
						<td>${employeeCountList[0] }</td>
						<th>활동 계정</th>
						<td>${employeeCountList[1] }</td>
					</tr>
					<tr>
						<th>서비스상태</th>
						<td style="color:green;">활성화</td>
						<th>최근 업데이트 날짜</th>
						<td>2024.05.11(토) 20:10</td>
					</tr>
					<tr>
						<th colspan="2">도입일자</th>
						<td colspan="2">2024.04.26(금) 20:12</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="container positon-relative mt-4">
	<div class="card bg-white">
		<div class="card-body p-5 text-center overflow-hidden">
			<div class="row">
				<div class="col-lg-6 col-md-3">
					<h2 class="float-start">
						<i class="fa-duotone fa-users fa-xl fa-fw" style="--fa-primary-color: #166bfe; --fa-secondary-color: #000000;"></i>
						부서 별 인원 통계
					</h2>
					<hr />
					<div id="charts"></div>
				</div>
				<div class="col-lg-6 col-md-3">
					<h2 class="float-start">
						<i class="fa-duotone fa-person-half-dress fa-xl fa-fw" style="--fa-primary-color: #fe4d4d; --fa-secondary-color: #0033ff; --fa-secondary-opacity: 1;"></i>
						성별 나이 통계
					</h2>
					<hr class="ms-3" />
					<div id="charts2"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/project/js/source/apexcharts.min.js"></script>
<script>
let employeeAgeGroup = JSON.parse('${employeeAgeGroupList}');
let employeeDept = JSON.parse('${employeeDeptList}');

$(function() {
	createDeptChartValue();
	createAgeChartValue();
});

function createDeptChartValue() {
    let count = [];
    let dept = [];
    for (let i = 0; i < employeeDept.length; i++) {
        count.push(employeeDept[i].COUNT);
        dept.push(employeeDept[i].DEPT_NM);
    }
    const colors = [
    	  '#4285F4', // 디자인팀 - 파란색 계열
    	  '#E91E63', // 총무팀 - 핑크색 계열
    	  '#FFC107', // 영업본부 - 노란색 계열
    	  '#00796B', // 플랫폼운영팀 - 녹색 계열
    	  '#673AB7', // 서비스개발팀 - 보라색 계열
    	  '#E53935', // 영업팀 - 빨간색 계열
    	  '#43A047', // 인터넷사업팀 - 연두색 계열
    	  '#1E88E5', // 개발본부 - 청록색 계열
    	  '#9C27B0', // 경영지원본부 - 자주색 계열
    	  '#FF9800', // 서비스본부 - 주황색 계열
    	  '#D32F2F', // 인사팀 - 진한 빨간색 계열
    	  '#7B1FA2', // 마케팅팀 - 진한 보라색 계열
    	  '#388E3C', // 커머스사업팀 - 어두운 녹색 계열
    	  '#616161'  // 본부 - 회색 계열
    ];
    
    var options = {
            series: [{
            	name: '인원 수',
            	data: count
			}],
            chart: {
            height: 350,
            type: 'bar',
            events: {
              click: function(chart, w, e) {
                console.log(chart, w, e)
              }
            },
            toolbar: {
            	show: false
            }
          },
          colors: colors,
          plotOptions: {
            bar: {
              columnWidth: '75%',
              distributed: true,
            }
          },
          dataLabels: {
            enabled: false
          },
          legend: {
            show: false
          },
          xaxis: {
            categories: dept,
            labels: {
              style: {
                colors: colors,
                fontSize: '14px',
                fontWeight: 500,
              }
            }
          },
          tooltip: {
        	  theme: 'light', // 툴팁 테마 변경
        	  style: {
        	  fontSize: '13px',
        	  fontFamily: 'Helvetica, Arial',
        	  },
		        y: {
				formatter: function (val) {
		            	return val + "명"
		       		}
		     	}
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

          var chart = new ApexCharts(document.querySelector("#charts"), options);
          chart.render();
}

function createAgeChartValue() {
	let age = [];
	let male = [];
	let female = [];
	
	console.log(employeeAgeGroup);
	
	let dataList = new Set();
	
	for(let i = 0; i < employeeAgeGroup.length; i++) {
		if(employeeAgeGroup[i].GENDER_GROUP == '남성') {
			male.push(employeeAgeGroup[i].COUNT);
		}else{
			female.push(employeeAgeGroup[i].COUNT);
		}
		
		dataList.add(employeeAgeGroup[i].AGE_GROUP);
	}
	
	age = [...dataList];
	
    var options = {
            series: [{
            name: '남성',
            data: male
          }, {
            name: '여성',
            data: female
          }],
            chart: {
            type: 'bar',
            height: 350,
            toolbar: {
                show: false
            }
          },
          colors : ['#0033ff', '#FE4D4D'],
          plotOptions: {
            bar: {
              horizontal: false,
              columnWidth: '55%',
              endingShape: 'rounded'
            },
          },
          dataLabels: {
            enabled: true
          },
          stroke: {
            show: true,
            width: 2,
            colors: ['transparent']
          },
          xaxis: {
        	  categories: age,
        	  labels: {
        	    rotate: -45, // 레이블을 -45도로 회전
        	    rotateAlways: true, // 항상 레이블을 회전
        	    style: {
        	      colors: [], // 레이블 색상을 개별적으로 설정하거나 하나의 색상으로 통일
        	      fontSize: '12px', // 글꼴 크기를 12px로 설정
        	      fontFamily: 'Helvetica, Arial, sans-serif', // 글꼴 가족을 설정
        	      cssClass: 'apexcharts-xaxis-label', // CSS 클래스 추가
        	    },
        	  },
        	  axisTicks: {
        	    show: false, // x축 눈금 숨기기
        	  },
        	  axisBorder: {
        	    show: true, // x축 경계선 보이기
        	    color: '#78909C', // 경계선 색상 설정
        	    height: 1, // 경계선 높이 설정
        	    width: '100%', // 경계선 너비 설정
        	    offsetX: 0,
        	    offsetY: 0
        	  },
        	},
            grid: {
                borderColor: '#f1f1f1', // 그리드 라인 색상 조정
            },
          fill: {
            opacity: 1
          },
          tooltip: {
            y: {
				formatter: function (val) {
                	return val + "명"
           		}
         	}
		}
    };

	var chart = new ApexCharts(document.querySelector("#charts2"), options);
	chart.render();
}
</script>