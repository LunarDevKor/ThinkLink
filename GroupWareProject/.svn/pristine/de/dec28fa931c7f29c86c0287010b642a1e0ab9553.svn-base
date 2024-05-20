package kr.or.ddit.groupware.controller.chat;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.chat.IChatService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.ChatListVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.MessageGroupParticipantVO;
import kr.or.ddit.groupware.vo.MessageGroupVO;
import kr.or.ddit.groupware.vo.MessageVO;

/**
 * 채팅 컨트롤러
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see ChatController
 * @see #chat(Model)
 * @see #getChatList(int, String)
 * @see #getTalkList(int, String)
 * @see #getTalk(int, int)
 * @see #getTalkHistory(MessageGroupParticipantVO)
 * @see #talkImageUpload(List)
 * @see #talkFileList(int)
 * @see #displayFile(String)
 * @see #downloadFile(String)
 * @see #modifyEstbs(EmployeeEstbsVO)
 * @see #groupChat(String, String)
 * @see #createChatGroup(String)
 */
@Controller
@RequestMapping("/chat")
public class ChatController {

	@Inject
	private IChatService chatService;

	@Inject
	private IEmployeeService employeeService;

	@Inject
	private FileUtil fileUtil;

	private ObjectMapper mapper = new ObjectMapper();

