package kr.or.ddit.groupware.service.employee;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.MapperFeature;

import kr.or.ddit.groupware.mapper.employee.IEmployeeMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ClassOfPositionVO;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.EmployeeDetailVO;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 사원 서비스 구현체
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see EmployeeServiceImpl
 */

@Service
public class EmployeeServiceImpl implements IEmployeeService {

	@Inject
	private IEmployeeMapper mapper;
	
	@Override
	public EmployeeVO selectEmployee(int empNo) {
		return mapper.selectEmployee(empNo);
	}

	@Override
	public Result pwCheck(EmployeeVO employeeVO) {
		Result result = null;
		int status = mapper.pwCheck(employeeVO);
		if(status > 0 ) {	// 패스워드 일치
			result = Result.EXIST;
		}else {				// 패스워드 불일치
			result = Result.NOTEXIST;
		}
		return result;
	}

	@Override
	public Result updateEmployee(EmployeeVO employeeVO) {
		Result result = null;
		int status = mapper.updateEmployee(employeeVO);
		if(status > 0 ) {	// 마이페이지 수정 성공
			result = Result.OK;
		}
		else { // 마이페이지 수정 실패
			result = Result.FAILED;
		}
		return result;
	}

	/**
	 * 전 사원 조회
	 * @author <strong>권예은</strong>
	 * @return 전 사원 emplVO List
	 */
	@Override
	public List<EmployeeVO> selectAllEmpl() {
		return mapper.selectAllEmpl();
	}

	/**
	 * 부서 사원 조회
	 * @author <strong>권예은</strong>
	 * @return 전 사원 emplVO List
	 */
	@Override
	public List<EmployeeVO> selectDeptEmpl(String deptCode) {
		return  mapper.selectDeptEmpl(deptCode);
	}
	
	/**
	 *  사원 옵션 조회
	 *	@author <strong>이명문</strong>
	 *	@param 사원 번호
	 *	@return 사원번호로 조회된 사원옵션정보
	 *	@Date
	 */
	@Override
	public EmployeeEstbsVO selectEstbsByEmplNo(EmployeeEstbsVO estbsVO) {
		return mapper.selectEstbsByEmplNo(estbsVO);
	}
	
	/**
	 *  사원 리스트
	 *	@author <strong>최소희</strong>
	 *	@return 사원 리스트
	 *	@Date
	 */
	@Override
	public List<EmployeeVO> selectAllEmpl2() {
		return mapper.selectAllEmpl2();
	}

	/**
	 * 사원 뉴스키워드 인서트
	 * @author <strong>이영주</strong>
	 * @param 사원 번호, 뉴스 키워드
	 */
	@Override
	public int insertNewsKeyword(EmployeeEstbsVO estbsVO) {
		return mapper.insertNewsKeyword(estbsVO);
	}

	/**
	 * 사원 뉴스키워드 업데이트
	 * @author <strong>이영주</strong>
	 * @param 사원 번호, 뉴스 키워드
	 */
	@Override
	public int updateNewsKeyword(EmployeeEstbsVO estbsVO) {
		return mapper.updateNewsKeyword(estbsVO);
	}

	/**
	 * 이용상태에 따른 사원리스트
	 * @author <strong>최소희</strong>
	 * @param 이용상태 enabled
	 */
	@Override
	public List<EmployeeVO> selectEmplList(PaginationInfoVO<EmployeeVO> pagingVO) {
		return mapper.selectEmplList(pagingVO);
	}

	/**
	 * 이용상태에 따른 사원리스트 명수
	 * @author <strong>최소희</strong>
	 * @param 이용상태 enabled
	 */
	@Override
	public int emplListCount(PaginationInfoVO<EmployeeVO> pagingVO) {
		return mapper.emplListCount(pagingVO);
	}

	/**
	 * 사원의 권한 리스트
	 * @author <strong>최소희</strong>
	 * @param 사원 넘버
	 */
	@Override
	public List<EmpAuthorityVO> selectAuthList(int emplNo) {
		return mapper.selectAuthList(emplNo);
	}

	/**
	 * 직급 리스트
	 * @author <strong>최소희</strong>
	 * @param
	 */
	@Override
	public List<ClassOfPositionVO> selectClsfList() {
		return mapper.selectClsfList();
	}
	
