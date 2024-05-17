package kr.or.ddit.groupware.mapper.employee;

import kr.or.ddit.groupware.vo.DclzVO;

public interface IDclzMapper {

	int countTodaysData(String emplNo);
	void insertDclz(String emplNo);
	void updateDclz(String emplNo);
	DclzVO selectDclzStatus(int emplNo);

}
