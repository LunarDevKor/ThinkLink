package kr.or.ddit.groupware.controller.employee;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.addressbook.IAddressBookService;
import kr.or.ddit.groupware.service.employee.IDeptService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.vo.DeptVO;
import kr.or.ddit.groupware.vo.EmployeeVO;

/**
 * 조직도 컨트롤러
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see OrganizationTreeController
 */
@Controller
@RequestMapping("/empltree")
public class OrganizationTreeController {

	@Inject
	private IEmployeeService employeeService;
	
	@Inject
	private IDeptService deptService;
	
	@Inject
	private IAddressBookService addressService;
	
	private ObjectMapper mapper = new ObjectMapper();
	
	/**
	 * 부서 사원 조회
	 * @author <strong>권예은</strong>
	 * @return 전 사원 emplVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping("/getDeptEmpl")
	@ResponseBody
	public String getDeptEmpl(String deptCode) throws JsonProcessingException {
		List<EmployeeVO> employeeList = employeeService.selectDeptEmpl(deptCode);
		 return convertObjectToJsonString(employeeList);
	}

	/**
	 * 하위부서 조회
	 * @author <strong>권예은</strong>
	 * @return 하위부서 DeptVO List
	 * @throws JsonProcessingException 
	 */
	@GetMapping("/getdepts")
	@ResponseBody
	public String getDepts(String deptCode) throws JsonProcessingException {
		
		List<DeptVO> deptList = deptService.selectDeptListByUpperDeptCode(deptCode);
		return convertObjectToJsonString(deptList);
	}

	/**
	 * VO 객체를 JsonString으로 변환
	 * @author <strong>권예은</strong>
	 * @param VO
	 * @return JsonString
	 */
	private String convertObjectToJsonString(Object obj) throws JsonProcessingException {
		
        ObjectMapper objectMapper = new ObjectMapper();
        String objectJson = objectMapper.writeValueAsString(obj);
		
		return objectJson;
	}
	
	
}
