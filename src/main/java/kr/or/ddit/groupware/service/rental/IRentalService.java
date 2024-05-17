package kr.or.ddit.groupware.service.rental;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.RentalVO;

/**
 * 예약 및 대여 서비스 인터페이스
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see IRentalService
 *
 */

public interface IRentalService {

	Result RentVehicle(RentalVO rentalVO);

	Result RentSupplies(RentalVO rentalVO);

	List<RentalVO> getReservationsByResourceType(RentalVO rentalVO);

	boolean isRentalPossible(RentalVO rentalVO);

	boolean deleteRentalVehicle(RentalVO rentalVO);

	boolean deleteRentalSupplies(RentalVO rentalVO);


	List<RentalVO> selectRentalList(PaginationInfoVO<RentalVO> pagingVO);


	int selectRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	//관리자 신청대여 조회 목록
	int selectAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectAdminRentalList(PaginationInfoVO<RentalVO> pagingVO);
//체크선택 승인
	Result bulkApproveRentals(List<Integer> rentalIds);
//체크선택 반려
	Result bulkRejectRentals(List<Integer> rentalIds);
//나의 반납대기리스트
	int selectReturnPendingCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectReturnPendingList(PaginationInfoVO<RentalVO> pagingVO);
//관리자 승인처리
	int selectApprovedAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectApprovedAdminRentalList(PaginationInfoVO<RentalVO> pagingVO);
//반납하기 
	boolean returnRental(RentalVO rentalVO);
//관리자 반납조회리스트
	int selectReturnedAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectReturnedAdminRentalList(PaginationInfoVO<RentalVO> pagingVO);

//	나의 반납완료리스트
	int ReturnSucceedCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> returnSucceedList(PaginationInfoVO<RentalVO> pagingVO);


	List<RentalVO> getMostRentalStat(RentalVO rentalVO);

	List<RentalVO> getDayRentalStat(RentalVO rentalVO);

	int selectAdminReservCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectAdminReservList(PaginationInfoVO<RentalVO> pagingVO);

}
