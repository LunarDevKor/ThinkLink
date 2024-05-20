package kr.or.ddit.groupware.mapper.rental;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.EmpAuthorityVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.RentalVO;
import kr.or.ddit.groupware.vo.StockVO;
/**
 * 예약 및 대여 SQL Mapper
 * @author 민경선
 * @version 1.0
 * @see IRentalMapper
 */
public interface IRentalMapper {

//대여 등록	
	int rentVehicle(RentalVO rentalVO);

	int rentSupplies(RentalVO rentalVO);
// 데이터 조회
	List<RentalVO> findRentalByResourceType(RentalVO rentalVO);
//대여신청 중복 방지
	List<RentalVO> findOverlappingRentals(
			@Param("eqpnmCd")
			String eqpnmCd,
			@Param("erntBeginDt")
			Date erntBeginDt, 
			@Param("erntEndDt")
			Date erntEndDt);
//대여신청 취소
	boolean cancleRentalVehicle(RentalVO rentalVO);

	boolean cancleRentalSupplies(RentalVO rentalVO);


//대여페이징
	int selectRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectRentalList(PaginationInfoVO<RentalVO> pagingVO);

//알림보낼 관리자 리스트
	List<Integer> findEmployeesByAuthority(EmpAuthorityVO empAuthVO);

////	대여승인
//	int approveRental(int erntNo);
////대여 반려
//	int rejectRental(int erntNo);
//관리자 승인관리 조회 
	
	int selectAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectAdminRentalList(PaginationInfoVO<RentalVO> pagingVO);

	int SelectApproveRental(Integer erntNo);

	int SelectRejectRental(Integer erntNo);

	int selectReturnPendingCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectReturnPendingList(PaginationInfoVO<RentalVO> pagingVO);

	int selectApprovedAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectApprovedAdminRentalList(PaginationInfoVO<RentalVO> pagingVO);

	boolean returnRental(RentalVO rentalVO);

	int selectReturnedAdminRentalCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectReturnedAdminRentalList(PaginationInfoVO<RentalVO> pagingVO);

	int ReturnSucceedCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> returnSucceedList(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> getMostRentalStat(RentalVO rentalVO);

	List<RentalVO> getDayRentalStat(RentalVO rentalVO);

	int selectAdminReservCount(PaginationInfoVO<RentalVO> pagingVO);

	List<RentalVO> selectAdminReservList(PaginationInfoVO<RentalVO> pagingVO);
 





}
