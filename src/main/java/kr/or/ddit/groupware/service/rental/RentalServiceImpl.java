package kr.or.ddit.groupware.service.rental;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.groupware.mapper.notification.INotificationMapper;
import kr.or.ddit.groupware.mapper.rental.IRentalMapper;
import kr.or.ddit.groupware.util.NotificationUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.NotificationVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.RentalVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RentalServiceImpl implements IRentalService {

	@Inject
	private INotificationMapper notiMapper;
	@Inject
	private NotificationUtil notiUtill;
	@Autowired
	private IRentalMapper rentalMapper;

	//차 대여 신청 등록 
	public Result RentVehicle(RentalVO rentalVO) {
		Result res = null;

		int cnt = rentalMapper.rentVehicle(rentalVO);

		if (cnt > 0) {
//			notiRentVehicle(rentalVO);
			res = Result.OK;
		}
		else {
			{
				res = Result.FAILED;
			}
		}
		return res;
	}
    //차 대여 신청 알람 설정
//	private void notiRentVehicle(RentalVO rentalVO) {
//		EmpAuthorityVO empAuthVO = new EmpAuthorityVO();
//		empAuthVO.setAuthorNm("ROLE_ADMIN"); 
//		List<Integer> adminEmpNos = getAdminEmployeeNumbers(empAuthVO);
//
//		for (int emplNo : adminEmpNos) {
//			NotificationVO notificationVO = new NotificationVO();
//			notificationVO.setNtcnRecp(emplNo);
//			notificationVO.setNtcnTypeCode("N115");
//			String content = "차량 대여 신청이 있습니다. 대여신청 번호: " + rentalVO.getErntNo();
//			notificationVO.setNtcnContent(content);
//			notificationVO.setNtcnUrl("/admin/rental/approval");
//			notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
//
//			notiMapper.insertNotification(notificationVO);
//		}
//	}
   //알람받을 관리자 리스트
	private List<Integer> getAdminEmployeeNumbers(EmpAuthorityVO empAuthVO) {
		return rentalMapper.findEmployeesByAuthority(empAuthVO);
	}
   //비품 대여 신청 등록
	@Override
	public Result RentSupplies(RentalVO rentalVO) {
		Result res = null;
		int cnt = rentalMapper.rentSupplies(rentalVO);

		if (cnt > 0) {
//			notiRentSupplies(rentalVO);
			res = Result.OK;

		}
		else {
			{
				res = Result.FAILED;
			}
		}
		return res;
	}
   //비품 대여 신청 알림 
//	private void notiRentSupplies(RentalVO rentalVO) {
//		EmpAuthorityVO empAuthVO = new EmpAuthorityVO();
//		empAuthVO.setAuthorNm("ROLE_ADMIN"); 
//		List<Integer> adminEmpNos = getAdminEmployeeNumbers(empAuthVO);
//		for (int emplNo : adminEmpNos) {
//			NotificationVO notificationVO = new NotificationVO();
//			notificationVO.setNtcnRecp(emplNo); // 예약자에게 알림
//			notificationVO.setNtcnTypeCode("N115"); // 알림 유형 코드
//			String content = "비품 대여 신청이 있습니다. 대여신청 번호: " + rentalVO.getErntNo();
//			notificationVO.setNtcnContent(content);
//			notificationVO.setNtcnUrl("/admin/rental/approval"); // 예약 세부정보 페이지 URL
//			notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
//
//			notiMapper.insertNotification(notificationVO); // 알림 DB에 저장
//		}
//	}

	//예약 데이터 가져오기   
	public List<RentalVO> getReservationsByResourceType(RentalVO rentalVO) {
		return rentalMapper.findRentalByResourceType(rentalVO);
	}

    //대여 중복 신청 방지 
	public boolean isRentalPossible(RentalVO rentalVO) {

		List<RentalVO> conflicts = rentalMapper.findOverlappingRentals(rentalVO.getEqpnmCd(), rentalVO.getErntBeginDt(),
				rentalVO.getErntEndDt());
		return conflicts.size() == 0;
	}
	//차대여 신청 취소
	public boolean deleteRentalVehicle(RentalVO rentalVO) {
		return rentalMapper.cancleRentalVehicle(rentalVO);
	}
	//비품대여 신청 취소
	public boolean deleteRentalSupplies(RentalVO rentalVO) {
		return rentalMapper.cancleRentalSupplies(rentalVO);

	}
	//대여 신청 리스트 페이징 
	public int selectRentalCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectRentalCount(pagingVO);
	}
	
	public List<RentalVO> selectRentalList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectRentalList(pagingVO);
	}
	//대여 승인
