package kr.or.ddit.groupware.service.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.TaskVO;

/**
 * Task 서비스 인터페이스
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see ITaskService
 */
public interface ITaskService {

	List<TaskVO> getTaskListByProject(ProjectVO project);
	List<TaskVO> selectOngoingTaskListByEmplNo(int emplNo, String status);
	TaskVO selectTaskByTaskNo(Map<String, Object> map);
	List<TaskVO> selectTaskListByPrjctNo(int prjctNo);
	int selectTaskCountByStatusNPrjctNo(int prjctNo, String status);
	HashMap<Object, Object> selectEnddeCnt(int prjctNo);
	Map<Integer, List<TaskVO>> selectTaskMapByPrjctNo(int prjctNo);
	void insertProjectTask(TaskVO task);
	void updateTaskProgrs(TaskVO task);
	List<TaskVO> selectProjectTaskTypeList(TaskVO taskVO);
	List<TaskVO> selectProjectTaskDetailList(TaskVO taskVO);
	TaskVO selectProjectTaskCountForEmployee(TaskVO taskVO);
	TaskVO selectProjectTaskClosingForEmployee(TaskVO taskVO);

}
