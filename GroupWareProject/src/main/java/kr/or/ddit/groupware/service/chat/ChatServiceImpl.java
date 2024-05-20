package kr.or.ddit.groupware.service.chat;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.mapper.chat.IChatMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ChatListVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.MessageGroupParticipantVO;
import kr.or.ddit.groupware.vo.MessageGroupVO;
import kr.or.ddit.groupware.vo.MessageVO;

/**
 * 채팅 서비스 구현체
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see ChatServiceImpl
 */

@Service
public class ChatServiceImpl implements IChatService {

	@Inject
	private IChatMapper chatMapper;

	@Override
	public List<ChatListVO> selectChatList(EmployeeVO employeeVO) {
		return chatMapper.selectChatList(employeeVO);
	}

	@Override
	public List<ChatListVO> selectTalkList(EmployeeVO employeeVO) {
		return chatMapper.selectTalkList(employeeVO);
	}

	@Transactional(rollbackFor = SQLException.class)
	@Override
	public int createChatGroup(String obj) {
		MessageGroupVO messageGroupVO = new MessageGroupVO();
		ObjectMapper mapper = new ObjectMapper();

		try {

			JsonNode node = mapper.readTree(obj);

			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String myName = customUser.getEmployeeVO().getEmplNm();
			int myEmplNo = customUser.getEmployeeVO().getEmplNo();
			int friendEmplNo = node.get("friend").asInt();

			Map<String, Integer> createdMap = new HashMap<>();
			createdMap.put("myEmplNo", myEmplNo);
			createdMap.put("friendEmplNo", friendEmplNo);
			int groupNo = chatMapper.isGroupCreated(createdMap);

			if (groupNo > 0) {
				return groupNo;
			}

			messageGroupVO.setMssagGroupTypeCode("M102");

			int cnt = chatMapper.createChatGroup(messageGroupVO);

			if (cnt <= 0) {
				throw new RuntimeException();
			}

			String friendName = chatMapper.getEmplName(friendEmplNo);

			node.fields().forEachRemaining(entry -> {
				String chatName = "";

				JsonNode emplNo = entry.getValue();

				if (entry.getKey().equals("friend")) {
					chatName = myName + "님 과의 채팅방";
				}
				else {
					chatName = friendName + "님 과의 채팅방";
				}

				MessageGroupParticipantVO messageGroupParticipantVO = new MessageGroupParticipantVO();
				messageGroupParticipantVO.setMssagGroupNo(messageGroupVO.getMssagGroupNo());
				messageGroupParticipantVO.setEmplNo(emplNo.asInt());
				messageGroupParticipantVO.setMssagGroupNm(chatName);

				int insertCnt = chatMapper.enterChatGroup(messageGroupParticipantVO);

				if (insertCnt <= 0) {
					new RuntimeException();
				}

			});

		} catch (Exception e) {
			e.printStackTrace();
		}

		return messageGroupVO.getMssagGroupNo();
	}

	@Override
	public MessageGroupParticipantVO selectTalk(MessageGroupParticipantVO groupParticipantVO) {
		int groupNo = groupParticipantVO.getMssagGroupNo();
		int cnt = chatMapper.isGroupChat(groupNo);
		if(cnt > 0) {
			chatMapper.updateLastReadCount(groupParticipantVO);
			return chatMapper.selectTalkGroup(groupParticipantVO);
		}
		
		chatMapper.updateLastReadCount(groupParticipantVO);
		return chatMapper.selectTalk(groupParticipantVO);
	}

	@Override
	public Result insertMessage(MessageVO messageVO) {
		int result = chatMapper.insertMessage(messageVO);
		
		if (result <= 0) {
			throw new RuntimeException();
		}

		return Result.OK;
	}

	@Override
	public List<MessageVO> selectTalkHistory(MessageGroupParticipantVO groupParticipantVO) {
		chatMapper.updateLastReadCount(groupParticipantVO);
		return chatMapper.selectChatHistory(groupParticipantVO);
	}

	@Override
	public String modifyEstbsCn(EmployeeEstbsVO estbsVO) {
		if (chatMapper.isExistEstbs(estbsVO) > 0) {
			chatMapper.modifyEstbsCn(estbsVO);
		}
		else {
			chatMapper.insertEstbsCn(estbsVO);
		}

		return chatMapper.selectEstbsCn(estbsVO);
	}

	@Transactional(rollbackFor = SQLException.class)
	@Override
	public MessageGroupVO createMultiGroup(List<Integer> emplList, String title) {

		MessageGroupVO messageGroupVO = new MessageGroupVO();
		messageGroupVO.setMssagGroupTypeCode("M101");

		chatMapper.createChatGroup(messageGroupVO);
		int groupNo = messageGroupVO.getMssagGroupNo();

		for (int emplNo : emplList) {
			MessageGroupParticipantVO messageGroupParticipantVO = new MessageGroupParticipantVO();
			messageGroupParticipantVO.setMssagGroupNo(groupNo);
			messageGroupParticipantVO.setEmplNo(emplNo);
			messageGroupParticipantVO.setMssagGroupNm(title);

			chatMapper.enterChatGroup(messageGroupParticipantVO);
		}
		
		return messageGroupVO;
	}

	@Override
	public List<MessageVO> selectTalkFileList(int groupNo) {
		return chatMapper.selectTalkFileList(groupNo);
	}

	@Override
	public void updateReadLastCount(MessageGroupParticipantVO groupParticipantVO) {
		chatMapper.updateLastReadCount(groupParticipantVO);
	}

	@Override
	public int getRoomSize(int mssagGroupNo) {
		return chatMapper.getRoomSize(mssagGroupNo);
	}
}
