package kr.or.ddit.groupware.controller.schedule;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.service.project.IProjectService;
import kr.or.ddit.groupware.service.schedule.IScheduleService;
import kr.or.ddit.groupware.util.JsonObjectUtil;
import kr.or.ddit.groupware.vo.CalendarVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.ScheduleVO;

/**
 * 일정 컨트롤러
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see ScheduleController
 */
@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Inject
	IScheduleService scheduleService;
	
	@Inject
	IEmployeeService emplService;
	
	@Inject
	IProjectService projectService;

	CustomUser customUser;
	EmployeeVO loginUser;
	int emplNo;
	
	/**
	 * 캘린더 메인 화면
	 * @author <strong>권예은</strong>
	 * @return 캘린더 메인 페이지
	 */
	@GetMapping("")
	public String calendarMain(Model model) {
		customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		loginUser = customUser.getEmployeeVO();
		emplNo = loginUser.getEmplNo();
		model.addAttribute("loginUser", loginUser);
		List<ProjectVO> projectList = projectService.selectAvailableProjectListByEmplNo(emplNo);
		model.addAttribute("projectList", projectList);
		return "calendar/main";
	}
	
	/**
	 * 일정 등록 폼 화면
	 * @author <strong>권예은</strong>
	 * @return 일정 등록 페이지
	 */
	@GetMapping("/form")
	public String scheduleForm(Model model) {
		
		customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		loginUser = customUser.getEmployeeVO();
		emplNo = loginUser.getEmplNo();
		model.addAttribute("loginUser", loginUser);
		
		LocalDateTime now = LocalDateTime.now();
		String nowString = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		model.addAttribute("now", nowString);
		
		List<ProjectVO> myAvailableProjectList = projectService.selectAvailableProjectListByEmplNo(emplNo);
		model.addAttribute("projectList", myAvailableProjectList);
		
		return "calendar/form";
	}
	
	/**
	 * 일정 수정 폼 화면
	 * @author <strong>권예은</strong>
	 * @return 일정 등록 페이지
	 */
	@GetMapping("/modify")
	public String scheduleModifyForm(Model model, int schdulNo) {
		
		LocalDateTime now = LocalDateTime.now();
		String nowString = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		model.addAttribute("now", nowString);
		
		List<ProjectVO> myAvailableProjectList = projectService.selectAvailableProjectListByEmplNo(emplNo);
		model.addAttribute("projectList", myAvailableProjectList);
		
		ScheduleVO schedule = scheduleService.selectScheduleBySchdulNo(schdulNo+"");
		
		List<Integer> attendeeNoList = scheduleService.selectParticipant(schdulNo+"");
		List<EmployeeVO> attendeeList = new ArrayList<EmployeeVO>();
		
		for(int emplNo : attendeeNoList) {
			EmployeeVO attendee = emplService.selectEmployee(emplNo);
			attendeeList.add(attendee);
		}
		
		schedule.setAttendeeList(attendeeList);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
		
		Date bgnDate = schedule.getSchdulBgnde();
		String bgnDateString = dateFormat.format(bgnDate);
		String bgnTimeString = timeFormat.format(bgnDate);
		Date endDate = schedule.getSchdulEndde(); 
		String endDateString = dateFormat.format(endDate);
		String endTimeString = timeFormat.format(endDate);
		model.addAttribute("bgnDateString", bgnDateString);
		model.addAttribute("bgnTimeString", bgnTimeString);
		model.addAttribute("endDateString", endDateString);
		model.addAttribute("endTimeString", endTimeString);
		
		model.addAttribute("schedule", schedule);
		model.addAttribute("status", "u");
		
		return "calendar/form";
	}
	
	/**
	 * 일정 삭제
	 * @author <strong>권예은</strong>
	 * @return 일정 목록 페이지
	 */
	@PostMapping("/delete")
	public String scheduleDelete(Model model, int schdulNo) {
		
		System.out.println("!!!!!!! schdulNo "+schdulNo);
		
		scheduleService.deleteSchdul(schdulNo);
		
		return "calendar/main";
	}
	
	/**
	 * 일정 등록
	 * @author <strong>권예은</strong>
	 * @param param
	 * @return
	 * @throws JsonProcessingException 
	 */
	@PostMapping("/register")
	@ResponseBody
	public String schduleInsert(@RequestParam Map<String, Object> param, @RequestParam("attendeeList[]") ArrayList<Integer> attendeeList) throws JsonProcessingException {
		
		param.put("register", loginUser.getEmplNo());
//		param.put("register", "20240004");
		
		System.out.println("param");
		System.out.println(param);
		
		int schdulNo = scheduleService.insertSchdul(param);
		param.put("schdulNo", schdulNo);
		
		if(param.get("schdulTypeCode").equals("C103")) { // 개인 일정
			for(int emplNo : attendeeList) {
				param.put("emplNo", emplNo);
				scheduleService.insertSchdulParticipant(param);
				
				param.put("psitnCode", emplNo);
				scheduleService.insertSchGroupInclude(param);
			}
		}else if(param.get("schdulTypeCode").equals("C102")) { // 부서 일정
			
			String deptCode = loginUser.getDeptCode();			
			List<String> deptCodeList = scheduleService.selectLowerDept(deptCode);
			
			param.put("psitnCode", deptCode);
			scheduleService.insertSchGroupInclude(param);
			for(int emplNo : attendeeList) {
				
				param.put("emplNo", emplNo);
				scheduleService.insertSchdulParticipant(param);
				
				EmployeeVO employeeVO = emplService.selectEmployee(emplNo);
				if(!deptCodeList.contains(employeeVO.getDeptCode())) {
					param.put("schdulTypeCode", "C103");
					param.put("psitnCode", emplNo);
					scheduleService.insertSchGroupInclude(param);					
				}
			}
		}else if(param.get("schdulTypeCode").equals("C104")){ // 프로젝트 일정
			scheduleService.insertSchGroupInclude(param);
			List<Integer> projectParticipantList = projectService.selectProjectParticipant(Integer.parseInt((String)param.get("psitnCode")));

			for(int emplNo : attendeeList) {
				
				param.put("emplNo", emplNo);
				scheduleService.insertSchdulParticipant(param);
				
				if(!projectParticipantList.contains(emplNo)) {
					param.put("schdulTypeCode", "C103");
					param.put("psitnCode", emplNo);
					scheduleService.insertSchGroupInclude(param);					
				}
			}
		}
		
		return JsonObjectUtil.convertObjectToJsonString(schdulNo);
	}
	
	/**
	 * 일정 수정 처리
	 * @param param
	 * @param attendeeList
	 * @return
	 */
	@PostMapping("/modify")
	@ResponseBody
	public String scheduleModify(@RequestParam Map<String, Object> param, @RequestParam("attendeeList[]") ArrayList<Integer> attendeeList) {
		System.out.println(param);
		scheduleService.updateSchdul(param,attendeeList);
		return "";
	}
	
	/**
	 * 일정 상세 정보
	 * @author <strong>권예은</strong>
	 * @return 일정 calendarVO
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/schdulDetail")
	@ResponseBody
	public String getSchedule(String schdulNo) throws JsonProcessingException {
		
		List<Integer> emplNoList = scheduleService.selectParticipant(schdulNo);
		List<EmployeeVO> attendeeList = new ArrayList<EmployeeVO>();
		for(int emplNo : emplNoList) {
			EmployeeVO attendeeEmployeeVO = emplService.selectEmployee(emplNo);
			attendeeList.add(attendeeEmployeeVO);
		}
		
		ScheduleVO schedule = scheduleService.selectScheduleBySchdulNo(schdulNo);
		schedule.setAttendeeList(attendeeList);
		
		if(schedule.getSchdulTypeCode().equals("C101")) {
			schedule.setSchdulGroupNm("사내 일정");
		} else if(schedule.getSchdulTypeCode().equals("C102")) {
			String deptNm = scheduleService.selectDeptNm(schedule.getPsitnCode());
			schedule.setSchdulGroupNm("부서 일정 - " + deptNm);
		} else if(schedule.getSchdulTypeCode().equals("C103")) {
			schedule.setSchdulGroupNm("개인 일정");
		} else if(schedule.getSchdulTypeCode().equals("C104")) {
			String prjctNm = scheduleService.selectProjectNm(schedule.getPsitnCode());
			schedule.setSchdulGroupNm("프로젝트 일정 - " + prjctNm);
		}
		
		return JsonObjectUtil.convertObjectToJsonString(schedule);
	}
	
	/**
	 * 로그인된 사용자의 모든 일정 출력
	 * @author <strong>권예은</strong>
	 * @return 로그인 사용자 모든 일정 calendarVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/getallschdul")
	@ResponseBody
	public String getAllSchedule() throws JsonProcessingException {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		
		calendarList = addCal(calendarList, "C103", loginUser.getEmplNo());
		calendarList = addCal(calendarList, "C102", loginUser.getDeptCode());
		calendarList = addCal(calendarList, "C101", null);
		calendarList = addProjectCal(calendarList);
		
		return JsonObjectUtil.convertObjectToJsonString(calendarList);
	}
	
	/**
	 * 로그인된 사용자의 개인 일정
	 * @author <strong>권예은</strong>
	 * @return 로그인 사용자 개인 일정 calendarVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/getmyschdul")
	@ResponseBody
	public String getMySchedule() throws JsonProcessingException {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		calendarList = addCal(calendarList, "C103", loginUser.getEmplNo());
		
		return JsonObjectUtil.convertObjectToJsonString(calendarList);
	}
	
	/**
	 * 로그인된 사용자의 부서 일정 출력
	 * @author <strong>권예은</strong>
	 * @return 로그인 사용자 부서 일정 calendarVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/getdeptschdul")
	@ResponseBody
	public String getDeptSchedule() throws JsonProcessingException {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		calendarList = addCal(calendarList, "C102", loginUser.getDeptCode());
		
		return JsonObjectUtil.convertObjectToJsonString(calendarList);
	}
	
	/**
	 * 로그인된 사용자의 프로젝트 일정 출력
	 * @author <strong>권예은</strong>
	 * @return 로그인 사용자 프로젝트 일정 calendarVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/getprjctschdul")
	@ResponseBody
	public String getProjectSchedule() throws JsonProcessingException {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		calendarList = addProjectCal(calendarList);
		
		return JsonObjectUtil.convertObjectToJsonString(calendarList);
	}
	
	private List<CalendarVO> addProjectCal(List<CalendarVO> calendarList) {
		List<ProjectVO> projectList = projectService.selectAvailableProjectListByEmplNo(emplNo);
		for(ProjectVO projectVO : projectList) {
			calendarList = addCal(calendarList, "C104", projectVO.getPrjctNo());
		}
		return calendarList;
	}

	/**
	 * 해당 프로젝트 일정 출력
	 * @author <strong>권예은</strong>
	 * @return 로그인 사용자 프로젝트 일정 calendarVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/getAprjctschdul")
	@ResponseBody
	public String getAProjectSchedule(int prjctNo) throws JsonProcessingException {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		calendarList = addCal(calendarList, "C104", prjctNo);
		
		return JsonObjectUtil.convertObjectToJsonString(calendarList);
	}
	
	/**
	 * 사내 일정 출력
	 * @author <strong>권예은</strong>
	 * @return 사내 일정 calendarVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping(value = "/getcompanyschdul")
	@ResponseBody
	public String getCompanySchedule() throws JsonProcessingException {
		
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();
		calendarList = addCal(calendarList, "C101", null);
		
		return JsonObjectUtil.convertObjectToJsonString(calendarList);
	}
	
	/**
	 * 해당 날짜 해당 직원 일정
	 * @param emplNo
	 * @param dateToCheck
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@GetMapping("/getAttendeeSchdul")
	public String getAttendeeSchdul(String emplNo, String dateToCheck) throws JsonProcessingException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		String bgnde = dateToCheck.substring(0, 9) + (Integer.parseInt(dateToCheck.substring(9))+1);
		String endde = dateToCheck;
		
		System.out.println("!!!!!!!!!! bgnde : " + bgnde);
		System.out.println("!!!!!!!!!! endde : " + endde);
		
		paramMap.put("emplNo", emplNo);
		paramMap.put("bgnde", bgnde);
		paramMap.put("endde", endde);
		
		List<ScheduleVO> scheduleList = scheduleService.selectScheduleListByEmplNoNDate(paramMap);
		return JsonObjectUtil.convertObjectToJsonString(scheduleList);
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

}
