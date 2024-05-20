package kr.or.ddit.groupware.controller.attendance;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.attendance.IAttendanceService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ClassOfPositionVO;
import kr.or.ddit.groupware.vo.DclzStatusVO;
import kr.or.ddit.groupware.vo.EmployeeVO;

/**
 * 근태통계 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see StatisticsController
 */
@Controller
@RequestMapping("/admin/attendance")
public class StatisticsController {

	@Inject
	private IAttendanceService service;

	@Inject
	private IEmployeeService employeeService;

	@Inject
	private AttendanceController attendanceController;

	// 해당 월의 1일부터 마지막날짜의 리스트(마지막날부터 저장)
	public List<Date> getDateList(int year, int month) {

		LocalDate currentFirst = LocalDate.of(year, month, 1);
		Date firstDay = Date.from(currentFirst.atStartOfDay(ZoneId.systemDefault()).toInstant());

		LocalDate today = LocalDate.now();
		LocalDate currentLast = LocalDate.of(year, month, currentFirst.lengthOfMonth());
		Date lastDay = null;

		if (today.compareTo(currentLast) < 0) {
			lastDay = Date.from(today.atStartOfDay(ZoneId.systemDefault()).toInstant());
		}
		else {
			lastDay = Date.from(currentLast.atStartOfDay(ZoneId.systemDefault()).toInstant());
		}

		List<Date> dateList = new ArrayList<>();
		while (!lastDay.before(firstDay)) {
			dateList.add(lastDay);
			LocalDate lastDayL = lastDay.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().minusDays(1);
			lastDay = Date.from(lastDayL.atStartOfDay(ZoneId.systemDefault()).toInstant());
		}
		return dateList;
	}

