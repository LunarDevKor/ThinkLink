package kr.or.ddit.groupware.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.vo.NewsItemVO;

/**
 *
 * @class : 실시간 뉴스 
 * @auther : <strong>이영주</strong>
 * @version 1.0
 * @see News
 * @date : 2024. 4. 19
 *
 */

public class News {
    private static final String clientId = "zbNsn7k8xUsjB_wS09Kr"; // 애플리케이션 클라이언트 아이디
    private static final String clientSecret = "gwWKrX4Q5Y"; // 애플리케이션 클라이언트 시크릿

    public static List<NewsItemVO> searchNews(String keyword) {
        String text = null;
        try {
            text = URLEncoder.encode(keyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패", e);
        }

        String apiURL = "https://openapi.naver.com/v1/search/news?query=" + text; // JSON 결과

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL, requestHeaders);

        // JSON 파싱을 위한 ObjectMapper 생성
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            // JSON을 JsonNode로 파싱
            JsonNode responseNode = objectMapper.readTree(responseBody);

            // items 배열에서 뉴스 아이템 추출
            List<NewsItemVO> newsItems = new ArrayList<>();
            JsonNode itemsNode = responseNode.get("items");
            if (itemsNode != null && itemsNode.isArray()) {
                for (JsonNode itemNode : itemsNode) {
                    String title = itemNode.get("title").asText();
                    String originallink = itemNode.get("originallink").asText();
                    String link = itemNode.get("link").asText();
                    String description = itemNode.get("description").asText();
                    String pubDate = itemNode.get("pubDate").asText();

                    // NewsItem 객체 생성 후 리스트에 추가
                    NewsItemVO newsItem = new NewsItemVO();
                    newsItem.setTitle(title);
                    newsItem.setOriginallink(originallink);
                    newsItem.setLink(link);
                    newsItem.setDescription(description);
                    newsItem.setPubDate(pubDate);

                    newsItems.add(newsItem);
                }
            }

            return newsItems;
        } catch (IOException e) {
            throw new RuntimeException("API 응답 파싱 실패", e);
        }
    }


	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 오류 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}
	
	private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
