package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.BookVO;

public interface BookService {
	
	public int insert(BookVO bookVO); // 도서 등록(추가)
	
	public List<BookVO> list(String keyword); // 도서 리스트 + 검색

	public BookVO detail(BookVO bookVO); // 특정 도서 상세내용
	
}
