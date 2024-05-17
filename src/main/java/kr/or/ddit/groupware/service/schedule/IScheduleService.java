package kr.or.ddit.groupware.service.schedule;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.ScheduleVO;

/**
 * 일정 관리 서비스 인터페이스
 * @author 권예은
 * @version 1.0
 * @see IScheduleService
 */
public interface IScheduleService {

	ScheduleVO selectScheduleBySchdulNo(String schdulNo);
	List<ScheduleVO> selectScheduleListByEmplNoNDate(Map<String, Object> paramMap);
	int selectSchdulGroupNo(Map<String, Object> param);
	int insertSchdul(Map<String, Object> param);
	void insertSchGroupInclude(Map<String, Object> param);
	void insertSchdulParticipant(Map<String, Object> param);
	List<String> selectLowerDept(String deptCode);
	List<ScheduleVO> selectScheduleList(Map<String, Object> map);
	List<Integer> selectParticipant(String schdulNo);
	String selectDeptNm(String deptCode);
	String selectProjectNm(String prjctNo);
	void deleteSchdul(int schdulNo);
	String getColorCode(String bgrnColorName);
	void updateSchdul(Map<String, Object> param, ArrayList<Integer> attendeeList);

}
