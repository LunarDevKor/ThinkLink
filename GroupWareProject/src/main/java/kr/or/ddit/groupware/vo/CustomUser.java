package kr.or.ddit.groupware.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6384154941705185333L;
	private EmployeeVO employee;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(EmployeeVO employee) {
		super(employee.getEmplId(), employee.getEmplPassword(), 
				employee.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthorNm())).collect(Collectors.toList()));
		this.employee = employee;
	}
	
	public EmployeeVO getEmployeeVO() {
		return employee;
	}
	
	public void setEmployeeVO(EmployeeVO employee) {
		this.employee = employee;
	}
}
