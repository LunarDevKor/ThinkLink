package kr.or.ddit.groupware.vo;

import java.util.List;

import lombok.Data;

/**
 * AddressGroupMappingVO
 * @author <strong>이영주</strong>
 * @version 1.0
 * @see AddressGroupMappingVO
 */
@Data
public class AddressGroupMappingVO {
	private int adbkGrpMpngNo; 	// 주소록 그룹맵핑 시퀀스번호
	private int adbkGrpNo;		// adbkGrpNo
	private int adbkNo;
	private int adbkEmpl;
	private int emplNo;
	private List<Integer> selectedIds;
}
