package kr.or.ddit.groupware.controller.project;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.zxing.Result;

import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.service.project.IProjectService;
import kr.or.ddit.groupware.service.project.ITaskService;
import kr.or.ddit.groupware.service.schedule.IScheduleService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.JsonObjectUtil;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.CalendarVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PrjctSchdulVO;
import kr.or.ddit.groupware.vo.ProjectReportVO;
import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.ScheduleVO;
import kr.or.ddit.groupware.vo.TaskVO;

/**
 * 프로젝트 컨트롤러
 *  업무일지 일감 등
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see ProjectController
 */

@Controller
@RequestMapping("/project")
public class ProjectController {
	
	@Inject
	private IProjectService projectService;
	
	@Inject
	private ITaskService taskService;
	
	@Inject
	IScheduleService scheduleService;
	
	@Inject
	IEmployeeService emplService;
	
	@Inject
	FileUtil fileUtil;

	CustomUser customUser;
	EmployeeVO loginUser;

	/**
	 * 프로젝트 탭 진입 시 보이는 프로젝트 홈
	 * @param model
	 * @return
	 */
	@GetMapping("")
	public String projectHome(Model model) {
		
		customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		loginUser = customUser.getEmployeeVO();
		
		List<ProjectVO> prjctList = projectService.selectAvailableProjectListByEmplNo(loginUser.getEmplNo());
		List<TaskVO> todoTaskList = taskService.selectOngoingTaskListByEmplNo(loginUser.getEmplNo(),"todo");
		List<TaskVO> inProgressTaskList = taskService.selectOngoingTaskListByEmplNo(loginUser.getEmplNo(),"inProgress");
		List<TaskVO> doneTaskList = taskService.selectOngoingTaskListByEmplNo(loginUser.getEmplNo(),"done");
		List<PrjctSchdulVO> prjctSchdulList = projectService.selectprjctSchdulListByemplNo(loginUser.getEmplNo());
		
		model.addAttribute("prjctList", prjctList);
		model.addAttribute("todoTaskList", todoTaskList);
		model.addAttribute("inProgressTaskList", inProgressTaskList);
		model.addAttribute("doneTaskList", doneTaskList);
		model.addAttribute("prjctSchdulList", prjctSchdulList);
		
		return "project/home";
	}
	
	/**
	 * 일감 상세 정보 Ajax
	 * @param taskNo
	 * @return
	 * @throws JsonProcessingException
	 */
	@GetMapping("/taskDetail")
	@ResponseBody
	public String getTaskDetail(int taskNo) throws JsonProcessingException {
		int emplNo = loginUser.getEmplNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplNo", emplNo);
		map.put("taskNo", taskNo);
		TaskVO taskVO = taskService.selectTaskByTaskNo(map);
		return JsonObjectUtil.convertObjectToJsonString(taskVO);
	}
	
	/**
	 * 프로젝트 메인 페이지
	 * @param prjctNo
	 * @return
	 * @throws JsonProcessingException 
	 */
	@GetMapping("/main")
	public String projectMain(int prjctNo, Model model) throws JsonProcessingException {
		
		model.addAttribute("loginUser", loginUser);
		
		ProjectVO project = projectService.selectProjectByPrjctNo(prjctNo,loginUser.getEmplNo());
		model.addAttribute("project", project);
		
		// 참여중인 프로젝트 리스트
		List<ProjectVO> prjctList = projectService.selectAvailableProjectListByEmplNo(loginUser.getEmplNo());
		model.addAttribute("prjctList", prjctList);
		
		// 상태별  업무 수
		int todoCnt = taskService.selectTaskCountByStatusNPrjctNo(prjctNo,"todo");
		int doingCnt = taskService.selectTaskCountByStatusNPrjctNo(prjctNo,"donig");
		int doneCnt = taskService.selectTaskCountByStatusNPrjctNo(prjctNo,"done");
		model.addAttribute("todoCnt", todoCnt);
		model.addAttribute("doingCnt", doingCnt);
		model.addAttribute("doneCnt", doneCnt);
		
		// 근 7일 내 마감 업무 수
		HashMap<Object, Object> dueDateMap = taskService.selectEnddeCnt(prjctNo);
		String dueDateJson = JsonObjectUtil.convertObjectToJsonString(dueDateMap);
		model.addAttribute("dueDateJson", dueDateJson);
		
		// 프로젝트 일정
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		calendarList = addCal(calendarList, "C104", prjctNo);
		String PrjctSchdulList = JsonObjectUtil.convertObjectToJsonString(calendarList);
		model.addAttribute("PrjctSchdulList", PrjctSchdulList);
		
		// 프로젝트 구성원
		List<EmployeeVO> emplList = projectService.selectPrjctPrtcpntListByPrjcrNo(prjctNo);
		model.addAttribute("emplList", emplList);
		
		// 프로젝트 일감
		List<TaskVO> taskList = taskService.selectTaskListByPrjctNo(prjctNo);
		String taskListJson = JsonObjectUtil.convertObjectToJsonString(taskList);
		model.addAttribute("taskList", taskList);
		model.addAttribute("taskListJson", taskListJson);
		
		// 업무 일지
		List<ProjectReportVO> prjctReprtList = projectService.selectPrjctReprtListByPrjctNo(prjctNo,"d");
		List<CalendarVO> reportCalendarList = convertProjectReportListToCalendarList(prjctReprtList);
		String reportCalendarListJson = JsonObjectUtil.convertObjectToJsonString(reportCalendarList);
		model.addAttribute("reportCalendarListJson", reportCalendarListJson);
		
		Map<Integer, List<TaskVO>> taskMap = taskService.selectTaskMapByPrjctNo(prjctNo);
		String taskMapJson = JsonObjectUtil.convertObjectToJsonString(taskMap);
		model.addAttribute("taskMapJson", taskMapJson);
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String todayString = now.format(formatter);
		model.addAttribute("todayString", todayString);
		
		return "project/main";
	}
	
