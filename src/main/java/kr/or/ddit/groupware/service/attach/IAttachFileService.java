package kr.or.ddit.groupware.service.attach;

import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;

public interface IAttachFileService {

	public int insertAttachFileGroup();

	public void insertSavedFile(AttachFileVO attachFileVO);

	public AttachFileGroupVO getAttachFileGroup(int attachFileGroupNo);

	public void attachFileDelete(int attachFileNo);

}
