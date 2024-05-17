package kr.or.ddit.groupware.mapper.memo;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.groupware.vo.MemoVO;

/**
 * 메모 SQL Mapper
 * @author 민경선
 * @version 1.0
 * @see IMemoMapper
 */
public interface IMemoMapper {

	public int addMemo(MemoVO memoVO);

	public List<MemoVO> getNotesList(int emplNo);

	public MemoVO getNoteOne(@Param("memoNo") int memoNo, @Param("emplNo") int emplNo);

	public int updateMemo(MemoVO memoVO);

	public boolean deleteMemo(@Param("memoNo") int memoNo, @Param("emplNo") int emplNo);

	public int toggleFavorite(@Param("memoNo") int memoNo, @Param("emplNo") int emplNo);

	public int moveToTrash(@Param("memoNo") int memoNo, @Param("emplNo") int emplNo);

	public List<MemoVO> getImportantMemos(int emplNo);

	public List<MemoVO> getTrashMemos(int emplNo);

	public int unfavoriteMemo(@Param("memoNo") int memoNo, @Param("emplNo") int emplNo);

	public int favoriteMemo(@Param("memoNo") int memoNo, @Param("emplNo") int emplNo);

	
	

}
