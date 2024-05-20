package kr.or.ddit.groupware.service.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.project.IProjectMapper;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PrjctSchdulVO;
import kr.or.ddit.groupware.vo.ProjectReportVO;
import kr.or.ddit.groupware.vo.ProjectVO;

/**
 * 프로젝트 서비스 구현체
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see ProjectServiceImpl
 */
@Service
public class ProjectServiceImpl implements IProjectService {

	@Inject
	IProjectMapper projectMapper;
	
	@Override
	public List<ProjectVO> selectProjectListByEmplNo(int emplNo) {
		return projectMapper.selectProjectListByEmplNo(emplNo);
	}

	@Override
	public List<ProjectVO> selectAvailableProjectListByEmplNo(int emplNo) {
		return projectMapper.selectAvailableProjectListByEmplNo(emplNo);
	}

	@Override
	public List<Integer> selectProjectParticipant(int projectNo) {
		return projectMapper.selectProjectParticipant(projectNo);
	}

	@Override
	public List<PrjctSchdulVO> selectprjctSchdulListByemplNo(int emplNo) {
		return projectMapper.selectprjctSchdulListByemplNo(emplNo);
	}

	@Override
	public List<EmployeeVO> selectPrjctPrtcpntListByPrjcrNo(int prjctNo) {
		return projectMapper.selectPrjctPrtcpntListByPrjcrNo(prjctNo);
	}

	@Override
	public List<ProjectReportVO> selectPrjctReprtListByPrjctNo(int prjctNo, String wd) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjctNo", prjctNo);
		map.put("wd", wd);
		return projectMapper.selectPrjctReprtListByPrjctNo(map);
	}

	@Override
	public int insertProject(Map<String, Object> param) {
		projectMapper.insertProject(param);
		int prjctNo = (int) param.get("prjctNo");
		return prjctNo;
	}

	@Override
	public void insertProjectParticipant(Map<String, Object> param) {
		projectMapper.insertProjectParticipant(param);
	}

	@Override
	public void insertProjectReport(ProjectReportVO prjctRept) {
		projectMapper.insertProjectReport(prjctRept);
	}

	@Override
	public ProjectVO selectProjectByPrjctNo(int prjctNo, int emplNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjctNo", prjctNo);
		map.put("emplNo", emplNo);
		return projectMapper.selectProjectByPrjctNo(map);
	}

	@Override
	public ProjectReportVO selectPrjctReptByReptNo(int prjctReprtNo) {
		return projectMapper.selectPrjctReptByReptNo(prjctReprtNo);
	}

	@Override
	public List<ProjectVO> selectProjectListForChart(ProjectVO projectVO) {
		return projectMapper.selectProjectListForChart(projectVO);
	}


}
