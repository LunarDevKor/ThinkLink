package kr.or.ddit.groupware.service.addressbook;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AddressBookVO;
import kr.or.ddit.groupware.vo.AddressGroupMappingVO;
import kr.or.ddit.groupware.vo.AddressGroupVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 주소록 서비스 인터페이스
 * @author <strong>이영주</strong>
 * @version 1.0
 * @see IAddressBookService
 */
public interface IAddressBookService {

//	public List<AddressBookVO> selectEmployeeAddressList(int emplNo);

//	public int totalEmployeeCnt(int emplNo);

	public Result insertAddress(AddressBookVO addressBookVO);

	public List<AddressBookVO> selectAddressGrpList(int emplNo);

	public int updateEmplAddress(AddressBookVO addressBookVO);

	
	public List<AddressBookVO> selectEmployeeAddressList(PaginationInfoVO<AddressBookVO> pagingVO);

	public int totalEmployeeCnt(PaginationInfoVO<AddressBookVO> pagingVO);
	
	// 그룹넘버가져오기
	public Integer selectGrpNo(int emplNo);
	//그룹에 있는 사람들 가져오기 
	public List<AddressBookVO> selectPersonalList(int grpNo);

	public int deleteAddress(AddressGroupMappingVO adgmVO);

	public List<AddressBookVO> selectDeptList(EmployeeVO employeeVO);

	public String selectDeptCodeByCodeName(String deptCode);
	// 그룹 생성
	public int createFolder(AddressGroupVO adgVO);

	public int getMaxGroupNo(int emplNo);

	public Result addAddressToGroup(AddressGroupMappingVO adgmVO);

	public int deptListCnt(EmployeeVO newEmployeeVO);

	public int modifyFolderName(AddressGroupVO addressGroupVO);

	public int deleteFolder(AddressGroupVO addressGroupVO);
	//개인주소록 수정
	public int updatePsAddress(AddressBookVO addressBookVO);

	public List<AddressBookVO> searchResultList(PaginationInfoVO<AddressBookVO> pagingVO);

	public int allInsertEmployeeAds(int emplNo);

	public int addToFolder(AddressGroupMappingVO adgmVO);

	public Integer checkGroupMember(AddressGroupMappingVO adgmVO);

	public int addMembersToFolder(AddressGroupMappingVO adgmVO);

}
