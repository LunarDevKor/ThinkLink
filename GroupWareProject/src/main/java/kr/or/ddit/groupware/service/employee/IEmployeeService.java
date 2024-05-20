package kr.or.ddit.groupware.service.employee;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.ClassOfPositionVO;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 사원 서비스 인터페이스
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see IEmployeeService
 */
public interface IEmployeeService {

	public EmployeeVO selectEmployee(int empNo);
	public Result pwCheck(EmployeeVO employeeVO);
	public Result updateEmployee(EmployeeVO employeeVO);
	public List<EmployeeVO> selectAllEmpl();
	public List<EmployeeVO> selectDeptEmpl(String deptCode);
	public EmployeeEstbsVO selectEstbsByEmplNo(EmployeeEstbsVO estbsVO);
	public List<EmployeeVO> selectAllEmpl2();
	public int insertNewsKeyword(EmployeeEstbsVO estbsVO);
	public int updateNewsKeyword(EmployeeEstbsVO estbsVO);
	public List<EmployeeVO> selectEmplList(PaginationInfoVO<EmployeeVO> pagingVO);
	public int emplListCount(PaginationInfoVO<EmployeeVO> pagingVO);
	public List<EmpAuthorityVO> selectAuthList(int emplNo);
	public List<ClassOfPositionVO> selectClsfList();
	public Result insertEmployee(EmployeeVO employeeVO);
	public Result idCheck(String emplId);
	public Result updateEmplInfo(EmployeeVO employeeVO);
	public Result enabledUpdate(EmployeeVO employeeVO);
	public Result deleteAuth(int emplNo);
	public EmployeeVO selectEmployee2(int emplNo);
	public Result insertEmpAuth(EmpAuthorityVO empAuthorityVO);
	public Result deleteEmployee(int emplNo);
	public List<EmployeeVO> selectAllEmplExceptMe(int emplNo);
	public List<EmployeeVO> selectTeamList(PaginationInfoVO<EmployeeVO> pagingVO);
	public int teamListCount(PaginationInfoVO<EmployeeVO> pagingVO);
	public List<EmployeeVO> selectEmplListStatics();
	public List<EmployeeVO> selectDeptList();
	public List<Integer> getEmployeeCount();
	public List<Map<String, Integer>> getEmployeeAgeChart();
	public List<Map<String, Integer>> getEmployeeDeptChart();
	public List<Map<String, Integer>> getEmployeeAgeGroupChart();
}