	/**
	 * @method : chat
	 * @auther : <strong>이명문</strong>
	 * @param  : Model - 채팅 설정 정보를 보내줄 모델
	 * @return : "main/chat"
	 * @date : 2024. 4. 8
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("")
	public String chat(Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		EmployeeEstbsVO estbsVO = new EmployeeEstbsVO();
		estbsVO.setEmplNo(employeeVO.getEmplNo());
		estbsVO.setEstbsTypeCode("3");
		estbsVO = employeeService.selectEstbsByEmplNo(estbsVO);

		model.addAttribute("employee", employeeVO);
		model.addAttribute("estbs", estbsVO);
		return "chat/popup/chat";
	}

	/**
	 * @method : getChatList
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원번호
	 * @param  : emplNm - 사원이름
	 * @return : JSON 형식의 chatList
	 * @date : 2024. 4. 8
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/chatlist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getChatList(int emplNo, String emplNm) throws Exception {
		List<ChatListVO> chatList = null;

		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmplNo(emplNo);

		if (StringUtils.isNotBlank(emplNm)) {
			employeeVO.setEmplNm(emplNm);
		}

		chatList = chatService.selectChatList(employeeVO);

		return chatList == null ? ResponseEntity.status(HttpStatus.NOT_FOUND).body("failed")
				: ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(chatList));
	}

	/**
	 * @method : getTalkList
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원번호
	 * @param  : emplNm - 사원이름
	 * @return : JSON 형식의 talkList
	 * @date : 2024. 4. 8
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/talklist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getTalkList(int emplNo, String emplNm) throws Exception {
		List<ChatListVO> talkList = null;
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmplNo(emplNo);

		if (StringUtils.isNotBlank(emplNm)) {
			employeeVO.setEmplNm(emplNm);
		}

		talkList = chatService.selectTalkList(employeeVO);

		return talkList == null ? ResponseEntity.status(HttpStatus.NOT_FOUND).body("failed")
				: ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(talkList));
	}

	/**
	 * @method : getTalk
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원번호
	 * @param  : groupNo - 채팅방 그룹 번호
	 * @return : JSON 형식의 채팅방 그룹 정보
	 * @date : 2024. 4. 9
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/talk/{emplNo}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getTalk(@PathVariable int emplNo, int groupNo) throws Exception {
		MessageGroupParticipantVO groupParticipantVO = new MessageGroupParticipantVO();
		groupParticipantVO.setEmplNo(emplNo);
		groupParticipantVO.setMssagGroupNo(groupNo);

		groupParticipantVO = chatService.selectTalk(groupParticipantVO);

		return groupParticipantVO == null ? ResponseEntity.status(HttpStatus.NOT_FOUND).body("failed")
				: ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(groupParticipantVO));
	}
	
	/**
	 * @method : getTalkHistory
	 * @auther : <strong>이명문</strong>
	 * @param  : MessageGroupParticipantVO - 그룹 정보가 담긴 VO
	 * @return : JSON 형식의 채팅방 메세지 내역
	 * @date : 2024. 4. 9
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/talk/history", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getTalkHistory(MessageGroupParticipantVO groupParticipantVO) throws Exception {
		List<MessageVO> messageList = chatService.selectTalkHistory(groupParticipantVO);
		return messageList == null ? ResponseEntity.status(HttpStatus.NOT_FOUND).body("failed")
				: ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(messageList));
	}

	/**
	 * @method : talkImageUpload
	 * @auther : <strong>이명문</strong>
	 * @param  : files - 업로드한 1개 이상의 파일
	 * @return : groupNo - 채팅방 그룹 번호
	 * @date : 2024. 4. 10
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/talk/file")
	public ResponseEntity<String> talkImageUpload(List<MultipartFile> files) throws Exception {
		int groupNo = fileUtil.saveUploadFile(files, TableCode.MESSAGE);
		return groupNo == 0 ? ResponseEntity.status(HttpStatus.NOT_FOUND).body(null)
				: ResponseEntity.status(HttpStatus.OK).body(String.valueOf(groupNo));
	}
	
	/**
	 * @method : talkFileList
	 * @auther : <strong>이명문</strong>
	 * @param  : groupNo - 채팅방 그룹 번호
	 * @return : list - 해당 채팅방 그룹의 파일을 분류한 리스트
	 * @date : 2024. 4. 10
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/talk/file/{groupNo}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> talkFileList(@PathVariable int groupNo) throws Exception {
		List<MessageVO> talkFileList = chatService.selectTalkFileList(groupNo);
		
		List<MessageVO> imageFileList = new ArrayList<>();
		List<MessageVO> fileList = new ArrayList<>();
		
		for (MessageVO messageVO : talkFileList) {
			String filePath = messageVO.getMssagCn();
			String ext = FilenameUtils.getExtension(filePath).toUpperCase();
			if(fileUtil.isImageFile(ext)) {
				imageFileList.add(messageVO);
			}else {
				fileList.add(messageVO);
			}
		}
		List<List<MessageVO>> list = new ArrayList<List<MessageVO>>(); 
		list.add(imageFileList);
		list.add(fileList);
		
		return ResponseEntity.ok(mapper.writeValueAsString(list));
	}

	/**
	 * @method : displayFile
	 * @auther : <strong>이명문</strong>
	 * @param  : String path
	 * @return : ResponseEntity<byte[]> - 출력해줄 이미지 파일 
	 * @date : 2024. 4. 11
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String path) {
		return fileUtil.getFileEntity(path, false);
	}

	/**
	 * @method : downloadFile
	 * @auther : <strong>이명문</strong>
	 * @param  : String path
	 * @return : ResponseEntity<byte[]> - 다운로드 받을 파일 
	 * @date : 2024. 4. 11
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/download")
	public ResponseEntity<byte[]> downloadFile(String path) {
		return fileUtil.getFileEntity(path, true);
	}

	/**
	 * @method : modifyEstbs
	 * @auther : <strong>이명문</strong>
	 * @param  : estbsVO - 상태메세지 정보가 담긴 VO
	 * @return : 상태메세지 수정 결과가 담긴 String
	 * @date : 2024. 4. 13
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/modify", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> modifyEstbs(@RequestBody EmployeeEstbsVO estbsVO) {
		estbsVO.setEstbsTypeCode("3");
		String result = chatService.modifyEstbsCn(estbsVO);
		return result == null ? ResponseEntity.status(HttpStatus.NOT_FOUND).body(null)
				: ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/**
	 * @method : groupChat
	 * @auther : <strong>이명문</strong>
	 * @param  : emplNo - 사원 번호
	 * @param  : title - 채팅방 이름
	 * @return : JSON 형식의 그룹 채팅방 VO
	 * @date : 2024. 4. 14
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/group/{title}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> groupChat(@RequestBody String emplNo, @PathVariable String title) throws Exception {
		List<Integer> emplList = mapper.readValue(emplNo, ArrayList.class);
		MessageGroupVO groupVO = chatService.createMultiGroup(emplList, title);
		groupVO.setTemp(title);
		return ResponseEntity.status(HttpStatus.OK).body(mapper.writeValueAsString(groupVO));
	}

	/**
	 * @method : createChatGroup
	 * @auther : <strong>이명문</strong>
	 * @param  : obj - 만들 채팅방 그룹 정보가 담긴 JSON
	 * @return : groupNo - 그룹번호
	 * @date : 2024. 4. 14
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/create")
	public ResponseEntity<String> createChatGroup(@RequestBody String obj) {
		int groupNo = chatService.createChatGroup(obj);
		return ResponseEntity.status(HttpStatus.OK).body(String.valueOf(groupNo));
	}
}
