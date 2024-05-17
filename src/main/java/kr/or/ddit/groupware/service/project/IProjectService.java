package kr.or.ddit.groupware.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PrjctSchdulVO;
import kr.or.ddit.groupware.vo.ProjectReportVO;
import kr.or.ddit.groupware.vo.ProjectVO;

/**
 * 프로젝트 서비스 인터페이스
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see IProjectService
 */
public interface IProjectService {

	List<ProjectVO> selectProjectListByEmplNo(int emplNo);
	List<ProjectVO> selectAvailableProjectListByEmplNo(int emplNo);
	List<Integer> selectProjectParticipant(int projectNo);
	List<PrjctSchdulVO> selectprjctSchdulListByemplNo(int emplNo);
	List<EmployeeVO> selectPrjctPrtcpntListByPrjcrNo(int prjctNo);
	List<ProjectReportVO> selectPrjctReprtListByPrjctNo(int prjctNo, String wd);
	int insertProject(Map<String, Object> param);
	void insertProjectParticipant(Map<String, Object> param);
	void insertProjectReport(ProjectReportVO prjctRept);
	ProjectVO selectProjectByPrjctNo(int prjctNo, int emplNo);
	ProjectReportVO selectPrjctReptByReptNo(int prjctReprtNo);
	List<ProjectVO> selectProjectListForChart(ProjectVO projectVO);

}