	/**
	 * 프로젝트 등록 폼 페이지 요청
	 * @author <strong>권예은</strong>
	 * @param model
	 * @return
	 */
	@GetMapping("/form")
	public String projectForm(Model model) {
		
		model.addAttribute("loginUser", loginUser);
		
		LocalDateTime now = LocalDateTime.now();
		String nowString = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		model.addAttribute("now", nowString);
		
		return "project/form";
	}

	/**
	 * 프로젝트 등록 처리
	 * @author <strong>권예은</strong>
	 * @return
	 */
	@PostMapping("/register")
	@ResponseBody
	public String projectRegister(@RequestParam Map<String, Object> param, @RequestParam("attendeeList[]") ArrayList<Integer> attendeeList) {
		
		param.put("emplNo", loginUser.getEmplNo());
		
		int prjctNo = projectService.insertProject(param);
		param.put("prjctNo", prjctNo);
		
		for(int emplNo : attendeeList) {
			param.put("emplNo", emplNo);
			projectService.insertProjectParticipant(param);
		}
		
		return "";
	}
	
	/**
	 * 업무일지 등록
	 * @param prjctRept
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/insertRept")
	@ResponseBody
	public String projectReportRegister(ProjectReportVO prjctRept) {
		
		
		prjctRept.setEmplNo(loginUser.getEmplNo());
		if(prjctRept.getFiles() == null || prjctRept.getFiles().size()==0) {
			prjctRept.setAtchFileGrpNo(0);
		} else {
			int atchFileGrpNo = fileUtil.saveUploadFile(prjctRept.getFiles(), TableCode.PROJECT);
			prjctRept.setAtchFileGrpNo(atchFileGrpNo);			
		}
		
		projectService.insertProjectReport(prjctRept);
		
		return "";
	}
	
	/**
	 * 일감 등록
	 * @param prjctRept
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/insertTask")
	@ResponseBody
	public String projectTaskRegister(TaskVO task) {
		
		System.out.println(task);
		
		task.setTaskRegister(loginUser.getEmplNo());
		
		taskService.insertProjectTask(task);
		
		return "";
	}
	
	/**
	 * 일감 진척도 수정
	 * @param task
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/modTaskProgrs")
	@ResponseBody
	public String projectTaskProgrsModify(TaskVO task) {
		
		taskService.updateTaskProgrs(task);
		
		return "";
	}
	
	/**
	 * 업무일지 상세 정보
	 * @param reptNo
	 * @return
	 * @throws JsonProcessingException
	 */
	@GetMapping("/reportDetail")
	@ResponseBody
	public String getReptDetail(String reptNo) throws JsonProcessingException {
		int prjctReprtNo = Integer.parseInt(reptNo);
		ProjectReportVO prjctRept = projectService.selectPrjctReptByReptNo(prjctReprtNo);
		EmployeeVO empl = emplService.selectEmployee(prjctRept.getEmplNo());
		prjctRept.setEmpl(empl);
		
		return JsonObjectUtil.convertObjectToJsonString(prjctRept);
	}
	
