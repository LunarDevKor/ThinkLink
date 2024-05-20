package kr.or.ddit.groupware.controller.common;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.vo.ApprovalVO;

@PreAuthorize("hasRole('ROLE_ADMIN')")
@Controller
@RequestMapping("/admin")
public class AdminController extends CommonAbstractImpl {
	
	@Inject
	private IEmployeeService employeeService;
	
	/**
	 * @method : adminMain
	 * @auther : <strong>이명문</strong>
	 * @param  : model - 사원 정보
	 * @return : admin/main_admin
	 * @throws Exception 
	 * @date : 2024. 4. 26
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/main")
	public String adminMain(ApprovalVO approvalVO, Model model) throws Exception {
		List<Integer> employeeCountList = employeeService.getEmployeeCount();
		List<Map<String, Integer>> employeeAgeGroupMap = employeeService.getEmployeeAgeGroupChart();
		List<Map<String, Integer>> employeeDeptMap = employeeService.getEmployeeDeptChart();
		model.addAttribute("employeeVO", getEmployee());
		model.addAttribute("employeeAgeGroupList", mapper.writeValueAsString(employeeAgeGroupMap));
		model.addAttribute("employeeDeptList", mapper.writeValueAsString(employeeDeptMap));
		model.addAttribute("employeeCountList", employeeCountList);
		return "admin/common/main_admin";
	}
}
