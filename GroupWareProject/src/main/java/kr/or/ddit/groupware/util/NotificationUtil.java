package kr.or.ddit.groupware.util;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.notification.INotificationService;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;


@Component
@EnableScheduling
@Slf4j
public class NotificationUtil {
	 
	@Inject
	private INotificationService notiService;

	public final Map<Integer, SseEmitter> emitterMap = new ConcurrentHashMap<>();
	public EmployeeVO employeeVO;

	ObjectMapper mapper = new ObjectMapper();

	/**
	 * @method : findEmitterByEmplNo
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원 번호
	 * @return : SseEmitter
	 * @date : 2024. 4. 26
	 */
	public SseEmitter findEmitterByEmplNo(int emplNo) {
		return emitterMap.get(emplNo);
	}
	
	/**
	 * @method : deleteEmitterByEmplNo
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원 번호
	 * @date : 2024. 4. 26
	 */
	public void deleteEmitterByEmplNo(int emplNo) {
		SseEmitter emitter = findEmitterByEmplNo(emplNo);
		emitter.complete();
		emitterMap.remove(emplNo);
	}
	
	/**
	 * @method : run
	 * @auther : <strong>이명문</strong>
	 * @date : 2024. 4. 24
	 */
	@Scheduled(cron = "0 * * * * ?")
	public void run() {
		if (employeeVO == null) {
			System.out.println("### EMPLOYEE VO IS NULL");
			return;
		}
		sendNoti(employeeVO.getEmplNo());
	}

	/**
	 * @method : createEmitter
	 * @auther : <strong>이명문</strong>
	 * @param  : employeeVO - 사원 정보
	 * @return : SseEmitter
	 * @date : 2024. 4. 25
	 */
	public SseEmitter createEmitter(EmployeeVO employeeVO) throws IOException {
		
		this.employeeVO = employeeVO;
		SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
		
		this.emitterMap.put(employeeVO.getEmplNo(), emitter);
		log.debug("### 추가햇당!");
		log.debug("### Emitter Map 확인!!! >> " + emitterMap);
		
		emitter.onCompletion(() -> {
			log.debug("###[NOTI] onCompletion 실행!");
//			emitterMap.remove(this.employeeVO.getEmplNo());
		});
		
		emitter.onTimeout(() -> {
			log.debug("###[NOTI] onTimeout 실행!");
			emitterMap.remove(this.employeeVO.getEmplNo());
		});
		
		emitter.onError((e) -> {
			log.info("###[NOTI] onError 실행!");
			emitterMap.remove(this.employeeVO.getEmplNo());
		});
		
		emitter.send(SseEmitter.event().data("connect!"));

		log.debug("### 사용자 => " + employeeVO.getEmplNm());
		log.debug("### Emitter Map SIZE >> " + emitterMap.size());
		log.debug("### Emitter Map VALUE >> " + emitterMap);
		
		return emitter;
	}

	/**
	 * @method : sendNoti
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo
	 * @date : 2024. 4. 24
	 */
	public void sendNoti(int emplNo) {

		SseEmitter emitter = findEmitterByEmplNo(emplNo);
		if (emitter == null) {
			log.warn("### Emitter IS NULL");
			return;
		}

		List<NotificationVO> notiList = notiService.selectNotiList(emplNo);
		NotificationVO notiVO = null;
		try {
			if (notiList.size() > 0) {
				for (NotificationVO notificationVO : notiList) {
					LocalDateTime reservationTime = notificationVO.getLocalDt();
					LocalDateTime currentTime = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime();

					if (notificationVO.getNtcnSendYn().equals("N") && reservationTime.getYear() == currentTime.getYear()
							&& reservationTime.getMonth().equals(currentTime.getMonth())
							&& reservationTime.getDayOfMonth() == currentTime.getDayOfMonth()
							&& reservationTime.getHour() == currentTime.getHour()
							&& (reservationTime.getMinute() == currentTime.getMinute()
									|| reservationTime.getMinute() == currentTime.getMinute() - 1)) 
					{
						notiService.updateNotiSendYn(notificationVO.getNtcnNo());
						emitter.send(SseEmitter.event().data(notificationVO, MediaType.APPLICATION_JSON));
						notiVO = notificationVO;
					}
				}
			}
		} catch (Exception e) {
			emitterMap.remove(emplNo);
			if(notiVO != null) 
				notiService.notiDelete(notiVO);
			emitter.completeWithError(e);
		}
	}
}
