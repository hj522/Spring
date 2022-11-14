package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.BookVO;

public interface BookMapper {
	
	// 도서 목록
	public List<BookVO> list();

	// 도서 상세
	public BookVO detailBook(BookVO bookVO);
	
	// 도서 수정
	public int updateBook(BookVO bookVO);

	// 도서 등록
	public int insertBook(BookVO bookVO);
	
}