	@GetMapping("/project")
	public String projectMain(Model model, ProjectVO project) {
		
		List<TaskVO> taskList = taskService.getTaskListByProject(project);
		return "";
	}
	
	/**
	 * 해당 사원이 참여중인 프로젝트 목록 (대기, 진행중만)
	 * @param emplNo
	 * @return
	 * @throws JsonProcessingException 
	 */
	@GetMapping("/my")
	public String getMyAvailableProject(int emplNo) throws JsonProcessingException {
		List<ProjectVO> myProjectList = projectService.selectAvailableProjectListByEmplNo(emplNo);
		return JsonObjectUtil.convertObjectToJsonString(myProjectList);
	}
	
	private List<ProjectVO> getOnesAllProjects(int emplNo){
		return projectService.selectProjectListByEmplNo(emplNo);
	}
	
	/**
	 * 
	 * @author <strong>권예은</strong>
	 * @param calendarList
	 * @return
	 */
	private List<CalendarVO> addCal(List<CalendarVO> calendarList, String schdulTypeCode, Object psitnCode){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schdulTypeCode", schdulTypeCode);
		map.put("psitnCode", psitnCode);
		
		List<ScheduleVO> scheduleList = scheduleService.selectScheduleList(map);
		for(ScheduleVO scheduleVO : scheduleList) {
			CalendarVO calendar = convertScheduleVOToCalendarVO(scheduleVO);
			calendarList.add(calendar);
		}
		return calendarList;
	}
	
	
	/**
	 * scheduleVO를 풀캘린더를 위한 CalendarVO로 변환
	 * @author <strong>권예은</strong>
	 * @param scheduleVO
	 * @return
	 */
	private CalendarVO convertScheduleVOToCalendarVO(ScheduleVO scheduleVO) {
		CalendarVO calendar = new CalendarVO();
		
		calendar.setId(""+scheduleVO.getSchdulNo());
		calendar.setTitle(scheduleVO.getSchdulNm());
		if(scheduleVO.getAlldayYn().equals("Y")) {
			calendar.setAllDay(true);
		}else {
			calendar.setAllDay(false);
			calendar.setEnd(scheduleVO.getSchdulEndde());
		}
		calendar.setStart(scheduleVO.getSchdulBgnde());
		String bgrnColorName = scheduleVO.getSchdulBgrnColor();
		String bgrnColorCode = scheduleService.getColorCode(bgrnColorName);
		calendar.setBackgroundColor(bgrnColorCode);
		calendar.setColor(bgrnColorCode);
		calendar.setTextColor(scheduleVO.getSchdulFontColor());
		
		return calendar;
	}
	
	
	/**
	 * ProjectReportVO를 풀캘린더를 위한 CalendarVO로 변환
	 * @author <strong>권예은</strong>
	 * @param ProjectReportVOList
	 * @return
	 */
	private List<CalendarVO> convertProjectReportListToCalendarList(List<ProjectReportVO> projectReportList) {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		int i = 0;
		Map<Integer, String> empColorMap = new HashMap<Integer, String>();
		
		for(ProjectReportVO report : projectReportList) {
			CalendarVO calendar = new CalendarVO();
			calendar.setId(""+report.getPrjctReprtNo());
			calendar.setTitle(report.getEmplNm());
			calendar.setAllDay(true);
			calendar.setStart(report.getPrjctReprtTargetDate());
			String bgrnColorCode = empColorMap.get(report.getEmplNo());
			if(bgrnColorCode == null) {
				bgrnColorCode = getColor(i++);
				empColorMap.put(report.getEmplNo(), bgrnColorCode);
			}
			calendar.setBackgroundColor(bgrnColorCode);
			calendar.setColor(bgrnColorCode);
			calendarList.add(calendar);
		}
		
		return calendarList;
	}
	
	private String getColor(int i) {
		switch (i%10) {
		case 0:
			return "#FF595E";
		case 1:
			return "#FF924C";
		case 2:
			return "#FFCA3A";
		case 3:
			return "#C5CA30";
		case 4:
			return "#8AC926";
		case 5:
			return "#36949D";
		case 6:
			return "#1982C4";
		case 7:
			return "#4267AC";
		case 8:
			return "#565AA0";
		case 9:
			return "#6A4C93";
		default:
			return "#FF595E";
		}
	}
	
}
