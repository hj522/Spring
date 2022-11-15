package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.BookVO;

public interface GalleryService {

	// 메소드 시그니처
	public BookVO list(BookVO bookVO);

	// 도서 목록 가져와서 select에 추가하기
	public List<BookVO> bookList();
	
	
}
