<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/project/css/project/home.css" />

<div class="row scrumboard" id="cancel-row">
	<div class="col-yen-15" style="width: 13%;">
		<div class="nav flex-column nav-pills mb-4 mb-md-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="moveToFormPage();" role="tab" aria-controls="v-pills-home" aria-selected="false">
				<i class="fa-solid fa-plus"></i> 새 프로젝트 </a>
			<br/>
			<div class="nav-link">
				<i class="fa-duotone fa-users" style="margin-right: 10px;"></i>
				내 프로젝트
			</div>
			<div class="myPrjct">
				<c:forEach var="project" items="${prjctList }">
					<div class="btn-prjct">
						<span class="side-stick yen-${project.prjctColorCode }"></span>
						<a class="nav-link" id="v-pills-my-tab" data-bs-toggle="pill" href="javascript:void(0);" onclick="moveToProjectMain(${project.prjctNo});" role="tab" aria-controls="v-pills-profile" aria-selected="false"> 
							${project.prjctNm } </a>					
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="col-yen-85 layout-spacing pb-3">
		<div data-simplebar>
			<div class="task-list-section">
				<!-- 일정 -->
				<div data-item="item-todo" class="task-list-container" data-action="sorting">
					<div class="connect-sorting connect-sorting-todo">
						<div class="task-container-header">
							<h6 class="item-head mb-0 fs-4 fw-semibold" data-item-title="Todo">일정</h6>
							<div class="hstack gap-2">
								<div class="add-kanban-title"></div>
								<div class="dropdown"></div>
							</div>
						</div>
						<div class="connect-sorting-content" data-sortable="true">
							<c:forEach var="prjctSchdul" items="${prjctSchdulList }">
								<!-- 프로젝트 일정 -->
								<div data-draggable="true" class="card img-task">
									<div class="card-body project-schedule">
										<div class="task-header">			
											<div class="task-summary">
												<span class="side-stick yen-${prjctSchdul.prjctColor }"></span>
												<h4 class="project-task-sub-title" data-prjct-schdul-no="${prjctSchdul.schdulNo }">
													${prjctSchdul.schdulNm }</h4>
												<h7>${prjctSchdul.prjctNm }</h7>
											</div>
										</div>
										<div class="task-body">
											<div class="schdul-bottom">
												<div class="tb-section-1">
													<span class="hstack gap-2 fs-2" data-item-date="24 July"><i class="ti ti-calendar fs-5"></i>
														${prjctSchdul.schdulBgnDateStr } 
														<c:if test="${prjctSchdul.schdulBgnDateStr ne '00:00' }">
															 ${prjctSchdul.schdulBgnTimeStr }
														</c:if>
													</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- // 프로젝트 일정 -->
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- // 일정 -->
				
				<!-- 대기 중 업무 -->
				<div data-item="item-inprogress" class="task-list-container">
					<div class="connect-sorting">
						<div class="task-container-header">
							<h6 class="item-head mb-0 fs-4 fw-semibold" data-item-title="P101">대기 중인 업무</h6>
						</div>
						<div class="connect-sorting-content">
							<c:forEach var="task" items="${todoTaskList }">
								<!-- 프로젝트 일감-->
								<div class="card img-task">
									<div class="card-body">
										<div class="task-header">
											<a class="task-summary" data-bs-toggle="collapse" href="#task${task.taskNo }" role="button" aria-expanded="false" aria-controls="task${task.taskNo }">
												<span class="side-stick yen-${task.prjctColor }"></span>
												<h4 class="project-task-sub-title" data-item-title="Battle with fire">${task.taskNm }</h4>
												<div class="project-task-prjct-title">${task.prjctNm }</div>
											</a>
										</div>
										<div id="task${task.taskNo }" class="task-body collapse">
											<div class="task-bottom">
												<div class="project-mini-body-section">
													<div>
														<div class="project-mini-body-index">
															<span>진척도</span>
														</div>
														<div class="project-mini-body-index">
															<span>우선순위</span>
														</div>
														<div class="project-mini-body-index">
															<span>중요도</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-content">
															<span>${task.taskProgrs }%</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskPriort eq 1 }">
																		낮음
																	</c:when>
																	<c:when test="${task.taskPriort eq 2 }">
																		보통
																	</c:when>
																	<c:when test="${task.taskPriort eq 3 }">
																		높음
																	</c:when>
																</c:choose>
															</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskImprtnc eq 1 }">
																		낮음
																	</c:when>
																	<c:when test="${task.taskImprtnc eq 2 }">
																		보통
																	</c:when>
																	<c:when test="${task.taskImprtnc eq 3 }">
																		높음
																	</c:when>
																</c:choose>
															</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-index">
															<span>시작 기한</span>
														</div>
														<div class="project-mini-body-index">
															<span>완료 기한</span>
														</div>
														<div class="project-mini-body-index">
															<span>최종 수정</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-content">
															<span>${task.taskBeginDtStr }</span>
														</div>
														<div class="project-mini-body-content">
															<span>${task.taskEndDtStr }</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskLastUpddeStr eq null}">
																		-
																	</c:when>
																	<c:when test="${task.taskLastUpddeStr ne null}">
																		${task.taskLastUpddeStr }
																	</c:when>
																</c:choose>
															</span>
														</div>
													</div>
												</div>
												<div class="project-mini-body-section">
													<span class="project-mini-button yen-${task.prjctColor }" onclick="showTaskDetail(this)" data-task-no="${task.taskNo }">더보기</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- // 프로젝트 일감-->
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- // 대기 중 업무 -->
				
				
				<!-- 진행 중 업무 -->
				<div data-item="item-pending" class="task-list-container" data-action="sorting">
					<div class="connect-sorting">
						<div class="task-container-header">
							<h6 class="item-head mb-0 fs-4 fw-semibold" data-item-title="Pending">진행중인 업무</h6>
							<div class="hstack gap-2">
								<div class="dropdown"></div>
							</div>
						</div>
						<div class="connect-sorting-content" data-sortable="true">
							<c:forEach var="task" items="${inProgressTaskList }">
								<!-- 프로젝트 일감-->
								<div class="card img-task">
									<div class="card-body">
										<div class="task-header">
											<a class="task-summary" data-bs-toggle="collapse" href="#task${task.taskNo }" role="button" aria-expanded="false" aria-controls="task${task.taskNo }">
												<span class="side-stick yen-${task.prjctColor }"></span>
												<h4 class="project-task-sub-title" data-item-title="Battle with fire">${task.taskNm }</h4>
												<div class="project-task-prjct-title">${task.prjctNm }</div>
											</a>
										</div>
										<div id="task${task.taskNo }" class="task-body collapse">
											<div class="task-bottom">
												<div class="project-mini-body-section">
													<div>
														<div class="project-mini-body-index">
															<span>진척도</span>
														</div>
														<div class="project-mini-body-index">
															<span>우선순위</span>
														</div>
														<div class="project-mini-body-index">
															<span>중요도</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-content">
															<span>${task.taskProgrs }%</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskPriort eq 1 }">
																		낮음
																	</c:when>
																	<c:when test="${task.taskPriort eq 2 }">
																		보통
																	</c:when>
																	<c:when test="${task.taskPriort eq 3 }">
																		높음
																	</c:when>
																</c:choose>
															</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskImprtnc eq 1 }">
																		낮음
																	</c:when>
																	<c:when test="${task.taskImprtnc eq 2 }">
																		보통
																	</c:when>
																	<c:when test="${task.taskImprtnc eq 3 }">
																		높음
																	</c:when>
																</c:choose>
															</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-index">
															<span>시작 기한</span>
														</div>
														<div class="project-mini-body-index">
															<span>완료 기한</span>
														</div>
														<div class="project-mini-body-index">
															<span>최종 수정</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-content">
															<span>${task.taskBeginDtStr }</span>
														</div>
														<div class="project-mini-body-content">
															<span>${task.taskEndDtStr }</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskLastUpddeStr eq null}">
																		-
																	</c:when>
																	<c:when test="${task.taskLastUpddeStr ne null}">
																		${task.taskLastUpddeStr }
																	</c:when>
																</c:choose>
															</span>
														</div>
													</div>
												</div>
												<div class="project-mini-body-section">
													<span class="project-mini-button yen-${task.prjctColor }" onclick="showTaskDetail(this)" data-task-no="${task.taskNo }">더보기</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- // 프로젝트 일감-->
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- // 진행 중 업무 -->
				
				<!-- 완료 업무 -->
				<div data-item="item-pending" class="task-list-container" data-action="sorting">
					<div class="connect-sorting">
						<div class="task-container-header">
							<h6 class="item-head mb-0 fs-4 fw-semibold" data-item-title="Done">완료된 업무</h6>
							<div class="hstack gap-2">
								<div class="dropdown"></div>
							</div>
						</div>
						<div class="connect-sorting-content" data-sortable="true">
							<c:forEach var="task" items="${doneTaskList }">
								<!-- 프로젝트 일감-->
								<div class="card img-task">
									<div class="card-body">
										<div class="task-header">
											<a class="task-summary" data-bs-toggle="collapse" href="#task${task.taskNo }" role="button" aria-expanded="false" aria-controls="task${task.taskNo }">
												<span class="side-stick yen-${task.prjctColor }"></span>
												<h4 class="project-task-sub-title" data-item-title="Battle with fire">${task.taskNm }</h4>
												<div class="project-task-prjct-title">${task.prjctNm }</div>
											</a>
										</div>
										<div id="task${task.taskNo }" class="task-body collapse">
											<div class="task-bottom">
												<div class="project-mini-body-section">
													<div>
														<div class="project-mini-body-index">
															<span>진척도</span>
														</div>
														<div class="project-mini-body-index">
															<span>우선순위</span>
														</div>
														<div class="project-mini-body-index">
															<span>중요도</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-content">
															<span>${task.taskProgrs }%</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskPriort eq 1 }">
																		낮음
																	</c:when>
																	<c:when test="${task.taskPriort eq 2 }">
																		보통
																	</c:when>
																	<c:when test="${task.taskPriort eq 3 }">
																		높음
																	</c:when>
																</c:choose>
															</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskImprtnc eq 1 }">
																		낮음
																	</c:when>
																	<c:when test="${task.taskImprtnc eq 2 }">
																		보통
																	</c:when>
																	<c:when test="${task.taskImprtnc eq 3 }">
																		높음
																	</c:when>
																</c:choose>
															</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-index">
															<span>시작 기한</span>
														</div>
														<div class="project-mini-body-index">
															<span>완료 기한</span>
														</div>
														<div class="project-mini-body-index">
															<span>최종 수정</span>
														</div>
													</div>
													<div>
														<div class="project-mini-body-content">
															<span>${task.taskBeginDtStr }</span>
														</div>
														<div class="project-mini-body-content">
															<span>${task.taskEndDtStr }</span>
														</div>
														<div class="project-mini-body-content">
															<span>
																<c:choose>
																	<c:when test="${task.taskLastUpddeStr eq null}">
																		-
																	</c:when>
																	<c:when test="${task.taskLastUpddeStr ne null}">
																		${task.taskLastUpddeStr }
																	</c:when>
																</c:choose>
															</span>
														</div>
													</div>
												</div>
												<div class="project-mini-body-section">
													<span class="project-mini-button yen-${task.prjctColor }" onclick="showTaskDetail(this)" data-task-no="${task.taskNo }">더보기</span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- // 프로젝트 일감-->
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- //완료 업무 -->
				
			</div>
		</div>
	</div>
