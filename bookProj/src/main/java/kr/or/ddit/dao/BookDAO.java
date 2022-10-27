package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.BookVO;

@Repository
public class BookDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	// 도서 추가
	public int insert(BookVO bookVO) {
		return this.sqlSessionTemplate.insert("book.addBook", bookVO);
	}
	
	// 도서 목록(+검색)
	public List<BookVO> list(String keyword) {
		return this.sqlSessionTemplate.selectList("book.books", keyword);
	}
	
	// 도서 상세
	public BookVO detail(BookVO bookVO) {
		return this.sqlSessionTemplate.selectOne("book.detail", bookVO);
	}

}
