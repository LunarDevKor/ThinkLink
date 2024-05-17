package kr.or.ddit.groupware.service.attach;

import java.sql.SQLException;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.groupware.mapper.attach.IAttachFileMapper;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;

@Service
public class AttachFileServiceImpl implements IAttachFileService {
	
	@Inject
	private IAttachFileMapper attachFileMapper;
	
	@Transactional(rollbackFor = SQLException.class)
	public int insertAttachFileGroup() {
		AttachFileGroupVO attachFileGroupVO = new AttachFileGroupVO();
		int result = attachFileMapper.insertAttachFileGroup(attachFileGroupVO);
		
		if(result > 0) {
			return attachFileGroupVO.getAtchFileGroupNo();
		}else {
			throw new RuntimeException();
		}
	}
	
	@Transactional(rollbackFor = SQLException.class)
	@Override
	public void insertSavedFile(AttachFileVO attachFileVO) {
		int result = attachFileMapper.insertSavedFile(attachFileVO);
		
		if(result <= 0) {
			throw new RuntimeException();
		}
	}

	@Override
	public AttachFileGroupVO getAttachFileGroup(int attachFileGroupNo) {
		return attachFileMapper.getAttachFileGroup(attachFileGroupNo);
	}

	@Override
	public void attachFileDelete(int attachFileNo) {
		attachFileMapper.attachFileDelete(attachFileNo);
	}
}
