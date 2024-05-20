package kr.or.ddit.groupware.controller.mail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.service.mail.IMailService;
import kr.or.ddit.groupware.vo.EmployeeVO;

/**
 * 관리자 메일통계 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see MailStatisticsController
 */
@Controller
@RequestMapping("/admin/mail")
public class MailStatisticsController extends CommonAbstractImpl {
	
	@Inject
	private IMailService service;

	@Inject
	private IEmployeeService employeeService;
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/stat")
	public String mailStatistics(Model model) throws Exception {
		
		// 부서별 메일량
		List<EmployeeVO> deptList = employeeService.selectDeptList();
		List<Map<String, Integer>> deptCntList = new ArrayList<Map<String,Integer>>();
		for (EmployeeVO employeeVO : deptList) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			int deptCnt = service.deptCount(employeeVO.getDeptCode());
			map.put(employeeVO.getDeptNm(), deptCnt);
			deptCntList.add(map);
		}
		System.out.println("@@부서" + deptCntList);
		
		// 시간별 메일량
		List<Map<String, Integer>> timeCntList = service.timeCount();
		System.out.println("@@시간" + timeCntList);
		
		// 요일별 메일량
		List<Map<String, Integer>> dayOfWeekCntList = service.dayOfWeekCount();
		System.out.println("@@요일" + dayOfWeekCntList);
		
		model.addAttribute("deptCntList", mapper.writeValueAsString(deptCntList));
		model.addAttribute("timeCntList", mapper.writeValueAsString(timeCntList));
		model.addAttribute("dayOfWeekCntList", mapper.writeValueAsString(dayOfWeekCntList));
		
		return "admin/mail/mail_statistics";
	}
}
