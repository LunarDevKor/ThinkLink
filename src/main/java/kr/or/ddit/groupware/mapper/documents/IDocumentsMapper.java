package kr.or.ddit.groupware.mapper.documents;

import java.util.List;

import kr.or.ddit.groupware.vo.DocumentsVO;

public interface IDocumentsMapper {

	List<DocumentsVO> selectDocumentsList();
	public int insertDocform(DocumentsVO docVO);
	public List<DocumentsVO> selectDocList();
	public int updateDocForm(DocumentsVO docVO);
	public DocumentsVO selectOneDoc(int docNo);
	public int updateDocuments(DocumentsVO docVO);
	public int delSelectedDoc(int docNo);
	List<DocumentsVO> getDocumentsUsedCountByDept(DocumentsVO documentsVO);
	List<DocumentsVO> getDocumentEmployeeChart(DocumentsVO documentsVO);

}
