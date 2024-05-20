package kr.or.ddit.groupware.mapper.common;

import java.util.List;

import kr.or.ddit.groupware.vo.SearchVO;

public interface ICommonMapper {

	List<SearchVO> totalSearch(SearchVO searchVO);

	List<SearchVO> typeSearch(SearchVO searchVO);

}
