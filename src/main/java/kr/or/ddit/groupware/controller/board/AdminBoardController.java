package kr.or.ddit.groupware.controller.board;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.service.answer.IAnswerService;
import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.board.IBoardService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 게시판 리스트 및 디테일 컨트롤러
 * 
 * @author <strong>최윤서</strong>
 * @version 1.0
 * @see AdminBoardController
 * @see #list()
 * @see #detail()
 */
@Slf4j
@Controller
@RequestMapping("/admin/board")
public class AdminBoardController extends CommonAbstractImpl {

	@Inject
	private IBoardService boardService;

	@Inject
	private IAnswerService answerService;
	
	@Inject
	private IEmployeeService employeeService;
	
	@Inject
	private IAttachFileService attachFileService;
	
	@Inject
	private FileUtil fileUtil;
	
//	@Resource(name="uploadPath")
//	private String resourcePath;

	/**
	 * 게시판 리스트
	 * 
	 * @author <strong>최윤서</strong>
	 * @param type  타입에 맞춰 게시글 출력 레이아웃이 변경됨
	 * @param model 게시글 리스트
	 * @return 분기 조건에 따른 이동 페이지(list/album) 지정
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "", produces = MediaType.APPLICATION_JSON_VALUE, method = {
			RequestMethod.GET, RequestMethod.POST
	})
	public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title")String searchType,
			@RequestParam(required = false)String searchWord,
			@RequestParam(defaultValue = "1")int bbsNo,
			String type,
			Model model) {
		

		List<BoardVO> boardList = new ArrayList<>(); // 게시글 리스트
		PaginationInfoVO<BoardVO> pagingVO = new PaginationInfoVO<BoardVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = boardService.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		pagingVO.setBbsNo(bbsNo);
		boardList = boardService.selectBoardList(pagingVO);
		pagingVO.setDataList(boardList);
		log.info(">>>"+bbsNo);

		model.addAttribute("pagingVO", pagingVO);
//		int commentCount = getCommentCount(bbsNo);
//		log.info(">>>>"+bbsNo);
//		model.addAttribute("commentCount", commentCount); // 댓글 수 추가




		return "admin/board/list";
	}
	/**
//	 * 게시판 카테고리 관리
//	 * 
//	 * @author <strong>최윤서</strong>
//	 * @param bbscttNo 게시글 번호
//	 * @param model    보여줄 게시글 데이터
//	 * @return 게시글 목록 페이지
//	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/{bbsNo}")
	public String getType(@PathVariable("bbsNo") int bbsNo , Model model){
		log.info("bbsNo : " + bbsNo);
		List<BoardVO> boardList = boardService.getType(bbsNo);
		
		model.addAttribute("boardList", boardList);
		return "admin/board/category";
	}

	/**
	 * 게시판 디테일
	 * 
	 * @author <strong>최윤서</strong>
	 * @param bbscttNo 게시글 번호
	 * @param model    보여줄 게시글 데이터
	 * @return 게시글 디테일 페이지
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/detail")
	public String detail(int bbscttNo, Model model) {
		BoardVO boardVO = boardService.selectBoard(bbscttNo);
		int answerCount = getCommentCount(bbscttNo);
		// 댓글 목록 가져오기
		List<AnswerVO> answerList =  answerService.selectAnswer(bbscttNo);
		List<AttachFileVO> atchFileList = boardService.selectAtchFileGroupNo(boardVO.getAtchFileGrpNo());
		log.info("#############1"+atchFileList);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("answerList", answerList);
		model.addAttribute("atchFileList",atchFileList);
		model.addAttribute("answerCount", answerCount);
		return "admin/board/detail";
	}
	
//	public int answerCount(int bbscttNo , Model model) {
//		
//		int answerCount = boardService.answerCount(bbscttNo);
//		model.addAttribute("answerCount", answerCount);
//	}
	// 댓글 수를 가져오는 서비스 메서드
	public int getCommentCount(int bbscttNo) {
	    return boardService.answerCount(bbscttNo);
	}


	/**
	 * 게시판 등록폼
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/form")
	public String insertForm(@RequestParam(defaultValue = "0")int bbsNo,Model model) {
		BoardVO boardVO = new BoardVO();
		boardVO.setBbsNo(bbsNo);
		model.addAttribute("boardVO", boardVO);
		
		return "admin/board/form";
//		return "board/notice";
		
	}

	/**
	 * 게시판 등록
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/insert")
	public String insert(
			@RequestBody List<MultipartFile> imgFile,
			HttpServletRequest req, BoardVO boardVO,@RequestParam() int bbsNo, Model model, RedirectAttributes ra) {
		String nextPage = "";
		
		
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(boardVO.getBbscttTitle())) {
			errors.put("bbscttTitle", "제목을 입력해주세요");
		}
		if (StringUtils.isBlank(boardVO.getBbscttCn())) {
			errors.put("bbscttCn", "내용을 입력해주세요");
		}
		
		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("boardVO", boardVO);
			nextPage = "admin/board/form";
		}
		else {
				System.out.println(imgFile);
			 int atchFileGroupNo = fileUtil.saveUploadFile(imgFile, TableCode.BOARD);
			 
//			 ResponseEntity<String> entity = null;
			
			CustomUser user =(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			EmployeeVO employeeVO = user.getEmployeeVO();
			
			if (employeeVO != null) {
				boardVO.setEmplNo(employeeVO.getEmplNo());
				boardVO.setBbsNo(bbsNo);
				log.info(">>>>",bbsNo);
				boardVO.setAtchFileGrpNo(atchFileGroupNo);
				Result result = boardService.insertBoard(req, boardVO);
				if (result.equals(Result.OK)) {
					ra.addFlashAttribute("message", "게시글 등록 성공!");
					nextPage = "redirect:/admin/board/detail?bbscttNo=" + boardVO.getBbscttNo();
				}
				else {
					model.addAttribute("message", "다시시도해주세요!");
					nextPage = "admin/board/form";
				}

			}
			else {
				ra.addFlashAttribute("message", "로그인 후에 사용가능합니다!");
				nextPage = "redirect:conn/login"; // 로그인 페이지
			}
		}

		return nextPage;

	}
	
	/**
	 * 게시판 수정폼
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/update")
	public String updateBoardForm(int bbscttNo,@RequestParam(defaultValue = "1")int bbsNo, Model model) {
		BoardVO boardVO = boardService.selectBoard(bbscttNo);
		boardVO.setBbsNo(bbsNo);
		List<AttachFileVO> atchFileList = boardService.selectAtchFileGroupNo(boardVO.getAtchFileGrpNo());
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("atchFileList", atchFileList);
		model.addAttribute("status", "u");
		return "admin/board/form";
	}
	/**
	 * 게시판 수정
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/update")
	public String update(List<MultipartFile> imgFile, HttpServletRequest req, RedirectAttributes ra, BoardVO boardVO, Model model) {
		String nextPage = "";
		boolean flag = true;
		
		Integer[] delAttachFileNo = boardVO.getDelAttachFileNo();
		if(delAttachFileNo != null && delAttachFileNo.length > 0) {
			for (Integer attachFileNo : delAttachFileNo) {
				fileUtil.attachFileDelete(attachFileNo);
			}
		}
		
		for (MultipartFile multipartFile : imgFile) {
			String name = multipartFile.getOriginalFilename().trim();
			if(name == null || name.equals("")) {
				flag = false;
			}
		}
		
		if(flag) {
			fileUtil.updateSaveFile(imgFile, boardVO.getAtchFileGrpNo(), TableCode.BOARD);
		}
		
		Result result = boardService.updateBoard(req, boardVO);
		if (result.equals(Result.OK)) {
			ra.addFlashAttribute("message", "게시글 수정이 완료되었습니다!");
			nextPage = "redirect:/admin/board/detail?bbscttNo=" + boardVO.getBbscttNo();
		}
		else {
			model.addAttribute("boardVO", boardVO);
			model.addAttribute("message", "다시 시도해주세요!");
			model.addAttribute("status", "u");
			nextPage = "admin/board/form";
		}
		return nextPage;
	}

	/**
	 * 게시판 삭제
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/delete")
	public @ResponseBody String deleteBoard(HttpServletRequest req, RedirectAttributes ra, @RequestParam int bbscttNo, Model model) {
		String nextPage = "";
		Result result = boardService.deleteBoard(req, bbscttNo);
//		if (result.equals(Result.OK)) {
//			ra.addFlashAttribute("message", "게시글 삭제가 완료되었습니다!");
//			nextPage = "redirect:/admin/board";
//		}
//		else {
//			ra.addFlashAttribute("message", "다시 시도해주세요!");
//			nextPage = "redirect:/admin/board/detail?bbscttNo=" + bbscttNo; // 수정된 부분
//		}
		return result.toString();
	}
	
	/**
	 * 게시판 파일 다운로드
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")	// 스프링 시큐리티 적용(ROLE_MEMBER 역할만 접근 가능)
	@RequestMapping(value="/download", method = RequestMethod.GET)
	public ResponseEntity<byte[]> fileDownload(int fileNo) throws IOException{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileName = null;
		AttachFileVO fileVO = boardService.selectFileInfo(fileNo);
		if(fileVO != null) {
			fileName = fileVO.getAtchFileNm();
			try {
				String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
//				MediaType mType = FileUtil.getMediaType(formatName);
				
				HttpHeaders headers = new HttpHeaders();
				in = new FileInputStream(fileVO.getAtchFilePath());
				
//				if(mType != null) {
//					headers.setContentType(mType);
//				}else {
					fileName = fileName.substring(fileName.indexOf("_") + 1);
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment; filename=\"" + 
							new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
//				}
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			}catch(Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}finally {
				in.close();
			}
		}else {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	/**
	 * 게시판 통계
	 * 많이 조회된 게시글
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 * @throws Exception 
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/stat")
	public String statistics(BoardVO boardVO,Model model) throws Exception {
		List<BoardVO> boardCntList = boardService.getBoardCntChart(boardVO);
		List<BoardVO> answerCntList = boardService.getAnswerCntChart(boardVO);
		List<BoardVO> boardViewRankList = boardService.getTopFiveBoardViewChart(boardVO);
		List<BoardVO> boardWriteList = boardService.getHoursBoardWritingChart(boardVO);
		
		model.addAttribute("boardCntList", mapper.writeValueAsString(boardCntList));
		model.addAttribute("answerCntList", mapper.writeValueAsString(answerCntList));
		model.addAttribute("boardViewRankList", mapper.writeValueAsString(boardViewRankList));
		model.addAttribute("boardWriteList", mapper.writeValueAsString(boardWriteList));
		
		return "admin/board/board_statistics";
	}
	
}// end
