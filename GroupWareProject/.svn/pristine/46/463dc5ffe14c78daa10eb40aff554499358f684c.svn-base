package kr.or.ddit.groupware.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

/**
 * @class : CustomLoginSuccessHandler
 * @implement : AuthenticationSuccessHandler
 * @auther : <strong>이명문</strong>
 * @date : 2024. 4. 10
 */
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		clearAuthenticationAttribute(request);

		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetURL = "/";

		if (savedRequest != null) targetURL = savedRequest.getRedirectUrl();
		
		response.sendRedirect(targetURL);
	}

	private void clearAuthenticationAttribute(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session == null) return;

		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

}
