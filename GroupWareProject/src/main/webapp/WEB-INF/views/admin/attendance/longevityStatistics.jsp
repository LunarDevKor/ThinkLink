<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
td {
	text-align: left;
}

th {
	text-align: left;
}


/* 페이징 버튼의 글꼴 크기 조절 */
.dataTables_paginate .paginate_button {
	font-size: 15px; /* 원하는 크기로 조절 */
	margin: 0 0px; /* 원하는 간격으로 조절 */
	cursor: pointer;
}

#tbl_paginate {
	margin-bottom: 50px; /* 바텀 마진 크기 조절 */
}

#tbl {
	background-color: #CCCCCC !important; /* 회색 */
}

.table-responsive .dataTables_wrapper .dataTables_filter {
	margin-bottom: 0px;
}

thead tr:first-child td {
	border-bottom: 1px solid #dee2e6;
}

#canvas-container {
	width: 100%; /* 원하는 가로 크기 */
	height: 400px; /* 원하는 세로 크기 */
}
</style>

<!-- 메뉴 옆 오른쪽 구역 시작 -->
<div class="w-100">
	<div class="min-width-340">
		<div class="px-9 pt-4 pb-3">
			<a href="/admin/attendance/longevity">
				<h3 class="fw-semibold mb-4">
					<i class="fa-solid fa-user-group fa-fw fa"></i>
					근속 통계
				</h3>
			</a>
		</div>
		<!-- 탭 시작 -->
		<div class="card">
			<div class="card-body">
				<div>
					<!-- Nav tabs -->
					<ul class="nav nav-underline" role="tablist">
						<li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#home" role="tab">
								<span>전체</span>
							</a></li>
						<li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#profile" role="tab">
								<span>직급</span>
							</a></li>
						<li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#messages" role="tab">
								<span>부서</span>
							</a></li>
					</ul>
					<!-- Tab panes -->
					<div class="tab-content">
						<div class="tab-pane active" id="home" role="tabpanel">
							<div id="canvas-container" style="display: flex; align-items: center;">
								<div style="width: 50%; text-align: center;">
									<canvas id="myChartAll"></canvas>
								</div>
								<div style="width: 50%; text-align: center;">
									<h2>
										우리 회사의 평균 근속연수는 <span class="mb-1 badge rounded-pill bg-primary-subtle text-primary" style="font-size: 1.1em;">${totalAverage}</span>입니다.
									</h2>
								</div>
							</div>
						</div>
						<div class="tab-pane p-3" id="profile" role="tabpanel">
							<div id="canvas-container">
								<canvas id="myChartClsf"></canvas>
							</div>
						</div>
						<div class="tab-pane p-3" id="messages" role="tabpanel">
							<div id="canvas-container">
								<canvas id="myChartDept"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 탭 끝  -->

		<!-- 현황 테이블 -->
		<!-- 		<table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd; margin-top: 15px; margin-bottom: 40px;"> -->
		<!-- 			<tr> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">출근 미체크</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">퇴근 미체크</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">지각</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">조퇴</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">결근</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">출장</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">외근</td> -->
		<!-- 				<td style="width: 12.5%; padding: 4px; padding-top: 30px; text-align: center;">휴가</td> -->

		<!-- 			</tr> -->
		<!-- 			<tr> -->
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${attendanceUnchecked }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${departureUnchecked }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${tardiness }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${earlyDeparture }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${absence }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${businessTrip }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${fieldWork }</td> --%>
		<%-- 				<td style="padding: 4px; padding-bottom: 30px; text-align: center; font-size: 23px;">${vacation }</td> --%>
		<!-- 			</tr> -->
		<!-- 		</table> -->
		<!-- 이번주 현황 테이블 -->

		<!-- 목록 다운로드 -->
		<div class="table-responsive border rounded-4">
			<table class="table table-hover text-center align-middle" id="tbl">
				<thead class="border-bottom text-start table-hover">
					<tr>
						<th>사원</th>
						<th>직급</th>
						<th>부서</th>
						<th>입사일</th>
						<th>근속연수</th>
					</tr>
				</thead>
				<tbody id="tbody" class="border-bottom text-start table-hover">
					<c:choose>
						<c:when test="${empty employeeList}">
							<tr>
								<td colspan="10" style="text-align: center;">데이터가 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${employeeList}" var="employee">
								<tr>
									<td>${employee.emplNm }</td>
									<td>${employee.classOfPositionVO.clsfNm }</td>
									<td>${employee.deptNm }</td>
									<td>
										<fmt:formatDate value="${employee.emplEncpn}" pattern="yyyy-MM-dd" />
									</td>
									<td>${employee.longevity}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<!-- 목록 다운로드 -->
	</div>
</div>
<!-- 메뉴 옆 오른쪽 구역 끝 -->



