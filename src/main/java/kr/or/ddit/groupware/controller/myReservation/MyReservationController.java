package kr.or.ddit.groupware.controller.myReservation;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.service.rental.IRentalService;
import kr.or.ddit.groupware.service.reservation.IReservationService;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.AnswerVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.MtgRoomReservVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.RentalVO;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

/**
 * 나의에약 컨트롤러
 * 
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see MyReservationController
 */
@Slf4j
@Controller
@RequestMapping("/myReservation")
public class MyReservationController {
	@Inject
	private IReservationService reservationService;
	@Inject
	private IRentalService rentalService;

	/**
	 * 예약/대여신청 메인페이지
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : HttpServletRequest
	 * @param : model
	 * @return : view
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/main")
	public String showReservationPage(HttpServletRequest request, Model model) {

		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		if (employeeVO != null) {
			model.addAttribute("user", employeeVO);
		}
		log.info("user정보", employeeVO);
		return "main/reservation";
	}

	/**
	 * 회의실예약신청
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : roomReservVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addRoomReservation")
	public ResponseEntity<String> reserveMeetingRoom(@RequestBody MtgRoomReservVO roomReservVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		roomReservVO.setEmplNo(employeeVO.getEmplNo());

		Result result = reservationService.addRoomReserv(roomReservVO);

		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("failed", HttpStatus.OK);
		}

	}

	/**
	 * resource type(회의실/차량/비품)에 따른 예약 조회
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : resourceType
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/displayList/{resourceType}")
	@ResponseBody
	public ResponseEntity<?> getReservationsByResourceType(@PathVariable("resourceType") String resourceType) {
		log.info("Fetching reservations for resourceType: {}", resourceType);
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		switch (resourceType) {
		case "room":
			MtgRoomReservVO roomReservVO = new MtgRoomReservVO();
			roomReservVO.setEmplNo(employeeVO.getEmplNo());
			roomReservVO.setResourceType(resourceType);
			return ResponseEntity.ok(reservationService.getReservationsByResourceType(roomReservVO));
		case "vehicle":
			RentalVO rentalVO = new RentalVO();
			rentalVO.setEmplNo(employeeVO.getEmplNo());
			rentalVO.setResourceType(resourceType);
			return ResponseEntity.ok(rentalService.getReservationsByResourceType(rentalVO));
		case "supplies":
			RentalVO rentalVOSup = new RentalVO();
			rentalVOSup.setEmplNo(employeeVO.getEmplNo());
			rentalVOSup.setResourceType(resourceType);
			return ResponseEntity.ok(rentalService.getReservationsByResourceType(rentalVOSup));
		default:
			return ResponseEntity.badRequest().body("Invalid resource type");
		}
	}

	/**
	 * 예약/대여 가능 여부 체크(중복예약방지)
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : reservation (MtgRoomReservVO)
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/reservations/check", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> checkReservation(@RequestBody MtgRoomReservVO reservation) {
		if (reservationService.isReservationPossible(reservation)) {
			return ResponseEntity.ok("Success");
		}
		else {
			return ResponseEntity.badRequest().body("이미 예약되었습니다.");
		}

	}

	/**
	 * 회의실예약수정
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : reservation (MtgRoomReservVO)
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/modifyReservation", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> modifyReservation(@RequestBody MtgRoomReservVO roomReservVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		roomReservVO.setEmplNo(employeeVO.getEmplNo());
		Result result = reservationService.modifyRoomReserv(roomReservVO);

		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("failed", HttpStatus.OK);
		}

	}

	/**
	 * 회의실예약취소
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param :roomReservVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/deleteReservation", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<?> deleteRoomReservation(@RequestBody MtgRoomReservVO roomReservVO) {
		boolean success = reservationService.deleteRoomReservation(roomReservVO);
		if (success) {
			return ResponseEntity.ok("회의실 예약을 취소하시겠습니까?");
		}
		else {
			return ResponseEntity.badRequest().body("Failed to delete room reservation.");
		}
	}

	/**
	 * 회의실 예약내역조회
	 * 
	 * @param currentPage 현재 페이지 번호 (기본값 1)
	 * @param searchWord  검색어
	 * @param model       Spring MVC의 Model 객체로, 뷰에 데이터를 전달하는 데 사용
	 * @return "myReservation/roomlist";
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/roomList", produces = MediaType.APPLICATION_JSON_VALUE, method = {
			RequestMethod.GET, RequestMethod.POST
	})
	public String reservlist(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord, String type, Model model) {
		// 사원번호가져오기
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		int emplNo = employeeVO.getEmplNo();

		PaginationInfoVO<MtgRoomReservVO> pagingVO = new PaginationInfoVO<MtgRoomReservVO>();
		pagingVO.setEmplNo(emplNo);

//		검색결과가 존재하면
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}

//		페이지 설정
		pagingVO.setCurrentPage(currentPage);
//		총 예약내역
		int totalRecord = reservationService.selectReservCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<MtgRoomReservVO> dataList = reservationService.selectReservList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		return "myReservation/roomlist";
	}

	/**
	 * 차량대여승인요청
	 * 
	 * @method : rentVehicle
	 * @auther : <strong>민경선</strong>
	 * @param : rentalVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addVehicleReservation")
	public ResponseEntity<String> rentVehicle(@RequestBody RentalVO rentalVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		rentalVO.setEmplNo(employeeVO.getEmplNo());

		Result result = rentalService.RentVehicle(rentalVO);
		log.info("rentalVO", rentalVO);
		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>("failed", HttpStatus.OK);
		}

	}

	/**
	 * 비품대여승인요청
	 * 
	 * @method : rentSupplies
	 * @auther : <strong>민경선</strong>
	 * @param : rentalVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/addSuppliesReservation")
	public ResponseEntity<String> rentSupplies(@RequestBody RentalVO rentalVO) {
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();

		rentalVO.setEmplNo(employeeVO.getEmplNo());
		Result result = rentalService.RentSupplies(rentalVO);
		log.info("result", result);
		if (result.equals(Result.OK)) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		return new ResponseEntity<String>("failed", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/**
	 * 대여신청리스트조회
	 * 
	 * @param currentPage 현재 페이지 번호 (기본값 1)
	 * @param searchWord  검색어
	 * @param model
	 * @return "myReservation/rentalList";
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/rentalList", produces = MediaType.APPLICATION_JSON_VALUE, method = {
			RequestMethod.GET, RequestMethod.POST
	})
	public String rentList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord, String type, Model model) {
		// 사원번호가져오기
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		int emplNo = employeeVO.getEmplNo();

		PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
		pagingVO.setEmplNo(emplNo);

//		검색결과가 존재하면
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}

//		페이지 설정
		pagingVO.setCurrentPage(currentPage);
//		총 예약내역
		int totalRecord = rentalService.selectRentalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<RentalVO> dataList = rentalService.selectRentalList(pagingVO);
		pagingVO.setDataList(dataList);

		model.addAttribute("pagingVO", pagingVO);

		return "myReservation/rentalList";

	}

	/**
	 * 대여가능 여부 체크
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : rentalVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/rental/check", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> checkRental(@RequestBody RentalVO rentalVO) {
		if (rentalService.isRentalPossible(rentalVO)) {
			return ResponseEntity.ok("예약이가능합니다.");
		}
		else {
			return ResponseEntity.badRequest().body("이미 예약되었습니다.");
		}
	}

	/**
	 * 차량대여신청 취소
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : rentalVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/deleteRentalVehicle", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<?> deleteRentalVehicle(@RequestBody RentalVO rentalVO) {
		boolean success1 = rentalService.deleteRentalVehicle(rentalVO);
		if (success1) {
			return ResponseEntity.ok("차량 대여신청을 취소하시겠습니까?");
		}
		else {
			return ResponseEntity.badRequest().body("Failed to delete car rental");
		}
	}

//	@PostMapping("/deleteRentalVehicle")
//	@ResponseBody
//	public ResponseEntity<?> rejectRental(@RequestParam("erntNo") int erntNo) {
//	    Result result = rentalService.rejectRental(erntNo);
//	    if (result == Result.OK) {
//	        return ResponseEntity.ok("Approval successful");
//	    } else {
//	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to approve rental");
//	    }
//	}
//	

	/**
	 * 비품대여신청 취소
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : rentalVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/deleteRentalSupplies", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<?> deleteRentalSupplies(@RequestBody RentalVO rentalVO) {
		boolean success = rentalService.deleteRentalSupplies(rentalVO);
		if (success) {
			return ResponseEntity.ok("비품 대여신청을 취소하시겠습니까?");
		}
		else {
			return ResponseEntity.badRequest().body("Failed to delete supplies rental");
		}
	}

	/**
	 * 반납대기리스트조회
	 * 
	 * @param currentPage 현재 페이지 번호 (기본값 1)
	 * @param searchWord  검색어
	 * @param model
	 * @return "myReservation/returnPending";
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/returnPending", produces = MediaType.APPLICATION_JSON_VALUE, method = {
			RequestMethod.GET, RequestMethod.POST
	})
	public String returnPendingList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord, String type, Model model) {
		// 사원번호가져오기
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		int emplNo = employeeVO.getEmplNo();

		PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
		pagingVO.setEmplNo(emplNo);

//	검색결과가 존재하면
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}

//	페이지 설정
		pagingVO.setCurrentPage(currentPage);
//	총 예약내역
		int totalRecord = rentalService.selectReturnPendingCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<RentalVO> dataList = rentalService.selectReturnPendingList(pagingVO);
		pagingVO.setDataList(dataList);
		log.info("dataList", dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "myReservation/returnPending";

	}

	/**
	 * 대여반납신청
	 * 
	 * @auther : <strong>민경선</strong>
	 * @param : rentalVO
	 * @return : response entity
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/returnRental", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<?> returnRental(@RequestBody RentalVO rentalVO) {
		boolean success1 = rentalService.returnRental(rentalVO);
		if (success1) {
			return ResponseEntity.ok("비품 대여신청을 취소하시겠습니까?");
		}
		else {
			return ResponseEntity.badRequest().body("Failed to delete supplies rental");
		}
	}

	/**
	 * 반납완료리스트조회
	 * 
	 * @param currentPage 현재 페이지 번호 (기본값 1)
	 * @param searchWord  검색어
	 * @param model
	 * @return "myReservation/returnPending";
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/returnSuccess", produces = MediaType.APPLICATION_JSON_VALUE, method = {
			RequestMethod.GET, RequestMethod.POST
	})
	public String returnSucceedList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchWord, String type, Model model) {
		// 사원번호가져오기
		CustomUser customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployeeVO();
		int emplNo = employeeVO.getEmplNo();

		PaginationInfoVO<RentalVO> pagingVO = new PaginationInfoVO<RentalVO>();
		pagingVO.setEmplNo(emplNo);

//	검색결과가 존재하면
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}

//	페이지 설정
		pagingVO.setCurrentPage(currentPage);
//	총 예약내역
		int totalRecord = rentalService.ReturnSucceedCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<RentalVO> dataList = rentalService.returnSucceedList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "myReservation/returnSuccess";

	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/detail")
	public String ReservDetail(@RequestParam int resveNo, Model model) {
		MtgRoomReservVO roomVO = reservationService.ReservDetail(resveNo);
		log.info("roomVO",roomVO);
		model.addAttribute("roomVO", roomVO);
		return "myReservation/reservDetail";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/deleteDetail")
	public ResponseEntity<?> deleteDetail(@RequestBody MtgRoomReservVO roomReservVO) {
		boolean success = reservationService.deleteReservDetail(roomReservVO);
	    if (success) {
	    	return ResponseEntity.ok("회의실 예약을 취소하시겠습니까?");
	    } else {
	        return ResponseEntity.badRequest().body("Failed to delete room reservation.");
	    }
	}

}
