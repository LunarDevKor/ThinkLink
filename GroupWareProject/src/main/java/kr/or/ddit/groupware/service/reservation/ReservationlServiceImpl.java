package kr.or.ddit.groupware.service.reservation;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.groupware.mapper.reservation.IReservationMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.MtgRoomReservVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 예약 및 대여 서비스 구현체
 * @author <strong>민경선</strong>
 * @version 1.0
 * @see ReservationlServiceImpl
 */
@Service
@Slf4j
public class ReservationlServiceImpl implements IReservationService {
	
	@Autowired
	private IReservationMapper reservationMapper;
	
	@Override
	public Result addRoomReserv(MtgRoomReservVO roomReservVO) {
		Result res = null;
		
		int cnt = reservationMapper.addRoomReserv(roomReservVO);
		
		if(cnt>0) {
			res = Result.OK;
		}else {
			{
				res = Result.FAILED;
			}
		}
		return res;
	}


	@Override
	public List<MtgRoomReservVO> getReservationsByResourceType(MtgRoomReservVO roomReservVO) {
		return reservationMapper.findReservationsByResourceType(roomReservVO);
	}


	@Override
	public boolean isReservationPossible(MtgRoomReservVO reservation) {
		  List<MtgRoomReservVO> conflicts = reservationMapper.findOverlappingReservations(
		            reservation.getMtngRoomNo(), 
		            reservation.getResveBeginDt(), 
		            reservation.getResveEndDt()
		        );
		        return conflicts.size() == 0;
		    }


	@Override
	public Result modifyRoomReserv(MtgRoomReservVO roomReservVO) {
	Result res = null;
		
		int cnt = reservationMapper.modifyRoomReserv(roomReservVO);
		
		if(cnt>0) {
			res = Result.OK;
		}else {
			{
				res = Result.FAILED;
			}
		}
		return res;
	}


	@Override
	public boolean deleteRoomReservation(MtgRoomReservVO roomReservVO) {
		return reservationMapper.cancleRoomReserve(roomReservVO);
	}


	@Override
	public int selectReservCount(PaginationInfoVO<MtgRoomReservVO> pagingVO) {
		
		return reservationMapper.selectReservCount(pagingVO);
	}


	@Override
	public List<MtgRoomReservVO> selectReservList(PaginationInfoVO<MtgRoomReservVO> pagingVO) {
		return reservationMapper.selectReservList(pagingVO);
	}


	@Override
	public List<MtgRoomReservVO> mainRoomReservList() {
		
		return reservationMapper.mainRoomReservList();
	}


	@Override
	public MtgRoomReservVO ReservDetail(int resveNo) {
		log.info("resveNo",resveNo);
		return reservationMapper.ReservDetail(resveNo);
	}


	@Override
	public boolean deleteReservDetail(MtgRoomReservVO roomReservVO) {
		return reservationMapper.deleteReservDetail(roomReservVO);
	}

}