</div>

<button id="btn-modal-task-detail" class="btn mb-1 bg-primary-subtle text-primary px-4 fs-4 " data-bs-toggle="modal" data-bs-target="#task-detail" style="display: none;">일감 상세 모달 버튼</button>

<!-- 일감 상세 모달 -->
<div class="modal fade" id="task-detail" tabindex="-1" aria-labelledby="bs-example-modal-lg" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-task-detail modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<div class="task-detail-title">
					<h5 class="modal-task-title h4" id="modaltaskDetailLabel"></h5>
					<span id="task-detail-side-stick" class="side-stick"></span>
					<h5 class="modal-task-prjct-title h6" id="modaltaskDetailLabelPrjct"></h5>
				</div>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="task-detail-info">
					<div id="task-detail-empl-elem" class="task-detail-info-elem">
						<i id="task-detail-icon-part" class="fa-regular fa-user fs-5 mb-0 task-detail-icon"></i>
						<div id="task-detail-empl"></div>
					</div>
					<div id="task-detail-bgndt-elem" class="task-detail-info-elem">
						<i id="task-detail-icon-bgndt" class="fa-regular fa-calendar fs-5 mb-0 task-detail-icon"></i>
						<div id="task-detail-bgndt"></div>
					</div>
					<div id="task-detail-enddt-elem" class="task-detail-info-elem">
						<i id="task-detail-icon-enddt" class="fa-regular fa-calendar-check fs-5 mb-0 task-detail-icon"></i>
						<div id="task-detail-enddt"></div>
					</div>
					<div id="task-detail-priort-elem" class="task-detail-info-elem">
						<i class="fa-regular fa-circle-exclamation fs-5 mb-0 task-detail-icon"></i>
						<div id="task-detail-priort"></div>
					</div>
					<div id="task-detail-imprtnc-elem" class="task-detail-info-elem">
						<i class="fa-regular fa-star fs-5 mb-0 task-detail-icon"></i>
						<div id="task-detail-imprtnc"></div>
					</div>
					<div id="task-detail-progrs-elem" class="task-detail-info-elem">
						<i class="fa-duotone fa-spinner-third fs-5 mb-0 task-detail-icon"></i>
						<div id="task-detail-progrs" onclick="showMod()">
						</div>
						<select id="select-task-progrs" onchange="modProgrs()" class="form-control form-select" data-placeholder="Choose a Category" tabindex="1" style="display: none;">
							<option value="" disabled selected>진척도</option>
							<option value="0">0%</option>
							<option value="10">10%</option>
							<option value="20">20%</option>
							<option value="30">30%</option>
							<option value="40">40%</option>
							<option value="50">50%</option>
							<option value="60">60%</option>
							<option value="70">70%</option>
							<option value="80">80%</option>
							<option value="90">90%</option>
							<option value="100">100%</option>
						</select>
					</div>
				</div>
				<p id="task-detail-cn" class="task-detail-info-elem"></p>
				<input type="hidden" id="taskNo">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn bg-danger-subtle text-danger " data-bs-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- / 일감 상세 모달 -->

<!-- Import Js Files -->
<script src="${pageContext.request.contextPath }/resources/project/js/project/project_home.js"></script>
