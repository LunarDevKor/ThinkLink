package kr.or.ddit.groupware.controller.project;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.service.project.IProjectService;
import kr.or.ddit.groupware.service.project.ITaskService;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.ProjectVO;
import kr.or.ddit.groupware.vo.TaskVO;

@Controller
@RequestMapping("/admin/project")
public class AdminProjectController extends CommonAbstractImpl {
	
	@Inject
	private IProjectService projectService;
	
	@Inject
	private ITaskService taskService;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/stat")
	public String adminProjectStat(ProjectVO projectVO, Model model) throws Exception {
		List<ProjectVO> projectList = projectService.selectProjectListForChart(projectVO);
		model.addAttribute("projectCount", mapper.writeValueAsString(projectList.get(0).getCount()));
		model.addAttribute("projectList", mapper.writeValueAsString(projectList));
		return "admin/project/project_statistics";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/participants")
	public @ResponseBody List<EmployeeVO> adminProjectDetail(ProjectVO projectVO) {
		return projectService.selectPrjctPrtcpntListByPrjcrNo(projectVO.getPrjctNo());
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/tasktype")
	public @ResponseBody List<TaskVO> adminProjectTaskTypeList(TaskVO taskVO) {
		return taskService.selectProjectTaskTypeList(taskVO);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/taskdetail")
	public @ResponseBody List<TaskVO> adminProjectTaskDetailList(TaskVO taskVO) {
		return taskService.selectProjectTaskDetailList(taskVO);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/emptaskcnt")
	public @ResponseBody TaskVO adminProjectTaskCountForEmployeet(TaskVO taskVO) {
		return taskService.selectProjectTaskCountForEmployee(taskVO);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/emptaskclosing")
	public @ResponseBody TaskVO adminProjectTaskClosingForEmployeet(TaskVO taskVO) {
		return taskService.selectProjectTaskClosingForEmployee(taskVO);
	}
}
