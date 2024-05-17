package kr.or.ddit.groupware.security;

import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * @class : CustomNoOpPasswordEncoder
 * @implement : PasswordEncoder
 * @auther : <strong>이명문</strong>
 * @date : 2024. 4. 10
 */
public class CustomNoOpPasswordEncoder implements PasswordEncoder{

	@Override
	public String encode(CharSequence rawPassword) {
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		return rawPassword.toString().equals(encodedPassword);
	}

}
