package kr.or.ddit.groupware.mapper.chat;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.vo.ChatListVO;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.MessageGroupParticipantVO;
import kr.or.ddit.groupware.vo.MessageGroupVO;
import kr.or.ddit.groupware.vo.MessageVO;

/**
 * 채팅 SQL Mapper
 * 
 * @author 이명문
 * @version 1.0
 * @see IChatMapper
 */
public interface IChatMapper {

	List<ChatListVO> selectChatList(EmployeeVO employeeVO);

	int createChatGroup(MessageGroupVO messageGroupVO);

	int enterChatGroup(MessageGroupParticipantVO messageGroupParticipantVO);

	String getEmplName(int friendEmplNo);

	List<ChatListVO> selectTalkList(EmployeeVO employeeVO);

	MessageGroupParticipantVO selectTalk(MessageGroupParticipantVO groupParticipantVO);

	int isGroupCreated(Map<String, Integer> createdMap);

	int insertMessage(MessageVO messageVO);

	List<MessageVO> selectChatHistory(MessageGroupParticipantVO groupParticipantVO);

	int modifyEstbsCn(EmployeeEstbsVO estbsVO);

	int isExistEstbs(EmployeeEstbsVO estbsVO);

	int insertEstbsCn(EmployeeEstbsVO estbsVO);

	String selectEstbsCn(EmployeeEstbsVO estbsVO);

	MessageGroupVO insertGroup();

	int isGroupChat(int groupNo);

	MessageGroupParticipantVO selectTalkGroup(MessageGroupParticipantVO groupParticipantVO);

	List<MessageVO> selectTalkFileList(int groupNo);

	void updateLastReadCount(MessageGroupParticipantVO groupParticipantVO);

	int getRoomSize(int mssagGroupNo);

}
