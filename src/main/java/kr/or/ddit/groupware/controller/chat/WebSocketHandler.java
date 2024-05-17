package kr.or.ddit.groupware.controller.chat;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.chat.IChatService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.EndPointVO;
import kr.or.ddit.groupware.vo.MessageGroupParticipantVO;
import kr.or.ddit.groupware.vo.MessageVO;

public class WebSocketHandler extends BinaryWebSocketHandler {

	private static Logger log = LoggerFactory.getLogger(WebSocketHandler.class);

	private ObjectMapper mapper = new ObjectMapper();

	private Map<Integer, EndPointVO> roomMap = new ConcurrentHashMap<>();
	private Set<WebSocketSession> sessionList = Collections.synchronizedSet(new HashSet<WebSocketSession>());

	@Inject
	private IChatService chatService;

	@Inject
	private IAttachFileService attachFileService;
	
	@Inject
	private IEmployeeService employeeService;

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) {

		try {
			String payload = message.getPayload();
			log.info(payload);

			MessageVO messageVO = mapper.readValue(payload, MessageVO.class);
			// 현재 날짜 포맷팅
			messageVO.setRgsde(getNow(new Date()));

			// 클라이언트로 받은 메시지중 type 값이 있으면
			if (messageVO.getType() != null) {
				String type = messageVO.getType();
				// 업로드라면 파일 업로드를 실행하고 MessageVO에 필요한 값들을 담는다
				if (type.equals("upload")) {
					EmployeeVO employeeVO = employeeService.selectEmployee2(messageVO.getEmplNo());
					messageVO.setEmplProflPhoto(employeeVO.getEmplProflPhoto());
					messageVO.setEmplNm(employeeVO.getEmplNm());
					
					int atchFileGroupNo = Integer.parseInt(messageVO.getMssagCn());
					AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(atchFileGroupNo);

					for (AttachFileVO attachFileVO : attachFileGroupVO.getAttachFileList()) {
						messageVO.setMssagCn(attachFileVO.getAtchFilePath());
						messageVO.setAtchFileGroupNo(atchFileGroupNo);
						messageVO.setType("upload");
						chatService.insertMessage(messageVO);

						for (WebSocketSession socketSession : sessionList) {
							socketSession.sendMessage(new TextMessage(mapper.writeValueAsString(messageVO)));
						}
					}
					return;
				}

				if (type.equals("enter")) {
					int groupNo = messageVO.getMssagGroupNo();
					EndPointVO endPointVO = roomMap.get(groupNo);

					if (endPointVO == null) {
						endPointVO = new EndPointVO(Collections.synchronizedSet(new HashSet<WebSocketSession>()));
					}

					Set<WebSocketSession> room = endPointVO.room;
					room.add(session);
					endPointVO.room = room;
					endPointVO.userIdentifiedMap.put(session.getId(), messageVO.getEmplNo());
					
					roomMap.put(groupNo, endPointVO);
					
					if(room.size() != 1) {
						for (WebSocketSession socketSession : room) {
							if(!socketSession.getId().equals(session.getId())) {
								messageVO.setType("update");
								socketSession.sendMessage(new TextMessage(mapper.writeValueAsString(messageVO)));
							}
						}
					}
					
					return;
				}
			}

			Result result = chatService.insertMessage(messageVO);

			if (result.equals(Result.OK)) {
				
				EndPointVO endPointVO = roomMap.get(messageVO.getMssagGroupNo());

				if (endPointVO == null) {
					endPointVO = new EndPointVO(Collections.synchronizedSet(new HashSet<WebSocketSession>()));
				}

				Set<WebSocketSession> room = endPointVO.room;
				room.add(session);
				endPointVO.room = room;
				endPointVO.userIdentifiedMap.put(session.getId(), messageVO.getEmplNo());
				
				roomMap.put(messageVO.getMssagGroupNo(), endPointVO);
				
				MessageGroupParticipantVO groupParticipantVO = new MessageGroupParticipantVO();
				groupParticipantVO.setEmplNo(messageVO.getEmplNo());
				groupParticipantVO.setMssagGroupNo(messageVO.getMssagGroupNo());
				chatService.updateReadLastCount(groupParticipantVO);
				
				int unreadCount = chatService.getRoomSize(messageVO.getMssagGroupNo());
				messageVO.setReadCount(unreadCount);
				
				for (WebSocketSession socketSession : room) {
					if(!session.getId().equals(socketSession.getId())) {
						
						messageVO.setReadCount(messageVO.getReadCount()-1);
						
						Map<String,Integer> userIdentifiedMap = roomMap.get(messageVO.getMssagGroupNo()).userIdentifiedMap;
						int emplNo = userIdentifiedMap.get(socketSession.getId());
						
						groupParticipantVO.setEmplNo(emplNo);
						chatService.updateReadLastCount(groupParticipantVO);
					}
				}
				
				EmployeeVO employeeVO = employeeService.selectEmployee2(messageVO.getEmplNo());
				messageVO.setEmplProflPhoto(employeeVO.getEmplProflPhoto());
				messageVO.setEmplNm(employeeVO.getEmplNm());
					
				for (WebSocketSession socketSession : room) {
					socketSession.sendMessage(new TextMessage(mapper.writeValueAsString(messageVO)));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("[CONNECT] : " + session.getId());
		sessionList.add(session);
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable ex) throws Exception {
		log.error("[ERROR] : " + ex.getMessage());
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("[DISCONNECT]");

		Iterator<WebSocketSession> sessionIt = sessionList.iterator();

		while (sessionIt.hasNext()) {
			WebSocketSession wSession = sessionIt.next();
			if (wSession.getId().equals(session.getId())) {
				sessionIt.remove();
				break;
			}
		}

		for (Entry<Integer, EndPointVO> entry : roomMap.entrySet()) {
			Iterator<WebSocketSession> roomIt = entry.getValue().room.iterator();
			while (roomIt.hasNext()) {
				WebSocketSession socketSession = roomIt.next();
				if(socketSession.getId().equals(session.getId())) {
					roomIt.remove();
					break;
				}
			}
		}
	}

	public static String getNow(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		SimpleDateFormat getAmPm = new SimpleDateFormat("a");

		String ampm = getAmPm.format(date).equals("AM") ? "오전" : "오후";
		String now = sdf.format(date);
		String sendDate = ampm + " " + now;

		return sendDate;
	}
}