	/**
	 * 사원등록
	 * @author <strong>최소희</strong>
	 * @param 사원 정보
	 */
	@Override
	public Result insertEmployee(EmployeeVO employeeVO) {
		
		Result result = null;
		
		int status = mapper.insertEmployee(employeeVO);
		
		if(status > 0 ) {	
			
			EmployeeDetailVO employeeDetailVO = new EmployeeDetailVO();
			
			employeeDetailVO.setEmplNo(employeeVO.getEmplNo());
			employeeDetailVO.setAccountDpstr(employeeVO.getEmployeeDetailVO().getAccountDpstr());
			employeeDetailVO.setBankAcnutno(employeeVO.getEmployeeDetailVO().getBankAcnutno());
			employeeDetailVO.setBankNm(employeeVO.getEmployeeDetailVO().getBankNm());
			employeeDetailVO.setRegister(employeeVO.getRegister());
			
			// 디테일 인서트
			mapper.insertEmplDetail(employeeDetailVO);
			
			EmpAuthorityVO empAuthorityVO = new EmpAuthorityVO();
			
			empAuthorityVO.setAuthorNm("ROLE_MEMBER");
			empAuthorityVO.setEmplNo(employeeVO.getEmplNo());
			empAuthorityVO.setRegister(employeeVO.getRegister());
			
			// 권한 인서트
			mapper.insertEmpAuth(empAuthorityVO);
			
			result = Result.OK;
		}else {		
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result idCheck(String emplId) {
		Result result = null;
		
		int status = mapper.idCheck(emplId);
		
		if(status > 0) {
			result = Result.EXIST;
		}else {
			result = Result.NOTEXIST;
		}
		return result;
	}

	@Override
	public Result updateEmplInfo(EmployeeVO employeeVO) {
		Result result = null;
		
		int status = mapper.updateEmplInfo(employeeVO);
		
		if(status > 0) {
			
			EmployeeDetailVO employeeDetailVO = new EmployeeDetailVO();
			
			employeeDetailVO.setEmplNo(employeeVO.getEmplNo());
			employeeDetailVO.setAccountDpstr(employeeVO.getEmployeeDetailVO().getAccountDpstr());
			employeeDetailVO.setBankAcnutno(employeeVO.getEmployeeDetailVO().getBankAcnutno());
			employeeDetailVO.setBankNm(employeeVO.getEmployeeDetailVO().getBankNm());
			employeeDetailVO.setUpdusr(employeeVO.getUpdusr());
			
			mapper.updateEmplDetail(employeeDetailVO);
			
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result enabledUpdate(EmployeeVO employeeVO) {
		Result result = null;
		
		int status = mapper.enabledUpdate(employeeVO);
		
		if(status > 0) {
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result deleteAuth(int emplNo) {
		Result result = null;
		
		int status = mapper.deleteAuth(emplNo);
		
		if(status > 0) {
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public EmployeeVO selectEmployee2(int emplNo) {
		return mapper.selectEmployee2(emplNo);
	}

	@Override
	public Result insertEmpAuth(EmpAuthorityVO empAuthorityVO) {
		Result result = null;
		
		int status = mapper.insertEmpAuth(empAuthorityVO);
		
		if(status > 0) {
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public Result deleteEmployee(int emplNo) {
		Result result = null;
		
		int status = mapper.deleteEmployee(emplNo);
		
		if(status > 0) {
			result = Result.OK;
		}else {
			result = Result.FAILED;
		}
		return result;	
	}

	@Override
	public List<EmployeeVO> selectAllEmplExceptMe(int emplNo) {
		return mapper.selectAllEmplExceptMe(emplNo);
	}

	@Override
	public List<EmployeeVO> selectTeamList(PaginationInfoVO<EmployeeVO> pagingVO) {
		return mapper.selectTeamList(pagingVO);
	}

	@Override
	public int teamListCount(PaginationInfoVO<EmployeeVO> pagingVO) {
		return mapper.teamListCount(pagingVO);
	}

	@Override
	public List<EmployeeVO> selectEmplListStatics() {
		return mapper.selectEmplListStatics();
	}

	@Override
	public List<EmployeeVO> selectDeptList() {
		return mapper.selectDeptList();
	}

	@Override
	public List<Integer> getEmployeeCount() {
		return mapper.getEmployeeCount();
	}

	@Override
	public List<Map<String, Integer>> getEmployeeAgeChart() {
		return mapper.getEmployeeAgeChart();
	}

	@Override
	public List<Map<String, Integer>> getEmployeeDeptChart() {
		return mapper.getEmployeeDeptChart();
	}

	@Override
	public List<Map<String, Integer>> getEmployeeAgeGroupChart() {
		return mapper.getEmployeeAgeGroupChart();
	}
}
