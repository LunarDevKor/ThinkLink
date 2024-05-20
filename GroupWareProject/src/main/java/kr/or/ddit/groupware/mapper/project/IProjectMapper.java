package kr.or.ddit.groupware.mapper.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PrjctSchdulVO;
import kr.or.ddit.groupware.vo.ProjectReportVO;
import kr.or.ddit.groupware.vo.ProjectVO;

/**
 * 프로젝트 SQL Mapper
 * @author 권예은
 * @version 1.0
 * @see IProjectMapper
 */
public interface IProjectMapper {

	List<ProjectVO> selectProjectListByEmplNo(int emplNo);
	List<ProjectVO> selectAvailableProjectListByEmplNo(int emplNo);
	List<Integer> selectProjectParticipant(int projectNo);
	List<PrjctSchdulVO> selectprjctSchdulListByemplNo(int emplNo);
	List<EmployeeVO> selectPrjctPrtcpntListByPrjcrNo(int prjctNo);
	List<ProjectReportVO> selectPrjctReprtListByPrjctNo(Map<String, Object> map);
	void insertProject(Map<String, Object> param);
	void insertProjectParticipant(Map<String, Object> param);
	void insertProjectReport(ProjectReportVO prjctRept);
	ProjectVO selectProjectByPrjctNo(Map<String, Object> map);
	ProjectReportVO selectPrjctReptByReptNo(int prjctReprtNo);
	List<ProjectVO> selectProjectListForChart(ProjectVO projectVO);

}
