package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	BookMapper bookMapper;
	
	// 도서 목록
	@Override
	public List<BookVO> list() {
		return this.bookMapper.list();
	}
	
	// 도서 상세
	@Override
	public BookVO detailBook(BookVO bookVO) {
		return this.bookMapper.detailBook(bookVO);
	}
	
	// 도서 수정
	@Override
	public int updateBook(BookVO bookVO) {
		return this.bookMapper.updateBook(bookVO);
	}
	
	// 도서 등록
	@Override
	public int insertBook(BookVO bookVO) {
		return this.bookMapper.insertBook(bookVO);
	}
}