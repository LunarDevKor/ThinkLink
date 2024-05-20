package kr.or.ddit.groupware.service.addressbook;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.addressbook.IAddressBookMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AddressBookVO;
import kr.or.ddit.groupware.vo.AddressGroupMappingVO;
import kr.or.ddit.groupware.vo.AddressGroupVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 주소록 서비스 구현체
 * @author <strong>이영주</strong>
 * @version 1.0
 * @see AddressBookServiceImpl
 */
@Service
public class AddressBookServiceImpl implements IAddressBookService  {
	
	@Inject
	private IAddressBookMapper mapper;
	
//	@Override
//	public List<AddressBookVO> selectEmployeeAddressList(int emplNo) {
//		
//		return mapper.selectEmployeeAddressList(emplNo);
//	}

//	@Override
//	public int totalEmployeeCnt(int emplNo) {
//		return mapper.totalEmployeeCnt2(emplNo);
//	}

	@Override
	public Result insertAddress(AddressBookVO addressBookVO) {
		Result result = null;
		int status = mapper.insertAddress(addressBookVO);
		
		if(status > 0 ) {	// 주소록 인서트 성공
			result = Result.OK;
		}
		else { // 주소록 인서트 실패
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public List<AddressBookVO> selectAddressGrpList(int emplNo) {
		
		return mapper.selectAddressGrpList(emplNo);
	}

	@Override
	public int updateEmplAddress(AddressBookVO addressBookVO) {
		
		
		int result = mapper.updateEmplAddress(addressBookVO);
		
		return result;
	}

	@Override
	public int totalEmployeeCnt(PaginationInfoVO<AddressBookVO> pagingVO) {
		return mapper.totalEmployeeCnt(pagingVO);
	}

	@Override
	public List<AddressBookVO> selectEmployeeAddressList(PaginationInfoVO<AddressBookVO> pagingVO) {
		return mapper.selectEmployeeAddressList(pagingVO);
	}

	@Override
	public Integer selectGrpNo(int emplNo) {
		return mapper.selectGrpNo(emplNo);
	}

	@Override
	public List<AddressBookVO> selectPersonalList(int grpNo) {
		return mapper.selectPersonalList(grpNo);
	}

	@Override
	public int deleteAddress(AddressGroupMappingVO adgmVO) {
		
		int result = mapper.deleteAddress(adgmVO);
		
		return result;
	}

	@Override
	public List<AddressBookVO> selectDeptList(EmployeeVO employeeVO) {
		return mapper.selectDeptList(employeeVO);
	}

	@Override
	public String selectDeptCodeByCodeName(String deptCode) {
		return mapper.selectDeptCodeByCodeName(deptCode);
	}

	@Override
	public int createFolder(AddressGroupVO adgVO) {
		return mapper.createFolder(adgVO);
	}

	@Override
	public int getMaxGroupNo(int emplNo) {
		return mapper.getMaxGroupNo(emplNo);
	}

	@Override
	public Result addAddressToGroup(AddressGroupMappingVO adgmVO) {
		
		Result result = null;
		int status = mapper.addAddressToGroup(adgmVO);
		
		if(status > 0 ) {	// 주소록  그룹 내 인서트 성공
			result = Result.OK;
		}
		else { // 주소록 그룹내 인서트 실패
			result = Result.FAILED;
		}
		return result;
		
	}

	@Override
	public int deptListCnt(EmployeeVO newEmployeeVO) {
		return mapper.deptListCnt(newEmployeeVO);
	}

	@Override
	public int modifyFolderName(AddressGroupVO addressGroupVO) {
		
		int result = mapper.modifyFolderName(addressGroupVO);
		
		return result;
	}

	@Override
	public int deleteFolder(AddressGroupVO addressGroupVO) {
		
		int result = mapper.deleteFolder(addressGroupVO);
		
		return result;
	}

	@Override
	public int updatePsAddress(AddressBookVO addressBookVO) {
		
		int result = mapper.updatePsAddress(addressBookVO);
		
		return result;
	}

	@Override
	public List<AddressBookVO> searchResultList(PaginationInfoVO<AddressBookVO> pagingVO) {
		return mapper.searchResultList(pagingVO);
	}

	@Override
	public int allInsertEmployeeAds(int emplNo) {
		return mapper.allInsertEmployeeAds(emplNo);
	}

	@Override
	public int addToFolder(AddressGroupMappingVO adgmVO) {
		return mapper.addToFolder(adgmVO);
	}

	@Override
	public Integer checkGroupMember(AddressGroupMappingVO adgmVO) {
		
		return mapper.checkGroupMember(adgmVO);
	}

	@Override
	public int addMembersToFolder(AddressGroupMappingVO adgmVO) {
		return mapper.addMembersToFolder(adgmVO);
	}

	

	
	
}