<script src="${pageContext.request.contextPath}/resources/vendor/js/apps/chat.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/js/datatable/datatable-advanced.init.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script> -->
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/helpers.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/helpers.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
<c:if test="${not empty message }">
	<script>
		showToast("${message}", 'info');
		<c:remove var="message" scope="request"/>
	</script>
</c:if>
<script>
	$(function() {
		let text = $('#tbody').text();
		if (!text.includes('존재하지')) {
			let table = new DataTable(
					'#tbl',
					{
						buttons : [
								{
									extend : 'copy',
									text : '<i class="fa-duotone fa-copy"></i>&nbsp;&nbsp;클립보드 복사',
									title : 'ThinkLink 근속현황',
									className : 'justify-content-center btn mb-1 btn-outline-primary align-items-center',
									action : function(e, dt, button, config) {
										showToast('클립보드에 복사가 되었습니다!', 'success');
									}
								},
								{
									extend : 'excel',
									text : '<i class="fa-duotone fa-arrow-down-to-line"></i>&nbsp;&nbsp;EXCEL',
									filename : 'ThinkLink_근속현황',
									title : 'ThinkLink 근속현황',
									className : 'justify-content-center btn mb-1 btn-outline-primary align-items-center'
								},

								{
									extend : 'print',
									text : '<i class="fa-duotone fa-print"></i>&nbsp;&nbsp;프린트',
									filename : 'ThinkLink 근속현황',
									title : 'ThinkLink 근속현황',
									className : 'justify-content-center btn mb-1 btn-outline-primary align-items-center'
								} ],
						header : false, // 헤더 중복 방지
						autoFill : true, // 자동 완성 활성화
						paging : true, // 페이징 기능 활성화
						pagingType : 'full_numbers', // 페이지 타입 번호 + 이전/다음 
						searching : true, // 검색 기능 활성화
						ordering : true, // 정렬 기능 활성화
						info : false, // 정보 표시 기능 활성화 (페이지 정보)
						responsive : false, // 반응형 활성화
						stateSave : false, // 저장 활성화
						dom : "<'row d-flex justify-content-end align-items-center my-2'<'col-md-8'B><'col-md-3'f><'col-md-1'l>>"
								+ // f 검색 l 페이지 사이즈 
								"t<'bottom d-flex justify-content-center align-items-center me-2'p>", // p 페이지네이션
						order : [ [ 2, 'desc' ] // 날짜
						],
						columnDefs : [ {
							targets : -1,
							className : 'order-column'
						}, {
							width : "20%",
							targets : 0
						}, {
							width : "20%",
							targets : 1
						}, {
							width : "20%",
							targets : 2
						}, {
							width : "20%",
							targets : 3
						}, {
							width : "20%",
							targets : 4
						} ],
						language : {
							"lengthMenu" : "_MENU_", // 한 페이지에 보여질 항목 수 변경
							"info" : "", // 표시되는 항목 수와 범위 변경
							"infoEmpty" : "", // 검색 결과가 없을 때 표시될 텍스트 변경
							"infoFiltered" : "", // 검색 결과가 있는 경우 표시될 텍스트 변경
							"zeroRecords" : function() {
								return '<div class="text-center fw-semibold">검색결과가 없습니다.</div>';
							},
							"search" : '<i class="fa-solid fa-magnifying-glass fa-lg" style="color: #6190ff;"></i>&nbsp;&nbsp;', // 검색 입력란 라벨
							"searchPlaceholder" : "검색어를 입력하세요", // 검색 입력란 라벨
							"loadingRecords" : "잠시만 기다려주세요", // 로딩중 텍스트
							"paginate" : {
								"first" : '<i class="fa-sharp fa-regular fa-angles-left fa-fw"></i>', // 첫 페이지 버튼의 텍스트를 변경
								"last" : '<i class="fa-sharp fa-regular fa-angles-right fa-fw"></i>', // 마지막 페이지 버튼의 텍스트 변경
								"next" : '<i class="fa-sharp fa-regular fa-angle-right fa-fw"></i>', // 다음 페이지 버튼의 텍스트를 변경
								"previous" : '<i class="fa-sharp fa-regular fa-angle-left fa-fw"></i>' // 이전 페이지 버튼의 텍스트를 변경
							}
						}
					})
		}

	});
	
	const dataAll = {
			labels : [ '1년 미만', '1년 이상 3년 미만', '3년 이상 5년 미만', '5년 이상 10년 미만', '10년 이상 15년 미만', '15년 이상' ],
			datasets : [ {
				label : '사원수',
				data : [ ${emplCnt.get(0)}, ${emplCnt.get(1)}, ${emplCnt.get(2)}, ${emplCnt.get(3)}, ${emplCnt.get(4)}, ${emplCnt.get(5)}],
				borderColor : [

				'rgba(255, 99, 132)', 'rgba(54, 162, 235)',
						'rgba(255, 206, 86)', 'rgba(75, 192, 192)',
						'rgba(153, 102, 255)', 'rgba(255, 159, 64)',
						'rgba(255, 99, 132)', 'rgba(54, 162, 235)',
						'rgba(255, 206, 86)', 'rgba(75, 192, 192)',
						'rgba(153, 102, 255)', 'rgba(255, 159, 64)'

				],
				backgroundColor : [

					'rgba(255, 99, 132)', 'rgba(54, 162, 235)',
					'rgba(255, 206, 86)', 'rgba(75, 192, 192)',
					'rgba(153, 102, 255)', 'rgba(255, 159, 64)',
					'rgba(255, 99, 132)', 'rgba(54, 162, 235)',
					'rgba(255, 206, 86)', 'rgba(75, 192, 192)',
					'rgba(153, 102, 255)', 'rgba(255, 159, 64)'

				],
				borderWidth : 1
			} ]
		};

		const ctxAll = document.getElementById('myChartAll').getContext('2d');
		const myChartAll = new Chart(ctxAll, {
				type : 'pie',
				data : dataAll,
				options : {
					maintainAspectRatio: false, // 아래 width와 height 설정을 유지하지 않도록 설정
					responsive : true,
					plugins : {
						legend : {
							position : 'right',
						},
						title : {
							display : true,
							text : '전체 사원의 근속연수'
						}
					}
				}
			});

	const dataDept = {
		labels : [ '본부', '개발본부', '경영지원본부', '영업본부', '서비스본부', '마케팅팀', '커머스사업팀',
				'인사팀', '총무팀', '인터넷사업팀', '디자인팀', '플랫폼운영팀', '서비스개발팀', '영업팀' ],
		datasets : [ {
			label : '평균 근속연수',
			data : [ ${deptNumberMap.get("본부")} , ${deptNumberMap.get("개발본부")} , ${deptNumberMap.get("경영지원본부")} ,
				${deptNumberMap.get("영업본부")} , ${deptNumberMap.get("서비스본부")} , ${deptNumberMap.get("마케팅팀")} ,
				${deptNumberMap.get("커머스사업팀")} , ${deptNumberMap.get("인사팀")} , ${deptNumberMap.get("총무팀")} ,
				${deptNumberMap.get("인터넷사업팀")} , ${deptNumberMap.get("디자인팀")} , ${deptNumberMap.get("플랫폼운영팀")} ,
				${deptNumberMap.get("서비스개발팀")} , ${deptNumberMap.get("영업팀")}
				],
			borderColor : [

			'rgba(54, 162, 235)'

			],
			backgroundColor : [

			'rgba(54, 162, 235)'

			],
			borderWidth : 1
		} ]
	};

	const ctxDept = document.getElementById('myChartDept').getContext('2d');
	const myChartDept = new Chart(ctxDept, {
			type : 'bar',
			data : dataDept,
			options : {
				maintainAspectRatio: false, // 아래 width와 height 설정을 유지하지 않도록 설정
				responsive : true,
				plugins : {
					legend : {
						position : 'top',
					},
					title : {
						display : true,
						text : '부서별 평균 근속연수',
						fontColor: '#c62828',
		            	fontStyle: 'bold',
		                fontSize: 20
					}
				},
				scales : {
					yAxes : [ {
						ticks : {
							stepSize : 1
						// 세로축 간격을 1로 설정
						}
					} ]
				}
			}
		});
	
	
	const dataClsf = {
			labels : ['대표이사','사장','전무','상무','이사','부장','차장','과장','대리','사원'],
			datasets : [ {
				label : '평균 근속연수',
				data : [ ${clsfNumberMap.get("대표이사")} , ${clsfNumberMap.get("사장")} , ${clsfNumberMap.get("전무")} ,
					${clsfNumberMap.get("상무")} , ${clsfNumberMap.get("이사")} , ${clsfNumberMap.get("부장")} ,
					${clsfNumberMap.get("차장")} , ${clsfNumberMap.get("과장")} , ${clsfNumberMap.get("대리")} ,
					${clsfNumberMap.get("사원")}] ,
				borderColor : [

					'rgba(54, 162, 235)'

				],
				backgroundColor : [

					'rgba(54, 162, 235)'

				],
				borderWidth : 1
			} ]
		};
	
	const ctxClsf = document.getElementById('myChartClsf').getContext('2d');
	const myChartClsf = new Chart(ctxClsf, {
			type : 'bar',
			data : dataClsf,
			options : {
				maintainAspectRatio: false, // 아래 width와 height 설정을 유지하지 않도록 설정
		        responsive: true,
				plugins : {
					legend : {
						position : 'top',
					},
					title : {
						display : true,
						text : '직급별 평균 근속연수'
					}
				},
				scales : {
					yAxes : [ {
						ticks : {
							stepSize : 1
						// 세로축 간격을 1로 설정
						}
					} ]
				}
			}
		});
	
</script>