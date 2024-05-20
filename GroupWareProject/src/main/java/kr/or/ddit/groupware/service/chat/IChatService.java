package kr.or.ddit.groupware.service.chat;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ChatListVO;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.MessageGroupParticipantVO;
import kr.or.ddit.groupware.vo.MessageGroupVO;
import kr.or.ddit.groupware.vo.MessageVO;

/**
 * 채팅 서비스 인터페이스
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see IChatService
 */
public interface IChatService {

	List<ChatListVO> selectChatList(EmployeeVO employeeVO);

	List<ChatListVO> selectTalkList(EmployeeVO employeeVO);

	int createChatGroup(String obj);

	MessageGroupParticipantVO selectTalk(MessageGroupParticipantVO groupParticipantVO);

	Result insertMessage(MessageVO messageVO);

	List<MessageVO> selectTalkHistory(MessageGroupParticipantVO groupParticipantVO);

	String modifyEstbsCn(EmployeeEstbsVO estbsVO);

	MessageGroupVO createMultiGroup(List<Integer> emplList, String title);

	List<MessageVO> selectTalkFileList(int groupNo);

	void updateReadLastCount(MessageGroupParticipantVO groupParticipantVO);

	int getRoomSize(int mssagGroupNo);

}
