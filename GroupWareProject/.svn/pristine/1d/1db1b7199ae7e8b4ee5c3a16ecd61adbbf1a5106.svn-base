package kr.or.ddit.groupware.controller.common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.groupware.service.approval.IApprovalService;
import kr.or.ddit.groupware.service.board.IBoardService;
import kr.or.ddit.groupware.service.common.ICommonService;
import kr.or.ddit.groupware.service.employee.IDclzService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.service.mail.IMailService;
import kr.or.ddit.groupware.service.notification.INotificationService;
import kr.or.ddit.groupware.service.project.IProjectService;
import kr.or.ddit.groupware.service.schedule.IScheduleService;
import kr.or.ddit.groupware.service.widget.IWidgetService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.JsonObjectUtil;
import kr.or.ddit.groupware.util.News;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.CalendarVO;
import kr.or.ddit.groupware.vo.DclzVO;
import kr.or.ddit.groupware.vo.EmailReceptionVO;
import kr.or.ddit.groupware.vo.EmailVO;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.NewsItemVO;
import kr.or.ddit.groupware.vo.NotificationVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.ScheduleVO;
import kr.or.ddit.groupware.vo.SearchVO;
import kr.or.ddit.groupware.vo.WidgetVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 메인 컨트롤러
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see MainController
 */
@Slf4j
@Controller
@RequestMapping("/")
public class MainController extends CommonAbstractImpl {

	@Inject
	private FileUtil fileUtil;

	@Inject
	private IWidgetService widgetService;

	@Inject
	private INotificationService notiService;

	@Inject
	private IEmployeeService employeeService;
	
	@Inject
	private IScheduleService scheduleService;
	
	@Inject
	private IProjectService projectService;
	
	@Inject
	private IMailService mailService;
	
	@Inject
	private IApprovalService approvalService;
	
	@Inject
	private ICommonService commonService;
	
	@Inject
	private IDclzService dclzService;
	
