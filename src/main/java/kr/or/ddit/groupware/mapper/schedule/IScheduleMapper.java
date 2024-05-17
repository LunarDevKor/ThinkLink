package kr.or.ddit.groupware.mapper.schedule;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.ScheduleVO;

/**
 * 일정 관리 SQL Mapper
 * @author 권예은
 * @version 1.0
 * @see IScheduleMapper
 */
public interface IScheduleMapper {

	ScheduleVO selectScheduleBySchdulNo(String schdulNo);
	List<ScheduleVO> selectScheduleListByEmplNoNDate(Map<String, Object> paramMap);
	Integer selectSchdulGroupNo(Map<String, Object> param);
	void insertSchdulGroup(Map<String, Object> param);
	void insertSchdul(Map<String, Object> param);
	void insertSchGroupInclude(Map<String, Object> param);
	void insertSchdulParticipant(Map<String, Object> param);
	List<String> selectLowerDept(String deptCode);
	List<ScheduleVO> selectScheduleList(Map<String, Object> map);
	List<Integer> selectParticipant(String schdulNo);
	String selectDeptNm(String deptCode);
	String selectProjectNm(String prjctNo);
	void deleteSchdulParticipant(int schdulNo);
	void deleteSchGroupInclude(int schdulNo);
	void deleteSchdul(int schdulNo);
	String getColorCode(String bgrnColorName);
	void updateSchdul(Map<String, Object> param);

}
