package kr.or.ddit.groupware.controller.addressbook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.service.addressbook.IAddressBookService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AddressBookVO;
import kr.or.ddit.groupware.vo.AddressGroupMappingVO;
import kr.or.ddit.groupware.vo.AddressGroupVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 주소록 컨트롤러
 * 
 * @author <strong>이영주</strong>
 * @version 1.0
 * @see AddressBookController
 */
@Slf4j
@Controller
@RequestMapping("/address")
public class AddressBookController {

	@Inject
	private IAddressBookService addressService;

	/**
	 * 주소록 리스트 페이지 출력
	 * 
	 * @author <strong>이영주</strong>
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/addressbook")
	public String selectAddressList(Model model) {

		return "address/addressList";
	}

	/**
	 * 주소록 사원리스트 출력
	 * 
	 * @author <strong>이영주</strong>
	 * @param model 보여줄 사원주소록 데이터
	 * @return 주소록 사원리스트
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/employeeAddressList")
	public String selectEmployeeAddressList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		int emplNo = employeeVO.getEmplNo(); // 사원번호 가져오기
		/**
		 * 페이징
		 */
		PaginationInfoVO<AddressBookVO> pagingVO = new PaginationInfoVO<AddressBookVO>();
		pagingVO.setEmplNo(emplNo);
		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);

		// totalRecord라는 총 게시글 수
		int totalRecord = addressService.totalEmployeeCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<AddressBookVO> dataList = addressService.selectEmployeeAddressList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		List<AddressBookVO> addressGrpList = addressService.selectAddressGrpList(emplNo);

		model.addAttribute("addressGrpList", addressGrpList);

		return "address/employeeAddressList";
	}
	
	
	@GetMapping(value = "/searchResult", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectSearchResultList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		
		int emplNo = employeeVO.getEmplNo(); // 사원번호 가져오기
		/**
		 * 페이징
		 */
		PaginationInfoVO<AddressBookVO> pagingVO = new PaginationInfoVO<AddressBookVO>();
		pagingVO.setEmplNo(emplNo);
		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);
		
		// totalRecord라는 총 게시글 수
		int totalRecord = addressService.totalEmployeeCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정
		
		List<AddressBookVO> dataList = addressService.searchResultList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		ObjectMapper mapper = new ObjectMapper();
		String searchList = mapper.writeValueAsString(dataList);
		
		return new ResponseEntity<String>(searchList,HttpStatus.OK);
	}

	/**
	 * 주소록 메인(개인주소록) 출력
	 * 
	 * @author <strong>이영주</strong>
	 * @param model
	 * @param 특정사원의 주소록 그룹과 그 그룹에 있는 사람들
	 * @return 주소록 메인페이지(개인주소록)
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/addresstable")
	public String addressTable(Model model, AddressBookVO addressBookVO) {

		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		int emplNo = employeeVO.getEmplNo(); // 사원번호 가져오기

		// 이 사원의 그룹리스트 가져오기
		List<AddressBookVO> addressGrpList = addressService.selectAddressGrpList(emplNo);

		// 이 사원의 가장 위에 있는 그룹넘버
		Integer grpNo = addressService.selectGrpNo(emplNo);

		// grpNo가 null이 아니고 0이 아닌 경우에만 리스트를 가져옴
		List<AddressBookVO> selectPersonalList = null;
		if (grpNo != null && grpNo != 0) {
			// 그룹에 들어있는 사람들 리스트 가져오기
			selectPersonalList = addressService.selectPersonalList(grpNo);
		}
		model.addAttribute("addressGrpList", addressGrpList);
		model.addAttribute("selectPersonalList", selectPersonalList);

		return "address/addressTable";
	}

	/**
	 * @method : selectPersonalList 개인주소록 리스트 출력 메서드 
	 * @auther : <strong>이영주</strong>
	 * @param : adbkGroupNo
	 * @return : ResponseEntity
	 * @date : 2024. 4. 15
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/selectPersonalList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectPersonalList(@RequestParam int adbkGroupNo) throws Exception {

		List<AddressBookVO>selectList = addressService.selectPersonalList(adbkGroupNo);

		ObjectMapper mapper = new ObjectMapper();
		String selectPersonalList = mapper.writeValueAsString(selectList);

		return new ResponseEntity<String>(selectPersonalList, HttpStatus.OK);
	}

	/**
	 * @method : 부서주소록 리스트 출력 (비동기)
	 * @auther : <strong>이영주</strong>
	 * @param :
	 * @return : 부서주소록 리스트
	 * @date : 2024. 4. 11
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/deptAddressBook", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectDeptList() throws Exception {

		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		int emplNo = employeeVO.getEmplNo();
		String deptName = employeeVO.getDeptCode();
		String deptCode = addressService.selectDeptCodeByCodeName(deptName);

		log.info("######################deptName" + deptName);
		// log.info("######################deptCode"+deptCode);

		EmployeeVO newEmployeeVO = new EmployeeVO(); // 다시누르면 deptCode가 NULL로 들어가는거 방지
		newEmployeeVO.setEmplNo(emplNo); // 사원 번호 설정
		newEmployeeVO.setDeptCode(deptName); // 부서 코드 설정

		List<AddressBookVO> selectDeptList = addressService.selectDeptList(newEmployeeVO);
		int deptListCnt = addressService.deptListCnt(newEmployeeVO); // 부서주소록 갯수
		Map<String, Object> responseMap = new HashMap<>();
		responseMap.put("selectDeptList", selectDeptList);
		responseMap.put("deptListCnt", deptListCnt);

		ObjectMapper mapper = new ObjectMapper();
		String jsonResponse = mapper.writeValueAsString(responseMap);

		return new ResponseEntity<String>(jsonResponse, HttpStatus.OK);
	}

	/**
	 * 사원 주소록 수정
	 * 
	 * @author <strong>이영주</strong>
	 * @param addressBookVO
	 * @return ResponseEntity
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/updateEmplAddress")
	public ResponseEntity<String> updateEmplAddress(@RequestBody AddressBookVO addressBookVO) {

		int result = addressService.updateEmplAddress(addressBookVO);

		if (result > 0) {
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	
	/**
	 * @method : updatePsAddress 개인주소록 수정
	 * @auther : <strong>이영주</strong>
	 * @param : addressBookVO
	 * @return : OK, FAILED
	 * @date : 2024. 4. 15
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/updatePsAddress")
	public ResponseEntity<String> updatePsAddress(@RequestBody AddressBookVO addressBookVO) {
		
		Integer adbkEmpl = addressBookVO.getAdbkEmpl();
		int result = 0;
		
		if(adbkEmpl == null || adbkEmpl == 0) {
			result = addressService.updatePsAddress(addressBookVO);
		}else {
			result = addressService.updateEmplAddress(addressBookVO);
		}
		
		if (result > 0) {
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	
//	/**
//	 * @method : quickAddressAdd 빠른추가
//	 * @auther : <strong>이영주</strong>
//	 * @param : addressBookVO
//	 * @return : OK
//	 * @date : 2024. 4. 16
//	 *
//	 */
//	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
//	@PostMapping("/quickAddressAdd")
//	public ResponseEntity<String> quickAddressAdd(@RequestBody AddressBookVO addressBookVO) {
//		
//		int result = addressService.updatePsAddress(addressBookVO);
//		
//		if (result > 0) {
//			return new ResponseEntity<String>("OK", HttpStatus.OK);
//		}
//		else {
//			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
//		}
//	}

	/**
	 * @method : 개인주소록 특정그룹내 특정인원 삭제
	 * @auther : <strong>이영주</strong>
	 * @param : adgmVO
	 * @return : ResponseEntity
	 * @date : 2024. 4. 11
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/deleteAddress")
	public ResponseEntity<String> deleteAddress(@RequestBody AddressGroupMappingVO adgmVO) {

		int result = addressService.deleteAddress(adgmVO);

		if (result > 0) {
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * @method : 개인주소록 내 폴더생성
	 * @auther : <strong>이영주</strong>
	 * @param : AddressGroupVO
	 * @return : ResponseEntity<String>
	 * @date : 2024. 4. 11
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/createFolder")
	public ResponseEntity<String> createFolder(@RequestBody AddressGroupVO adgVO) {

		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		int emplNo = employeeVO.getEmplNo(); // 사원번호 가져오기
		String adbkGrpNm = adgVO.getAdbkGrpNm(); // 생성할 그룹명

		adgVO.setEmplNo(emplNo);
		adgVO.setAdbkGrpNm(adbkGrpNm);

		int result = addressService.createFolder(adgVO);

		if (result > 0) {

			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * @method : 가장 최근에 만든 폴더의 adbkGroupNo 가져오는 메서드
	 * @auther : <strong>이영주</strong>
	 * @param : 사원번호
	 * @return : ResponseEntity<String>(adbkGroupNo, HttpStatus.OK)
	 * @date : 2024. 4. 12
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/getMaxGroupNo")
	public ResponseEntity<String> getMaxGroupNo() throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		int emplNo = employeeVO.getEmplNo();

		int GrpNo = addressService.getMaxGroupNo(emplNo);

		ObjectMapper mapper = new ObjectMapper();
		String adbkGroupNo = mapper.writeValueAsString(GrpNo);

		return new ResponseEntity<String>(adbkGroupNo, HttpStatus.OK);
	}

	/**
	 * @method : 폴더리스트 비동기로 가져오기
	 * @auther : <strong>이영주</strong>
	 * @param : 사원번호
	 * @return : 폴더리스트 addressGrpList
	 * @date : 2024. 4. 12
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/getFolderList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getFolderList() throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		int emplNo = employeeVO.getEmplNo();

		// 이 사원의 그룹리스트 가져오기
		List<AddressBookVO> GrpList = addressService.selectAddressGrpList(emplNo);

		ObjectMapper mapper = new ObjectMapper();
		String addressGrpList = mapper.writeValueAsString(GrpList);

		return new ResponseEntity<String>(addressGrpList, HttpStatus.OK);
	}

	/**
	 * @method : 주소록 외부인원 인서트
	 * @auther : <strong>이영주</strong>
	 * @param : addressBookVO
	 * @return : 인서트 후 화면
	 * @date : 2024. 4. 11
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/insertAddress")
	public ResponseEntity<String> insertAddress(@RequestBody AddressBookVO addressBookVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		int emplNo = employeeVO.getEmplNo(); // 사원번호 가져오기
		
		addressBookVO.setEmplNo(emplNo);

		Result result = addressService.insertAddress(addressBookVO);

		if (result.equals(Result.OK)) {
			// 주소록 추가가 성공한 경우, 그룹에도 추가
			AddressGroupMappingVO adgmVO = new AddressGroupMappingVO();
			adgmVO.setAdbkNo(addressBookVO.getAdbkNo()); // 추가된 주소록의 번호 설정
			adgmVO.setAdbkGrpNo(addressBookVO.getAdbkGroupNo()); // 선택한 그룹 번호 설정

			result = addressService.addAddressToGroup(adgmVO);
			if (result.equals(Result.OK)) {
				return new ResponseEntity<String>("OK", HttpStatus.OK);
			}
			else {
				return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
			}
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * @method : modifyFolderName 폴더이름수정메서드
	 * @auther : <strong>이영주</strong>
	 * @param : adbkGroupNo, adbkGrpNm
	 * @return : ResponseEntity
	 * @date : 2024. 4. 15
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/modifyFolderName")
	public ResponseEntity<String> modifyFolderName(@RequestBody AddressGroupVO addressGroupVO) {

		int result = addressService.modifyFolderName(addressGroupVO);

		if (result > 0) {

			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * @method : deleteFolder 폴더 삭제
	 * @auther : <strong>이영주</strong>
	 * @param : adbkGroupNo
	 * @return : ResponseEntity
	 * @date : 2024. 4. 15
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/deleteFolder")
	public ResponseEntity<String> deleteFolder(@RequestBody AddressGroupVO addressGroupVO) {

		int result = addressService.deleteFolder(addressGroupVO);

		if (result > 0) {

			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	
	/**
	 * @method : 조직도에서 개인주소록 폴더에 추가하는 메서드
	 * @auther : <strong>이영주</strong>
	 * @param : adgmVO
	 * @return : OK, FAILED
	 * @date : 2024. 5. 8
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/addToFolder")
	public ResponseEntity<String> addToFolder(@RequestBody AddressGroupMappingVO adgmVO) {
		
		int result = addressService.addToFolder(adgmVO);
		
		if (result > 0) {;
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
	/**
	 * @method : 그룹에 중복된 사람이 있는지 체크
	 * @auther : <strong>이영주</strong>
	 * @param : adgmVO
	 * @return :
	 * @date : 2024. 5. 8
	 *
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/checkGroupMember")
	public ResponseEntity<String> checkGroupMember(@RequestBody AddressGroupMappingVO adgmVO) {
		
		Integer isMemberExists = addressService.checkGroupMember(adgmVO);
		
		if (isMemberExists == null || isMemberExists > 0) {
		    return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		} else {
		    return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/addMembersToFolder")
	public ResponseEntity<String> addMembersToFolder(@RequestBody AddressGroupMappingVO adgmVO) {
		
		int result = addressService.addMembersToFolder(adgmVO);
		
		if (result > 0) {;
			return new ResponseEntity<String>("OK", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

}
