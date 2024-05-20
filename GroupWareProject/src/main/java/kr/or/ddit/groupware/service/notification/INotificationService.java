package kr.or.ddit.groupware.service.notification;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.NotificationVO;

/**
 * 알림 서비스 인터페이스
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see INotificationService
 */
public interface INotificationService {
	
	int insertNotification(NotificationVO notificationVO);

	List<NotificationVO> selectNotiList(int emplNo);

	List<NotificationVO> selectNotReadNotiList(int emplNo);

	List<NotificationVO> selectNotReadNotiFive(int emplNo);

	Result notiRead(NotificationVO notificationVO);

	Result notiDelete(NotificationVO notificationVO);

	void updateNotiSendYn(int ntcnNo);

	List<NotificationVO> selectNotiPageList(NotificationVO notificationVO);
}
