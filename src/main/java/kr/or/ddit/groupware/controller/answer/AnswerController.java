package kr.or.ddit.groupware.controller.answer;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.groupware.service.answer.IAnswerService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;

@RequestMapping("/answer")
@Controller
public class AnswerController {

	@Inject
	private IAnswerService answerService;

	/**
	 * 댓글 등록
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/insert")
	@ResponseBody
	public void insertAnswer(@RequestBody AnswerVO answerVO, Model model) {
		String nextPage = "";
		int answerBbscttNo = answerVO.getBbscttNo();
		String content = answerVO.getReplyCn();
		answerVO.setBbscttNo(answerBbscttNo);
		answerVO.setReplyCn(content);

		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getEmployeeVO();

		if (employeeVO != null) {
			answerVO.setEmplNo(employeeVO.getEmplNo());
			// 게시글번호 내용 전달받기
			// 서비스에 넘기고
			// 세션정보안에 사원번호 꺼내서 answerVO 셋팅
			// 메퍼에 넘기고
			// 쿼리에 전달
			answerService.insertAnswer(answerVO);
		}
	}
	
	/**
	 * 댓글 목록
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@GetMapping("")
	public List<AnswerVO> selectAnswer(Model model, @RequestParam("bbscttNo")int bbscttNo ) {
		List<AnswerVO> answerList =  answerService.selectAnswer(bbscttNo);
		
		return answerList;
	}
	/**
	 * 댓글 수정
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping("/update")
	public String modifyAnswer(@RequestBody AnswerVO answerVO ) {
		return answerService.updateAnswer(answerVO);
	}
	
	/**
	 * 댓글 삭제
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping("/delete")
	public String deleteAnswer(@RequestBody AnswerVO answerVO) {
		return answerService.deleteAnswer(answerVO);
	}

	
	/**
	 * 대댓글 등록
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/insert2")
	@ResponseBody
	public void insertReply(@RequestBody AnswerVO answerVO) {
		
		int answerBbscttNo = answerVO.getBbscttNo();
		int answerNo = answerVO.getAnswerNo();
		String content = answerVO.getReplyCn();
		String answerDp = answerVO.getAnswerDp();
				
		answerVO.setBbscttNo(answerBbscttNo);
		answerVO.setAnswerNo(answerNo);
		answerVO.setReplyCn(content);
		answerVO.setAnswerDp(answerDp);
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = user.getEmployeeVO();

		if (employeeVO != null) {
			answerVO.setEmplNo(employeeVO.getEmplNo());
			// 게시글번호 내용 전달받기
			// 서비스에 넘기고
			// 세션정보안에 사원번호 꺼내서 answerVO 셋팅
			// 메퍼에 넘기고
			// 쿼리에 전달
			answerService.insertAnswer2(answerVO);
		}
	}
	
	/**
	 * 대댓글 목록
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@GetMapping("reply")
	public List<AnswerVO> selectReply(@RequestParam("upperAnswerNo")int upperAnswerNo ) {
		List<AnswerVO> replyList =  answerService.selectReply(upperAnswerNo);
		
		return replyList;
	}
	
	/**
	 * 대댓글 수정
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping("/update2")
	public String modifyReply(@RequestBody AnswerVO answerVO ) {
		System.out.println("###"+answerVO);
		return answerService.updateReply(answerVO);
	}
	
	/**
	 * 대댓글 삭제
	 * 
	 * @author <strong>최윤서</strong>
	 * @version 1.0
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping("/delete2")
	public String deleteReply(@RequestBody AnswerVO answerVO) {
		return answerService.deleteReply(answerVO);
	}
}
