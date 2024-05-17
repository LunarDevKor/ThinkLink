package kr.or.ddit.groupware.mapper.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.TaskVO;

/**
 * Task SQL Mapper
 * @author 권예은
 * @version 1.0
 * @see ITaskMapper
 */
public interface ITaskMapper {

	List<TaskVO> selectTaskListByProject(ProjectVO project);
	List<TaskVO> selectOngoingTaskListByEmplNo(Map<String, Object> map);
	TaskVO selectTaskByTaskNo(Map<String, Object> map);
	List<TaskVO> selectTaskListByPrjctNo(int prjctNo);
	int selectTaskCountByStatusNPrjctNo(Map<String, Object> map);
	HashMap<Object, Object> selectEnddeCnt(int prjctNo);
	List<TaskVO> selectTaskListByUpperTaskNo(Map<String, Object> map);
	void insertTask(TaskVO task);
	void updateTaskProgrs(TaskVO task);
	List<TaskVO> selectProjectTaskTypeList(TaskVO taskVO);
	List<TaskVO> selectProjectTaskDetailList(TaskVO taskVO);
	TaskVO selectProjectTaskCountForEmployee(TaskVO taskVO);
	TaskVO selectProjectTaskClosingForEmployee(TaskVO taskVO);

}
