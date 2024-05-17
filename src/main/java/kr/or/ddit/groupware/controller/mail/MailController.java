package kr.or.ddit.groupware.controller.mail;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.service.mail.IMailService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmailReceptionVO;
import kr.or.ddit.groupware.vo.EmailVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 메일 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see MailController
 */
@Controller
@RequestMapping("/mail")
public class MailController {

	@Inject
	private IMailService service;

	@Inject
	private IEmployeeService employeeService;

	@Inject
	private FileUtil fileUtil;

	@Resource(name = "path")
	private String resourcePath;

	@Inject
	private IAttachFileService attachFileService;

	/**
	 * 받은메일함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/inbox")
	public String selectInbox(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectEmailCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectEmailList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		// 안 읽은 메일 개수
		int noRead = service.selectNoReadCount(emplNo);
		model.addAttribute("noRead", noRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		model.addAttribute("where", "inbox");

		return "mail/email";
	}

	/**
	 * 메일 상세 페이지 (selectOne)
	 * 
	 * @author 최소희
	 * @param model
	 * @param emailNo
	 * @return 메일 상세 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/detail")
	public String selectEmail(Model model, int emailNo, String where) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		EmailReceptionVO erVO = new EmailReceptionVO();
		erVO.setEmailNo(emailNo);
		erVO.setEmplNo(emplNo);
		Result result = service.readEmail(erVO);

		EmailVO emailVO = service.selectEmail(emailNo);
		EmployeeVO senderVo = employeeService.selectEmployee(emailVO.getSenderNo());
		List<EmailReceptionVO> receptionList = service.selectReceptionList(emailNo);
		for (EmailReceptionVO emailReceptionVO : receptionList) {
			emailReceptionVO.setReceiverVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
		}
		if (emailVO.getAtchFileGroupNo() != 0) {
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(emailVO.getAtchFileGroupNo());
			List<AttachFileVO> attachFileList = attachFileGroupVO.getAttachFileList();
			model.addAttribute("attachFileList", attachFileList);
		}

		model.addAttribute("email", emailVO);
		model.addAttribute("sender", senderVo);
		model.addAttribute("receptionList", receptionList);
		model.addAttribute("where", where);

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailDetail";
	}

	/**
	 * 프로필 사진 view
	 * 
	 * @param path
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/view/{path}")
	public ResponseEntity<byte[]> view(@PathVariable String path) {
		path = resourcePath + "employee/" + path;
		System.out.println("이미지 주소 : " + path);
		ResponseEntity<byte[]> entity = null;
		File file = new File(path);
		if (file.exists()) {
			entity = fileUtil.getFileEntity(path, false); // false view, true download
		}

		return entity;
	}

	/**
	 * 첨부파일 preview
	 * 
	 * @param path
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/preview/{path}")
	public ResponseEntity<byte[]> preview(@PathVariable String path) {
		ResponseEntity<byte[]> entity = null;
		File file = new File(path);
		if (file.exists()) {
			entity = fileUtil.getFileEntity(path, false); // false view, true download
		}

		return entity;
	}

	/**
	 * 메일 상세페이지에서 휴지통으로 보내기
	 * 
	 * @author 최소희
	 * @param emailNo
	 * @param senderNo
	 * @param ra
	 * @return 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/delete")
	public String deleteEmail(int emailNo, int senderNo, String where, RedirectAttributes ra, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		String goPage = "";
		Result result = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();
		emailReceptionVO.setEmailNo(emailNo);
		emailReceptionVO.setEmplNo(emplNo);

		if (emplNo == senderNo) { // 사용자와 발신자가 같을 때 보낸메일 삭제
			result = service.deleteEmail(emailNo);
		}
		else { // 사용자와 발신자가 다를 때 받은메일 삭제
			result = service.deleteReception(emailReceptionVO);
		}

		if (result.equals(Result.OK)) {
			ra.addFlashAttribute("message", "메일이 삭제되었습니다!");
			if (where.equals("inbox")) {
				goPage = "redirect:inbox";
			}
			else if (where.equals("sent")) {
				goPage = "redirect:sent";
			}
			else if (where.equals("noRead")) {
				goPage = "redirect:noRead";
			}
			else if (where.equals("importantbox")) {
				goPage = "redirect:importantbox";
			}
			else if (where.equals("toMe")) {
				goPage = "redirect:toMe";
			}
			else if (where.equals("reservation")) {
				goPage = "redirect:reservation";
			}
			else if (where.equals("draft")) {
				goPage = "redirect:draft";
			}
			else if (where.equals("trash")) {
				goPage = "redirect:trash";
			}
			else if (where.equals("check")) {
				goPage = "redirect:check";
			}
		}
		else {
			model.addAttribute("message", "메일 삭제에 실패하였습니다!");
			goPage = "mail/emailDetail?emailNo=" + emailNo;
		}
		return goPage;
	}

	/**
	 * 체크된 메일 휴지통으로 보내기
	 * 
	 * @author 최소희
	 * @param map emailNo배열
	 * @return ResponseEntity<String>
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/deleteEmailArray", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> deleteEmailArray(@RequestBody Map<String, Integer[]> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		Integer[] emailArray = map.get("emailArray"); // emailNo
		Integer[] senderArray = map.get("senderArray"); // senderNo

		Result result = null;
		String message = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (int i = 0; i < emailArray.length; i++) {
			emailReceptionVO.setEmailNo(emailArray[i]);
			emailReceptionVO.setEmplNo(emplNo);
			result = service.existReception(emailReceptionVO); // 받은메일이면 ok, 보낸메일이면 fail

			if (result.equals(Result.OK)) { // 받은메일일 때
				result = service.deleteReception(emailReceptionVO);
				for (int j = 0; j < senderArray.length; j++) {

					if (senderArray[i] == emplNo) { // 나에게쓴메일일 때
						result = service.deleteEmail(emailArray[i]);
					}
				}
			}
			else { // 보낸메일일 때
				result = service.deleteEmail(emailArray[i]);
			}
		}

		if (result.equals(Result.OK)) {
			message = emailArray.length + "개의 메일이 삭제되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
		else {
			message = "메일 삭제가 실패되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.FAILED_DEPENDENCY);
		}
	}

	/**
	 * 체크된 메일 휴지통에서 복구하기
	 * 
	 * @author 최소희
	 * @param map emailNo배열
	 * @return ResponseEntity<String>
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/recoverEmailArray", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> recoverEmailArray(@RequestBody Map<String, Integer[]> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		Integer[] emailArray = map.get("emailArray"); // emailNo
		Integer[] senderArray = map.get("senderArray"); // senderNo

		Result result = null;
		String message = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (int i = 0; i < emailArray.length; i++) {
			emailReceptionVO.setEmailNo(emailArray[i]);
			emailReceptionVO.setEmplNo(emplNo);
			result = service.existReception(emailReceptionVO); // 받은메일이면 ok, 보낸메일이면 fail

			if (result.equals(Result.OK)) { // 받은메일일 때
				result = service.recoverReception(emailReceptionVO);
				for (int j = 0; j < senderArray.length; j++) {

					if (senderArray[i] == emplNo) { // 나에게쓴메일일 때
						result = service.recoverEmail(emailArray[i]);
					}
				}
			}
			else { // 보낸메일일 때
				result = service.recoverEmail(emailArray[i]);
			}
		}

		if (result.equals(Result.OK)) {
			message = emailArray.length + "개의 메일이 복구되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
		else {
			message = "메일 복구가 실패되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.FAILED_DEPENDENCY);
		}
	}

	/**
	 * 체크된 메일 휴지통에서 영구삭제하기
	 * 
	 * @author 최소희
	 * @param map emailNo배열
	 * @return ResponseEntity<String>
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/clearEmailArray", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> clearEmailArray(@RequestBody Map<String, Integer[]> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		Integer[] emailArray = map.get("emailArray"); // emailNo
		Integer[] senderArray = map.get("senderArray"); // senderNo

		Result result = null;
		String message = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (int i = 0; i < emailArray.length; i++) {
			emailReceptionVO.setEmailNo(emailArray[i]);
			emailReceptionVO.setEmplNo(emplNo);
			result = service.existReception(emailReceptionVO); // 받은메일이면 ok, 보낸메일이면 fail

			if (result.equals(Result.OK)) { // 받은메일일 때
				result = service.clearReception(emailReceptionVO);
				for (int j = 0; j < senderArray.length; j++) {

					if (senderArray[i] == emplNo) { // 나에게쓴메일일 때
						result = service.clearEmail(emailArray[i]);
					}
				}
			}
			else { // 보낸메일일 때
				result = service.clearEmail(emailArray[i]);
			}
		}

		if (result.equals(Result.OK)) {
			message = emailArray.length + "개의 메일이 영구삭제되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
		else {
			message = "메일 삭제가 실패되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.FAILED_DEPENDENCY);
		}
	}

	/**
	 * 체크된 메일 중요표시하기
	 * 
	 * @author 최소희
	 * @param map emailNo배열
	 * @return ResponseEntity<String>
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/importantEmailArray", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> importantEmailArray(@RequestBody Map<String, Integer[]> map, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		Integer[] emailArray = map.get("emailArray"); // emailNo
		Integer[] senderArray = map.get("senderArray"); // senderNo

		Result result = null;
		String message = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (int i = 0; i < emailArray.length; i++) {
			emailReceptionVO.setEmailNo(emailArray[i]);
			emailReceptionVO.setEmplNo(emplNo);
			result = service.existReception(emailReceptionVO); // 받은메일이면 ok, 보낸메일이면 fail

			if (result.equals(Result.OK)) { // 받은메일일 때
				result = service.importantReception(emailReceptionVO);
				for (int j = 0; j < senderArray.length; j++) {

					if (senderArray[i] == emplNo) { // 나에게쓴메일일 때
						result = service.importantEmail(emailArray[i]);
					}
				}
			}
			else { // 보낸메일일 때
				result = service.importantEmail(emailArray[i]);
			}
		}

		if (result.equals(Result.OK)) {
			message = emailArray.length + "개의 메일이 중요메일함에 추가되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
		else {
			message = "중요메일함 추가가 실패되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 체크된 메일 중요하지않음으로 변경하기
	 * 
	 * @author 최소희
	 * @param map emailNo배열
	 * @return ResponseEntity<String>
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/unimportantEmailArray", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> unimportantEmailArray(@RequestBody Map<String, Integer[]> map, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		Integer[] emailArray = map.get("emailArray"); // emailNo
		Integer[] senderArray = map.get("senderArray"); // senderNo

		Result result = null;
		String message = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (int i = 0; i < emailArray.length; i++) {
			emailReceptionVO.setEmailNo(emailArray[i]);
			emailReceptionVO.setEmplNo(emplNo);
			result = service.existReception(emailReceptionVO); // 받은메일이면 ok, 보낸메일이면 fail

			if (result.equals(Result.OK)) { // 받은메일일 때
				result = service.unimportantReception(emailReceptionVO);
				for (int j = 0; j < senderArray.length; j++) {

					if (senderArray[i] == emplNo) { // 나에게쓴메일일 때
						result = service.unimportantEmail(emailArray[i]);
					}
				}
			}
			else { // 보낸메일일 때
				result = service.unimportantEmail(emailArray[i]);
			}
		}

		if (result.equals(Result.OK)) {
			message = emailArray.length + "개의 메일이 중요메일함에서 제거되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
		else {
			message = "중요메일함 제거가 실패되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 체크된 메일 읽음처리하기
	 * 
	 * @param map
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/readEmailArray", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> readEmailArray(@RequestBody Map<String, Integer[]> map, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		Integer[] emailArray = map.get("emailArray");

		Result result = null;
		String message = null;

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (int i = 0; i < emailArray.length; i++) {
			emailReceptionVO.setEmailNo(emailArray[i]);
			emailReceptionVO.setEmplNo(emplNo);
			result = service.readEmail(emailReceptionVO);
		}

		if (result.equals(Result.OK)) {
			message = emailArray.length + "개의 메일이 읽음처리되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
		else {
			message = "읽음처리가 실패되었습니다!";
			return new ResponseEntity<String>(message, HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 보낸메일함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailSent
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/sent")
	public String selectSent(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectSentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectSentList(pagingVO);
		pagingVO.setDataList(dataList);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (EmailVO emailVO : dataList) {
			emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
			emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
		}

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("where", "sent");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailSent";
	}

	/**
	 * 안읽은메일함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailNoRead
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/noRead")
	public String selectNoRead(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectNoReadCount(emplNo);

		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectNoReadList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		// 받은 메일 개수
		int all = service.selectEmailCount(pagingVO);
		model.addAttribute("all", all);

		model.addAttribute("where", "noRead");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailNoRead";
	}

	/**
	 * 중요메일함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailImportant
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/importantbox")
	public String selectImportantbox(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectImportantCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectImportantList(pagingVO);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();
		for (EmailVO emailVO : dataList) {
			// 받는사람 1명 받아오기
			if (emailVO.getSenderNo() == emplNo) { // 받은메일
				emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
				// employeeVO에 받는사람 정보 넣기
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
			}
			else { // 보낸메일
					// employeeVO에 보낸사람 정보 넣기
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailVO.getSenderNo()));
			}
		}

		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);

		// 안 읽은 메일 개수
		int noRead = service.selectImportantNoReadCount(emplNo);
		model.addAttribute("noRead", noRead);

		model.addAttribute("user", userVO);

		model.addAttribute("where", "importantbox");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailImportant";
	}

	/**
	 * 내게쓴메일함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailToMe
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/toMe")
	public String selectToMe(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectToMeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectToMeList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		// 안 읽은 메일 개수
		int noRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("noRead", noRead);

		model.addAttribute("where", "toMe");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailToMe";
	}

	/**
	 * 예약메일함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailReservation
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/reservation")
	public String selectReservation(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectReservationCount(emplNo);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectReservationList(pagingVO);
		pagingVO.setDataList(dataList);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (EmailVO emailVO : dataList) {
			emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
			emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
		}

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("where", "reservation");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailReservation";
	}

	/**
	 * 임시보관함 (selectList)
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailSent
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/draft")
	public String selectDraft(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectDraftCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectDraftList(pagingVO);
		pagingVO.setDataList(dataList);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (EmailVO emailVO : dataList) {
			emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
			if (emailReceptionVO != null) {
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
			}
		}

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("where", "draft");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailDraft";
	}

	/**
	 * 메일 쓰기 화면
	 * 
	 * @author 최소희
	 * @return mail/emailForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/emailForm")
	public String emailForm(Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		List<EmployeeVO> employeeList = employeeService.selectAllEmpl2();
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("user", userVO);

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailForm";
	}

	/**
	 * 메일 보내기 버튼
	 * 
	 * @author 최소희
	 * @param files
	 * @param emailVO
	 * @param Trnsmis
	 * @param receiverArray
	 * @param ccArray
	 * @param model
	 * @param me
	 * @return 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/send")
	public String send(List<MultipartFile> files, EmailVO emailVO,
			@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date Trnsmis, int[] receiverArray, int[] ccArray,
			Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		emailVO.setSenderVO(userVO);

		int emplNo = userVO.getEmplNo();
		emailVO.setEmplNo(emplNo);

		if (emailVO.getEmailNm().trim().equals("") || emailVO.getEmailNm() == null) {
			emailVO.setEmailNm("(제목 없음)");
		}

		emailVO.setEmailTrnsmis(Trnsmis);

		String goPage = "";
		boolean flag = true;

		for (MultipartFile file : files) {
			if (StringUtils.isBlank(file.getOriginalFilename())) {
				flag = false;
				break;
			}
		}

		if (flag) {
			int atchFileGroupNo = fileUtil.saveUploadFile(files, TableCode.EMAIL);
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(atchFileGroupNo);
			emailVO.setAtchFileGroupNo(atchFileGroupNo);
		}

		Result result = service.insertEmail(emailVO, receiverArray, ccArray);
		if (result.equals(Result.OK)) {
			if (emailVO.getEmailStatusCode().equals("E103")) {
				goPage = "redirect:draftSuccess";
			}
			else {
				goPage = "redirect:success";
			}
		}
		else {
			model.addAttribute("email", emailVO);
			goPage = "mail/emailForm";
		}
		return goPage;
	}

	/**
	 * 메일이 성공적으로 보내졌을 때 나타나는 페이지
	 * 
	 * @author 최소희
	 * @return 메일 성공 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/success")
	public String success(Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailSuccess";
	}

	/**
	 * 임시메일이 성공적으로 저장됐을 때 나타나는 페이지
	 * 
	 * @author 최소희
	 * @return 임시메일 성공 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/draftSuccess")
	public String draftSuccess(Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailDraftSuccess";
	}

	/**
	 * 미리보기 버튼
	 * 
	 * @author 최소희
	 * @param map
	 * @return 이메일폼에 쓰여진 받는사람과 참조 리스트
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/preview")
	public ResponseEntity<List<List<EmployeeVO>>> preview(@RequestBody Map<String, Integer[]> map) {

		List<EmployeeVO> receiverList = new ArrayList<>();
		List<EmployeeVO> ccList = new ArrayList<>();

		Integer[] receiverArray = map.get("receiverArray");
		Integer[] ccArray = map.get("ccArray");

		if (receiverArray != null && receiverArray.length > 0) {
			for (int i = 0; i < receiverArray.length; i++) {
				receiverList.add(employeeService.selectEmployee(receiverArray[i]));
			}
		}
		if (ccArray != null && ccArray.length > 0) {
			for (int i = 0; i < ccArray.length; i++) {
				ccList.add(employeeService.selectEmployee(ccArray[i]));
			}
		}

		List<List<EmployeeVO>> receptionList = new ArrayList<>();
		receptionList.add(receiverList);
		receptionList.add(ccList);

		return new ResponseEntity<>(receptionList, HttpStatus.OK);
	}

	/**
	 * 이메일 상세페이지에서 답장을 눌렀을 때
	 * 
	 * @author 최소희
	 * @param emailNo
	 * @param model
	 * @return mail/emailForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/reply")
	public String reply(int emailNo, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();

		List<EmployeeVO> employeeList = employeeService.selectAllEmpl2();
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("user", userVO);

		EmailVO emailVO = service.selectEmail(emailNo);
		EmployeeVO senderVo = employeeService.selectEmployee(emailVO.getSenderNo());
		List<EmailReceptionVO> receptionList = service.selectReceptionList(emailNo);
		for (EmailReceptionVO emailReceptionVO : receptionList) {
			emailReceptionVO.setReceiverVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
		}

		model.addAttribute("sender", senderVo);
		model.addAttribute("receptionList", receptionList);
		model.addAttribute("reEmail", emailVO);
		model.addAttribute("status", "r");
		return "mail/emailForm";
	}

	/**
	 * 이메일 상세페이지에서 전달을 눌렀을 때
	 * 
	 * @author 최소희
	 * @param emailNo
	 * @param model
	 * @return mail/emailForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/forward")
	public String forward(int emailNo, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();

		List<EmployeeVO> employeeList = employeeService.selectAllEmpl2();
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("user", userVO);

		EmailVO emailVO = service.selectEmail(emailNo);
		EmployeeVO senderVo = employeeService.selectEmployee(emailVO.getSenderNo());
		List<EmailReceptionVO> receptionList = service.selectReceptionList(emailNo);
		for (EmailReceptionVO emailReceptionVO : receptionList) {
			emailReceptionVO.setReceiverVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
		}

		if (emailVO.getAtchFileGroupNo() != 0) {
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(emailVO.getAtchFileGroupNo());
			List<AttachFileVO> attachFileList = attachFileGroupVO.getAttachFileList();
			model.addAttribute("attachFileList", attachFileList);
		}

		model.addAttribute("sender", senderVo);
		model.addAttribute("receptionList", receptionList);
		model.addAttribute("reEmail", emailVO);
		model.addAttribute("status", "f");
		return "mail/emailForm";
	}

	/**
	 * 임시보관함에서 이메일을 눌렀을 때 뜨는 폼
	 * 
	 * @author 최소희
	 * @param emailNo
	 * @param model
	 * @return mail/emailForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/draftDetail")
	public String draftDetail(int emailNo, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();

		List<EmployeeVO> employeeList = employeeService.selectAllEmpl2();
		model.addAttribute("employeeList", employeeList);
		model.addAttribute("user", userVO);

		EmailVO emailVO = service.selectEmail(emailNo);
		EmployeeVO senderVo = employeeService.selectEmployee(userVO.getEmplNo());
		List<EmailReceptionVO> receptionList = service.selectReceptionList(emailNo);
		for (EmailReceptionVO emailReceptionVO : receptionList) {
			emailReceptionVO.setReceiverVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
		}

		if (emailVO != null && emailVO.getAtchFileGroupNo() != 0) {
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(emailVO.getAtchFileGroupNo());
			List<AttachFileVO> attachFileList = attachFileGroupVO.getAttachFileList();
			model.addAttribute("attachFileList", attachFileList);
		}

		model.addAttribute("sender", senderVo);
		model.addAttribute("receptionList", receptionList);
		model.addAttribute("reEmail", emailVO);
		model.addAttribute("status", "d");
		return "mail/emailForm";
	}

	/**
	 * 임시보관함에 있던 이메일을 수정하여 보내기
	 * 
	 * @author 최소희
	 * @param files
	 * @param emailVO
	 * @param Trnsmis
	 * @param receiverArray
	 * @param ccArray
	 * @param model
	 * @return goPage
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/update")
	public String update(List<MultipartFile> files, EmailVO emailVO,
			@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date Trnsmis, int[] receiverArray, int[] ccArray,
			Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();

		emailVO.setEmplNo(emplNo);
		if (emailVO.getEmailNm().trim().equals("") || emailVO.getEmailNm() == null) {
			emailVO.setEmailNm("(제목 없음)");
		}

		emailVO.setEmailTrnsmis(Trnsmis);

		String goPage = "";
		boolean flag = true;

		Integer[] delFileNo = emailVO.getDelFileNo();

		for (MultipartFile file : files) {
			if (StringUtils.isBlank(file.getOriginalFilename())) {
				flag = false;
				break;
			}
		}

		if (emailVO.getAtchFileGroupNo() != 0) { // 기존에 첨부한 파일이 있을 때

			if (flag) { // 추가하는 파일이 있으면
				// 추가된 파일 업데이트
				fileUtil.updateSaveFile(files, emailVO.getAtchFileGroupNo(), TableCode.EMAIL);
			}

			// 삭제 파일 딜리트
			if (emailVO.getDelFileNo() == null || emailVO.getDelFileNo().length == 0) {
				System.out.println("삭제파일 없음");
			}
			else {
				for (int i = 0; i < emailVO.getDelFileNo().length; i++) {
					fileUtil.attachFileDelete(emailVO.getDelFileNo()[i]);
				}
			}

			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(emailVO.getAtchFileGroupNo());

			// 위의 결과 파일이 없으면 attachFileGroupNo를 0으로 변경
			if (attachFileGroupVO == null) {
				emailVO.setAtchFileGroupNo(0);
			}
			else {
				if (attachFileGroupVO.getAttachFileList() == null
						|| attachFileGroupVO.getAttachFileList().size() == 0) {
					emailVO.setAtchFileGroupNo(0);
				}
			}
		}

		if (emailVO.getAtchFileGroupNo() == 0 && flag) { // 기존 파일이 없고 추가하는 파일이 있으면

			int atchFileGroupNo = fileUtil.saveUploadFile(files, TableCode.EMAIL);
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(atchFileGroupNo);
			emailVO.setAtchFileGroupNo(atchFileGroupNo);
		}

		Result result = service.updateEmail(emailVO, receiverArray, ccArray);
		if (result.equals(Result.OK)) {
			goPage = "redirect:success";
		}
		else {
			model.addAttribute("reEmail", emailVO);
			model.addAttribute("status", "d");
			goPage = "mail/emailForm";
		}
		return goPage;
	}

	/**
	 * 휴지통
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return mail/emailImportant
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/trash")
	public String trash(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectTrashCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectTrashList(pagingVO);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();
		for (EmailVO emailVO : dataList) {
			// 받는사람 1명 받아오기
			if (emailVO.getSenderNo() == emplNo) { // 받은메일
				System.out.println("@@보낸메일 if문 실행");
				emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
				System.out.println("@@보낸메일 이메일VO:" + emailVO);
			}
			else { // 보낸메일
					// employeeVO에 받는사람 정보 넣기
				System.out.println("@@받은메일 if문 실행");
				// employeeVO에 보낸사람 정보 넣기
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailVO.getSenderNo()));
				System.out.println("@@받은메일 이메일VO:" + emailVO);
			}
		}

		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);

		// 안 읽은 메일 개수
		int noRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("noRead", noRead);

		model.addAttribute("user", userVO);

		model.addAttribute("where", "trash");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailTrash";
	}

	/**
	 * 수신확인 페이지
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/check")
	public String receiptCheck(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectSentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectSentList(pagingVO);
		pagingVO.setDataList(dataList);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();

		for (EmailVO emailVO : dataList) {
			emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
			emailVO.setEmailReceptionVO(emailReceptionVO);
			emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
			emailVO.setReceptionCount(service.receptionCount(emailVO.getEmailNo()));
			emailVO.setReceptionReadCount(service.receptionReadCount(emailVO.getEmailNo()));
		}

		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("where", "check");

		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailCheck";
	}

	/**
	 * 수신확인 페이지에서 수신자 리스트 비동기로 보내준다
	 * 
	 * @author 최소희
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/receptionList")
	public ResponseEntity<List<EmailReceptionVO>> receptionList(@RequestBody Map<String, Integer> map) {
		int emailNo = map.get("emailNo");
		List<EmailReceptionVO> receptionList = service.selectReceptionList(emailNo);
		for (EmailReceptionVO emailReceptionVO : receptionList) {
			emailReceptionVO.setReceiverVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
			emailReceptionVO.setEmailVO(service.selectEmail(emailNo));
		}
		return new ResponseEntity<>(receptionList, HttpStatus.OK);
	}

	/**
	 * 상세검색 결과가 나타나는 페이지
	 * 
	 * @param currentPage
	 * @param sender
	 * @param receiver
	 * @param emailNm
	 * @param emailCn
	 * @param atchFileOrnlFileNm
	 * @param model
	 * @return mail/emailSearchDetail
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/searchDetail")
	public String searchDetail(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam("searchSender") String sender, @RequestParam("searchReceiver") String receiver,
			@RequestParam("searchTitle") String emailNm, @RequestParam("searchContent") String emailCn,
			@RequestParam("searchAttach") String atchFileOrnlFileNm, Model model) {

		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int emplNo = userVO.getEmplNo();
		PaginationInfoVO<EmailVO> pagingVO = new PaginationInfoVO<EmailVO>();
		pagingVO.setEmplNo(emplNo);

		// 검색이 이뤄지면 아래가 실행됨
		if(StringUtils.isNotBlank(sender)) {
			pagingVO.setSearchSender(sender);
		}
		if(StringUtils.isNotBlank(receiver)) {
			pagingVO.setSearchReceiver(receiver);
		}
		if(StringUtils.isNotBlank(emailNm)) {
			pagingVO.setSearchNm(emailNm);
		}
		if(StringUtils.isNotBlank(emailCn)) {
			pagingVO.setSearchCn(emailCn);
		}
		if(StringUtils.isNotBlank(atchFileOrnlFileNm)) {
			pagingVO.setSearchFileNm(atchFileOrnlFileNm);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.selectSearchCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmailVO> dataList = service.selectSearchList(pagingVO);
		System.out.println("@@DataList"+dataList);

		EmailReceptionVO emailReceptionVO = new EmailReceptionVO();
		for (EmailVO emailVO : dataList) {
			// 받는사람 1명 받아오기
			if (emailVO.getSenderNo() == emplNo) { // 받은메일
				// employeeVO에 받는사람 정보 넣기
				emailReceptionVO = service.selectReceptionOne(emailVO.getEmailNo());
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailReceptionVO.getReceiverNo()));
			}
			else { // 보낸메일
				// employeeVO에 보낸사람 정보 넣기
				emailVO.setEmployeeVO(employeeService.selectEmployee(emailVO.getSenderNo()));
			}
		}

		pagingVO.setDataList(dataList);
		
		model.addAttribute("searchSender", sender);
		model.addAttribute("searchReceiver", receiver);
		model.addAttribute("searchTitle", emailNm);
		model.addAttribute("searchContent", emailCn);
		model.addAttribute("searchAttach", atchFileOrnlFileNm);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("user", userVO);
		model.addAttribute("where", "searchDetail");
		
		// 안 읽은 메일 개수
		int inboxNoRead = service.selectNoReadCount(emplNo);
		model.addAttribute("inboxNoRead", inboxNoRead);

		// 내게쓴메일함 안 읽은 개수
		int toMeNoRead = service.selectToMeNoReadCount(emplNo);
		model.addAttribute("toMeNoRead", toMeNoRead);

		// 휴지통 안 읽은 개수
		int trashNoRead = service.selectTrashNoReadCount(emplNo);
		model.addAttribute("trashNoRead", trashNoRead);

		// 예약메일 개수
		int reservation = service.selectReservationCount(emplNo);
		model.addAttribute("reservation", reservation);

		return "mail/emailSearchDetail";
	}

	/**
	 * 조직도에서 메일 버튼 눌렀을 때
	 * 
	 * @author 최소희
	 * @param emplNo
	 * @param model
	 * @return mail/emailForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/sendToEmpl")
	public String sendToEmpl(int emplNo, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();

		List<EmployeeVO> employeeList = employeeService.selectAllEmpl2();

		EmployeeVO senderVo = employeeService.selectEmployee(emplNo);

		model.addAttribute("employeeList", employeeList);
		model.addAttribute("user", userVO);
		model.addAttribute("sender", senderVo);
		model.addAttribute("status", "e");

		return "mail/emailForm";
	}

}
