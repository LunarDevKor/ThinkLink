package kr.or.ddit.groupware.service.reservation;

import java.util.List;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.MtgRoomReservVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

/**
 * 예약 및 대여 서비스 인터페이스
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see IReservationService
 */
public interface IReservationService {

	Result addRoomReserv(MtgRoomReservVO roomReservVO);

	List<MtgRoomReservVO> getReservationsByResourceType(MtgRoomReservVO roomReservVO);

	boolean isReservationPossible(MtgRoomReservVO reservation);

	Result modifyRoomReserv(MtgRoomReservVO roomReservVO);

	boolean deleteRoomReservation(MtgRoomReservVO roomReservVO);

	int selectReservCount(PaginationInfoVO<MtgRoomReservVO> pagingVO);
//	나의예약내역 리스트 조회
	public List<MtgRoomReservVO> selectReservList(PaginationInfoVO<MtgRoomReservVO> pagingVO);
//메인 위젯예약 내역 리스트 조회
	List<MtgRoomReservVO> mainRoomReservList();

	MtgRoomReservVO ReservDetail(int resveNo);

	boolean deleteReservDetail(MtgRoomReservVO roomReservVO);
	
}
