package kr.or.ddit.groupware.service.memo;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.MemoVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 메모 서비스 인터페이스
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see IMemoService
 */
public interface IMemoService {

	

	public Result addMemo(MemoVO memoVO);

	public List<MemoVO> getNotesList(int emplNo);

	public MemoVO getNoteOne(int noteId, int emplNo);

	public Result updateMemo(MemoVO memoVO);

	public boolean deleteMemo(int noteId, int emplNo);

	public boolean toggleFavorite(int memoNo, int emplNo);

	public boolean isMovedToTrash(int memoNo, int emplNo);

	public List<MemoVO> getImportantMemos(int emplNo);

	public List<MemoVO> getTrashMemos(int emplNo);

	public boolean toggleFavorite(int memoNo, int emplNo, boolean isFavorited);


	

}
