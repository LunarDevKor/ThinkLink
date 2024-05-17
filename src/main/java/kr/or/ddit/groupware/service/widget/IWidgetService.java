package kr.or.ddit.groupware.service.widget;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.WidgetVO;

public interface IWidgetService {

	List<WidgetVO> selectWidgetList(int emplNo);

	void saveWidgetLayout(ArrayList<WidgetVO> widgetList);

	Result updateWidgetUseYn(WidgetVO widgetVO);

}
