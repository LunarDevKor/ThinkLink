package kr.or.ddit.groupware.controller.employee;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.groupware.service.addressbook.IAddressBookService;
import kr.or.ddit.groupware.service.approval.IApprovalService;
import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.employee.IDeptService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.AddressBookVO;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.ClassOfPositionVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DeptVO;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 사원관리 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see EmplManagementController
 */
@Controller
@RequestMapping("/admin/employee")
public class EmplManagementController {

	@Inject
	private IEmployeeService service;

	@Inject
	private IDeptService deptService;

	@Inject
	private FileUtil fileUtil;

	@Inject
	private IAttachFileService attachFileService;

	@Inject
	private PasswordEncoder pe;

	@Inject
	private IAddressBookService addressService;

	@Inject
	private IApprovalService approvalService;

	@Resource(name = "path")
	private String resourcePath;

	/**
	 * 프로필 사진 view
	 * 
	 * @param path
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/view/{path}")
	public ResponseEntity<byte[]> downloadFile(@PathVariable String path) {
		path = resourcePath + "employee/" + path;
		System.out.println("이미지 주소 : " + path);
		ResponseEntity<byte[]> entity = null;
		File file = new File(path);
		if (file.exists()) {
			entity = fileUtil.getFileEntity(path, false); // false view, true download
		}

		return entity;
	}

	/**
	 * 정상 사원 리스트
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return admin/employee/normalManagement
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/normalManagement")
	public String normalEmployeeList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {

		PaginationInfoVO<EmployeeVO> pagingVO = new PaginationInfoVO<EmployeeVO>();

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

		// 사원 이용상태 추가
		pagingVO.setEnabled(1);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.emplListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmployeeVO> dataList = service.selectEmplList(pagingVO);
		pagingVO.setDataList(dataList);

		List<EmpAuthorityVO> authList = new ArrayList<EmpAuthorityVO>();

		for (EmployeeVO employeeVO : dataList) {
			authList = service.selectAuthList(employeeVO.getEmplNo());
			employeeVO.setAuthList(authList);
		}

		// 퇴사자 수 구하기
		pagingVO.setEnabled(0);
		int stopCount = service.emplListCount(pagingVO);

		model.addAttribute("normalCount", totalRecord);
		model.addAttribute("stopCount", stopCount);
		model.addAttribute("pagingVO", pagingVO);

		return "admin/employee/normalManagement";
	}

	/**
	 * 중지 사원 리스트
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return admin/employee/stopManagement
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/stopManagement")
	public String StopEmployeeList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {

		PaginationInfoVO<EmployeeVO> pagingVO = new PaginationInfoVO<EmployeeVO>();

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

		// 사원 이용상태 추가
		pagingVO.setEnabled(0);

		// totalRecord라는 총 게시글 수
		int totalRecord = service.emplListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage 설정

		List<EmployeeVO> dataList = service.selectEmplList(pagingVO);
		pagingVO.setDataList(dataList);

		List<EmpAuthorityVO> authList = new ArrayList<EmpAuthorityVO>();

		for (EmployeeVO employeeVO : dataList) {
			authList = service.selectAuthList(employeeVO.getEmplNo());
			employeeVO.setAuthList(authList);
		}

		// 재직자 수 구하기
		pagingVO.setEnabled(1);
		int normalCount = service.emplListCount(pagingVO);

		model.addAttribute("stopCount", totalRecord);
		model.addAttribute("normalCount", normalCount);
		model.addAttribute("pagingVO", pagingVO);

		return "admin/employee/stopManagement";
	}

	/**
	 * 사원등록 폼
	 * 
	 * @author 최소희
	 * @param model
	 * @return admin/employee/employeeForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/form")
	public String employeeForm(Model model) {
		List<DeptVO> deptList = deptService.selectDeptList();
		List<ClassOfPositionVO> clsfList = service.selectClsfList();

		model.addAttribute("deptList", deptList);
		model.addAttribute("clsfList", clsfList);

		return "admin/employee/employeeForm";
	}

	/**
	 * 사원등록 프로세스
	 * 
	 * @author 최소희
	 * @param imgFile
	 * @param signFile
	 * @param employeeVO
	 * @param emplEncpn_
	 * @param ra
	 * @param model
	 * @return form
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/insert")
	public String employeeForm(List<MultipartFile> imgFile, List<MultipartFile> signFile, EmployeeVO employeeVO,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date emplEncpn_, RedirectAttributes ra, Model model)
			throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int adminNo = userVO.getEmplNo();

		// 입사년월
		employeeVO.setEmplEncpn(emplEncpn_);
		// 등록한 admin No
		employeeVO.setRegister(adminNo);
		// 패스워드 인코딩
		employeeVO.setEmplPassword(pe.encode(employeeVO.getEmplPassword()));

		// 프로필 이미지
		if (imgFile != null && !imgFile.isEmpty()) {
			int atchFileGroupNo = fileUtil.saveUploadFile(imgFile, TableCode.EMPLOYEE);
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(atchFileGroupNo);
			employeeVO.setEmplProflPhoto(attachFileGroupVO.getAttachFileList().get(0).getAtchFileNm());
		}

		// 서명 이미지
		if (signFile != null && !signFile.isEmpty()) {
			String emplSign = "data:image/png;base64," + Base64.getEncoder().encodeToString(signFile.get(0).getBytes());
			employeeVO.setEmplSign(emplSign);
		}

		Result result = service.insertEmployee(employeeVO);

		// 등록된 직원의 emplNo
		int emplNo = employeeVO.getEmplNo();
		// 직원등록시 주소록에 사원 전체 넣어주기
		addressService.allInsertEmployeeAds(emplNo);
		if (result.equals(Result.OK)) {
			ra.addFlashAttribute("message", "사원 등록이 완료되었습니다!");
			return "redirect:form";
		}
		else {
			model.addAttribute("employeeVO", employeeVO);
			ra.addFlashAttribute("message", "사원 등록이 실패하였습니다!");
			return "redirect:form";
		}
	}

	/**
	 * 아이디 중복체크
	 * 
	 * @author 최소희
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/idCheck")
	public ResponseEntity<String> idCheck(@RequestBody Map<String, String> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int adminNo = userVO.getEmplNo();
		String emplId = map.get("emplId");

		Result result = null;

		result = service.idCheck(emplId);

		if (result.equals(Result.EXIST)) {
			return new ResponseEntity<String>("EXIST", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("NOTEXIST", HttpStatus.OK);
		}
	}

	/**
	 * 사원 수정 폼
	 * 
	 * @author 최소희
	 * @param model
	 * @param emplNo
	 * @return admin/employee/employeeForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/updateForm")
	public String employeeUpdateForm(Model model, int emplNo) {
		List<DeptVO> deptList = deptService.selectDeptList();
		List<ClassOfPositionVO> clsfList = service.selectClsfList();

		EmployeeVO employeeVO = service.selectEmployee2(emplNo);

		model.addAttribute("deptList", deptList);
		model.addAttribute("clsfList", clsfList);
		model.addAttribute("empl", employeeVO);
		model.addAttribute("status", "u");

		return "admin/employee/employeeForm";
	}

	/**
	 * 사원 수정 프로세스
	 * 
	 * @author 최소희
	 * @param imgFile
	 * @param signFile
	 * @param employeeVO
	 * @param emplEncpn_
	 * @param ra
	 * @param model
	 * @return normalManagement
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/update")
	public String employeeUpdate(List<MultipartFile> imgFile, List<MultipartFile> signFile, EmployeeVO employeeVO,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date emplEncpn_, RedirectAttributes ra, Model model)
			throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int adminNo = userVO.getEmplNo();

		// 입사년월
		employeeVO.setEmplEncpn(emplEncpn_);
		// 수정한 admin No
		employeeVO.setUpdusr(adminNo);
		// 패스워드 인코딩
		if (employeeVO.getEmplPassword().length() < 15) {
			employeeVO.setEmplPassword(pe.encode(employeeVO.getEmplPassword()));
		}

		boolean flag = true;

		for (MultipartFile file : imgFile) {
			if (StringUtils.isBlank(file.getOriginalFilename())) {
				flag = false;
				break;
			}
		}

		// 프로필 이미지
		if (flag) {
			int atchFileGroupNo = fileUtil.saveUploadFile(imgFile, TableCode.EMPLOYEE);
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(atchFileGroupNo);
			employeeVO.setEmplProflPhoto(attachFileGroupVO.getAttachFileList().get(0).getAtchFileNm());
		}

		for (MultipartFile file : signFile) {
			if (StringUtils.isBlank(file.getOriginalFilename())) {
				flag = false;
				break;
			}
		}

		// 서명 이미지
		if (flag) {
			String emplSign = "data:image/png;base64," + Base64.getEncoder().encodeToString(signFile.get(0).getBytes());
			employeeVO.setEmplSign(emplSign);
		}

		Result result = service.updateEmplInfo(employeeVO);

		if (result.equals(Result.OK)) {
			ra.addFlashAttribute("message", "사원정보 수정이 완료되었습니다!");
			return "redirect:normalManagement";
		}
		else {
			model.addAttribute("employeeVO", employeeVO);
			ra.addFlashAttribute("message", "사원정보 수정이 실패하였습니다!");
			return "redirect:normalManagement";
		}
	}

	/**
	 * 사원 중지, 중지해제 프로세스
	 * 
	 * @author 최소희
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/enabledUpdate")
	public ResponseEntity<String> enabledUpdate(@RequestBody Map<String, Integer> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int adminNo = userVO.getEmplNo();

		int emplNo = map.get("emplNo");

		EmployeeVO employeeVO = service.selectEmployee(emplNo);
		employeeVO.setUpdusr(adminNo);

		if (employeeVO.getEnabled().equals("1")) {
			employeeVO.setEnabled("0");
		}
		else {
			employeeVO.setEnabled("1");
		}

		Result result = service.enabledUpdate(employeeVO);

		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 관리자 권한 해제 프로세스
	 * 
	 * @author 최소희
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/deleteAuth")
	public ResponseEntity<String> deleteAuth(@RequestBody Map<String, Integer> map) {
		int emplNo = map.get("emplNo");

		Result result = service.deleteAuth(emplNo);

		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 관리자 권한 부여 프로세스
	 * 
	 * @author 최소희
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/insertAuth")
	public ResponseEntity<String> insertAuth(@RequestBody Map<String, Integer> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int adminNo = userVO.getEmplNo();

		int emplNo = map.get("emplNo");

		EmpAuthorityVO empAuthorityVO = new EmpAuthorityVO();
		empAuthorityVO.setEmplNo(emplNo);
		empAuthorityVO.setRegister(adminNo);
		empAuthorityVO.setAuthorNm("ROLE_ADMIN");

		Result result = service.insertEmpAuth(empAuthorityVO);

		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 사원 삭제(퇴사자 관리) 프로세스
	 * 
	 * @author 최소희
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping("/deleteEmployee")
	public ResponseEntity<String> deleteEmployee(@RequestBody Map<String, Integer> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO();
		int adminNo = userVO.getEmplNo();

		int emplNo = map.get("emplNo");

		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmplNo(emplNo);
		employeeVO.setUpdusr(adminNo);
		employeeVO.setEnabled("2");

		Result result = service.enabledUpdate(employeeVO);

		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("FAILED", HttpStatus.BAD_REQUEST);
		}
	}
}
