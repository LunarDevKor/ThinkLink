package kr.or.ddit.groupware.service.attendance;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.MapperFeature;

import kr.or.ddit.groupware.mapper.attendance.IAttendanceMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.DclzStatusVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 근태 서비스 구현체
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see AttendanceServiceImpl
 */
@Service
public class AttendanceServiceImpl implements IAttendanceService {
	
	@Inject
	private IAttendanceMapper mapper;
	
	@Override
	public List<DclzStatusVO> selectDclzList(DclzStatusVO dclzStatusVO) {
		return mapper.selectDclzList(dclzStatusVO);
	}

	@Override
	public Result updateTime(DclzStatusVO dclzStatusVO) {
		
		Result result = null;
		int status = mapper.updateTime(dclzStatusVO);
		if (status > 0) {
			result = Result.OK;
		}
		else {
			result = Result.FAILED;
		}
		return result;
	}
}
