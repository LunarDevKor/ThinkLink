package kr.or.ddit.groupware.service.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.common.ICommonMapper;
import kr.or.ddit.groupware.vo.SearchVO;

@Service
public class CommonServiceImpl implements ICommonService {
	
	@Inject
	private ICommonMapper commonMapper;

	@Override
	public List<SearchVO> totalSearch(SearchVO searchVO) {
		if(searchVO.getSearchType() == null)
			return commonMapper.totalSearch(searchVO);
		
		return commonMapper.typeSearch(searchVO);
	}

}
