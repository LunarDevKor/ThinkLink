package kr.or.ddit.groupware.mapper.reservation;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

import kr.or.ddit.groupware.vo.MtgRoomReservVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;
import kr.or.ddit.groupware.vo.RentalVO;

/**
 * 예약 및 대여 SQL Mapper
 * @author 민경선
 * @version 1.0
 * @see IReservationMapper
 */

@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "type")
@JsonSubTypes({
    @JsonSubTypes.Type(value = MtgRoomReservVO.class, name = "mtgRoom"),
    @JsonSubTypes.Type(value = RentalVO.class, name = "rental")
})
public interface IReservationMapper {

	int addRoomReserv(MtgRoomReservVO roomReservVO);

	List<MtgRoomReservVO> findReservationsByResourceType(MtgRoomReservVO roomReservVO);


	List<MtgRoomReservVO> findOverlappingReservations( @Param("mtngRoomNo") int mtngRoomNo,
		    @Param("resveBeginDt") Date resveBeginDt,
		    @Param("resveEndDt") Date resveEndDt);

	int modifyRoomReserv(MtgRoomReservVO roomReservVO);

	boolean cancleRoomReserve(MtgRoomReservVO roomReservVO);

	List<MtgRoomReservVO> selectReservList(PaginationInfoVO<MtgRoomReservVO> pagingVO);

	int selectReservCount(PaginationInfoVO<MtgRoomReservVO> pagingVO);

	List<MtgRoomReservVO> mainRoomReservList();

	MtgRoomReservVO ReservDetail(int resveNo);

	boolean deleteReservDetail(MtgRoomReservVO roomReservVO);


}
