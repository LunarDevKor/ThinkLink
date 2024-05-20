package kr.or.ddit.groupware.service.widget;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.groupware.mapper.widget.IWidgetMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.WidgetLayoutVO;
import kr.or.ddit.groupware.vo.WidgetVO;

@Service
public class WidgetServiceImpl implements IWidgetService {

	@Inject
	private IWidgetMapper widgetMapper;
	
	private Map<String, WidgetLayoutVO> widgetLayouts;
	
	public WidgetServiceImpl() {
		widgetLayouts = new HashMap<>();
        widgetLayouts.put("내 정보", new WidgetLayoutVO(0, 0, 2, 8));
        widgetLayouts.put("근태관리", new WidgetLayoutVO(0, 8, 2, 4));
        widgetLayouts.put("사내공지", new WidgetLayoutVO(2, 0, 4, 4));
        widgetLayouts.put("일정관리", new WidgetLayoutVO(2, 4, 4, 10));
        widgetLayouts.put("업무현황", new WidgetLayoutVO(6, 0, 4, 5));
        widgetLayouts.put("오늘의뉴스", new WidgetLayoutVO(6, 5, 4, 5));
        widgetLayouts.put("메일", new WidgetLayoutVO(6, 10, 4, 6));
        widgetLayouts.put("현재날씨", new WidgetLayoutVO(10, 0, 2, 5));
        widgetLayouts.put("시설및비품예약", new WidgetLayoutVO(10, 5, 2, 4));
        widgetLayouts.put("메모", new WidgetLayoutVO(10, 9, 2, 5));
	}

	@Transactional(rollbackFor = {SQLException.class, RuntimeException.class})
	@Override
	public List<WidgetVO> selectWidgetList(int emplNo) {

		int cnt = widgetMapper.isExistWidgetData(emplNo);

		if (cnt == 0) {
			List<WidgetVO> createdWidgetList = createDefaultWidget();
			for (WidgetVO widgetVO : createdWidgetList) {
				widgetVO.setEmplNo(emplNo);
				int result = widgetMapper.insertDefaultWidget(widgetVO);
				
				if(result <= 0) {
					throw new RuntimeException();
				}
			}
		}

		return widgetMapper.selectWidgetList(emplNo);
	}

	public List<WidgetVO> createDefaultWidget() {
		List<WidgetVO> widgetsTitleList = widgetMapper.getWidgetsTitle();
        List<WidgetVO> widgetList = new ArrayList<>();

        for (WidgetVO widgetVO : widgetsTitleList) {
            String widgetName = widgetVO.getWidgName();
            String widgetCode = widgetVO.getWidgCode();
            
            WidgetLayoutVO widgetLayout = widgetLayouts.get(widgetName);
            if (widgetLayout != null) {
                WidgetVO widgVO = new WidgetVO();
                widgVO.setWidgCode(widgetCode);
                widgVO.setWidgX(widgetLayout.getX());
                widgVO.setWidgY(widgetLayout.getY());
                widgVO.setWidgW(widgetLayout.getW());
                widgVO.setWidgH(widgetLayout.getH());
                
                widgetList.add(widgVO);
            }
        }
        
        return widgetList;
	}

	@Transactional(rollbackFor = SQLException.class)
	@Override
	public void saveWidgetLayout(ArrayList<WidgetVO> widgetList) {
		for (WidgetVO widgetVO : widgetList) {
			int result = widgetMapper.saveWidgetLayout(widgetVO);
			
			if(result <= 0) {
				throw new RuntimeException();
			}
		}
	}

	@Override
	public Result updateWidgetUseYn(WidgetVO widgetVO) {
		int result = widgetMapper.updateWidgetUseYn(widgetVO);
		if(result > 0 ) {
			return Result.OK;
		}
		return Result.FAILED;
	}
}
