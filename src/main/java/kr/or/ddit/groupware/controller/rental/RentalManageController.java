package kr.or.ddit.groupware.controller.rental;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.service.rental.IRentalService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.RentalVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/rental")
public class RentalManageController extends CommonAbstractImpl{

	@Inject
	private IRentalService rentalService;
	
	

	/**
	 * 승인신청리스트조회
	 * 
	 * @param currentPage 현재 페이지 번호 (기본값 1)
	 * @param searchWord 검색어
	 * @param model 
	 */
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/approval", produces = MediaType.APPLICATION_JSON_VALUE, method = {RequestMethod.GET, RequestMethod.POST})
	public String approval(
			@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage,
			@RequestParam(required = false)String searchWord, String type,
			Model model) {
		//사원번호가져오기
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		int emplNo = employeeVO.getEmplNo(); 
		
		PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
		pagingVO.setEmplNo(emplNo);
		
//		검색결과가 존재하면
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord",searchWord);
		}
		
//		페이지 설정
		pagingVO.setCurrentPage(currentPage);
//		총 예약내역
		int totalRecord = rentalService.selectAdminRentalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<RentalVO> dataList = rentalService.selectAdminRentalList(pagingVO);
		pagingVO.setDataList(dataList);
		
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "admin/rental/approval";
	
	}
//	 선택한 대여리스트 승인
	 	@PostMapping(value ="/bulkApprove")
	    @ResponseBody
	    public ResponseEntity<?> bulkApproveRentals(@RequestBody RentalVO rentalVO) {
	        try {
	            if (rentalVO.getErntNos() == null || rentalVO.getErntNos().isEmpty()) {
	                return ResponseEntity.badRequest().body("No rental IDs provided");
	            }

	            List<Integer> rentalIds = rentalVO.getErntNos().stream().map(Integer::parseInt).collect(Collectors.toList());
	            Result result = rentalService.bulkApproveRentals(rentalIds);
	            if (result == Result.OK) {
	                return ResponseEntity.ok("Bulk approval successful");
	            } else {
	                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일괄승인 실패");
	            }
	        } catch (NumberFormatException e) {
	            log.error("Error parsing rental IDs: ", e);
	            return ResponseEntity.badRequest().body("유효하지 않은 id포맷입니다");
	        } catch (Exception e) {
	            log.error("Error during bulk approval: ", e);
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일괄승인시 에러발생");
	        }
	    }
//	 선택한 대여리스트 반려
	 	@PostMapping("/bulkReject")
	    @ResponseBody
	    public ResponseEntity<?> bulkRejectRentals(@RequestBody RentalVO rentalVO) {
	        try {
	            if (rentalVO.getErntNos() == null || rentalVO.getErntNos().isEmpty()) {
	                return ResponseEntity.badRequest().body("No rental IDs provided");
	            }

	            List<Integer> rentalIds = rentalVO.getErntNos().stream().map(Integer::parseInt).collect(Collectors.toList());
	            Result result = rentalService.bulkRejectRentals(rentalIds);
	            if (result == Result.OK) {
	                return ResponseEntity.ok("Bulk approval successful");
	            } else {
	                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일괄승인 실패");
	            }
	        } catch (NumberFormatException e) {
	            log.error("Error parsing rental IDs: ", e);
	            return ResponseEntity.badRequest().body("유효하지 않은 id포맷입니다");
	        } catch (Exception e) {
	            log.error("Error during bulk approval: ", e);
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일괄승인시 에러발생");
	        }
	    }
	 	
		/**
		 * 승인처리조회
		 * 
		 * @param currentPage 현재 페이지 번호 (기본값 1)
		 * @param searchWord 검색어
		 * @param model 
		 *
		 */
		@PreAuthorize("hasRole('ROLE_ADMIN')")
		@RequestMapping(value = "/manageApproval", produces = MediaType.APPLICATION_JSON_VALUE, method = {RequestMethod.GET, RequestMethod.POST})
		public String approved(
				@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage,
				@RequestParam(required = false)String searchWord, String type,
				Model model) {
			//사원번호가져오기
			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO employeeVO = customUser.getEmployeeVO();
			int emplNo = employeeVO.getEmplNo(); 
			
			PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
			pagingVO.setEmplNo(emplNo);
			
//			검색결과가 존재하면
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchWord",searchWord);
			}
			
//			페이지 설정
			pagingVO.setCurrentPage(currentPage);
//			총 예약내역
			int totalRecord = rentalService.selectApprovedAdminRentalCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<RentalVO> dataList = rentalService.selectApprovedAdminRentalList(pagingVO);
			pagingVO.setDataList(dataList);
			
			model.addAttribute("pagingVO", pagingVO);
			
			return "admin/rental/manageApproval";
		
		}
		
		/*반납 조회 리스트 
		 * 
		 * @param currentPage 현재 페이지 번호 (기본값 1)
		 * @param searchWord 검색어
		 * @param model 
		 *
		 */
		@PreAuthorize("hasRole('ROLE_ADMIN')")
		@RequestMapping(value = "/returnList", produces = MediaType.APPLICATION_JSON_VALUE, method = {RequestMethod.GET, RequestMethod.POST})
		public String ViewReturnList(
				@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage,
				@RequestParam(required = false)String searchWord, String type,
				Model model) {
			//사원번호가져오기
			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO employeeVO = customUser.getEmployeeVO();
			int emplNo = employeeVO.getEmplNo(); 
			
			PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
			pagingVO.setEmplNo(emplNo);
			
//			검색결과가 존재하면
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchWord",searchWord);
			}
			
//			페이지 설정
			pagingVO.setCurrentPage(currentPage);
//			총 예약내역
			int totalRecord = rentalService.selectReturnedAdminRentalCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<RentalVO> dataList = rentalService.selectReturnedAdminRentalList(pagingVO);
			pagingVO.setDataList(dataList);
			
			model.addAttribute("pagingVO", pagingVO);
			
			return "admin/rental/returnList";
		
		}
		
	
		@PreAuthorize("hasRole('ROLE_ADMIN')")
	 	@GetMapping("/stat")
	 	public String adminRentalStat(RentalVO rentalVO, Model model) throws Exception {
			List<RentalVO> mostRentalList = rentalService.getMostRentalStat(rentalVO);
			List<RentalVO> dayRentalList = rentalService.getDayRentalStat(rentalVO);
			model.addAttribute("mostRentalList", mapper.writeValueAsString(mostRentalList));
			model.addAttribute("dayRentalList", mapper.writeValueAsString(dayRentalList));
	 		return "admin/rental/rental_statistics";
	 	}
		
		@PreAuthorize("hasRole('ROLE_ADMIN')")
		@RequestMapping(value = "/reservationList", produces = MediaType.APPLICATION_JSON_VALUE, method = {RequestMethod.GET, RequestMethod.POST})
		public String reservationList(
				@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage,
				@RequestParam(required = false)String searchWord, String type,
				Model model) {
			//사원번호가져오기
			CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO employeeVO = customUser.getEmployeeVO();
			int emplNo = employeeVO.getEmplNo(); 
			
			PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
			pagingVO.setEmplNo(emplNo);
			
//			검색결과가 존재하면
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchWord",searchWord);
			}
			
//			페이지 설정
			pagingVO.setCurrentPage(currentPage);
//			총 예약내역
			int totalRecord = rentalService.selectAdminReservCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<RentalVO> dataList = rentalService.selectAdminReservList(pagingVO);
			pagingVO.setDataList(dataList);
			
			model.addAttribute("pagingVO", pagingVO);
			
			return "admin/rental/reservationList";
		
		}
		
}