	@Inject
	private IBoardService boardService;
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("")
	public String testView(Model model) throws Exception {
		EmployeeVO employeeVO = getEmployee();
		
		List<WidgetVO> widgetList = widgetService.selectWidgetList(employeeVO.getEmplNo());

		if (widgetList != null) {
			model.addAttribute("widgetList", mapper.writeValueAsString(widgetList));
			model.addAttribute("employee", employeeVO);
		}

		/*
		 * 24.04.19 뉴스 추가 - 이영주
		 */
		EmployeeEstbsVO estbsVO = new EmployeeEstbsVO();
		estbsVO.setEmplNo(employeeVO.getEmplNo()); // 주체
		estbsVO.setEstbsTypeCode("2"); // 옵션타입코드 - 뉴스
		estbsVO = employeeService.selectEstbsByEmplNo(estbsVO); // 뉴스키워드 여부 셀렉
		
		List<NewsItemVO> newsItems = null;
		if(estbsVO != null && estbsVO.getEstbsCn() != null) {    // null이 아니고 뉴스 키워드가 있으면
		    newsItems = News.searchNews(estbsVO.getEstbsCn());
		} else {    // 없으면
		    newsItems = new ArrayList<>(); // 빈 리스트 생성
		}
		model.addAttribute("newsItems", newsItems);
		model.addAttribute("selectEstbsValue", estbsVO);
		
		/*
		 * 2024.04.23. 권예은 - 캘린더
		 */
		List<CalendarVO> allCalendarList = new ArrayList<CalendarVO>();
		List<CalendarVO> comCalendarList = new ArrayList<CalendarVO>();
		comCalendarList = addCal(comCalendarList, "C101", null);
		String comCalendarListJson = JsonObjectUtil.convertObjectToJsonString(comCalendarList);
		allCalendarList.addAll(comCalendarList);
		
		List<CalendarVO> deptCalendarList = new ArrayList<CalendarVO>();
		deptCalendarList = addCal(deptCalendarList, "C102", employeeVO.getDeptCode());
		String deptCalendarListJson = JsonObjectUtil.convertObjectToJsonString(deptCalendarList);
		allCalendarList.addAll(deptCalendarList);
		
		List<CalendarVO> emplCalendarList = new ArrayList<CalendarVO>();
		emplCalendarList = addCal(emplCalendarList, "C103", employeeVO.getEmplNo());
		String emplCalendarListJson = JsonObjectUtil.convertObjectToJsonString(emplCalendarList);
		allCalendarList.addAll(emplCalendarList);
		String allCalendarListJson = JsonObjectUtil.convertObjectToJsonString(allCalendarList);
		
		model.addAttribute("comCalendarListJson", comCalendarListJson);
		model.addAttribute("deptCalendarListJson", deptCalendarListJson);
		model.addAttribute("emplCalendarListJson", emplCalendarListJson);
		model.addAttribute("allCalendarListJson", allCalendarListJson);

		/*
		 * 2024.04.23. 권예은 - 프로젝트
		 */
		List<ProjectVO> projectList = projectService.selectAvailableProjectListByEmplNo(employeeVO.getEmplNo());
		model.addAttribute("projectList", projectList);
		
		/*
		 * 2024.04.25. 최소희 - 메일
		 */
		List<EmailVO> emailList = mailService.mainEmailList(employeeVO.getEmplNo());
		
		List<EmailVO> sentList = mailService.mainSentList(employeeVO.getEmplNo());
		EmailReceptionVO sentReceptionVO = new EmailReceptionVO();
		for (EmailVO emailVO : sentList) {
			// 받는사람 1명 받아오기
			sentReceptionVO = mailService.selectReceptionOne(emailVO.getEmailNo());
			// employeeVO에 받는사람 정보 넣기
			if(sentReceptionVO != null) {
				emailVO.setEmployeeVO(employeeService.selectEmployee(sentReceptionVO.getReceiverNo()));
			}
		}
		
		List<EmailVO> importantList = mailService.mainImportantList(employeeVO.getEmplNo());
		EmailReceptionVO impReceptionVO = new EmailReceptionVO();
		for (EmailVO emailVO : importantList) {
			// 받는사람 1명 받아오기
			if(emailVO.getSenderNo() == employeeVO.getEmplNo()) { // 받은메일
				impReceptionVO = mailService.selectReceptionOne(emailVO.getEmailNo());
				// employeeVO에 받는사람 정보 넣기
				emailVO.setEmployeeVO(employeeService.selectEmployee(impReceptionVO.getReceiverNo()));
			}else { // 보낸메일
				// employeeVO에 보낸사람 정보 넣기
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailVO.getSenderNo()));
			}
		}
		
		List<EmailVO> noReadList = mailService.mainNoReadList(employeeVO.getEmplNo());
		
		model.addAttribute("emailList", emailList);
		model.addAttribute("sentList", sentList);
		model.addAttribute("importantList", importantList);
		model.addAttribute("noReadList", noReadList);
		
		/*
		 * 	2024.04.30. 이명문 - 결재 카운트
		 */
		List<Map<String, Object>> approvalList = approvalService.myDocumentsCount(employeeVO.getEmplNo());
		
		model.addAttribute("approvalList", approvalList);
		
		/*
		 * 2024.05.08. 최소희 - 안읽은메일 카운트
		 */
		
		int noReadCnt = mailService.selectNoReadCount(employeeVO.getEmplNo());
		
		model.addAttribute("noReadCnt", noReadCnt);
		
		/*
		 * 2024.05.08. 권예은 - 출근 및 퇴근 시간
		 */
		
		 SimpleDateFormat yFormat = new SimpleDateFormat("yyyy년 MM월 dd일 (E)", Locale.KOREA);
		 Date today = new Date();
		 String todayString = yFormat.format(today);
		 model.addAttribute("todayString", todayString);
		
		DclzVO dclz = dclzService.selectDclzStatus(employeeVO.getEmplNo());
		
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		String attendString = "-";
		String lvffcString = "-";
		if( dclz!= null && dclz.getAttendDt() != null) {
			attendString = format.format(dclz.getAttendDt());
		}
		
		if(dclz!= null && dclz.getLvffcDt() != null) {
			lvffcString = format.format(dclz.getLvffcDt());
		}
		
		model.addAttribute("attendString", attendString);
		model.addAttribute("lvffcString", lvffcString);
		
		/*
		 * 2024.05.08. 최윤서 - 게시판 공지사항 불러오기
		 */
		List<BoardVO> boardList = new ArrayList<>();
		boardList = boardService.mainBoardList();
		model.addAttribute("boardList", boardList);
	
		return "main/main";
	}
	
	/**
	 * @method : totalSearch
	 * @auther : <strong>이명문</strong>
	 * @param  :
	 * @return :
	 * @throws Exception 
	 * @date : 2024. 5. 1
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> totalSearch(SearchVO searchVO) throws Exception {
		List<SearchVO> searchList = commonService.totalSearch(searchVO);
		return ResponseEntity.ok(mapper.writeValueAsString(searchList));
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping(value = "/search/{searchType}")
	public String searchForm(@PathVariable String searchType,
							@RequestParam("s") String searchText
							, Model model) throws Exception {
		
		SearchVO searchVO = new SearchVO();
		searchVO.setEmplNo(getEmployee().getEmplNo());
		
		if(StringUtils.isNotBlank(searchText))
			searchVO.setSearchText(searchText);
		
		if(StringUtils.isNotBlank(searchType)) 
			searchVO.setSearchType(searchType);
		
		
		
		List<SearchVO> searchList = commonService.totalSearch(searchVO);
		model.addAttribute("searchList", searchList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchText", searchVO.getSearchText());
		if(searchList.size() > 0) {
			model.addAttribute("totalCnt", searchList.get(0).getTotalCnt());
		}
		
		return "main/search";
	}
	
	/**
	 * @method : downloadFile
	 * @auther : <strong>이명문</strong>
	 * @param  :
	 * @return :
	 * @date : 2024. 4. 5
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/download")
	public ResponseEntity<byte[]> downloadFile(String p) {
		File file = new File(p);
		if(file.exists()) {
			return fileUtil.getFileEntity(p, true);
		}
		return null;
	}
	
	/**
	 * @method : displayFile
	 * @auther : <strong>이명문</strong>
	 * @param  :
	 * @return :
	 * @date : 2024. 4. 5
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/display")
	public ResponseEntity<byte[]> displayFile(String p) {
		File file = new File(p);
		if(file.exists()) {
			return fileUtil.getFileEntity(p, false);
		}
		return null;
	}

	/**
	 * @method : notiView
	 * @auther : <strong>이명문</strong>
	 * @param : model - 값을 담아 전달해줄 모델
	 * @param : type - 파라미터 값으로 어떠한 리스트를 가져올지 분기처리
	 * @return : "main/notification"
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/noti")
	public String notiView(Model model, String type) {
		int emplNo = getEmployee().getEmplNo();
		List<NotificationVO> notiList = null;
		
		if (type != null && type.equals("unread")) {
			notiList = notiService.selectNotReadNotiList(emplNo);
		}else {
			NotificationVO notificationVO = new NotificationVO();
			notificationVO.setNtcnRecp(emplNo);
			notificationVO.setType(type);
			notiList = notiService.selectNotiPageList(notificationVO);
		}

		model.addAttribute("notiList", notiList);
		model.addAttribute("type", type);

		return "main/notification";
	}
	
	/**
	 * @method : InsertNewsKeyword 뉴스키워드인서트
	 * @auther : <strong>이영주</strong>
	 * @param : 사원번호, 뉴스코드, 키워드
	 * @return : OK, FAILED
	 * @date : 2024. 4. 19
	 *
	 */
	@PostMapping("/keywordSetting")
	public ResponseEntity<String> InsertNewsKeyword(@RequestBody EmployeeEstbsVO estbsVO){
		EmployeeVO employeeVO = getEmployee();
		
		estbsVO.setEmplNo(employeeVO.getEmplNo());
		estbsVO.setEstbsTypeCode("2"); // 옵션타입코드 - 뉴스
		estbsVO.setEstbsCn(estbsVO.getEstbsCn());
		estbsVO.setEstbsRegister(employeeVO.getEmplNo());
		
		int result = employeeService.insertNewsKeyword(estbsVO);
		
		if (result > 0) {
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	
	/**
	 * @method : UpdateNewsKeyword 뉴스키워드업데이트
	 * @auther : <strong>이영주</strong>
	 * @param : 사원번호, 뉴스코드, 키워드
	 * @return : OK, FAILED
	 * @date : 2024. 4. 19
	 *
	 */
	@PostMapping("/keywordUpdate")
	public ResponseEntity<String> UpdateNewsKeyword(@RequestBody EmployeeEstbsVO estbsVO){
		EmployeeVO employeeVO = getEmployee();
		EmployeeEstbsVO NewEstbsVO = new EmployeeEstbsVO();
		NewEstbsVO.setEmplNo(employeeVO.getEmplNo());
		NewEstbsVO.setEstbsTypeCode("2"); // 옵션타입코드 - 뉴스
		NewEstbsVO = employeeService.selectEstbsByEmplNo(NewEstbsVO); // 뉴스키워드 여부 셀렉
		
		estbsVO.setEstbsNo(NewEstbsVO.getEstbsNo());
		
		estbsVO.setEmplNo(employeeVO.getEmplNo());
		estbsVO.setEstbsCn(estbsVO.getEstbsCn());
		estbsVO.setEstbsUpdusr(employeeVO.getEmplNo()); //업데이트한 사원번호
		
		int result = employeeService.updateNewsKeyword(estbsVO);
		
		if (result > 0) {
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	
	/**
	 * @method : CreateNewsList 뉴스리스트 다시 불러오는 메서드
	 * @auther : <strong>이영주</strong>
	 * @param : 사원번호, 뉴스코드, 키워드
	 * @return : 바뀐 키워드로 불러온 뉴스리스트
	 * @date : 2024. 4. 20
	 *
	 */
	@GetMapping(value = "/createNewsList", produces = MediaType.APPLICATION_JSON_VALUE )
	public ResponseEntity<String> CreateNewsList() throws Exception{
		EmployeeVO employeeVO = getEmployee();
		
		EmployeeEstbsVO estbsVO = new EmployeeEstbsVO();
		estbsVO.setEmplNo(employeeVO.getEmplNo()); // 주체
		estbsVO.setEstbsTypeCode("2"); // 옵션타입코드 - 뉴스
		estbsVO = employeeService.selectEstbsByEmplNo(estbsVO); // 뉴스키워드 여부 셀렉
		
		List<NewsItemVO> newsItems = null;
		if(estbsVO != null && estbsVO.getEstbsCn() != null) {    // null이 아니고 뉴스 키워드가 있으면
		    newsItems = News.searchNews(estbsVO.getEstbsCn());
		} else {    // 없으면
		    newsItems = new ArrayList<>(); // 빈 리스트 생성
		}
		String newNewsList = mapper.writeValueAsString(newsItems);
		return new ResponseEntity<String>(newNewsList,HttpStatus.OK);
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
