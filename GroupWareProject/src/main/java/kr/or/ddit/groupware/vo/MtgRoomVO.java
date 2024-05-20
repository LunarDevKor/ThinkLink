package kr.or.ddit.groupware.vo;

import lombok.Data;

@Data
public class MtgRoomVO {

	private int mtgRoomNo; 				//회의실 번호 n.n
	private String mtgRoomNm;           //회의실호수
	private int mtgRoomSeat; 			//좌석수
	private String mtgRoomBeamYn;	 	//빔프로젝터여부
	private String mtgRoomBoardYn;		//화이트보드 여부 
	
}
