package kr.or.ddit.groupware.service.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.project.ITaskMapper;
import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.TaskVO;

/**
 * Task 서비스 구현체
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see TaskServiceImpl
 */
@Service
public class TaskServiceImpl implements ITaskService {
	
	@Inject
	private ITaskMapper taskMapper;

	@Override
	public List<TaskVO> getTaskListByProject(ProjectVO project) {
		return taskMapper.selectTaskListByProject(project);
	}

	@Override
	public List<TaskVO> selectOngoingTaskListByEmplNo(int emplNo, String status) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emplNo", emplNo);
		map.put("status", status);
		return taskMapper.selectOngoingTaskListByEmplNo(map);
	}

	@Override
	public TaskVO selectTaskByTaskNo(Map<String, Object> map) {
		return taskMapper.selectTaskByTaskNo(map);
	}

	@Override
	public List<TaskVO> selectTaskListByPrjctNo(int prjctNo) {
		return taskMapper.selectTaskListByPrjctNo(prjctNo);
	}

	@Override
	public int selectTaskCountByStatusNPrjctNo(int prjctNo, String status) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prjctNo", prjctNo);
		map.put("status", status);
		return taskMapper.selectTaskCountByStatusNPrjctNo(map);
	}

	@Override
	public HashMap<Object, Object> selectEnddeCnt(int prjctNo) {
		return taskMapper.selectEnddeCnt(prjctNo);
	}

	@Override
	public Map<Integer, List<TaskVO>> selectTaskMapByPrjctNo(int prjctNo) {
		
		Map<Integer, List<TaskVO>> taskMap = new HashMap<Integer, List<TaskVO>>();
		taskMap = putTaskInMap(taskMap, 0, prjctNo);
		
		return taskMap;
	}

	private Map<Integer, List<TaskVO>> putTaskInMap(Map<Integer, List<TaskVO>> taskMap, int upperTaskNo, int prjctNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("upperTaskNo", upperTaskNo);
		map.put("prjctNo", prjctNo);
		List<TaskVO> taskList = taskMapper.selectTaskListByUpperTaskNo(map);
		if(taskList == null) {
			return taskMap;
		}
		taskMap.put(upperTaskNo, taskList);
		for(TaskVO taskVO : taskList) {
			taskMap = putTaskInMap(taskMap, taskVO.getTaskNo(), prjctNo);
		}
		return taskMap;
	}

	@Override
	public void insertProjectTask(TaskVO task) {
		taskMapper.insertTask(task);
	}

	@Override
	public void updateTaskProgrs(TaskVO task) {
		taskMapper.updateTaskProgrs(task);
	}

	@Override
	public List<TaskVO> selectProjectTaskTypeList(TaskVO taskVO) {
		return taskMapper.selectProjectTaskTypeList(taskVO);
	}

	@Override
	public List<TaskVO> selectProjectTaskDetailList(TaskVO taskVO) {
		return taskMapper.selectProjectTaskDetailList(taskVO);
	}

	@Override
	public TaskVO selectProjectTaskCountForEmployee(TaskVO taskVO) {
		return taskMapper.selectProjectTaskCountForEmployee(taskVO);
	}

	@Override
	public TaskVO selectProjectTaskClosingForEmployee(TaskVO taskVO) {
		return taskMapper.selectProjectTaskClosingForEmployee(taskVO);
	}

	
}
