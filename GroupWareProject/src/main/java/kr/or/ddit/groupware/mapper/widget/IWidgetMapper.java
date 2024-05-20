package kr.or.ddit.groupware.mapper.widget;

import java.util.List;

import kr.or.ddit.groupware.vo.WidgetVO;

public interface IWidgetMapper {

	List<WidgetVO> selectWidgetList(int emplNo);

	int isExistWidgetData(int emplNo);

	List<WidgetVO> getWidgetsTitle();

	int insertDefaultWidget(WidgetVO widgetVO);

	int saveWidgetLayout(WidgetVO widgetVO);

	int updateWidgetUseYn(WidgetVO widgetVO);

}
