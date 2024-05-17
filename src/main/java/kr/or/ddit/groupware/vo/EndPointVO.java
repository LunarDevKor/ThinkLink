package kr.or.ddit.groupware.vo;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.WebSocketSession;

public class EndPointVO {

	public Set<WebSocketSession> room = null;
	public Map<String, Integer> userIdentifiedMap = null;

	public EndPointVO(Set<WebSocketSession> room) {
			this.room = room;
			userIdentifiedMap = new ConcurrentHashMap<>();
	}

}
