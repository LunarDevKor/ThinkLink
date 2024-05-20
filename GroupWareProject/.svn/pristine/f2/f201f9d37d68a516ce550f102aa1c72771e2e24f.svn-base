package kr.or.ddit.groupware.controller.employee;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.ClassOfPositionVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DeptVO;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 팀원관리 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see TeamManagementController
 */
@Controller
@RequestMapping("/employee")
public class TeamManagementController {
	
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
	private IApprovalService approvalService;

	@Resource(name = "path")
	private String resourcePath;
	
	/**
	 * 팀원 리스트
	 * 
	 * @author 최소희
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/teamManagement")
	public String teamManagement(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "all") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		
		PaginationInfoVO<EmployeeVO> pagingVO = new PaginationInfoVO<EmployeeVO>();
		
		// 검색이 이뤄지면 아래가 실행됨
		// 검색이 이뤄졌다는 걸 정확하게 확인하기 위해서는 searchWord가 비어있지 않을 때
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		// startRow, endRow, startPage, endPage를 설정
		pagingVO.setCurrentPage(currentPage);
		
		// 접속자 부서코드 추가
		pagingVO.setWord(userVO.getDeptCode());
		
		// totalRecord라는 총 게시글 수
		int totalRecord = service.teamListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);	// totalPage 설정
		
		List<EmployeeVO> dataList = service.selectTeamList(pagingVO);
		pagingVO.setDataList(dataList);
		
		List<EmpAuthorityVO> authList = new ArrayList<EmpAuthorityVO>();
		
		for (EmployeeVO employeeVO : dataList) {
			authList = service.selectAuthList(employeeVO.getEmplNo());
			employeeVO.setAuthList(authList);
		}
		
		model.addAttribute("user",userVO);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("deptNm",dataList.get(0).getDeptNm());
		
		return "employee/teamManagement";
	}
	
	/**
	 * 팀장급의 사원 수정 폼
	 * 
	 * @author 최소희
	 * @param model
	 * @param emplNo
	 * @return employee/employeeForm
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/teamUpdateForm")
	public String teamUpdateForm(Model model, int emplNo) {
		List<DeptVO> deptList = deptService.selectDeptList();
		List<ClassOfPositionVO> clsfList = service.selectClsfList();
		
		EmployeeVO employeeVO = service.selectEmployee2(emplNo);
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("clsfList", clsfList);
		model.addAttribute("empl", employeeVO);
		model.addAttribute("status", "u");
		
		return "employee/teamEmployeeForm";
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
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/update")
	public String employeeUpdate(
			List<MultipartFile> imgFile, List<MultipartFile> signFile, EmployeeVO employeeVO,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date emplEncpn_, RedirectAttributes ra, Model model
			) throws Exception {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int adminNo = userVO.getEmplNo();
		
		// 입사년월
		employeeVO.setEmplEncpn(emplEncpn_);
		// 수정한 admin No
		employeeVO.setUpdusr(adminNo);
		// 패스워드 인코딩
		if(employeeVO.getEmplPassword().length() < 15) {
			employeeVO.setEmplPassword(pe.encode(employeeVO.getEmplPassword()));
		}
		
		boolean flag = true;
		
		for (MultipartFile file : imgFile) {
			if(StringUtils.isBlank(file.getOriginalFilename())) {
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
			if(StringUtils.isBlank(file.getOriginalFilename())) {
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
			return "redirect:teamManagement";
		}
		else {
			model.addAttribute("employeeVO", employeeVO);
			ra.addFlashAttribute("message", "사원정보 수정이 실패하였습니다!");
			return "redirect:teamManagement";
		}
	}
}
