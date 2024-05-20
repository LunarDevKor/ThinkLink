package kr.or.ddit.groupware.mapper.attendance;

import java.util.List;
import kr.or.ddit.groupware.vo.DclzStatusVO;

/**
 * 근태 SQL Mapper
 * @author 최소희
 * @version 1.0
 * @see IAttendanceMapper
 */
public interface IAttendanceMapper {
	List<DclzStatusVO> selectDclzList(DclzStatusVO dclzStatusVO);
	int updateTime(DclzStatusVO dclzStatusVO);
}