//	@Override
//	public Result approveRental(int erntNo) {
//		int cnt = rentalMapper.approveRental(erntNo);
//		if (cnt > 0) {
//			return Result.OK;
//		}
//		else {
//			return Result.FAILED; //해당 행이 update되지 않음
//		}
//	}
//	//대여 반려
//	@Override
//	public Result rejectRental(int erntNo) {
//		int cnt = rentalMapper.rejectRental(erntNo);
//		if (cnt > 0) {
//			return Result.OK; 
//		}
//		else {
//			return Result.FAILED; 
//		}
//	}
	
//	관리자 신청대여 승인관리 
	public int selectAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectAdminRentalCount(pagingVO);
	}
	public List<RentalVO> selectAdminRentalList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectAdminRentalList(pagingVO);
	}
//	선택, 일괄 승인
	@Transactional
	public Result bulkApproveRentals(List<Integer> rentalIds) {
	    if (rentalIds == null || rentalIds.isEmpty()) {
	        return Result.FAILED;  // Nothing to process
	    }

	    int count = 0;
	    for (Integer erntNo : rentalIds) {
	        int updated = rentalMapper.SelectApproveRental(erntNo);
	        if (updated > 0) {
	            count++;
	        }
	    }

	    if (count == rentalIds.size()) {
	        return Result.OK;  
	    } else if (count > 0) {
	        return Result.OK; 
	    } else {
	        return Result.FAILED; 
	    }
	}
//	선택, 일괄 반려
	@Transactional
	public Result bulkRejectRentals(List<Integer> rentalIds) {
		 if (rentalIds == null || rentalIds.isEmpty()) {
		        return Result.FAILED; 
		    }

		    int count = 0;
		    for (Integer erntNo : rentalIds) {
		        int updated = rentalMapper.SelectRejectRental(erntNo);
		        if (updated > 0) {
		            count++;
		        }
		    }

		    if (count == rentalIds.size()) {
		        return Result.OK;  
		    } else if (count > 0) {
		        return Result.OK; 
		    } else {
		        return Result.FAILED; 
		    }
	}
	@Override
	public int selectReturnPendingCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectReturnPendingCount(pagingVO);
	}
	@Override
	public List<RentalVO> selectReturnPendingList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectReturnPendingList(pagingVO);
	}
	@Override
	public int selectApprovedAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectApprovedAdminRentalCount(pagingVO);
	}
	@Override
	public List<RentalVO> selectApprovedAdminRentalList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectApprovedAdminRentalList(pagingVO);
	}
	@Override
	public boolean returnRental(RentalVO rentalVO) {
		return rentalMapper.returnRental(rentalVO);
	}
	@Override
	public int selectReturnedAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectReturnedAdminRentalCount(pagingVO);
	}
	@Override
	public List<RentalVO> selectReturnedAdminRentalList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectReturnedAdminRentalList(pagingVO);
	}
	@Override
	public int ReturnSucceedCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.ReturnSucceedCount(pagingVO);
	}
	@Override
	public List<RentalVO> returnSucceedList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.returnSucceedList(pagingVO);
	}
	@Override
	public List<RentalVO> getMostRentalStat(RentalVO rentalVO) {
		return rentalMapper.getMostRentalStat(rentalVO);
	}
	@Override
	public List<RentalVO> getDayRentalStat(RentalVO rentalVO) {
		return rentalMapper.getDayRentalStat(rentalVO);
	}
	@Override
	public int selectAdminReservCount(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectAdminReservCount(pagingVO);
	}
	@Override
	public List<RentalVO> selectAdminReservList(PaginationInfoVO<RentalVO> pagingVO) {
		return rentalMapper.selectAdminReservList(pagingVO);
	}
}
