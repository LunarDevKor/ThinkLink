package kr.or.ddit.board;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import junit.framework.Assert;
import kr.or.ddit.groupware.mapper.board.IBoardMapper;
import kr.or.ddit.groupware.vo.BoardVO;
import kr.or.ddit.groupware.vo.PaginationInfoVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"/kr/or/ddit/config/test-context.xml"
})
public class IBoardMapperJUnit {
	private static Logger log = LoggerFactory.getLogger(IBoardMapperJUnit.class);
	
	@Inject
	private IBoardMapper boardMapper;
	
	@Test
	public void testSelectBoardList() {
		
		PaginationInfoVO<BoardVO> pagingVO = new PaginationInfoVO<BoardVO>();
		pagingVO.setStartRow(0);
		pagingVO.setEndRow(10);
		
		List<BoardVO> list = boardMapper.selectBoardList(pagingVO);
		
		Assert.assertTrue(list.size()>0);
		
		for(BoardVO boardVO:list) {
			log.info(boardVO.toString());
		}
	}
}
