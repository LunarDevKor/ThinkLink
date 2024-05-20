package kr.or.ddit.groupware.mapper.employee;

import java.util.List;
import java.util.Map;

import kr.or.ddit.groupware.mapper.addressbook.IAddressBookMapper;
import kr.or.ddit.groupware.vo.ClassOfPositionVO;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.EmployeeDetailVO;
import kr.or.ddit.groupware.vo.EmployeeEstbsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 사원 SQL Mapper
 * @author 최소희
 * @version 1.0
 * @see IAddressBookMapper
 */
public interface IEmployeeMapper {
	public EmployeeVO selectEmployee(int empNo);
	public int pwCheck(EmployeeVO employeeVO);
	public int updateEmployee(EmployeeVO employeeVO);
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
	public int insertEmployee(EmployeeVO employeeVO);
	public void insertEmplDetail(EmployeeDetailVO employeeDetailVO);
	public int insertEmpAuth(EmpAuthorityVO empAuthorityVO);
	public int idCheck(String emplId);
	public int updateEmplInfo(EmployeeVO employeeVO);
	public void updateEmplDetail(EmployeeDetailVO employeeDetailVO);
	public int enabledUpdate(EmployeeVO employeeVO);
	public int deleteAuth(int emplNo);
	public EmployeeVO selectEmployee2(int emplNo);
	public int deleteEmployee(int emplNo);
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
