package kr.or.ddit.groupware.controller.memo;

import java.io.Console;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.service.memo.IMemoService;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.MemoVO;
import lombok.extern.slf4j.Slf4j;
import oracle.net.aso.m;

/**
 * 메모 컨트롤러
 * 
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see MemoController
 */

@Slf4j
@Controller
@RequestMapping("/")
public class MemoController {

	@Inject
	private IMemoService memoService;
	@Inject
	private FileUtil fileUtil;
	@Inject
	private IAttachFileService fileService;

	@javax.annotation.Resource(name = "path")
	private String resourcePath;

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping("/note")
	public String note() {
		return "main/memo";
	}

	/**
	 * 메모등록
	 * 
	 * @author <strong>민경선</strong>
	 * @param VO
	 * @return
	 * 
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addNote")
	@ResponseBody
	public ResponseEntity<?> addNote(@RequestParam(value = "imgFile", required = false) List<MultipartFile> imgFile,
			 @RequestParam("memoCn") String noteDescription, MemoVO memoVO) {

		Map<String, Object> response = new HashMap<>();
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if (authentication == null || !(authentication.getPrincipal() instanceof CustomUser)) {
				response.put("message", "Authentication failed");
				return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
			}

			CustomUser user = (CustomUser) authentication.getPrincipal();
			EmployeeVO employeeVO = user.getEmployeeVO();

			if (imgFile != null && !imgFile.isEmpty()) {
				int atchFileGroupNo = fileUtil.saveUploadFile(imgFile, TableCode.MEMO);
				if (atchFileGroupNo != -1) { // 파일 저장이 성공적으로 이루어진 경우에만 번호 설정
					memoVO.setAtchFileGrpupNo(atchFileGroupNo);
				}
				else {
					memoVO.setAtchFileGrpupNo(null); // 파일 저장 실패 또는 파일 없음
				}
			}
			else {
				memoVO.setAtchFileGrpupNo(null); // 파일 없음
			}

			memoVO.setEmplNo(employeeVO.getEmplNo());
			Result res = memoService.addMemo(memoVO);
			if (!res.equals(Result.OK)) {
				response.put("status", "failed");
				response.put("message", "Failed to add memo");
				return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
			}

			response.put("status", "success");
			response.put("memoCn", memoVO.getMemoCn());
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("status", "error");
			response.put("message", "Server error occurred");
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 이미지파일 출력
	 * 
	 * @author <strong>민경선</strong>
	 * @param
	 * @return
	 * 
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/displayFile", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<byte[]> displayFile(@RequestParam("path") String path) {
		log.info("Requested file path: {}", path);
		if (path == null || path.equals("undefined")) {
			log.warn("Invalid file path received: {}", path);
			return ResponseEntity.badRequest().build();
		}
		return fileUtil.getFileEntity(path, false);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getNotes")
	@ResponseBody
	public ResponseEntity<List<MemoVO>> getNotesList() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || !authentication.isAuthenticated()) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}

		CustomUser user = (CustomUser) authentication.getPrincipal();
		EmployeeVO employeeVO = user.getEmployeeVO();

		List<MemoVO> list = memoService.getNotesList(employeeVO.getEmplNo());
		log.info("다음메모리스트" +   list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/getNoteDetail")
	@ResponseBody
	public ResponseEntity<?> getNoteDetail(@RequestParam("id") int noteId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || !authentication.isAuthenticated()) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}

		CustomUser user = (CustomUser) authentication.getPrincipal();
		EmployeeVO employeeVO = user.getEmployeeVO();

		// 메모 정보 조회
		MemoVO memoVO = memoService.getNoteOne(noteId, employeeVO.getEmplNo());
		List<AttachFileVO> attachFiles = new ArrayList<>();

		if (memoVO != null && memoVO.getAtchFileGrpupNo() != null && memoVO.getAtchFileGrpupNo() != 0) {
			AttachFileGroupVO attachFileGroup = fileService.getAttachFileGroup(memoVO.getAtchFileGrpupNo());
			if (attachFileGroup != null) {
				attachFiles = attachFileGroup.getAttachFileList();
				memoVO.setAttachFileList(attachFiles);
			}
		}

		log.info("Memo Details: {}", memoVO);
		log.info("Attached Files: {}", attachFiles);

		// 반환할 객체 준비
		Map<String, Object> result = new HashMap<>();
		result.put("memoVO", memoVO);
		result.put("files", attachFiles); // 첨부 파일 목록 추가

		return ResponseEntity.ok(result);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/updateNote")
	@ResponseBody
	public ResponseEntity<?> updateNote(@ModelAttribute MemoVO memoVO,
			@RequestParam("imageFile") MultipartFile imageFile) {
		Map<String, Object> response = new HashMap<>();

		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if (authentication == null || !(authentication.getPrincipal() instanceof CustomUser)) {
				response.put("message", "Authentication failed");
				return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
			}

			CustomUser user = (CustomUser) authentication.getPrincipal();
			EmployeeVO employeeVO = user.getEmployeeVO();
			memoVO.setEmplNo(employeeVO.getEmplNo());

			if (imageFile != null && !imageFile.isEmpty()) {
				int atchFileGroupNo = fileUtil.saveUploadFile(Collections.singletonList(imageFile), TableCode.MEMO);
				memoVO.setAtchFileGrpupNo(atchFileGroupNo);
			}
			Result result = memoService.updateMemo(memoVO);
			if (result.equals(Result.OK)) {
				response.put("status", "success");
				response.put("memo", memoVO);
				if (memoVO.getAtchFileGrpupNo() != null) {
					AttachFileGroupVO attachFileGroupVO = fileService.getAttachFileGroup(memoVO.getAtchFileGrpupNo());
					response.put("files", attachFileGroupVO.getAttachFileList());
				}
				return ResponseEntity.ok(response);
			}
			else {
				response.put("status", "failed");
				response.put("message", "Failed to update memo");
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
			}
		} catch (Exception e) {
			response.put("status", "error");
			response.put("message", "Error updating note: " + e.getMessage());
			return ResponseEntity.badRequest().body(response);
		}
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@DeleteMapping("/deleteNote")
	@ResponseBody
	public ResponseEntity<?> deleteNote(@RequestParam("id") int noteId) {

		log.info("Received request to delete memo with ID: {}", noteId);
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if (authentication == null || !authentication.isAuthenticated()) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
			}

			CustomUser user = (CustomUser) authentication.getPrincipal();
			EmployeeVO employeeVO = user.getEmployeeVO();
			
			// 메모 삭제 로직 호출
			boolean deleted = memoService.deleteMemo(noteId, employeeVO.getEmplNo());
			if (deleted) {
				return ResponseEntity.ok().body("Note deleted successfully");
			}
			else {
				return ResponseEntity.badRequest().body("Failed to delete note");
			}
		} catch (Exception e) {
			// 오류 처리
			return ResponseEntity.internalServerError()
					.body("An error occurred while deleting the note: " + e.getMessage());
		}
	}

//	@PreAuthorize("hasRole('ROLE_MEMBER')")
//	@PostMapping(value="/FavoriteNote",produces = "text/plain; charset=UTF-8")
//	@ResponseBody
//	public ResponseEntity<String> FavoriteNote(@RequestParam("noteId") int memoNo) {
//	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//	    if (authentication == null || !(authentication.getPrincipal() instanceof CustomUser)) {
//	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("인증된 사용자가 아닙니다.");
//	    }
//
//	    CustomUser customUser = (CustomUser) authentication.getPrincipal();
//	    EmployeeVO userVO = customUser.getEmployeeVO(); 
//	    int emplNo = userVO.getEmplNo();
//	    try {
//	        boolean isFavoriteUpdated = memoService.toggleFavorite(memoNo,emplNo);
//	        if (isFavoriteUpdated) {
//	            return ResponseEntity.ok("즐겨찾기 상태가 변경되었습니다.");
//	        } else {
//	            return ResponseEntity.badRequest().body("즐겨찾기 변경이 실패하였습니다.");
//	        }
//	    } catch (Exception e) {
//	        log.error("즐겨찾기 상태 변경 중 오류 발생", e);
//	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
//	    }
//	}
//	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/FavoriteNote", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> toggleFavoriteNote(@RequestParam("noteId") int memoNo,
	                                                 @RequestParam("isFavorited") boolean isFavorited) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || !(authentication.getPrincipal() instanceof CustomUser)) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("인증된 사용자가 아닙니다.");
	    }

	    CustomUser customUser = (CustomUser) authentication.getPrincipal();
	    EmployeeVO userVO = customUser.getEmployeeVO();
	    int emplNo = userVO.getEmplNo();
	    try {
	        boolean result = memoService.toggleFavorite(memoNo, emplNo, isFavorited);
	        if (result) {
	            String message = isFavorited ? "즐겨찾기에서 해제되었습니다." : "즐겨찾기에 추가되었습니다.";
	            return ResponseEntity.ok(message);
	        } else {
	            return ResponseEntity.badRequest().body("즐겨찾기 변경이 실패하였습니다.");
	        }
	    } catch (Exception e) {
	        log.error("즐겨찾기 상태 변경 중 오류 발생", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
	    }
	}
	
	
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value="/moveToTrash")
	@ResponseBody
	public ResponseEntity<String> moveToTrash(@RequestParam("noteId") int memoNo) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || !(authentication.getPrincipal() instanceof CustomUser)) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("인증된 사용자가 아닙니다.");
	    }

	    CustomUser customUser = (CustomUser) authentication.getPrincipal();
	    EmployeeVO userVO = customUser.getEmployeeVO(); 
	    int emplNo = userVO.getEmplNo();
	    try {
	        boolean isMovedToTrash = memoService.isMovedToTrash(memoNo,emplNo);
	        if (isMovedToTrash) {
	            return ResponseEntity.ok("휴지통으로 이동하였습니다.");
	        } else {
	            return ResponseEntity.badRequest().body("휴지통 이동이 실패하였습니다.");
	        }
	    } catch (Exception e) {
	        log.error("즐겨찾기 상태 변경 중 오류 발생", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
	    }
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value="/getImportantNotes")
	 public ResponseEntity<List<MemoVO>> getImportantMemos() {
			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO userVO = customUser.getEmployeeVO(); 
			int emplNo = userVO.getEmplNo();
			MemoVO memoVO = new MemoVO();
			memoVO.setEmplNo(emplNo);
	        List<MemoVO> importantMemos = memoService.getImportantMemos(emplNo);
	        log.info("다음중요메모리스트" + importantMemos);
	        if (importantMemos.isEmpty()) {
	            return ResponseEntity.noContent().build();
	        }
	        return ResponseEntity.ok(importantMemos);
	    }
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value="/getTrashNotes",produces = "text/plain; charset=UTF-8")
	 public ResponseEntity<List<MemoVO>> getTrashMemos() {
			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO userVO = customUser.getEmployeeVO(); 
			int emplNo = userVO.getEmplNo();
			MemoVO memoVO = new MemoVO();
			memoVO.setEmplNo(emplNo);
	        List<MemoVO> TrashMemos = memoService.getTrashMemos(emplNo);
	        log.info("다음휴지통메모리스트" + TrashMemos);
	        if (TrashMemos.isEmpty()) {
	            return ResponseEntity.noContent().build();
	        }
	        return ResponseEntity.ok(TrashMemos);
	    }
	

}
