package kr.or.ddit.groupware.service.memo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.memo.IMemoMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.MemoVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 메모 서비스 구현체
 * 
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see MemoServiceImpl
 */
@Slf4j
@Service
public class MemoServiceImpl implements IMemoService {

	@Autowired
	private IMemoMapper memoMapper;

	@Override
	public Result addMemo(MemoVO memoVO) {
		Result res = null;
		int cnt = memoMapper.addMemo(memoVO);

		if (cnt > 0) {
			res = Result.OK;

		}
		else {
			res = Result.FAILED;
		}
		return res;
	}

	@Override
	public List<MemoVO> getNotesList(int emplNo) {
		return memoMapper.getNotesList(emplNo);
	}

	@Override
	public MemoVO getNoteOne(int noteId, int emplNo) {

		return memoMapper.getNoteOne(noteId, emplNo);
	}

	@Override
	public Result updateMemo(MemoVO memoVO) {
		Result res = null;
		log.info("Updating memo with ID: {}", memoVO.getMemoNo());
		int cnt = memoMapper.updateMemo(memoVO);
		log.info("Update result: {}", cnt);

		if (cnt > 0) {
			res = Result.OK;

		}
		else {
			res = Result.FAILED;
		}
		return res;
	}

	@Override
	public boolean deleteMemo(int noteId, int emplNo) {
		return memoMapper.deleteMemo(noteId, emplNo);

	}

	@Override
	public boolean toggleFavorite(int memoNo, int emplNo) {

		try {
			int count = memoMapper.toggleFavorite(memoNo, emplNo);
			if (count > 0) {
				log.info("Importance status toggled successfully for memo ID: {}", memoNo);
				return true;
			}
			else {
				log.error("Failed to toggle importance status for memo ID: {}", memoNo);
				return false;
			}
		} catch (Exception e) {
			log.error("Error while toggling importance status for memo ID: {}", memoNo, e);
			return false;
		}
	}

	@Override
	public boolean isMovedToTrash(int memoNo, int emplNo) {
		try {
			int count = memoMapper.moveToTrash(memoNo, emplNo);
			if (count > 0) {
				return true;
			}
			else {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public List<MemoVO> getImportantMemos(int emplNo) {
		
		return memoMapper.getImportantMemos(emplNo);
	}

	@Override
	public List<MemoVO> getTrashMemos(int emplNo) {
		
		return memoMapper.getTrashMemos(emplNo);
		
	}

	@Override
	public boolean toggleFavorite(int memoNo, int emplNo, boolean isFavorited) {
	    try {
	        int count;
	        if (isFavorited) {
	            // If it is already favorited, we need to unfavorite it
	            count = memoMapper.unfavoriteMemo(memoNo, emplNo);
	        } else {
	            // If it is not favorited, we need to favorite it
	            count = memoMapper.favoriteMemo(memoNo, emplNo);
	        }

	        if (count > 0) {
	            String action = isFavorited ? "unfavorited" : "favorited";
	            log.info("Memo ID: {} has been successfully {}.", memoNo, action);
	            return true;
	        } else {
	            log.error("Failed to toggle favorite status for memo ID: {}", memoNo);
	            return false;
	        }
	    } catch (Exception e) {
	        return false;
	    }
	}

	
	
}