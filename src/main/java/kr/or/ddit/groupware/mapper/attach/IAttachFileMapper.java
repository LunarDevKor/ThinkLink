package kr.or.ddit.groupware.mapper.attach;

import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;

public interface IAttachFileMapper {

	public int insertAttachFileGroup(AttachFileGroupVO attachFileGroupVO);

	public int insertSavedFile(AttachFileVO attachFileVO);

	public AttachFileGroupVO getAttachFileGroup(int attachFileGroupNo);

	public void attachFileDelete(int attachFileNo);
	
}
