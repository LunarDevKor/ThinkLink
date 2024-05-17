package kr.or.ddit.groupware.service.attendance;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.DclzStatusVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 근태 서비스 인터페이스
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see IAttendanceService
 */
public interface IAttendanceService {
	List<DclzStatusVO> selectDclzList(DclzStatusVO dclzStatusVO);
	Result updateTime(DclzStatusVO dclzStatusVO);
}
