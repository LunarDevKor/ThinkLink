package kr.or.ddit.groupware.vo;

import java.util.List;

import lombok.Data;

@Data
public class PaginationInfoVO<T> {
	private int totalRecord;	// 총 게시글 수
	private int totalPage;		// 총 페이지 수
	private int currentPage;	// 현재 페이지
	private int screenSize = 10;		// 페이지 당 게시글 수
	private int blockSize = 5;		// 페이지 블록 수
	private int startRow;		// 시작 row
	private int endRow;			// 끝 row
	private int startPage;		// 시작 페이지
	private int endPage;		// 끝 페이지
	private List<T> dataList;	// 결과를 넣을 데이터 리스트
	private String searchType;	// 검색 타입
	private String searchWord;	// 검색 단어(키워드)
	
	private String searchSender;	// 검색 단어(키워드)
	private String searchReceiver;	// 검색 단어(키워드)
	private String searchNm;	// 검색 단어(키워드)
	private String searchCn;	// 검색 단어(키워드)
	private String searchFileNm;	// 검색 단어(키워드)
	
	private int emplNo; //사원번호 추가
	private int enabled; //사원 이용상태 추가
	private String word; //파라미터 필요할 때 사용할 용도
	private int bbsNo; // 게시판 카테고리 번호
	
	public PaginationInfoVO() {}
	// PaginationInfoVO 객체를 만들 때, 한 페이지당 게시글 수와 페이지 블록 수를 원하는 값으로 초기화 할 수 있다.
	public PaginationInfoVO(int screenSize, int blockSize) {
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	
	public void setTotalRecord(int totalRecord){
		this.totalRecord = totalRecord;
		// ceil은 올림
		// totalRecord = 121
		// 121 / 10 = 12.1 
		// 올림을 통해서 13을 만들고 정수로 만든다. (totalPage)
		totalPage = (int)Math.ceil(totalRecord / (double)screenSize);
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;		// 현재 페이지
		endRow = currentPage * screenSize;	// 끝 row = 현재페이지 * 한 페이지당 게시글 수
		startRow = endRow - (screenSize - 1);	// 시작 row = 끝 row - (한 페이지당 게시글 수 - 1)
		// 마지막 페이지 = (현재 페이지 + (페이지 블록 사이즈 - 1)) / 페이지 블록 사이즈 * 페이지 블록 사이즈
		// /blockSize * blockSize는 1,2,3,4,5... 페이지마다 실수계산이 아닌 정수 계산을 이용해 endPage를 구하기 위함 
		endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		startPage = endPage - (blockSize - 1);
	}
	
	public String getPagingHTML() {
		// startPage는 1,6,11... 등으로 해당 숫자의 형태로 증가해서 올라갑니다.
		// 1-5 범위안에 있는 경우는 Prev가 생성되지 않는다.
		// 6범위부터 Prev가 만들어지는 조건이 생성된다.
		StringBuffer html = new StringBuffer();
		
		html.append("<ul class='pagination justify-content-center'>");
		
		if(startPage > 1) {
			html.append("<li class='page-item'>"
					+ "<a href='' tabindex='-1' class='page-link' data-page='" + (startPage - blockSize) + "'>"
						+ "<span class='material-icons'>Previous</span>"
						+ "<span class='sr-only'>Previous</span>"
					+ "</a></li>");
		}
		
		for(int i = startPage; i <= (endPage < totalPage ? endPage : totalPage); i++) {
			if(i == currentPage) {
				html.append("<li class='page-item active'><span class='page-link'>" + i + "</span></li>");
			}else {
				html.append("<li class='page-item'><a href='' class='page-link' data-page='" + 
						i + "'>" + i + "</a></li>");
			}
		}
		
		if(endPage < totalPage) {
			html.append("<li class='page-item'>"
					+ "<a href='' class='page-link' data-page='" + (endPage + 1) + "'>"
						+ "<span class='material-icons'>Next</span>"
						+ "<span class='sr-only'>Next</span>"
					+ "</a></li>");
		}
		
		html.append("</ul>");
		return html.toString();
	}
	
}















