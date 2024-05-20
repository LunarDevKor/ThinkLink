package kr.or.ddit.groupware.controller.employee;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;

/**
 * 사원 컨트롤러
 * 
 * @author <strong>최소희</strong>
 * @version 1.0
 * @see EmployeeController
 */
@Controller
@RequestMapping("/profile")
public class EmployeeController {

	@Inject
	private IEmployeeService service;

	@Inject
	private FileUtil fileUtil;

	@Inject
	private IAttachFileService attachFileService;

	@Resource(name = "path")
	private String resourcePath;

	@Inject
	private PasswordEncoder pe;
	
	/**
	 * 프로필 수정 폼 (select)
	 * 
	 * @author 최소희
	 * @param model
	 * @return 프로필 수정 폼
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping(value = "/form")
	public String selectEmployee(Model model) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		EmployeeVO employeeVO = service.selectEmployee(emplNo);
		System.out.println("프로필폼에 넣을 거 : " + employeeVO);
		model.addAttribute("employee", employeeVO);
		model.addAttribute("user",userVO);
		return "main/profile";
	}

	/**
	 * 프로필 사진 view
	 * 
	 * @param path
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
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
	 * 프로필 수정 프로세스 (update)
	 * 
	 * @author 최소희
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/modify")
	public String profileModify(Model model, EmployeeVO employeeVO, List<MultipartFile> imgFile,
			RedirectAttributes ra) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		employeeVO.setEmplNo(emplNo);
		
		boolean flag = true;
		
		for (MultipartFile file : imgFile) {
			if(StringUtils.isBlank(file.getOriginalFilename())) {
				flag = false;
				break;
			}
		}

		if (flag) {
			int atchFileGroupNo = fileUtil.saveUploadFile(imgFile, TableCode.EMPLOYEE);
			AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(atchFileGroupNo);
			employeeVO.setEmplProflPhoto(attachFileGroupVO.getAttachFileList().get(0).getAtchFileNm());
		}

		Result result = service.updateEmployee(employeeVO);

		if (result.equals(Result.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다!");
			return "redirect:form";
		}
		else {
			model.addAttribute("employeeVO", employeeVO);
			ra.addFlashAttribute("message", "수정이 실패하였습니다!");
			return "redirect:form";
		}
	}

	/**
	 * 패스워드 일치 확인 프로세스 (count)
	 * 
	 * @author 최소희
	 * @param map
	 * @return result 입력 패스워드의 존재 여부
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value = "/pwCheck")
	public ResponseEntity<String> PwCheck(@RequestBody Map<String, String> map) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO userVO = customUser.getEmployeeVO(); 
		int emplNo = userVO.getEmplNo();
		
		String emplPassword = map.get("emplPassword");

		EmployeeVO employeeVO = service.selectEmployee(emplNo);
		String encodedPwd = employeeVO.getEmplPassword();

		Result result = null;

		if (pe.matches(emplPassword, encodedPwd)) {
			result = result.EXIST; // 패스워드 일치
		}
		else {
			result = result.NOTEXIST; // 패스워드 불일치
		}

		if (result.equals(Result.EXIST)) {
			return new ResponseEntity<String>("EXIST", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("NOTEXIST", HttpStatus.OK);
		}
	}
}
