package kr.or.ddit.groupware.service.schedule;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.groupware.mapper.schedule.IScheduleMapper;
import kr.or.ddit.groupware.vo.ScheduleVO;

/**
 * 일정 관리 서비스 구현체
 * @author 권예은
 * @version 1.0
 * @see ScheduleServiceImpl
 */
@Service
public class ScheduleServiceImpl implements IScheduleService{

	@Inject
	private IScheduleMapper scheduleMapper;
	
	@Override
	public ScheduleVO selectScheduleBySchdulNo(String schdulNo) {
		return scheduleMapper.selectScheduleBySchdulNo(schdulNo);
	}

	@Override
	public List<ScheduleVO> selectScheduleListByEmplNoNDate(Map<String, Object> paramMap) {
		return scheduleMapper.selectScheduleListByEmplNoNDate(paramMap);
	}

	/**
	 * schdulGroup에서 해당 데이터 찾아 없으면 insert 후 schdulGroupNo 리턴 
	 */
	@Override
	public int selectSchdulGroupNo(Map<String, Object> param) {
		Integer schdulGroupNo =  scheduleMapper.selectSchdulGroupNo(param);
		if(schdulGroupNo == null) {
			scheduleMapper.insertSchdulGroup(param);
			schdulGroupNo =  scheduleMapper.selectSchdulGroupNo(param);
		}
		return schdulGroupNo;
	}

	@Override
	public int insertSchdul(Map<String, Object> param) {
		scheduleMapper.insertSchdul(param);
		int schdulNo = (int) param.get("schdulNo");
		
		return schdulNo;
	}

	/**
	 * SchGroupInclude에 insert
	 */
	@Override
	public void insertSchGroupInclude(Map<String, Object> param) {
		int schdulGroupNo = selectSchdulGroupNo(param);
		param.put("schdulGroupNo", schdulGroupNo+"");
		scheduleMapper.insertSchGroupInclude(param);
	}

	@Override
	public void insertSchdulParticipant(Map<String, Object> param) {
		scheduleMapper.insertSchdulParticipant(param);
	}

	/**
	 * 공통코드 테이블에서 하위 부서 리스트 출력
	 */
	@Override
	public List<String> selectLowerDept(String deptCode) {
		return scheduleMapper.selectLowerDept(deptCode);
	}

	@Override
	public List<ScheduleVO> selectScheduleList(Map<String, Object> map) {
		return scheduleMapper.selectScheduleList(map);
	}

	@Override
	public List<Integer> selectParticipant(String schdulNo) {
		return scheduleMapper.selectParticipant(schdulNo);
	}

	@Override
	public String selectDeptNm(String deptCode) {
		return scheduleMapper.selectDeptNm(deptCode);
	}

	@Override
	public String selectProjectNm(String prjctNo) {
		return scheduleMapper.selectProjectNm(prjctNo);
	}

	@Transactional
	@Override
	public void deleteSchdul(int schdulNo) {
		scheduleMapper.deleteSchdulParticipant(schdulNo);
		scheduleMapper.deleteSchGroupInclude(schdulNo);
		scheduleMapper.deleteSchdul(schdulNo);
	}

	@Override
	public String getColorCode(String bgrnColorName) {
		return scheduleMapper.getColorCode(bgrnColorName);
	}

	@Override
	public void updateSchdul(Map<String, Object> param, ArrayList<Integer> attendeeList) {
		scheduleMapper.updateSchdul(param);
		
		if(attendeeList == null) {
			return;
		}
		
		int schdulNo = Integer.parseInt((String)param.get("schdulNo"));
		scheduleMapper.deleteSchdulParticipant(schdulNo);
		for(int emplNo : attendeeList) {
			param.put("emplNo", emplNo);
			scheduleMapper.insertSchdulParticipant(param);
		}
	}

}
