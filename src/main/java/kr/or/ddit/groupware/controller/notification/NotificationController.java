package kr.or.ddit.groupware.controller.notification;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.notification.INotificationService;
import kr.or.ddit.groupware.util.NotificationUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.NotificationVO;
import lombok.RequiredArgsConstructor;

/**
 * 알림 컨트롤러
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see NotificationController
 */
@RestController
@RequiredArgsConstructor
public class NotificationController {

	@Inject
	private INotificationService notiService;

	@Inject
	private NotificationUtil noti;
	
	ObjectMapper mapper = new ObjectMapper();

	/**
	 * @method : selectNotiList
	 * @auther : <strong>이명문</strong>
	 * @return : JSON 형식으로 변환한 notiList
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/notilist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectNotiList() throws Exception {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<NotificationVO> notiList = notiService.selectNotReadNotiFive(user.getEmployeeVO().getEmplNo());
		return ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(notiList));
	}

	/**
	 * @method : notiRead
	 * @auther : <strong>이명문</strong>
	 * @param : notificationVO - ntcnNo(키값)이 담긴 VO
	 * @return : result - 결과 값 (OK/FAILED)
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/notiread", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> notiRead(@RequestBody NotificationVO notificationVO) {
		Result result = notiService.notiRead(notificationVO);
		return ResponseEntity.ok(result.toString());
	}

	/**
	 * @method : notiDelete
	 * @auther : <strong>이명문</strong>
	 * @param : notificationVO - ntcnNo(키값)이 담긴 VO
	 * @return : result - 결과 값 (OK/FAILED)
	 * @date : 2024. 4. 15
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/notidelete", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> notiDelete(@RequestBody NotificationVO notificationVO) {
		Result result = notiService.notiDelete(notificationVO);
		return ResponseEntity.ok(result.toString());
	}

	/**
	 * @method : handleEvents
	 * @auther : <strong>이명문</strong>
	 * @return : emitter - SseEmitter 객체 반환
	 * @throws IOException 
	 * @date : 2024. 4. 15
	 */
	@GetMapping(value = "/sse", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public ResponseEntity<SseEmitter> handleEvents() throws IOException {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		SseEmitter emitter = noti.findEmitterByEmplNo(user.getEmployeeVO().getEmplNo());
		if(emitter != null) {
			noti.deleteEmitterByEmplNo(user.getEmployeeVO().getEmplNo());
		}
		
		emitter = noti.createEmitter(user.getEmployeeVO());
		
		return ResponseEntity.ok(emitter);
	}
}
