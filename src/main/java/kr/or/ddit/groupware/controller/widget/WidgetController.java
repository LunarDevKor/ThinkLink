package kr.or.ddit.groupware.controller.widget;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.widget.IWidgetService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.WidgetVO;

@RestController
@RequestMapping("/widget")
public class WidgetController {
	
	@Inject
	private IWidgetService widgetService;
	
	private ObjectMapper mapper = new ObjectMapper();
	
	/**
	 * @method : selectWidgetList
	 * @auther : 이명문
	 * @param  : emplNo - 사원번호
	 * @return : JSON 형식의 widgetList
	 * @date : 2024. 4. 15
	 */
	@GetMapping(value = "/read", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectWidgetList(int emplNo) throws Exception {
		List<WidgetVO> widgetList = widgetService.selectWidgetList(emplNo);
		return ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(widgetList));
	}
	
	/**
	 * @method : saveWidgetLayout
	 * @auther : 이명문
	 * @param  : widgetList - 위젯 정보가 담겨있는 VO의 List
	 * @return : OK
	 * @date : 2024. 4. 15
	 */
	@PostMapping(value = "/save")
	public ResponseEntity<String> saveWidgetLayout(@RequestBody ArrayList<WidgetVO> widgetList) throws Exception {
		widgetService.saveWidgetLayout(widgetList);
		return ResponseEntity.ok(Result.OK.toString());
	}
	
	/**
	 * @method : updateWidgetUseYn
	 * @auther : 이명문
	 * @param  : widgetVO - 위젯 정보가 담겨있는 VO
	 * @return : OK
	 * @date : 2024. 4. 15
	 */
	@PostMapping(value = "/update")
	public ResponseEntity<String> updateWidgetUseYn(WidgetVO widgetVO) {
		System.out.println(widgetVO);
		Result result = widgetService.updateWidgetUseYn(widgetVO);
		return ResponseEntity.ok(result.toString());
	}
}
