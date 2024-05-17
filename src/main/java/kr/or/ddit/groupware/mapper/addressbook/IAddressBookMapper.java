package kr.or.ddit.groupware.mapper.addressbook;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AddressBookVO;
import kr.or.ddit.groupware.vo.AddressGroupMappingVO;
import kr.or.ddit.groupware.vo.AddressGroupVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 주소록 SQL Mapper
 * @author 이영주
 * @version 1.0
 * @see IAddressBookMapper
 */
public interface IAddressBookMapper {

	public List<AddressBookVO> selectEmployeeAddressList(int emplNo);

	public int totalEmployeeCnt2(int emplNo);

	public int insertAddress(AddressBookVO addressBookVO);

	public List<AddressBookVO> selectAddressGrpList(int emplNo);

	public int updateEmplAddress(AddressBookVO addressBookVO);

	
	
	public int totalEmployeeCnt(PaginationInfoVO<AddressBookVO> pagingVO);

	public List<AddressBookVO> selectEmployeeAddressList(PaginationInfoVO<AddressBookVO> pagingVO);
	
	// 그룹
	public Integer selectGrpNo(int emplNo);
	public List<AddressBookVO> selectPersonalList(int grpNo);

	public int deleteAddress(AddressGroupMappingVO adgmVO);
	// 부서주소록 리스트 
	public List<AddressBookVO> selectDeptList(EmployeeVO employeeVO);

	public String selectDeptCodeByCodeName(String deptCode);

	public int createFolder(AddressGroupVO adgVO);

	public int getMaxGroupNo(int emplNo);
	
	// 그룹에 외부인원 인서트 
	public int addAddressToGroup(AddressGroupMappingVO adgmVO);

	public int deptListCnt(EmployeeVO newEmployeeVO);

	public int modifyFolderName(AddressGroupVO addressGroupVO);
	//그룹 삭제
	public int deleteFolder(AddressGroupVO addressGroupVO);

	public int updatePsAddress(AddressBookVO addressBookVO);

	public List<AddressBookVO> searchResultList(PaginationInfoVO<AddressBookVO> pagingVO);

	public int allInsertEmployeeAds(int emplNo);

	public int addToFolder(AddressGroupMappingVO adgmVO);

	public Integer checkGroupMember(AddressGroupMappingVO adgmVO);

	public int addMembersToFolder(AddressGroupMappingVO adgmVO);

}
