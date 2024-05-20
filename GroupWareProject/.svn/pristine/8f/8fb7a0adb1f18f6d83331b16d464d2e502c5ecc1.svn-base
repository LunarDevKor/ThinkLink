package kr.or.ddit.groupware.controller.common;

import org.springframework.security.core.context.SecurityContextHolder;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;

public abstract class CommonAbstractImpl {
	
	protected ObjectMapper mapper = new ObjectMapper();
	
	public EmployeeVO getEmployee() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return user.getEmployeeVO();
	}
	
}
