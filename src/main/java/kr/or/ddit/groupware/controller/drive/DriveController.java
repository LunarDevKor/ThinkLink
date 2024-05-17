package kr.or.ddit.groupware.controller.drive;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.service.drive.IDriveService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DriveFolderVO;
import kr.or.ddit.groupware.vo.DriveItemVO;
import kr.or.ddit.groupware.vo.DriveVO;
import kr.or.ddit.groupware.vo.LogVO;

/**
 * 자료실 컨트롤러
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see DriveController
 */
@Controller
@RequestMapping("/drive")
public class DriveController extends CommonAbstractImpl {

	@Inject
	private IDriveService driveService;
	
	ObjectMapper mapper = new ObjectMapper();
	
	/**
	 * @method : driveMain
	 * @auther : <strong>이명문</strong>
	 * @return : drive/drvie_main
	 * @date : 2024. 4. 26
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("")
	public String driveMain() {

		return "drive/drive_main";
	}
	
	
	/**
	 * @method : driveUpload
	 * @auther : <strong>이명문</strong>
	 * @param  : files - 업로드할 파일 리스트
	 * @return : 
	 * @date : 2024. 4. 27
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/upload")
	public ResponseEntity<String> driveUpload(DriveVO driveVO) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(driveVO.getFldrType().equals("1")) {
			driveVO.setDeptCode(user.getEmployeeVO().getDeptCode());
		}
		Result result = driveService.saveUploadFiles(driveVO);
		return ResponseEntity.ok(result.toString());
	}
	
	/**
	 * @method : selectDriveMainFiles
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 27
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/files", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> selectDriveMainFiles(DriveItemVO driveItemVO) throws Exception {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		driveItemVO.setEmplNo(user.getEmployeeVO().getEmplNo());
		if(driveItemVO.getFldrType().equals("1")) {
			driveItemVO.setDeptCode(user.getEmployeeVO().getDeptCode());
		}
		List<DriveItemVO> driveList = driveService.selectDriveMainFiles(driveItemVO);
		return ResponseEntity.ok(mapper.writeValueAsString(driveList));
	}
	
	/**
	 * @method : imageFileView
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 27
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping(value = "/view", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<byte[]> imageFileView(String filePath) {
		System.out.println(filePath);
		return driveService.imageFileView(filePath);
	}
	
	/**
	 * @method : createNewFolder
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 28
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/newfolder", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Integer> createNewFolder(@RequestBody DriveFolderVO driveFolderVO) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(driveFolderVO.getFldrType().equals("1")) {
			driveFolderVO.setDeptCode(user.getEmployeeVO().getDeptCode());
		}
		int folderNo = driveService.createNewFolder(driveFolderVO);
		return ResponseEntity.ok(folderNo);
	}
	
	/**
	 * @method : getFolder
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 28
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping(value = "/getfolder", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> getFolder(DriveFolderVO driveFolderVO) throws Exception {
		List<DriveFolderVO> folderList = driveService.getFolder(driveFolderVO);
		return ResponseEntity.ok(mapper.writeValueAsString(folderList));
	}
	
	/**
	 * @method : deleteFile
	 * @auther : <strong>이명문</strong>
	 * @param  :
	 * @return :
	 * @date : 2024. 4. 28
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/del", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> deleteFile(@RequestBody DriveItemVO driveItemVO) {
		Result result = driveService.deleteFile(driveItemVO);
		return ResponseEntity.ok(result.toString());
	}
	
	/**
	 * @method : fileMove
	 * @auther : <strong>이명문</strong>
	 * @param  :
	 * @return :
	 * @date : 2024. 4. 29
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/filemove", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> fileMove(@RequestBody DriveItemVO driveItemVO) {
		Result result = driveService.fileMove(driveItemVO);
		return ResponseEntity.ok(result.toString());
	}
	
	
	/**
	 * @method : editName
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 28
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/editname")
	public ResponseEntity<String> editName(DriveItemVO driveItemVO) {
		Result result = driveService.editName(driveItemVO);
		return ResponseEntity.ok(result.toString());
	}
	
	
	/**
	 * @method : searchDrive
	 * @auther : <strong>이명문</strong>
	 * @param  :
	 * @return :
	 * @throws Exception 
	 * @date : 2024. 4. 29
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> searchDrive(DriveItemVO driveItemVO) throws Exception {
		List<DriveItemVO> driveItemList = driveService.searchDrive(driveItemVO);
		return ResponseEntity.ok(mapper.writeValueAsString(driveItemList));
	}
	
	/**
	 * @method : downloadFile
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 5
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/download")
	public ResponseEntity<byte[]> downloadFile(int itemNo) {
		return driveService.downloadFile(itemNo);
	}
	
	/**
	 * @method : getFileLog
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 6
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/getlog")
	public @ResponseBody List<LogVO> getFileLog(DriveItemVO driveItemVO) {
		List<LogVO> logList = driveService.getLog(driveItemVO);
		return logList;
	}
	
	/**
	 * @method : getAllLog
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 5. 7
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/alllog")
	public @ResponseBody List<LogVO> getAllLog(DriveItemVO driveItemVO) {
		List<LogVO> logList = driveService.getAllLog(driveItemVO);
		return logList;
	}
}
