package kr.or.ddit.groupware.controller.conn;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.groupware.service.conn.ILoginService;

/**
 * 로그인 컨트롤러
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see LoginController
 */
@Controller
@RequestMapping("/")
public class LoginController {

	@Inject
	ILoginService loginService;

	/**
	 * @method : login
	 * @auther : <strong>이명문</strong>
	 * @param  : error 에러 정보 
	 * @param  : Model 에러 정보를 보내줄 모델 
	 * @return : "conn/login"
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("permitAll()")
	@GetMapping("/login")
	public String login(String error, Model model) {
		if(error!=null) {
			model.addAttribute("message", "로그인 정보가 잘못되었습니다! 다시 시도해주세요!");
		}
		return "conn/login";
	}
}
