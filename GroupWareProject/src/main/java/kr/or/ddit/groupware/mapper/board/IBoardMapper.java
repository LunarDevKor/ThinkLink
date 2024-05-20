package kr.or.ddit.groupware.mapper.board;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 게시판 SQL Mapper
 * @author 최윤서
 * @version 1.0
 * @see IBoardMapper
 */
public interface IBoardMapper {

	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO);

	public BoardVO selectBoard(int bbscttNo);

	public void insert(BoardVO boardVO);

	public int insertBoard(BoardVO boardVO);

	public int updateBoard(BoardVO boardVO);

	public int deleteBoard(int bbscttNo);

	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);

	public void incremenHit(int bbscttNo);

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
