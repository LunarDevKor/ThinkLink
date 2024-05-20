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

import org.springframework.security.access.prepost.PreAuthorize;
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
 * @see AdminScheduleController
 */
@Controller
@RequestMapping("/admin/schedule")
public class AdminScheduleController {
	
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
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("")
	public String calendarMain(Model model) {
		return "admin/calendar/main";
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
		
		return "admin/calendar/form";
	}
	
	/**
	 * 일정 수정 폼 화면
	 * @author <strong>권예은</strong>
	 * @return 일정 등록 페이지
	 */
	@GetMapping("/modify")
	public String scheduleModifyForm(Model model, int schdulNo) {
		
		System.out.println("!!!modify!!!");
		
		LocalDateTime now = LocalDateTime.now();
		String nowString = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		model.addAttribute("now", nowString);
		
		ScheduleVO schedule = scheduleService.selectScheduleBySchdulNo(schdulNo+"");
		
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
		
		return "admin/calendar/form";
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
		
		return "admin/calendar/main";
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
	public String schduleInsert(@RequestParam Map<String, Object> param) throws JsonProcessingException {
		
		param.put("register", loginUser.getEmplNo());
		
		System.out.println("param");
		System.out.println(param);
		
		int schdulNo = scheduleService.insertSchdul(param);
		param.put("schdulNo", schdulNo);
				
		param.put("psitnCode", "C101");
		scheduleService.insertSchGroupInclude(param);
		
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
	public String scheduleModify(@RequestParam Map<String, Object> param) {
		System.out.println(param);
		scheduleService.updateSchdul(param, null);
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
