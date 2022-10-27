package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.BookDAO;
import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookServiceImpl implements BookService {

	@Autowired
	BookDAO bookDao;

	// 도서 등록
	@Override
	public int insert(BookVO bookVO) {
		return this.bookDao.insert(bookVO);
	}

	// 도서 목록
	@Override
	public List<BookVO> list(String keyword) {
		return this.bookDao.list(keyword);
	}

	// 도서 상세
	@Override
	public BookVO detail(BookVO bookVO) {
		return this.bookDao.detail(bookVO);
	}
}
