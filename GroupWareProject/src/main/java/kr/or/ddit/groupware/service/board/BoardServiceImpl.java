package kr.or.ddit.groupware.service.board;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.board.IBoardMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 게시판 서비스 구현체
 * @author <strong>최윤서</strong>
 * @version 1.0
 * @see BoardServiceImpl
 */

@Service
public class BoardServiceImpl implements IBoardService {

	@Inject
	private IBoardMapper boardMapper;
	
	
	@Override
	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.selectBoardList(pagingVO);
	}


	@Override
	public BoardVO selectBoard(int bbscttNo) {
		boardMapper.incremenHit(bbscttNo);
		return boardMapper.selectBoard(bbscttNo);
	}


	@Override
	public void insert(BoardVO boardVO) {
		boardMapper.insert(boardVO);
	}


	@Override
	public Result insertBoard(HttpServletRequest req, BoardVO boardVO) {
		Result result = null;
		
		int status = boardMapper.insertBoard(boardVO);
		
		if(status > 0) {
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;  
	}


	@Override
	public Result updateBoard(HttpServletRequest req, BoardVO boardVO) {
		Result result = null;
		int status = boardMapper.updateBoard(boardVO);
		if(status > 0) {
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;
	}


	@Override
	public Result deleteBoard(HttpServletRequest req, int bbscttNo) {
	    Result result = null;
	    BoardVO boardVO = boardMapper.selectBoard(bbscttNo);
	    if (boardVO != null) {
	        // 게시글이 존재하는 경우 삭제 수행
	        int deletedRows = boardMapper.deleteBoard(bbscttNo);
	        if (deletedRows > 0) {
	            result = Result.OK;
	        } else {
	            result = Result.FAILED;
	        }
	    } else {
	        result = Result.FAILED; // 게시글이 존재하지 않음
	    }
	    return result;
	}





	@Override
	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.selectBoardCount(pagingVO);
	}


	@Override
	public AttachFileVO selectFileInfo(int fileNo) {
		return boardMapper.selectFileInfo(fileNo);
	}


	@Override
	public List<AttachFileVO> selectAtchFileGroupNo(int groupNo) {
		return boardMapper.selectAtchFileGroupNo(groupNo);
	}


	@Override
	public List<BoardVO> getType(int itemId) {
		return boardMapper.getType(itemId);
	}


	@Override
	public int answerCount(int bbscttNo) {
		return boardMapper.answerCount(bbscttNo);
	}


	@Override
	public List<BoardVO> mainBoardList() {
		return boardMapper.mainBoardList();
	}


	@Override
	public List<BoardVO> getBoardCntChart(BoardVO boardVO) {
		return boardMapper.getBoardCntChart(boardVO);
	}


	@Override
	public List<BoardVO> getAnswerCntChart(BoardVO boardVO) {
		return boardMapper.getAnswerCntChart(boardVO);
	}


	@Override
	public List<BoardVO> getTopFiveBoardViewChart(BoardVO boardVO) {
		return boardMapper.getTopFiveBoardViewChart(boardVO);
	}


	@Override
	public List<BoardVO> getHoursBoardWritingChart(BoardVO boardVO) {
		return boardMapper.getHoursBoardWritingChart(boardVO);
	}
	
}
