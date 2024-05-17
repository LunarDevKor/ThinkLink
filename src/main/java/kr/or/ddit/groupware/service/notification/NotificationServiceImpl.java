package kr.or.ddit.groupware.service.notification;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.notification.INotificationMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.NotificationVO;

/**
 * 알림 서비스 구현체
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see NotificationServiceImpl
 */
@Service
public class NotificationServiceImpl implements INotificationService {
	
	@Inject
	private INotificationMapper notiMapper;
	
	@Override
	public int insertNotification(NotificationVO notificationVO) {
		return notiMapper.insertNotification(notificationVO);
	}
	
	@Override
	public List<NotificationVO> selectNotiList(int emplNo) {
		return notiMapper.selectNotiList(emplNo);
	}

	@Override
	public List<NotificationVO> selectNotiPageList(NotificationVO notificationVO) {
		return notiMapper.selectNotiPageList(notificationVO);
	}

	@Override
	public List<NotificationVO> selectNotReadNotiList(int emplNo) {
		return notiMapper.selectNotReadNotiList(emplNo);
	}

	@Override
	public List<NotificationVO> selectNotReadNotiFive(int emplNo) {
		return notiMapper.selectNotReadNotiFive(emplNo);
	}

	@Override
	public Result notiRead(NotificationVO notificationVO) {
		int result = notiMapper.notiRead(notificationVO);
		if (result > 0)
			return Result.OK;
		
		return Result.FAILED;
	}

	@Override
	public Result notiDelete(NotificationVO notificationVO) {
		int result = notiMapper.notiDelete(notificationVO);
		if(result > 0)
			return Result.OK;
		
		return Result.FAILED;
	}

	@Override
	public void updateNotiSendYn(int ntcnNo) {
		notiMapper.updateNotiSendYn(ntcnNo);
	}

}
