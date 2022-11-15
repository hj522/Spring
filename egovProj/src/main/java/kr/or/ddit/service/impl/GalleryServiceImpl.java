package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.GalleryMapper;
import kr.or.ddit.service.GalleryService;
import kr.or.ddit.vo.BookVO;

@Service
public class GalleryServiceImpl implements GalleryService {

	@Autowired
	GalleryMapper galleryMapper;
	
	// 한 권의 책에 대한 여러 개의 이미지 목록
	@Override
	public BookVO list(BookVO bookVO) {
		return this.galleryMapper.list(bookVO);
	}
	
	// 도서 목록 가져와서 select에 추가하기
	@Override
	public List<BookVO> bookList() {
		return this.galleryMapper.bookList();
	}
}
