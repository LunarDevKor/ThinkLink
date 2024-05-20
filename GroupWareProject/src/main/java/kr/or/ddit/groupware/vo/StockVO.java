package kr.or.ddit.groupware.vo;

import lombok.Data;

@Data
public class StockVO {
    
    private String eqpnmCd; // 자원 코드 
	private int totalQy;  //전체 재고수량
	private int availableQy;  //대여가능 수량
	private int erntQy; 
}
