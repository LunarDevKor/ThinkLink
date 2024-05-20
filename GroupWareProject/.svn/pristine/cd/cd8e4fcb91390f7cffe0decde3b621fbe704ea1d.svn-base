package kr.or.ddit.groupware.service.documents;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.groupware.mapper.documents.IDocumentsMapper;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.DocumentsVO;

@Service
public class DocumentsServiceImpl implements IDocumentsService {

	@Inject
	private IDocumentsMapper documentsMapper;

	@Override
	public List<DocumentsVO> selectDocumentsList() {
		return documentsMapper.selectDocumentsList();
	}

	@Override
	public Result insertDocform(DocumentsVO docVO) {
		Result result = null;

		int status = documentsMapper.insertDocform(docVO);

		if (status > 0) { // 인서트 성공
			result = Result.OK;
		}
		else { // 인서트 실패
			result = Result.FAILED;
		}
		return result;

	}

	@Override
	public List<DocumentsVO> selectDocList() {
		return documentsMapper.selectDocList();
	}

	@Override
	public Result updateDocForm(DocumentsVO docVO) {
		Result result = null;

		int status = documentsMapper.updateDocForm(docVO);

		if (status > 0) { // 성공
			result = Result.OK;
		}
		else { // 실패
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public DocumentsVO selectOneDoc(int docNo) {
		return documentsMapper.selectOneDoc(docNo);
	}

	@Override
	public Result updateDocuments(DocumentsVO docVO) {
		Result result = null;

		int status = documentsMapper.updateDocuments(docVO);

		if (status > 0) { // 성공
			result = Result.OK;
		}
		else { // 실패
			result = Result.FAILED;
		}
		return result;
	}

	@Override
	public int delSelectedDoc(int docNo) {
		
		int result = documentsMapper.delSelectedDoc(docNo);

		return result;
	}

	@Override
	public List<DocumentsVO> getDocumentsUsedCountByDept(DocumentsVO documentsVO) {
		return documentsMapper.getDocumentsUsedCountByDept(documentsVO);
	}

	@Override
	public List<DocumentsVO> getDocumentEmployeeChart(DocumentsVO documentsVO) {
		return documentsMapper.getDocumentEmployeeChart(documentsVO);
	}

}
