package kr.or.ddit.groupware.service.employee;

import java.util.List;

import kr.or.ddit.groupware.vo.DeptVO;

/**
 * 공통코드 부서 서비스 인터페이스
 * 
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see IDeptService
 */
public interface IDeptService {

	List<DeptVO> selectDeptListByUpperDeptCode(String deptCode);

	List<DeptVO> selectDeptList();

}
