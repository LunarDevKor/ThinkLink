package kr.or.ddit.groupware.mapper.notification;

import java.util.List;

import kr.or.ddit.groupware.vo.NotificationVO;

/**
 * 알림 SQL Mapper
 * @author 이명문
 * @version 1.0
 * @see INotificationMapper
 */
public interface INotificationMapper {

	int insertNotification(NotificationVO notificationVO);
	
	List<NotificationVO> selectNotiList(int emplNo);

	List<NotificationVO> selectNotReadNotiList(int emplNo);

	List<NotificationVO> selectNotReadNotiFive(int emplNo);

	int notiRead(NotificationVO notificationVO);

	int notiDelete(NotificationVO notificationVO);

	void updateNotiSendYn(int ntcnNo);

	List<NotificationVO> selectNotiPageList(NotificationVO notificationVO);
}
