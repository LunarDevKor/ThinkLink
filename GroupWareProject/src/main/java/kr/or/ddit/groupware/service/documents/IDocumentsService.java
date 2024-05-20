package kr.or.ddit.groupware.service.documents;

import java.util.List;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.DocumentsVO;

/**
 * @class : 문서 양식 서비스 인터페이스
 * @auther : <strong>이영주</strong>
 * @version 1.0
 * @date : 2024. 4. 17
 * @see IDocumentsService
 */
public interface IDocumentsService {

	List<DocumentsVO> selectDocumentsList();
	public Result insertDocform(DocumentsVO docVO);
	public List<DocumentsVO> selectDocList();
	public Result updateDocForm(DocumentsVO docVO);
	public DocumentsVO selectOneDoc(int docNo);
	public Result updateDocuments(DocumentsVO docVO);
	public int delSelectedDoc(int docNo);
	List<DocumentsVO> getDocumentsUsedCountByDept(DocumentsVO documentsVO);
	List<DocumentsVO> getDocumentEmployeeChart(DocumentsVO documentsVO);


}
