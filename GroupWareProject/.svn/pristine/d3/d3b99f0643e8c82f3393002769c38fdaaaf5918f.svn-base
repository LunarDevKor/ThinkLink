package kr.or.ddit.groupware.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.or.ddit.groupware.mapper.conn.ILoginMapper;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;

/**
 * @class : CustomUserDetailsService
 * @implement : UserDetailsService
 * @auther : <strong>이명문</strong>
 * @date : 2024. 4. 10
 */
public class CustomUserDetailsService implements UserDetailsService {
	
	@Inject
	private ILoginMapper loginMapper;
	
	@Inject
	private PasswordEncoder pe;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		EmployeeVO employee;
		
		try {
			employee = loginMapper.readByEmployeeId(username);
			return employee == null ? null : new CustomUser(employee);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
