package kr.or.ddit.groupware.service.common;

import java.util.List;

import kr.or.ddit.groupware.vo.SearchVO;

public interface ICommonService {

	List<SearchVO> totalSearch(SearchVO searchVO);

}