	/**
	 * 근태통계 페이지
	 * 
	 * @author 최소희
	 * @param year
	 * @param month
	 * @param model
	 * @return admin/attendance/attendanceStatistics
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping(value = "/statistics")
	public String statistics(Integer year, Integer month, Model model) {

		DclzStatusVO dclzStatusVO = new DclzStatusVO();

		if (year == null || year == 0) {
			year = LocalDate.now().getYear();
		}
		if (month == null || month == 0) {
			month = LocalDate.now().getMonthValue();
		}

		LocalDate currentFirst = LocalDate.of(year, month, 1);
		LocalDate currentLast = LocalDate.of(year, month, currentFirst.lengthOfMonth()).plusDays(1);

		dclzStatusVO.setFirstDay(currentFirst);
		dclzStatusVO.setLastDay(currentLast);

		List<Date> dateList = getDateList(year, month);
		List<EmployeeVO> employeeList = employeeService.selectEmplListStatics();

		List<DclzStatusVO> allDataList = new ArrayList<DclzStatusVO>();

		// 날짜와 사원정보 넣기
		for (Date date : dateList) {
			for (EmployeeVO employeeVO : employeeList) {
				DclzStatusVO dsVO = new DclzStatusVO();
				dsVO.setDate(date);
				dsVO.setEmplNo(employeeVO.getEmplNo());
				dsVO.setEmplNm(employeeVO.getEmplNm());
				dsVO.setDeptNm(employeeVO.getDeptNm());
				dsVO.setClsfNm(employeeVO.getClassOfPositionVO().getClsfNm());
				allDataList.add(dsVO);
			}
		}

		List<DclzStatusVO> dclzStatusList = service.selectDclzList(dclzStatusVO); // emplNo 안 넣으면 모든 데이터

		// 보여질 모든 날짜와 테이블 합치기
		for (DclzStatusVO dsVO : allDataList) {
			for (DclzStatusVO dsVO2 : dclzStatusList) {
				LocalDate dsVODate = dsVO.getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				LocalDate dsVO2Date = dsVO2.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				if (dsVO2.getEmplNo() != 0 && dsVO.getEmplNo() == dsVO2.getEmplNo() && dsVO2.getAttendDt() != null
						&& dsVODate.equals(dsVO2Date)) {
					dsVO.setDclzNo(dsVO2.getDclzNo());
					dsVO.setEmplNo(dsVO2.getEmplNo());
					dsVO.setAttendDt(dsVO2.getAttendDt());
					dsVO.setLvffcDt(dsVO2.getLvffcDt());
					dsVO.setDclzPartclrNo(dsVO2.getDclzPartclrNo());
					dsVO.setBeginDt(dsVO2.getBeginDt());
					dsVO.setEndDt(dsVO2.getEndDt());
					dsVO.setDclzTypeCode(dsVO2.getDclzTypeCode());
					dsVO.setDclzNm(dsVO2.getDclzNm());
				}
			}
		}

		// 기본근무시간, 연장근무시간, 야근근무시간 구하기
		for (DclzStatusVO dsVO : allDataList) {
			if (dsVO.getAttendDt() != null && dsVO.getLvffcDt() != null) {
				LocalTime lvffcDt = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				LocalTime attendDt = dsVO.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				LocalTime sixPM = LocalTime.of(18, 0, 0);
				LocalTime tenPM = LocalTime.of(22, 0, 0);

				// 차이를 0h 0m 0s 형식으로 포맷팅
				// 기본 근무
				String defaultTime = attendanceController.getHMS(attendDt, lvffcDt);
				// 연장 근무
				String overTime = attendanceController.getHMS(sixPM, lvffcDt);
				// 야간 근무
				String nightTime = attendanceController.getHMS(tenPM, lvffcDt);

				dsVO.setDefaultTime(defaultTime);
				dsVO.setOverTime(overTime);
				dsVO.setNightTime(nightTime);

				// 휴일 근무
				LocalDate lvffcDt_LD = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				DayOfWeek dayOfWeek = lvffcDt_LD.getDayOfWeek();

				if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
					dsVO.setHolidayTime(defaultTime);
				}
			}
		}

		int attendanceUnchecked = 0;
		int departureUnchecked = 0;
		int tardiness = 0;
		int earlyDeparture = 0;
		int absence = 0;
		int businessTrip = 0;
		int fieldWork = 0;
		int vacation = 0;

		for (DclzStatusVO dsVO : allDataList) {

			LocalTime nineAM = LocalTime.of(9, 0); // 오전 9시
			LocalTime sixPM = LocalTime.of(18, 0); // 오후 6시

			if (dsVO.getAttendDt() == null || dsVO.getAttendDt().equals("")) {
				attendanceUnchecked++;
			}
			if (dsVO.getLvffcDt() == null || dsVO.getLvffcDt().equals("")) {
				departureUnchecked++;
			}
			if (dsVO.getAttendDt() != null && !dsVO.getAttendDt().equals("")) {
				LocalTime attendDt = dsVO.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				if (attendDt.isAfter(nineAM)) {
					tardiness++;
				}
			}
			if (dsVO.getLvffcDt() != null && !dsVO.getLvffcDt().equals("")) {
				LocalTime lvffcDt = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				if (lvffcDt.isBefore(sixPM)) {
					earlyDeparture++;
				}
			}
			if ((dsVO.getAttendDt() == null || dsVO.getAttendDt().equals(""))
					&& (dsVO.getDclzNm() == null || dsVO.getDclzNm().equals(""))) {
				absence++;
			}
			if (dsVO.getDclzNm() != null && !dsVO.getDclzNm().equals("")) {
				if (dsVO.getDclzNm().equals("출장")) {
					businessTrip++;
				}
				if (dsVO.getDclzNm().equals("외근")) {
					fieldWork++;
				}
				if (dsVO.getDclzNm().equals("휴가")) {
					vacation++;
				}
			}
		}

		model.addAttribute("year", year);
		model.addAttribute("month", String.format("%02d", month));

		model.addAttribute("allDataList", allDataList);

		model.addAttribute("attendanceUnchecked", attendanceUnchecked);
		model.addAttribute("departureUnchecked", departureUnchecked);
		model.addAttribute("tardiness", tardiness);
		model.addAttribute("earlyDeparture", earlyDeparture);
		model.addAttribute("absence", absence);
		model.addAttribute("businessTrip", businessTrip);
		model.addAttribute("fieldWork", fieldWork);
		model.addAttribute("vacation", vacation);

		return "admin/attendance/attendanceStatistics";
	}

	/**
	 * 근태통계에서 사원을 누르면 뜨는 회원 근태현황 데이터 보내는 프로세스
	 * 
	 * @author 최소희
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/detail", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> statisticsDetail(@RequestBody Map<String, Integer> map, Model model)
			throws Exception {
		int year = map.get("year");
		int month = map.get("month");
		int emplNo = map.get("emplNo");

		DclzStatusVO dclzStatusVO = new DclzStatusVO();
		dclzStatusVO.setEmplNo(emplNo);

		dclzStatusVO.setFirstDay(attendanceController.getFirstMonday(year, month));
		dclzStatusVO.setLastDay(attendanceController.getLastSunday(year, month));

		List<Date> dateList = attendanceController.getDateList(year, month);
		List<DclzStatusVO> dclzStatusList = service.selectDclzList(dclzStatusVO);
		List<DclzStatusVO> allDataList = new ArrayList<DclzStatusVO>();

		for (Date date : dateList) {
			DclzStatusVO dsVO = new DclzStatusVO();
			dsVO.setDate(date);
			allDataList.add(dsVO);
		}

		// 보여질 모든 날짜와 테이블 합치기
		for (DclzStatusVO dsVO : allDataList) {
			for (DclzStatusVO dsVO2 : dclzStatusList) {
				LocalDate dsVODate = dsVO.getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				LocalDate dsVO2Date = dsVO2.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				if (dsVO2.getAttendDt() != null && dsVODate.equals(dsVO2Date)) {
					dsVO.setDclzNo(dsVO2.getDclzNo());
					dsVO.setEmplNo(dsVO2.getEmplNo());
					dsVO.setAttendDt(dsVO2.getAttendDt());
					dsVO.setLvffcDt(dsVO2.getLvffcDt());
					dsVO.setDclzPartclrNo(dsVO2.getDclzPartclrNo());
					dsVO.setBeginDt(dsVO2.getBeginDt());
					dsVO.setEndDt(dsVO2.getEndDt());
					dsVO.setDclzTypeCode(dsVO2.getDclzTypeCode());
					dsVO.setDclzNm(dsVO2.getDclzNm());
				}
			}
		}

		// 기본근무시간, 연장근무시간, 야근근무시간 구하기
		for (DclzStatusVO dsVO : allDataList) {
			if (dsVO.getAttendDt() != null && dsVO.getLvffcDt() != null) {
				LocalTime lvffcDt = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				LocalTime attendDt = dsVO.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				LocalTime sixPM = LocalTime.of(18, 0, 0);
				LocalTime tenPM = LocalTime.of(22, 0, 0);

				// 차이를 0h 0m 0s 형식으로 포맷팅
				// 기본 근무
				String defaultTime = attendanceController.getHMS(attendDt, lvffcDt);
				// 연장 근무
				String overTime = attendanceController.getHMS(sixPM, lvffcDt);
				// 야간 근무
				String nightTime = attendanceController.getHMS(tenPM, lvffcDt);

				dsVO.setDefaultTime(defaultTime);
				dsVO.setOverTime(overTime);
				dsVO.setNightTime(nightTime);
			}
		}

		// 주당 근무시간 구하기
		List<String> weekDefaultList = attendanceController.getWeekTimeList(allDataList, "default");
		List<String> weekOverList = attendanceController.getWeekTimeList(allDataList, "over");

		// 이번주 리스트
		Date today = new Date();
		List<DclzStatusVO> thisWeekList = new ArrayList<DclzStatusVO>();

		for (int i = 0; i < allDataList.size(); i++) {
			LocalDate localToday = today.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate localDate = allDataList.get(i).getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			if (localToday.equals(localDate)) {
				int index = i + 1;
				int mod = index % 7;

				if (mod == 0) {
					for (int j = index - 7; j < index; j++) {
						thisWeekList.add(allDataList.get(j));
					}
				}
				else {
					for (int j = index - mod; j < index; j++) {
						thisWeekList.add(allDataList.get(j));
					}
				}
			}
		}

		// 이번주 누적 근무시간 구하기
		List<String> thisWeekDefaultList = attendanceController.getWeekTimeList(thisWeekList, "default");
		List<String> thisWeekOverList = attendanceController.getWeekTimeList(thisWeekList, "over");
		List<String> thisWeekNightList = attendanceController.getWeekTimeList(thisWeekList, "night");

		// 이번달 누적 근무시간 구하기
		String thisMonthDefault = attendanceController.getMonthTime(allDataList, "default");
		String thisMonthOver = attendanceController.getMonthTime(allDataList, "over");

		Map<String, Object> responseMap = new HashMap<>();

		responseMap.put("year", year);
		responseMap.put("month", String.format("%02d", month));
		responseMap.put("today", today);
		responseMap.put("allDataList", allDataList);
		responseMap.put("weekDefaultList", weekDefaultList);
		responseMap.put("weekOverList", weekOverList);
		responseMap.put("thisWeekDefault", thisWeekDefaultList.get(0));
		responseMap.put("thisWeekOver", thisWeekOverList.get(0));
		responseMap.put("thisNightOver", thisWeekNightList.get(0));
		responseMap.put("thisMonthDefault", thisMonthDefault);
		responseMap.put("thisMonthOver", thisMonthOver);

		ObjectMapper mapper = new ObjectMapper();
		String jsonResponse = mapper.writeValueAsString(responseMap);

		return new ResponseEntity<String>(jsonResponse, HttpStatus.OK);
	}

	@SuppressWarnings({
			"rawtypes", "unchecked"
	})
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping(value = "/longevity")
	public String longevityStatistics(Model model) {
		List<EmployeeVO> employeeList = employeeService.selectEmplListStatics();

		// 근속연수 구하기
		setlongevity(employeeList);

		// 전체평균 구하기
		int totalYears = 0;
		int totalMonths = 0;

		for (EmployeeVO employeeVO : employeeList) {
			String[] parts = employeeVO.getLongevity().split("년 |개월");
			int years = Integer.parseInt(parts[0]);
			int months = Integer.parseInt(parts[1]);

			totalYears += years;
			totalMonths += months;
		}

		int realTotalMonths = (totalYears * 12 + totalMonths) / employeeList.size();
		int averageYears = realTotalMonths / 12;
		int averageMonths = realTotalMonths % 12;

		String totalAverage = averageYears + "년 " + averageMonths + "개월";
		double numYears = averageYears + (double) averageMonths / 12;
		double totalAverageDouble = Math.round(numYears * 10) / 10.0;

		// 직급별 평균 구하기
		List<Map> clsfAverage = getAverage(employeeList, "clsf");
		Map<String, String> clsfStringMap = clsfAverage.get(0);
		Map<String, Double> clsfNumberMap = clsfAverage.get(1);
		
		// 부서별 평균 구하기
		List<Map> deptAverage = getAverage(employeeList, "dept");
		Map<String, String> deptStringMap = deptAverage.get(0);
		Map<String, Double> deptNumberMap = deptAverage.get(1);
		
		//기간별 사원수 구하기
		List<Integer> emplCnt = getCount(employeeList);

		model.addAttribute("employeeList", employeeList); // 근속연수 포함한 직원 리스트
		model.addAttribute("totalAverage", totalAverage); // 전체 평균  String
		model.addAttribute("totalAverageDouble", totalAverageDouble); // 전체 평균 Double
		model.addAttribute("clsfStringMap", clsfStringMap); // 직급별 평균 String Nm으로 꺼내기
		model.addAttribute("clsfNumberMap", clsfNumberMap); // 직급별 평균 Double Nm으로 꺼내기
		model.addAttribute("deptStringMap", deptStringMap); // 부서별 평균 String Nm으로 꺼내기
		model.addAttribute("deptNumberMap", deptNumberMap); // 부서별 평균 Double Nm으로 꺼내기
		model.addAttribute("emplCnt", emplCnt);

		return "admin/attendance/longevityStatistics";
	}

	// 근속연수 구해서 set하기
	public void setlongevity(List<EmployeeVO> employeeList) {
		for (EmployeeVO employeeVO : employeeList) {
			LocalDate emplEncpn = employeeVO.getEmplEncpn().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate today = LocalDate.now();

			// 날짜 차이 계산
			long diffInDays = ChronoUnit.DAYS.between(emplEncpn, today);

			// 날짜를 년, 월, 일로 변환
			long years = diffInDays / 365; // 1년은 365일
			long remainingDays = diffInDays % 365;
			long months = remainingDays / 30; // 한달은 평균 30일
			long days = remainingDays % 30;

			String longevityString = years + "년 " + months + "개월";
			employeeVO.setLongevity(longevityString);
			
			double numYears = years + (double) months / 12;
			double roundedTotalYears = Math.round(numYears * 10) / 10.0; // 소수점 첫째 자리까지 반올림
			employeeVO.setLongevityDouble(roundedTotalYears);
		}
	}

	// 부서, 직급별 근속연수 구하기 list.get(0) = 0년 0개월, list.get(1) = 0.0
	@SuppressWarnings("rawtypes")
	public List<Map> getAverage(List<EmployeeVO> employeeList, String type) {

		Map<String, String> stringMap = new HashMap<String, String>(); // 0년 0개월
		Map<String, Double> numberMap = new HashMap<String, Double>(); // 0.0
		List<Map> averageList = new ArrayList<Map>();

		switch (type) {

		case "dept":

			List<EmployeeVO> deptList = employeeService.selectDeptList();

			for (EmployeeVO employeeVO : deptList) {

				int totalYears = 0;
				int totalMonths = 0;
				int cnt = 0; // 해당 타입의 개수

				for (EmployeeVO employeeVO2 : employeeList) {

					if (employeeVO.getDeptNm().equals(employeeVO2.getDeptNm())) {

						String[] parts = employeeVO2.getLongevity().split("년 |개월");
						int years = Integer.parseInt(parts[0]);
						int months = Integer.parseInt(parts[1]);

						totalYears += years;
						totalMonths += months;
						cnt++;
					}
				}

				if (cnt != 0) {
					int realTotalMonths = (totalYears * 12 + totalMonths) / cnt;
					int averageYears = realTotalMonths / 12;
					int averageMonths = realTotalMonths % 12;

					String totalAverage = averageYears + "년 " + averageMonths + "개월";
					stringMap.put(employeeVO.getDeptNm(), totalAverage);

					double numYears = averageYears + (double) averageMonths / 12;
					double roundedTotalYears = Math.round(numYears * 10) / 10.0; // 소수점 첫째 자리까지 반올림
					numberMap.put(employeeVO.getDeptNm(), roundedTotalYears);

				}

			}
			averageList.add(stringMap);
			averageList.add(numberMap);

			break;

		case "clsf":

			List<ClassOfPositionVO> clsfList = employeeService.selectClsfList();

			for (ClassOfPositionVO classOfPositionVO : clsfList) {

				int totalYears = 0;
				int totalMonths = 0;
				int cnt = 0; // 해당 타입의 개수

				for (EmployeeVO employeeVO2 : employeeList) {

					if (classOfPositionVO.getClsfNm().equals(employeeVO2.getClassOfPositionVO().getClsfNm())) {

						String[] parts = employeeVO2.getLongevity().split("년 |개월");
						int years = Integer.parseInt(parts[0]);
						int months = Integer.parseInt(parts[1]);

						totalYears += years;
						totalMonths += months;
						cnt++;
					}
				}

				if (cnt != 0) {
					int realTotalMonths = (totalYears * 12 + totalMonths) / cnt;
					int averageYears = realTotalMonths / 12;
					int averageMonths = realTotalMonths % 12;

					String totalAverage = averageYears + "년 " + averageMonths + "개월";
					stringMap.put(classOfPositionVO.getClsfNm(), totalAverage);

					double numYears = averageYears + (double) averageMonths / 12;
					double roundedTotalYears = Math.round(numYears * 10) / 10.0; // 소수점 첫째 자리까지 반올림
					numberMap.put(classOfPositionVO.getClsfNm(), roundedTotalYears);

				}
			}
			averageList.add(stringMap);
			averageList.add(numberMap);

			break;

		}

		return averageList;
	}
	
	// 기간별 사원수 구하기
	public List<Integer> getCount(List<EmployeeVO> employeeList) {
		
		List<Integer> emplCnt = new ArrayList<Integer>();
		
		int lg1 = 0;
		int lg3 = 0;
		int lg5 = 0;
		int lg10 = 0;
		int lg15 = 0;
		int lgMore = 0;
		
		for (EmployeeVO employeeVO : employeeList) {
			if(employeeVO.getLongevityDouble() < 1) {
				lg1++;
			}else if(employeeVO.getLongevityDouble() < 3) {
				lg3++;
			}else if(employeeVO.getLongevityDouble() < 5) {
				lg5++;
			}else if(employeeVO.getLongevityDouble() < 10) {
				lg10++;
			}else if(employeeVO.getLongevityDouble() < 15) {
				lg15++;
			}else {
				lgMore++;
			}
		}
		
		emplCnt.add(lg1);
		emplCnt.add(lg3);
		emplCnt.add(lg5);
		emplCnt.add(lg10);
		emplCnt.add(lg15);
		emplCnt.add(lgMore);
		
		return emplCnt;
	}
	
	/**
	 * 근태관리 페이지
	 * 
	 * @author 최소희
	 * @param year
	 * @param month
	 * @param model
	 * @return admin/attendance/attendanceManagement
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping(value = "/management")
	public String management(Integer year, Integer month, Model model) {

		DclzStatusVO dclzStatusVO = new DclzStatusVO();

		if (year == null || year == 0) {
			year = LocalDate.now().getYear();
		}
		if (month == null || month == 0) {
			month = LocalDate.now().getMonthValue();
		}

		LocalDate currentFirst = LocalDate.of(year, month, 1);
		LocalDate currentLast = LocalDate.of(year, month, currentFirst.lengthOfMonth()).plusDays(1);

		dclzStatusVO.setFirstDay(currentFirst);
		dclzStatusVO.setLastDay(currentLast);

		List<Date> dateList = getDateList(year, month);
		List<EmployeeVO> employeeList = employeeService.selectEmplListStatics();

		List<DclzStatusVO> allDataList = new ArrayList<DclzStatusVO>();

		// 날짜와 사원정보 넣기
		for (Date date : dateList) {
			for (EmployeeVO employeeVO : employeeList) {
				DclzStatusVO dsVO = new DclzStatusVO();
				dsVO.setDate(date);
				dsVO.setEmplNo(employeeVO.getEmplNo());
				dsVO.setEmplNm(employeeVO.getEmplNm());
				dsVO.setDeptNm(employeeVO.getDeptNm());
				dsVO.setClsfNm(employeeVO.getClassOfPositionVO().getClsfNm());
				allDataList.add(dsVO);
			}
		}

		List<DclzStatusVO> dclzStatusList = service.selectDclzList(dclzStatusVO); // emplNo 안 넣으면 모든 데이터

		// 보여질 모든 날짜와 테이블 합치기
		for (DclzStatusVO dsVO : allDataList) {
			for (DclzStatusVO dsVO2 : dclzStatusList) {
				LocalDate dsVODate = dsVO.getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				LocalDate dsVO2Date = dsVO2.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				if (dsVO2.getEmplNo() != 0 && dsVO.getEmplNo() == dsVO2.getEmplNo() && dsVO2.getAttendDt() != null
						&& dsVODate.equals(dsVO2Date)) {
					dsVO.setDclzNo(dsVO2.getDclzNo());
					dsVO.setEmplNo(dsVO2.getEmplNo());
					dsVO.setAttendDt(dsVO2.getAttendDt());
					dsVO.setLvffcDt(dsVO2.getLvffcDt());
					dsVO.setDclzPartclrNo(dsVO2.getDclzPartclrNo());
					dsVO.setBeginDt(dsVO2.getBeginDt());
					dsVO.setEndDt(dsVO2.getEndDt());
					dsVO.setDclzTypeCode(dsVO2.getDclzTypeCode());
					dsVO.setDclzNm(dsVO2.getDclzNm());
				}
			}
		}

		// 기본근무시간, 연장근무시간, 야근근무시간 구하기
		for (DclzStatusVO dsVO : allDataList) {
			if (dsVO.getAttendDt() != null && dsVO.getLvffcDt() != null) {
				LocalTime lvffcDt = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				LocalTime attendDt = dsVO.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				LocalTime sixPM = LocalTime.of(18, 0, 0);
				LocalTime tenPM = LocalTime.of(22, 0, 0);

				// 차이를 0h 0m 0s 형식으로 포맷팅
				// 기본 근무
				String defaultTime = attendanceController.getHMS(attendDt, lvffcDt);
				// 연장 근무
				String overTime = attendanceController.getHMS(sixPM, lvffcDt);
				// 야간 근무
				String nightTime = attendanceController.getHMS(tenPM, lvffcDt);

				dsVO.setDefaultTime(defaultTime);
				dsVO.setOverTime(overTime);
				dsVO.setNightTime(nightTime);

				// 휴일 근무
				LocalDate lvffcDt_LD = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				DayOfWeek dayOfWeek = lvffcDt_LD.getDayOfWeek();

				if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
					dsVO.setHolidayTime(defaultTime);
				}
			}
		}

		int attendanceUnchecked = 0;
		int departureUnchecked = 0;
		int tardiness = 0;
		int earlyDeparture = 0;
		int absence = 0;
		int businessTrip = 0;
		int fieldWork = 0;
		int vacation = 0;

		for (DclzStatusVO dsVO : allDataList) {

			LocalTime nineAM = LocalTime.of(9, 0); // 오전 9시
			LocalTime sixPM = LocalTime.of(18, 0); // 오후 6시

			if (dsVO.getAttendDt() == null || dsVO.getAttendDt().equals("")) {
				attendanceUnchecked++;
			}
			if (dsVO.getLvffcDt() == null || dsVO.getLvffcDt().equals("")) {
				departureUnchecked++;
			}
			if (dsVO.getAttendDt() != null && !dsVO.getAttendDt().equals("")) {
				LocalTime attendDt = dsVO.getAttendDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				if (attendDt.isAfter(nineAM)) {
					tardiness++;
				}
			}
			if (dsVO.getLvffcDt() != null && !dsVO.getLvffcDt().equals("")) {
				LocalTime lvffcDt = dsVO.getLvffcDt().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
				if (lvffcDt.isBefore(sixPM)) {
					earlyDeparture++;
				}
			}
			if ((dsVO.getAttendDt() == null || dsVO.getAttendDt().equals(""))
					&& (dsVO.getDclzNm() == null || dsVO.getDclzNm().equals(""))) {
				absence++;
			}
			if (dsVO.getDclzNm() != null && !dsVO.getDclzNm().equals("")) {
				if (dsVO.getDclzNm().equals("출장")) {
					businessTrip++;
				}
				if (dsVO.getDclzNm().equals("외근")) {
					fieldWork++;
				}
				if (dsVO.getDclzNm().equals("휴가")) {
					vacation++;
				}
			}
		}

		model.addAttribute("year", year);
		model.addAttribute("month", String.format("%02d", month));

		model.addAttribute("allDataList", allDataList);

		model.addAttribute("attendanceUnchecked", attendanceUnchecked);
		model.addAttribute("departureUnchecked", departureUnchecked);
		model.addAttribute("tardiness", tardiness);
		model.addAttribute("earlyDeparture", earlyDeparture);
		model.addAttribute("absence", absence);
		model.addAttribute("businessTrip", businessTrip);
		model.addAttribute("fieldWork", fieldWork);
		model.addAttribute("vacation", vacation);

		return "admin/attendance/attendanceManagement";
	}
	
	/**
	 * 근태관리 수정 프로세스
	 * 
	 * @author 최소희 
	 * @param dclzStatusVO
	 * @param ra
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/update")
	public String update(DclzStatusVO dclzStatusVO, RedirectAttributes ra) throws Exception {
		
		LocalDateTime attendDtL = LocalDateTime.parse(dclzStatusVO.getAttendDtString());
		Date attendDt = Date.from(attendDtL.atZone(ZoneId.systemDefault()).toInstant());
		dclzStatusVO.setAttendDt(attendDt);
		
		if(dclzStatusVO.getLvffcDtString() != null && !dclzStatusVO.getLvffcDtString().equals("")) {
			LocalDateTime lvffcDtL = LocalDateTime.parse(dclzStatusVO.getLvffcDtString());
			Date lvffcDt = Date.from(lvffcDtL.atZone(ZoneId.systemDefault()).toInstant());
			dclzStatusVO.setLvffcDt(lvffcDt);
		}
        
		Result result = service.updateTime(dclzStatusVO);
		
		if(result.equals(Result.OK)) {
			ra.addFlashAttribute("message","수정이 완료되었습니다!");
			return "redirect:management";
		}else {
			ra.addFlashAttribute("message","수정이 실패하였습니다!");
			return "redirect:management";
		}
	}
}
