package kr.or.ddit.groupware.service.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 게시판 서비스 인터페이스
 * @author <strong>최윤서</strong>
 * @version 1.0
 * @see IBoardService
 */
public interface IBoardService {

	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO);

	public BoardVO selectBoard(int bbscttNo);

	public void insert(BoardVO boardVO);

	public Result insertBoard(HttpServletRequest req, BoardVO boardVO);

	public Result updateBoard(HttpServletRequest req, BoardVO boardVO);

	public Result deleteBoard(HttpServletRequest req, int bbscttNo);

	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);

	public AttachFileVO selectFileInfo(int fileNo);

	public List<AttachFileVO> selectAtchFileGroupNo(int groupNo);

	public List<BoardVO> getType(int itemId);

	public int answerCount(int bbscttNo);

	public List<BoardVO> mainBoardList();

	public List<BoardVO> getBoardCntChart(BoardVO boardVO);

	public List<BoardVO> getAnswerCntChart(BoardVO boardVO);

	public List<BoardVO> getTopFiveBoardViewChart(BoardVO boardVO);

	public List<BoardVO> getHoursBoardWritingChart(BoardVO boardVO);

}
