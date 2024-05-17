package kr.or.ddit.groupware.controller.attendance;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.groupware.service.attendance.IAttendanceService;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DclzStatusVO;
import kr.or.ddit.groupware.vo.EmployeeVO;

/**
 * 근태 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see AttendanceController
 */
@Controller
@RequestMapping("/attendance")
public class AttendanceController {

	@Inject
	private IAttendanceService service;

	// 해당 월의 시작날짜와 마지막날짜의 리스트
	public List<Date> getDateList(int year, int month) {
		// 2024-04-01
		LocalDate currentFirst = LocalDate.of(year, month, 1);
		// 2024-04 마지막날
		LocalDate currentLast = LocalDate.of(year, month, currentFirst.lengthOfMonth());
		// 4월 1일이 속한 주의 월요일 날짜
		LocalDate firstMondayOri = currentFirst.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)); // 해당 주의 월요일
		Date firstMonday = Date.from(firstMondayOri.atStartOfDay(ZoneId.systemDefault()).toInstant());
		// 4월의 마지막날이 속한 주의 일요일 날짜
		LocalDate lastSundayOri = currentLast.with(DayOfWeek.SUNDAY);
		Date lastSunday = Date.from(lastSundayOri.atStartOfDay(ZoneId.systemDefault()).toInstant());

		List<Date> dateList = new ArrayList<>();
		while (!firstMonday.after(lastSunday)) {
			dateList.add(firstMonday);
			LocalDate firstMondayL = firstMonday.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().plusDays(1);
			firstMonday = Date.from(firstMondayL.atStartOfDay(ZoneId.systemDefault()).toInstant());
		}
		return dateList;
	}

	// 해당 월의 1일이 속한 주의 월요일 날짜
	public LocalDate getFirstMonday(int year, int month) {
		LocalDate currentFirst = LocalDate.of(year, month, 1);
		LocalDate firstMonday = currentFirst.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
		return firstMonday;
	}

	// 해당 월의 마지막날짜가 속한 주의 일요일 날짜 + 1
	public LocalDate getLastSunday(int year, int month) {
		LocalDate currentFirst = LocalDate.of(year, month, 1);
		LocalDate currentLast = LocalDate.of(year, month, currentFirst.lengthOfMonth());
		LocalDate lastSunday = currentLast.with(DayOfWeek.SUNDAY).plusDays(1);
		return lastSunday;
	}

	// 근무시간 구하기
	public String getHMS(LocalTime time1, LocalTime time2) {
		long hour = Duration.between(time1, time2).getSeconds() / 3600;
		long min = (Duration.between(time1, time2).getSeconds() - hour * 3600) / 60;
		long sec = (Duration.between(time1, time2).getSeconds() - hour * 3600 - min * 60) % 60;

		if (sec < 0 || min < 0 || hour < 0) {
			hour = 0;
			min = 0;
			sec = 0;
		}

		// 결과를 0h 0m 0s 형식으로 포맷팅
		return String.format("%dh %dm %ds", hour, min, sec);
	}

	// 주간 누적 구하기
	public List<String> getWeekTimeList(List<DclzStatusVO> dataList, String type) {

		List<String> weekTimeList = new ArrayList<String>();

		int listSize = 0;
		int forSize = 0;

		if (dataList.size() < 7) {
			listSize = 1;
		}
		else {
			listSize = dataList.size() / 7;
		}

		for (int i = 0; i < listSize; i++) {

			if (dataList.size() < 7) {
				forSize = dataList.size();
			}
			else {
				forSize = (i + 1) * 7;
			}

			int totalHours = 0;
			int totalMinutes = 0;
			int totalSeconds = 0;
			String totalWeekTime = null;

			for (int j = i * 7; j < forSize; j++) {

				String time = dataList.get(j).getDefaultTime();

				switch (type) {
				case "default": // 기본누적
					time = dataList.get(j).getDefaultTime();
					break;
				case "over": // 연장누적
					time = dataList.get(j).getOverTime();
					break;
				case "night": // 야간누적
					time = dataList.get(j).getNightTime();
					break;
				default: // 기본누적
					time = dataList.get(j).getDefaultTime();
					break;
				}
				if (time != null && !time.trim().equals("")) {
					String[] parts = time.split("\\s+");

					int hours = Integer.parseInt(parts[0].replace("h", ""));
					int minutes = Integer.parseInt(parts[1].replace("m", ""));
					int seconds = Integer.parseInt(parts[2].replace("s", ""));

					totalHours += hours;
					totalMinutes += minutes;
					totalSeconds += seconds;

					// 분이 60분을 넘으면 시간에 추가
					if (totalMinutes >= 60) {
						totalHours += totalMinutes / 60;
						totalMinutes %= 60;
					}
					// 초가 60초를 넘으면 분에 추가
					if (totalSeconds >= 60) {
						totalMinutes += totalSeconds / 60;
						totalSeconds %= 60;
					}
				}
			}
			totalWeekTime = totalHours + "h " + totalMinutes + "m " + totalSeconds + "s";
			weekTimeList.add(totalWeekTime);
		}

		if (weekTimeList == null || weekTimeList.size() == 0) {
			weekTimeList.add("0h 0m 0s");
		}
		return weekTimeList;
	}

	// 한달 누적 구하기
	public String getMonthTime(List<DclzStatusVO> dataList, String type) {

		int totalHours = 0;
		int totalMinutes = 0;
		int totalSeconds = 0;
		String totalMonthTime = null;

		for (int i = 0; i < dataList.size(); i++) {

			String time = dataList.get(i).getDefaultTime();

			switch (type) {
			case "default": // 기본누적
				time = dataList.get(i).getDefaultTime();
				break;
			case "over": // 연장누적
				time = dataList.get(i).getOverTime();
				break;
			case "night": // 야간누적
				time = dataList.get(i).getNightTime();
				break;
			default: // 기본누적
				time = dataList.get(i).getDefaultTime();
				break;
			}
			if (time != null && !time.trim().equals("")) {
				String[] parts = time.split("\\s+");

				int hours = Integer.parseInt(parts[0].replace("h", ""));
				int minutes = Integer.parseInt(parts[1].replace("m", ""));
				int seconds = Integer.parseInt(parts[2].replace("s", ""));

				totalHours += hours;
				totalMinutes += minutes;
				totalSeconds += seconds;

				// 분이 60분을 넘으면 시간에 추가
				if (totalMinutes >= 60) {
					totalHours += totalMinutes / 60;
					totalMinutes %= 60;
				}
				// 초가 60초를 넘으면 분에 추가
				if (totalSeconds >= 60) {
					totalMinutes += totalSeconds / 60;
					totalSeconds %= 60;
				}
			}
			totalMonthTime = totalHours + "h " + totalMinutes + "m " + totalSeconds + "s";
		}

		if (totalMonthTime == null || totalMonthTime.trim().equals("")) {
			totalMonthTime = "0h 0m 0s";
		}
		return totalMonthTime;
	}

	/**
	 * 근태통계 페이지
	 * 
	 * @author 최소희
	 * @param year
	 * @param month
	 * @param model
	 * @return attendance/status
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/status")
	public String attendanceStatus(Integer year, Integer month, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		DclzStatusVO dclzStatusVO = new DclzStatusVO();
		dclzStatusVO.setEmplNo(emplNo);

		if (year == null || year == 0) {
			year = LocalDate.now().getYear();
		}
		if (month == null || month == 0) {
			month = LocalDate.now().getMonthValue();
		}

		dclzStatusVO.setFirstDay(getFirstMonday(year, month));
		dclzStatusVO.setLastDay(getLastSunday(year, month));

		List<Date> dateList = getDateList(year, month);
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
				String defaultTime = getHMS(attendDt, lvffcDt);
				// 연장 근무
				String overTime = getHMS(sixPM, lvffcDt);
				// 야간 근무
				String nightTime = getHMS(tenPM, lvffcDt);

				dsVO.setDefaultTime(defaultTime);
				dsVO.setOverTime(overTime);
				dsVO.setNightTime(nightTime);
			}
		}

		// 주당 근무시간 구하기
		List<String> weekDefaultList = getWeekTimeList(allDataList, "default");
		List<String> weekOverList = getWeekTimeList(allDataList, "over");

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
		List<String> thisWeekDefaultList = getWeekTimeList(thisWeekList, "default");
		List<String> thisWeekOverList = getWeekTimeList(thisWeekList, "over");
		List<String> thisWeekNightList = getWeekTimeList(thisWeekList, "night");

		// 이번달 누적 근무시간 구하기
		String thisMonthDefault = getMonthTime(allDataList, "default");
		String thisMonthOver = getMonthTime(allDataList, "over");

		model.addAttribute("user", userVO);
		model.addAttribute("year", year);
		model.addAttribute("month", String.format("%02d", month));
		model.addAttribute("today", today);
		model.addAttribute("allDataList", allDataList);
		model.addAttribute("weekDefaultList", weekDefaultList);
		model.addAttribute("weekOverList", weekOverList);
		model.addAttribute("thisWeekDefault", thisWeekDefaultList.get(0));
		model.addAttribute("thisWeekOver", thisWeekOverList.get(0));
		model.addAttribute("thisNightOver", thisWeekNightList.get(0));
		model.addAttribute("thisMonthDefault", thisMonthDefault);
		model.addAttribute("thisMonthOver", thisMonthOver);

		return "attendance/status";
	}

	/**
	 * 오늘 날짜 데이터로 이동하는 프로세스
	 * 
	 * @author 최소희
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/today")
	public ResponseEntity<Integer> today() {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		DclzStatusVO dclzStatusVO = new DclzStatusVO();
		dclzStatusVO.setEmplNo(emplNo);

		int year = LocalDate.now().getYear();
		int month = LocalDate.now().getMonthValue();

		dclzStatusVO.setFirstDay(getFirstMonday(year, month));
		dclzStatusVO.setLastDay(getLastSunday(year, month));

		List<Date> dateList = getDateList(year, month);
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

		Date today = new Date();
		int num = 0;

		for (int i = 0; i < allDataList.size(); i++) {
			LocalDate localToday = today.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate localDate = allDataList.get(i).getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			if (localToday.equals(localDate)) {
				int index = i + 1;
				int mod = index % 7;
				if (mod == 0) {
					num = index / 7;
				}
				else {
					num = index / 7 + 1;
				}
			}
		}
		return new ResponseEntity<Integer>(num, HttpStatus.OK);
	}
}
