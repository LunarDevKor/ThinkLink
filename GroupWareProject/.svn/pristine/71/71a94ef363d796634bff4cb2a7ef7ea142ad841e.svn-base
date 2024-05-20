package kr.or.ddit.groupware.service.employee;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.employee.IDeptMapper;
import kr.or.ddit.groupware.vo.DeptVO;

/**
 * 공통코드 부서 서비스 구현체
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see DeptServiceImpl
 */
@Service
public class DeptServiceImpl implements IDeptService {
	
	@Inject
	private IDeptMapper deptMapper;

	@Override
	public List<DeptVO> selectDeptListByUpperDeptCode(String deptCode) {
		return deptMapper.selectDeptListByUpperDeptCode(deptCode);
	}

	/**
	 * 부서 리스트
	 * @author <strong>최소희</strong>
	 * @param 부서 리스트
	 */
	@Override
	public List<DeptVO> selectDeptList() {
		return deptMapper.selectDeptList();
	}

}
