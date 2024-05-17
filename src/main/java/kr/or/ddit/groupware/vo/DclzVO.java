package kr.or.ddit.groupware.vo;

import java.util.Date;
import lombok.Data;

@Data
public class DclzVO {
	private int dclzNo;
	private int emplNo;
	private Date attendDt;
	private Date lvffcDt;
}
