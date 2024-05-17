package kr.or.ddit.groupware.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
@Data
public class MtgRoomReservVO  {
	
	
	private int resveNo;                  //예약번호 n.n
	private int emplNo;					//예악한사원  n.n
	private int mtngRoomNo;				//회의실번호  n.n
	
	private Date resveRgsde;			//최초등록일시
	   @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Date resveBeginDt;				//시작시간
	   @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Date resveEndDt;		        //종료시간
	private String resveCn;			         //예약내용
	
	private String resourceType;

	 // MtgRoom 정보 추가
    private String mtgRoomNm; // 회의실 이름
    private int mtgRoomSeat; // 좌석 수
	
	
	
}
