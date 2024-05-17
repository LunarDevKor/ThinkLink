package kr.or.ddit.groupware.service.employee;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.employee.IDclzMapper;
import kr.or.ddit.groupware.vo.DclzVO;

@Service
public class DclzServiceImpl implements IDclzService {

	@Inject
	private IDclzMapper mapper;

	@Override
	public void insertDclz(String emplNo) {
		
		int cnt = mapper.countTodaysData(emplNo);
		
		if(cnt == 0) {
			mapper.insertDclz(emplNo);
		}else {
			mapper.updateDclz(emplNo);
		}
		
	}

	@Override
	public DclzVO selectDclzStatus(int emplNo) {
		return mapper.selectDclzStatus(emplNo);
	}
	
	
}
