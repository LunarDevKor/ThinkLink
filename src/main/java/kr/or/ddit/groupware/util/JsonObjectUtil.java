package kr.or.ddit.groupware.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonObjectUtil {
	
	/**
	 * VO 객체를 JsonString으로 변환
	 * @author <strong>권예은</strong>
	 * @param VO
	 * @return JsonString
	 */
	 public static String convertObjectToJsonString(Object obj) throws JsonProcessingException {
		
        ObjectMapper objectMapper = new ObjectMapper();
        String objectJson = objectMapper.writeValueAsString(obj);
		
		return objectJson;
		
	}

}
