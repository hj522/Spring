package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

public interface GalleryMapper {

	// 한 권의 책에 대한 여러 개의 이미지 목록
	public BookVO list(BookVO bookVO);
	
	// 도서 목록 가져와서 select에 추가하기
	public List<BookVO> bookList();
	
	// 변경된 사진 db에 반영
	public int updatePost(AttachVO attachVO);
	
	public int deletePost(AttachVO attachVO);
}